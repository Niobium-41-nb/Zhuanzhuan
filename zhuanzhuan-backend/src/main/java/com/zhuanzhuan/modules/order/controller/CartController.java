package com.zhuanzhuan.modules.order.controller;

import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.order.dto.CartUpdateDTO;
import com.zhuanzhuan.modules.order.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    private Long getCurrentUserId() {
        return (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }

    @PostMapping
    public Result<?> addToCart(@RequestBody Map<String, Object> body) {
        Long productId = Long.valueOf(body.get("productId").toString());
        Integer quantity = body.get("quantity") != null ? Integer.valueOf(body.get("quantity").toString()) : 1;
        return Result.success(cartService.add(getCurrentUserId(), productId, quantity));
    }

    @GetMapping("/list")
    public Result<List<Map<String, Object>>> getCartList() {
        return Result.success(cartService.getCartList(getCurrentUserId()));
    }

    @PutMapping("/{id}")
    public Result<?> updateCart(@PathVariable Long id, @RequestBody CartUpdateDTO dto) {
        return Result.success(cartService.updateCart(getCurrentUserId(), id, dto.getQuantity(), dto.getSelected()));
    }

    @DeleteMapping("/{id}")
    public Result<Void> deleteCart(@PathVariable Long id) {
        cartService.delete(getCurrentUserId(), id);
        return Result.success("删除成功");
    }
}
