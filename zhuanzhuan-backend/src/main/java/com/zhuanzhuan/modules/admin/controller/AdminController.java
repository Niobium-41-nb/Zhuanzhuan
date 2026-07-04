package com.zhuanzhuan.modules.admin.controller;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zhuanzhuan.common.result.PageResult;
import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.message.entity.Announcement;
import com.zhuanzhuan.modules.message.mapper.AnnouncementMapper;
import com.zhuanzhuan.modules.order.entity.Order;
import com.zhuanzhuan.modules.order.mapper.OrderMapper;
import com.zhuanzhuan.modules.product.entity.Product;
import com.zhuanzhuan.modules.product.mapper.ProductMapper;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/admin")
@RequiredArgsConstructor
public class AdminController {

    private final UserMapper userMapper;
    private final ProductMapper productMapper;
    private final OrderMapper orderMapper;
    private final AnnouncementMapper announcementMapper;

    // ============ User Management ============
    @GetMapping("/users")
    public PageResult<User> getUserList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) String role) {
        Page<User> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<User>()
                .like(keyword != null, User::getUsername, keyword)
                .or(keyword != null)
                .like(keyword != null, User::getEmail, keyword)
                .or(keyword != null)
                .like(keyword != null, User::getPhone, keyword)
                .eq(status != null, User::getStatus, status)
                .eq(role != null, User::getRole, role)
                .orderByDesc(User::getCreatedAt);
        IPage<User> result = userMapper.selectPage(pageParam, wrapper);
        return PageResult.success(result.getRecords(), result.getTotal(), page, size);
    }

    @PutMapping("/user/{id}/status")
    public Result<Void> updateUserStatus(@PathVariable Long id, @RequestBody Map<String, Integer> body) {
        User user = userMapper.selectById(id);
        if (user == null) return Result.error(404, "用户不存在");
        user.setStatus(body.get("status"));
        userMapper.updateById(user);
        return Result.success("操作成功");
    }

    @PutMapping("/user/{id}/role")
    public Result<Void> updateUserRole(@PathVariable Long id, @RequestBody Map<String, String> body) {
        User user = userMapper.selectById(id);
        if (user == null) return Result.error(404, "用户不存在");
        user.setRole(body.get("role"));
        userMapper.updateById(user);
        return Result.success("操作成功");
    }

    // ============ Product Review ============
    @GetMapping("/product/review")
    public PageResult<Product> getReviewList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String status) {
        Page<Product> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<Product>()
                .eq(status != null && !status.isEmpty(), Product::getStatus, status)
                .orderByDesc(Product::getCreatedAt);
        IPage<Product> result = productMapper.selectPage(pageParam, wrapper);
        return PageResult.success(result.getRecords(), result.getTotal(), page, size);
    }

    @PutMapping("/product/review/{id}")
    public Result<Void> reviewProduct(@PathVariable Long id, @RequestBody Map<String, String> body) {
        Product product = productMapper.selectById(id);
        if (product == null) return Result.error(404, "商品不存在");
        String action = body.get("action");
        if ("approve".equals(action)) {
            product.setStatus("在售");
        } else if ("reject".equals(action)) {
            product.setStatus("审核驳回");
        } else {
            return Result.error(400, "无效操作");
        }
        productMapper.updateById(product);
        return Result.success("审核完成");
    }

    @PutMapping("/product/{id}/offline")
    public Result<Void> offlineProduct(@PathVariable Long id, @RequestBody Map<String, String> body) {
        Product product = productMapper.selectById(id);
        if (product == null) return Result.error(404, "商品不存在");
        product.setStatus("已下架");
        productMapper.updateById(product);
        return Result.success("已下架");
    }

    // ============ Order Management ============
    @GetMapping("/orders")
    public PageResult<Order> getOrderList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String orderNo) {
        Page<Order> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Order> wrapper = new LambdaQueryWrapper<Order>()
                .eq(status != null && !status.isEmpty(), Order::getStatus, status)
                .like(orderNo != null, Order::getOrderNo, orderNo)
                .orderByDesc(Order::getCreatedAt);
        IPage<Order> result = orderMapper.selectPage(pageParam, wrapper);
        return PageResult.success(result.getRecords(), result.getTotal(), page, size);
    }

    // ============ Statistics ============
    @GetMapping("/statistics")
    public Result<Map<String, Object>> getStatistics() {
        long userCount = userMapper.selectCount(null);
        long todayRegister = userMapper.selectCount(new LambdaQueryWrapper<User>()
                .ge(User::getCreatedAt, DateUtil.beginOfDay(new Date()).toJdkDate()));
        long productCount = productMapper.selectCount(null);
        long todayProduct = productMapper.selectCount(new LambdaQueryWrapper<Product>()
                .ge(Product::getCreatedAt, DateUtil.beginOfDay(new Date()).toJdkDate()));
        long orderCount = orderMapper.selectCount(null);
        long todayOrder = orderMapper.selectCount(new LambdaQueryWrapper<Order>()
                .ge(Order::getCreatedAt, DateUtil.beginOfDay(new Date()).toJdkDate()));

        Map<String, Object> stats = new HashMap<>();
        stats.put("userCount", userCount);
        stats.put("todayRegisterCount", todayRegister);
        stats.put("productCount", productCount);
        stats.put("todayProductCount", todayProduct);
        stats.put("orderCount", orderCount);
        stats.put("todayOrderCount", todayOrder);
        return Result.success(stats);
    }

    @GetMapping("/statistics/detail")
    public Result<Map<String, Object>> getStatisticsDetail(
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String dimension) {
        Map<String, Object> result = new HashMap<>();
        // Category distribution
        List<Product> allProducts = productMapper.selectList(null);
        Map<String, Long> categoryDist = allProducts.stream()
                .collect(Collectors.groupingBy(Product::getCondition, Collectors.counting()));
        List<Map<String, Object>> catList = categoryDist.entrySet().stream().map(e -> {
            Map<String, Object> m = new HashMap<>();
            m.put("name", e.getKey());
            m.put("value", e.getValue());
            return m;
        }).collect(Collectors.toList());
        result.put("categoryDistribution", catList);
        result.put("labels", List.of("2026-07-01", "2026-07-02", "2026-07-03", "2026-07-04"));
        result.put("values", List.of(10, 15, 8, 12));
        return Result.success(result);
    }

    // ============ Announcement Management ============
    @GetMapping("/announcement")
    public Result<List<Announcement>> getAnnouncementList() {
        return Result.success(announcementMapper.selectList(
                new LambdaQueryWrapper<Announcement>().orderByDesc(Announcement::getCreatedAt)));
    }

    @PostMapping("/announcement")
    public Result<Announcement> createAnnouncement(@RequestBody Announcement announcement) {
        Long adminId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        announcement.setAdminId(adminId);
        announcement.setStatus(1);
        announcementMapper.insert(announcement);
        return Result.success("发布成功", announcement);
    }

    @PutMapping("/announcement/{id}")
    public Result<Announcement> updateAnnouncement(@PathVariable Long id, @RequestBody Announcement announcement) {
        announcement.setId(id);
        announcementMapper.updateById(announcement);
        return Result.success(announcementMapper.selectById(id));
    }

    @DeleteMapping("/announcement/{id}")
    public Result<Void> deleteAnnouncement(@PathVariable Long id) {
        announcementMapper.deleteById(id);
        return Result.success("删除成功");
    }
}
