package com.zhuanzhuan.modules.admin.controller;

import com.zhuanzhuan.common.result.PageResult;
import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.admin.service.AdminService;
import com.zhuanzhuan.modules.message.entity.Announcement;
import com.zhuanzhuan.modules.order.entity.Order;
import com.zhuanzhuan.modules.product.entity.Product;
import com.zhuanzhuan.modules.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/admin")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;

    private Long getCurrentAdminId() {
        return (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }

    // ============ User Management ============
    @GetMapping("/users")
    public PageResult<User> getUserList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) String role) {
        var result = adminService.getUserList(page, size, keyword, status, role);
        return PageResult.success(result.getRecords(), result.getTotal(), page, size);
    }

    @PutMapping("/user/{id}/status")
    public Result<Void> updateUserStatus(@PathVariable Long id, @RequestBody Map<String, Integer> body) {
        adminService.updateUserStatus(id, body.get("status"));
        return Result.success("操作成功");
    }

    @PutMapping("/user/{id}/role")
    public Result<Void> updateUserRole(@PathVariable Long id, @RequestBody Map<String, String> body) {
        adminService.updateUserRole(id, body.get("role"));
        return Result.success("操作成功");
    }

    // ============ Product Management ============
    @GetMapping("/products")
    public PageResult<Product> getProductList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate) {
        var result = adminService.getProductList(page, size, keyword, status, categoryId, startDate, endDate);
        return PageResult.success(result.getRecords(), result.getTotal(), page, size);
    }

    @GetMapping("/product/review")
    public PageResult<Product> getReviewList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "待审核") String status) {
        var result = adminService.getReviewList(page, size, status);
        return PageResult.success(result.getRecords(), result.getTotal(), page, size);
    }

    @PutMapping("/product/review/{id}")
    public Result<Void> reviewProduct(@PathVariable Long id, @RequestBody Map<String, String> body) {
        adminService.reviewProduct(id, body.get("action"));
        return Result.success("审核完成");
    }

    @PutMapping("/product/{id}")
    public Result<Void> updateProduct(@PathVariable Long id, @RequestBody Product product) {
        adminService.adminUpdateProduct(id, product);
        return Result.success("更新成功");
    }

    @PutMapping("/product/{id}/offline")
    public Result<Void> offlineProduct(@PathVariable Long id) {
        adminService.offlineProduct(id);
        return Result.success("已下架");
    }

    @DeleteMapping("/product/{id}")
    public Result<Void> deleteProduct(@PathVariable Long id) {
        adminService.adminDeleteProduct(id);
        return Result.success("已删除");
    }

    // ============ Order Management ============
    @GetMapping("/orders")
    public PageResult<Order> getOrderList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String orderNo,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate) {
        var result = adminService.getOrderList(page, size, status, orderNo, startDate, endDate);
        return PageResult.success(result.getRecords(), result.getTotal(), page, size);
    }

    @GetMapping("/order/{id}")
    public Result<Order> getOrderDetail(@PathVariable Long id) {
        return Result.success(adminService.getOrderDetail(id));
    }

    @PutMapping("/order/{id}/status")
    public Result<Void> updateOrderStatus(@PathVariable Long id, @RequestBody Map<String, String> body) {
        adminService.adminUpdateOrderStatus(id, body.get("status"), body.get("remark"));
        return Result.success("更新成功");
    }

    // ============ Statistics ============
    @GetMapping("/statistics")
    public Result<Map<String, Object>> getStatistics() {
        return Result.success(adminService.getStatistics());
    }

    @GetMapping("/statistics/detail")
    public Result<Map<String, Object>> getStatisticsDetail(
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String dimension) {
        return Result.success(adminService.getStatisticsDetail(type, dimension));
    }

    // ============ Announcement Management ============
    @GetMapping("/announcement")
    public Result<List<Announcement>> getAnnouncementList() {
        return Result.success(adminService.getAnnouncementList());
    }

    @PostMapping("/announcement")
    public Result<Announcement> createAnnouncement(@RequestBody Announcement announcement) {
        return Result.success("发布成功", adminService.createAnnouncement(announcement, getCurrentAdminId()));
    }

    @PutMapping("/announcement/{id}")
    public Result<Announcement> updateAnnouncement(@PathVariable Long id, @RequestBody Announcement announcement) {
        return Result.success(adminService.updateAnnouncement(id, announcement));
    }

    @DeleteMapping("/announcement/{id}")
    public Result<Void> deleteAnnouncement(@PathVariable Long id) {
        adminService.deleteAnnouncement(id);
        return Result.success("删除成功");
    }
}
