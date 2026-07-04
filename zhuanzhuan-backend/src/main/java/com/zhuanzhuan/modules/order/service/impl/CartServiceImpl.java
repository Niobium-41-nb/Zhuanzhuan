package com.zhuanzhuan.modules.order.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.zhuanzhuan.modules.order.entity.Cart;
import com.zhuanzhuan.modules.order.mapper.CartMapper;
import com.zhuanzhuan.modules.order.service.CartService;
import com.zhuanzhuan.modules.product.entity.Product;
import com.zhuanzhuan.modules.product.mapper.ProductMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {

    private final CartMapper cartMapper;
    private final ProductMapper productMapper;

    @Override
    @Transactional
    public Cart add(Long userId, Long productId, Integer quantity) {
        Cart existing = cartMapper.selectOne(
                new LambdaQueryWrapper<Cart>().eq(Cart::getUserId, userId).eq(Cart::getProductId, productId));
        if (existing != null) {
            existing.setQuantity(existing.getQuantity() + (quantity != null ? quantity : 1));
            cartMapper.updateById(existing);
            return existing;
        }
        Cart cart = new Cart();
        cart.setUserId(userId);
        cart.setProductId(productId);
        cart.setQuantity(quantity != null ? quantity : 1);
        cart.setSelected(1);
        cartMapper.insert(cart);
        return cart;
    }

    @Override
    public List<Map<String, Object>> getCartList(Long userId) {
        List<Cart> carts = cartMapper.selectList(
                new LambdaQueryWrapper<Cart>().eq(Cart::getUserId, userId).orderByDesc(Cart::getCreatedAt));
        return carts.stream().map(c -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", c.getId());
            map.put("productId", c.getProductId());
            map.put("quantity", c.getQuantity());
            map.put("selected", c.getSelected());
            Product p = productMapper.selectById(c.getProductId());
            if (p != null) {
                map.put("title", p.getTitle());
                map.put("coverImage", p.getCoverImage());
                map.put("price", p.getPrice());
                map.put("status", p.getStatus());
            }
            return map;
        }).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public Cart updateCart(Long userId, Long cartId, Integer quantity, Integer selected) {
        Cart cart = cartMapper.selectById(cartId);
        if (cart == null || !cart.getUserId().equals(userId)) return null;
        if (quantity != null) cart.setQuantity(quantity);
        if (selected != null) cart.setSelected(selected);
        cartMapper.updateById(cart);
        return cart;
    }

    @Override
    @Transactional
    public void delete(Long userId, Long cartId) {
        Cart cart = cartMapper.selectById(cartId);
        if (cart != null && cart.getUserId().equals(userId)) {
            cartMapper.deleteById(cartId);
        }
    }
}
