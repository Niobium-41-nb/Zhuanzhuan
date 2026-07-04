package com.zhuanzhuan.modules.product.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zhuanzhuan.common.exception.BusinessException;
import com.zhuanzhuan.modules.product.entity.Favorite;
import com.zhuanzhuan.modules.product.entity.Product;
import com.zhuanzhuan.modules.product.mapper.FavoriteMapper;
import com.zhuanzhuan.modules.product.mapper.ProductMapper;
import com.zhuanzhuan.modules.product.service.FavoriteService;
import com.zhuanzhuan.modules.product.vo.ProductListVO;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class FavoriteServiceImpl implements FavoriteService {

    private final FavoriteMapper favoriteMapper;
    private final ProductMapper productMapper;
    private final UserMapper userMapper;

    @Override
    @Transactional
    public Map<String, Object> toggle(Long userId, Long productId) {
        Product product = productMapper.selectById(productId);
        if (product == null) throw new BusinessException(404, "商品不存在");

        Favorite existing = favoriteMapper.selectByUserAndProduct(userId, productId);
        boolean isFavorited;
        if (existing != null) {
            favoriteMapper.deleteByUserAndProduct(userId, productId);
            isFavorited = false;
        } else {
            Favorite fav = new Favorite();
            fav.setUserId(userId);
            fav.setProductId(productId);
            favoriteMapper.insert(fav);
            isFavorited = true;
        }

        // Update count
        int count = favoriteMapper.countByProductId(productId);
        product.setFavoriteCount(count);
        productMapper.updateById(product);

        Map<String, Object> result = new HashMap<>();
        result.put("isFavorited", isFavorited);
        result.put("favoriteCount", count);
        return result;
    }

    @Override
    public IPage<ProductListVO> getFavoriteList(Long userId, int page, int size) {
        Page<Favorite> favPage = new Page<>(page, size);
        Page<Favorite> result = favoriteMapper.selectPage(favPage,
                new LambdaQueryWrapper<Favorite>().eq(Favorite::getUserId, userId).orderByDesc(Favorite::getCreatedAt));

        List<Favorite> records = result.getRecords();
        if (records.isEmpty()) {
            IPage<ProductListVO> voPage = new Page<>(page, size);
            voPage.setTotal(result.getTotal());
            voPage.setRecords(Collections.emptyList());
            return voPage;
        }

        // 批量查询商品（1 次查询替代 N 次）
        Set<Long> productIds = records.stream().map(Favorite::getProductId).collect(Collectors.toSet());
        Map<Long, Product> productMap = productMapper.selectBatchIds(productIds).stream()
                .collect(Collectors.toMap(Product::getId, Function.identity()));

        // 批量查询卖家（1 次查询替代 N 次）
        Set<Long> sellerIds = productMap.values().stream().map(Product::getUserId).collect(Collectors.toSet());
        Map<Long, User> userMap = sellerIds.isEmpty() ? Collections.emptyMap()
                : userMapper.selectBatchIds(sellerIds).stream()
                        .collect(Collectors.toMap(User::getId, Function.identity()));

        IPage<ProductListVO> voPage = new Page<>(page, size);
        voPage.setTotal(result.getTotal());
        voPage.setRecords(records.stream().map(fav -> {
            Product p = productMap.get(fav.getProductId());
            if (p == null) return null;
            ProductListVO vo = new ProductListVO();
            BeanUtil.copyProperties(p, vo);
            User seller = userMap.get(p.getUserId());
            if (seller != null) {
                Map<String, Object> sellerMap = new HashMap<>();
                sellerMap.put("userId", seller.getId());
                sellerMap.put("nickname", seller.getNickname() != null ? seller.getNickname() : seller.getUsername());
                sellerMap.put("avatar", seller.getAvatar());
                vo.setSeller(sellerMap);
            }
            return vo;
        }).filter(v -> v != null).collect(Collectors.toList()));
        return voPage;
    }
}
