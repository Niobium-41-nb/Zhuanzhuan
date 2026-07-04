package com.zhuanzhuan.modules.order.service;

import com.zhuanzhuan.modules.order.entity.Cart;
import java.util.List;
import java.util.Map;

public interface CartService {
    Cart add(Long userId, Long productId, Integer quantity);
    List<Map<String, Object>> getCartList(Long userId);
    Cart updateCart(Long userId, Long cartId, Integer quantity, Integer selected);
    void delete(Long userId, Long cartId);
}
