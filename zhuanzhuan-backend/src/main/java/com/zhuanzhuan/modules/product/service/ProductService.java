package com.zhuanzhuan.modules.product.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.zhuanzhuan.modules.product.dto.ProductPublishDTO;
import com.zhuanzhuan.modules.product.entity.Product;
import com.zhuanzhuan.modules.product.vo.ProductListVO;
import com.zhuanzhuan.modules.product.vo.ProductVO;
import java.math.BigDecimal;

public interface ProductService extends IService<Product> {
    ProductVO publish(Long userId, ProductPublishDTO dto);
    IPage<ProductListVO> getProductList(int page, int size, String keyword, Long categoryId,
                                         BigDecimal minPrice, BigDecimal maxPrice, String condition,
                                         String sort, String order, Long userId, String status);
    ProductVO getProductDetail(Long id, Long currentUserId);
    ProductVO updateProduct(Long userId, Long productId, ProductPublishDTO dto);
    void deleteProduct(Long userId, Long productId);
    void updateStatus(Long userId, Long productId, String status);
}
