package com.zhuanzhuan.modules.product.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.zhuanzhuan.modules.product.vo.ProductListVO;
import java.util.Map;

public interface FavoriteService {
    Map<String, Object> toggle(Long userId, Long productId);
    IPage<ProductListVO> getFavoriteList(Long userId, int page, int size);
}
