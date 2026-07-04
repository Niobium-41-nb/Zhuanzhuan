package com.zhuanzhuan.modules.product.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zhuanzhuan.common.exception.BusinessException;
import com.zhuanzhuan.modules.product.dto.ProductPublishDTO;
import com.zhuanzhuan.modules.product.entity.Category;
import com.zhuanzhuan.modules.product.entity.Favorite;
import com.zhuanzhuan.modules.product.entity.Product;
import com.zhuanzhuan.modules.product.entity.ProductImage;
import com.zhuanzhuan.modules.product.mapper.CategoryMapper;
import com.zhuanzhuan.modules.product.mapper.FavoriteMapper;
import com.zhuanzhuan.modules.product.mapper.ProductImageMapper;
import com.zhuanzhuan.modules.product.mapper.ProductMapper;
import com.zhuanzhuan.modules.product.service.ProductService;
import com.zhuanzhuan.modules.product.vo.ProductListVO;
import com.zhuanzhuan.modules.product.vo.ProductVO;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements ProductService {

    private final ProductMapper productMapper;
    private final ProductImageMapper productImageMapper;
    private final CategoryMapper categoryMapper;
    private final FavoriteMapper favoriteMapper;
    private final UserMapper userMapper;

    @Override
    @Transactional
    public ProductVO publish(Long userId, ProductPublishDTO dto) {
        Product product = new Product();
        BeanUtil.copyProperties(dto, product);
        product.setUserId(userId);
        product.setStatus("待审核");
        product.setViewCount(0);
        product.setFavoriteCount(0);
        productMapper.insert(product);

        // Save images
        if (dto.getImageIds() != null && !dto.getImageIds().isEmpty()) {
            List<ProductImage> images = productImageMapper.selectBatchIds(dto.getImageIds());
            for (ProductImage img : images) {
                img.setProductId(product.getId());
                productImageMapper.updateById(img);
            }
            // Set cover image
            product.setCoverImage(images.get(0).getUrl());
            productMapper.updateById(product);
        }

        return getProductDetail(product.getId(), userId);
    }

    @Override
    public IPage<ProductListVO> getProductList(int page, int size, String keyword, Long categoryId,
                                                BigDecimal minPrice, BigDecimal maxPrice, String condition,
                                                String sort, String order, Long userId, String status) {
        Page<Product> pageParam = new Page<>(page, size);
        String queryStatus = status != null ? status : "在售";
        IPage<Product> productPage = productMapper.selectPageWithCondition(
                pageParam, keyword, categoryId, minPrice, maxPrice, condition, queryStatus, userId, sort, order);

        IPage<ProductListVO> voPage = new Page<>(page, size);
        voPage.setTotal(productPage.getTotal());
        voPage.setRecords(productPage.getRecords().stream().map(p -> {
            ProductListVO vo = new ProductListVO();
            BeanUtil.copyProperties(p, vo);
            Category cat = categoryMapper.selectById(p.getCategoryId());
            if (cat != null) vo.setCategoryName(cat.getName());
            User seller = userMapper.selectById(p.getUserId());
            if (seller != null) {
                Map<String, Object> sellerMap = new HashMap<>();
                sellerMap.put("userId", seller.getId());
                sellerMap.put("nickname", seller.getNickname() != null ? seller.getNickname() : seller.getUsername());
                sellerMap.put("avatar", seller.getAvatar());
                sellerMap.put("creditScore", seller.getCreditScore());
                vo.setSeller(sellerMap);
            }
            return vo;
        }).collect(Collectors.toList()));
        return voPage;
    }

    @Override
    public ProductVO getProductDetail(Long id, Long currentUserId) {
        Product product = productMapper.selectById(id);
        if (product == null) throw new BusinessException(404, "商品不存在");

        productMapper.incrementViewCount(id);

        ProductVO vo = new ProductVO();
        BeanUtil.copyProperties(product, vo);

        // Images
        List<ProductImage> images = productImageMapper.selectList(
                new LambdaQueryWrapper<ProductImage>().eq(ProductImage::getProductId, id).orderByAsc(ProductImage::getSortOrder));
        vo.setImages(images.stream().map(img -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", img.getId());
            map.put("url", img.getUrl());
            map.put("sortOrder", img.getSortOrder());
            return map;
        }).collect(Collectors.toList()));

        // Category
        Category cat = categoryMapper.selectById(product.getCategoryId());
        if (cat != null) {
            Map<String, Object> catMap = new HashMap<>();
            catMap.put("id", cat.getId());
            catMap.put("name", cat.getName());
            if (cat.getParentId() != null && cat.getParentId() > 0) {
                Category parent = categoryMapper.selectById(cat.getParentId());
                catMap.put("parentName", parent != null ? parent.getName() : null);
            }
            vo.setCategory(catMap);
        }

        // Seller
        User seller = userMapper.selectById(product.getUserId());
        if (seller != null) {
            Map<String, Object> sellerMap = new HashMap<>();
            sellerMap.put("userId", seller.getId());
            sellerMap.put("nickname", seller.getNickname() != null ? seller.getNickname() : seller.getUsername());
            sellerMap.put("avatar", seller.getAvatar());
            sellerMap.put("creditScore", seller.getCreditScore());
            int count = productMapper.countByUserId(seller.getId());
            sellerMap.put("productCount", count);
            vo.setSeller(sellerMap);
        }

        // Favorite status
        if (currentUserId != null) {
            Favorite fav = favoriteMapper.selectByUserAndProduct(currentUserId, id);
            vo.setIsFavorited(fav != null);
        } else {
            vo.setIsFavorited(false);
        }

        return vo;
    }

    @Override
    @Transactional
    public ProductVO updateProduct(Long userId, Long productId, ProductPublishDTO dto) {
        Product product = productMapper.selectById(productId);
        if (product == null) throw new BusinessException(404, "商品不存在");
        if (!product.getUserId().equals(userId)) throw new BusinessException(403, "无权操作");
        BeanUtil.copyProperties(dto, product);
        product.setId(productId);
        productMapper.updateById(product);
        return getProductDetail(productId, userId);
    }

    @Override
    @Transactional
    public void deleteProduct(Long userId, Long productId) {
        Product product = productMapper.selectById(productId);
        if (product == null) throw new BusinessException(404, "商品不存在");
        if (!product.getUserId().equals(userId)) throw new BusinessException(403, "无权操作");
        productMapper.deleteById(productId);
    }

    @Override
    @Transactional
    public void updateStatus(Long userId, Long productId, String status) {
        Product product = productMapper.selectById(productId);
        if (product == null) throw new BusinessException(404, "商品不存在");
        if (!product.getUserId().equals(userId)) throw new BusinessException(403, "无权操作");
        product.setStatus(status);
        productMapper.updateById(product);
    }
}
