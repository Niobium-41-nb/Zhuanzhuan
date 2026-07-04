package com.zhuanzhuan.modules.product.controller;

import com.zhuanzhuan.common.result.PageResult;
import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.product.dto.ProductPublishDTO;
import com.zhuanzhuan.modules.product.service.CategoryService;
import com.zhuanzhuan.modules.product.service.FavoriteService;
import com.zhuanzhuan.modules.product.service.ProductService;
import com.zhuanzhuan.modules.product.vo.CategoryVO;
import com.zhuanzhuan.modules.product.vo.ProductListVO;
import com.zhuanzhuan.modules.product.vo.ProductVO;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final FavoriteService favoriteService;

    private Long getCurrentUserId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof Long) return (Long) principal;
        return null;
    }

    @GetMapping("/product/list")
    public PageResult<ProductListVO> getProductList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam(required = false) String condition,
            @RequestParam(required = false) String sort,
            @RequestParam(required = false) String order,
            @RequestParam(required = false) Long userId) {
        var result = productService.getProductList(page, size, keyword, categoryId, minPrice, maxPrice, condition, sort, order, userId, null);
        return PageResult.success(result.getRecords(), result.getTotal(), page, size);
    }

    @GetMapping("/product/{id}")
    public Result<ProductVO> getProductDetail(@PathVariable Long id) {
        return Result.success(productService.getProductDetail(id, getCurrentUserId()));
    }

    @PostMapping("/product")
    public Result<ProductVO> publishProduct(@Valid @RequestBody ProductPublishDTO dto) {
        return Result.success("发布成功，等待审核", productService.publish(getCurrentUserId(), dto));
    }

    @PutMapping("/product/{id}")
    public Result<ProductVO> updateProduct(@PathVariable Long id, @Valid @RequestBody ProductPublishDTO dto) {
        return Result.success(productService.updateProduct(getCurrentUserId(), id, dto));
    }

    @DeleteMapping("/product/{id}")
    public Result<Void> deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(getCurrentUserId(), id);
        return Result.success("删除成功");
    }

    @PutMapping("/product/{id}/status")
    public Result<Void> updateStatus(@PathVariable Long id, @RequestBody Map<String, String> body) {
        productService.updateStatus(getCurrentUserId(), id, body.get("status"));
        return Result.success("状态更新成功");
    }

    @PostMapping("/product/favorite")
    public Result<Map<String, Object>> toggleFavorite(@RequestBody Map<String, Long> body) {
        return Result.success(favoriteService.toggle(getCurrentUserId(), body.get("productId")));
    }

    @GetMapping("/product/favorite/list")
    public PageResult<ProductListVO> getFavoriteList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        var result = favoriteService.getFavoriteList(getCurrentUserId(), page, size);
        return PageResult.success(result.getRecords(), result.getTotal(), page, size);
    }
}
