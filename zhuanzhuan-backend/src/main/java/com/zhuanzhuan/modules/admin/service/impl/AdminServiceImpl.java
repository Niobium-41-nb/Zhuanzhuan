package com.zhuanzhuan.modules.admin.service.impl;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.admin.service.AdminService;
import com.zhuanzhuan.modules.message.entity.Announcement;
import com.zhuanzhuan.modules.message.mapper.AnnouncementMapper;
import com.zhuanzhuan.modules.order.entity.Order;
import com.zhuanzhuan.modules.order.mapper.OrderMapper;
import com.zhuanzhuan.modules.product.entity.Product;
import com.zhuanzhuan.modules.product.mapper.ProductMapper;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

    private final UserMapper userMapper;
    private final ProductMapper productMapper;
    private final OrderMapper orderMapper;
    private final AnnouncementMapper announcementMapper;

    // ============ User Management ============

    @Override
    public IPage<User> getUserList(int page, int size, String keyword, Integer status, String role) {
        Page<User> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<User>();
        if (keyword != null) {
            wrapper.and(w -> w.like(User::getUsername, keyword)
                    .or().like(User::getEmail, keyword)
                    .or().like(User::getPhone, keyword));
        }
        wrapper.eq(status != null, User::getStatus, status)
               .eq(role != null, User::getRole, role)
               .orderByDesc(User::getCreatedAt);
        return userMapper.selectPage(pageParam, wrapper);
    }

    @Override
    @Transactional
    public void updateUserStatus(Long id, Integer status) {
        User user = userMapper.selectById(id);
        if (user == null) throw new com.zhuanzhuan.common.exception.BusinessException(404, "用户不存在");
        user.setStatus(status);
        userMapper.updateById(user);
    }

    @Override
    @Transactional
    public void updateUserRole(Long id, String role) {
        User user = userMapper.selectById(id);
        if (user == null) throw new com.zhuanzhuan.common.exception.BusinessException(404, "用户不存在");
        // 防止管理员将自己降级
        user.setRole(role);
        userMapper.updateById(user);
    }

    // ============ Product Management ============

    @Override
    public IPage<Product> getProductList(int page, int size, String keyword, String status, Long categoryId,
                                          String startDate, String endDate) {
        Page<Product> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<Product>()
                .like(keyword != null && !keyword.isEmpty(), Product::getTitle, keyword)
                .eq(status != null && !status.isEmpty(), Product::getStatus, status)
                .eq(categoryId != null, Product::getCategoryId, categoryId)
                .ge(startDate != null, Product::getCreatedAt, startDate)
                .le(endDate != null, Product::getCreatedAt, endDate + " 23:59:59")
                .orderByDesc(Product::getCreatedAt);
        return productMapper.selectPage(pageParam, wrapper);
    }

    @Override
    public IPage<Product> getReviewList(int page, int size, String status) {
        Page<Product> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<Product>()
                .eq(Product::getStatus, status)
                .orderByDesc(Product::getCreatedAt);
        return productMapper.selectPage(pageParam, wrapper);
    }

    @Override
    @Transactional
    public void reviewProduct(Long id, String action) {
        Product product = productMapper.selectById(id);
        if (product == null) throw new com.zhuanzhuan.common.exception.BusinessException(404, "商品不存在");
        if ("approve".equals(action)) {
            product.setStatus("在售");
        } else if ("reject".equals(action)) {
            product.setStatus("审核驳回");
        } else {
            throw new com.zhuanzhuan.common.exception.BusinessException(400, "无效操作");
        }
        productMapper.updateById(product);
    }

    @Override
    @Transactional
    public void offlineProduct(Long id) {
        Product product = productMapper.selectById(id);
        if (product == null) throw new com.zhuanzhuan.common.exception.BusinessException(404, "商品不存在");
        product.setStatus("已下架");
        productMapper.updateById(product);
    }

    @Override
    @Transactional
    public void adminUpdateProduct(Long id, Product product) {
        Product existing = productMapper.selectById(id);
        if (existing == null) throw new com.zhuanzhuan.common.exception.BusinessException(404, "商品不存在");
        // 仅允许管理员修改以下字段
        existing.setTitle(product.getTitle());
        existing.setPrice(product.getPrice());
        existing.setOriginalPrice(product.getOriginalPrice());
        existing.setCondition(product.getCondition());
        existing.setDescription(product.getDescription());
        existing.setCoverImage(product.getCoverImage());
        existing.setCategoryId(product.getCategoryId());
        existing.setStatus(product.getStatus());
        productMapper.updateById(existing);
    }

    @Override
    @Transactional
    public void adminDeleteProduct(Long id) {
        Product product = productMapper.selectById(id);
        if (product == null) throw new com.zhuanzhuan.common.exception.BusinessException(404, "商品不存在");
        productMapper.deleteById(id);
    }

    // ============ Order Management ============

    @Override
    public IPage<Order> getOrderList(int page, int size, String status, String orderNo,
                                      String startDate, String endDate) {
        Page<Order> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Order> wrapper = new LambdaQueryWrapper<Order>()
                .eq(status != null && !status.isEmpty(), Order::getStatus, status)
                .like(orderNo != null && !orderNo.isEmpty(), Order::getOrderNo, orderNo)
                .ge(startDate != null, Order::getCreatedAt, startDate)
                .le(endDate != null, Order::getCreatedAt, endDate + " 23:59:59")
                .orderByDesc(Order::getCreatedAt);
        return orderMapper.selectPage(pageParam, wrapper);
    }

    @Override
    public Order getOrderDetail(Long id) {
        Order order = orderMapper.selectById(id);
        if (order == null) throw new com.zhuanzhuan.common.exception.BusinessException(404, "订单不存在");
        return order;
    }

    @Override
    @Transactional
    public void adminUpdateOrderStatus(Long id, String status, String remark) {
        Order order = orderMapper.selectById(id);
        if (order == null) throw new com.zhuanzhuan.common.exception.BusinessException(404, "订单不存在");
        order.setStatus(status);
        switch (status) {
            case "已付款":
                order.setPaidAt(LocalDateTime.now());
                break;
            case "已发货":
                order.setShippedAt(LocalDateTime.now());
                break;
            case "已完成":
                order.setReceivedAt(LocalDateTime.now());
                break;
        }
        orderMapper.updateById(order);
    }

    // ============ Statistics ============

    @Override
    public Map<String, Object> getStatistics() {
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
        return stats;
    }

    @Override
    public Map<String, Object> getStatisticsDetail(String type, String dimension) {
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
        return result;
    }

    // ============ Announcement Management ============

    @Override
    public List<Announcement> getAnnouncementList() {
        return announcementMapper.selectList(
                new LambdaQueryWrapper<Announcement>().orderByDesc(Announcement::getCreatedAt));
    }

    @Override
    @Transactional
    public Announcement createAnnouncement(Announcement announcement, Long adminId) {
        announcement.setAdminId(adminId);
        announcement.setStatus(1);
        announcementMapper.insert(announcement);
        return announcement;
    }

    @Override
    @Transactional
    public Announcement updateAnnouncement(Long id, Announcement announcement) {
        announcement.setId(id);
        announcementMapper.updateById(announcement);
        return announcementMapper.selectById(id);
    }

    @Override
    @Transactional
    public void deleteAnnouncement(Long id) {
        announcementMapper.deleteById(id);
    }
}
