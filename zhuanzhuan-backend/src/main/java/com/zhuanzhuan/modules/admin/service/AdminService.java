package com.zhuanzhuan.modules.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.zhuanzhuan.modules.message.entity.Announcement;
import com.zhuanzhuan.modules.order.entity.Order;
import com.zhuanzhuan.modules.product.entity.Product;
import com.zhuanzhuan.modules.user.entity.User;

import java.util.List;
import java.util.Map;

public interface AdminService {

    // ============ User Management ============
    IPage<User> getUserList(int page, int size, String keyword, Integer status, String role);

    void updateUserStatus(Long id, Integer status);

    void updateUserRole(Long id, String role);

    // ============ Product Management ============
    IPage<Product> getProductList(int page, int size, String keyword, String status, Long categoryId,
                                   String startDate, String endDate);

    IPage<Product> getReviewList(int page, int size, String status);

    void reviewProduct(Long id, String action);

    void offlineProduct(Long id);

    void adminUpdateProduct(Long id, Product product);

    void adminDeleteProduct(Long id);

    // ============ Order Management ============
    IPage<Order> getOrderList(int page, int size, String status, String orderNo,
                               String startDate, String endDate);

    Order getOrderDetail(Long id);

    void adminUpdateOrderStatus(Long id, String status, String remark);

    // ============ Statistics ============
    Map<String, Object> getStatistics();

    Map<String, Object> getStatisticsDetail(String type, String dimension);

    // ============ Announcement Management ============
    List<Announcement> getAnnouncementList();

    Announcement createAnnouncement(Announcement announcement, Long adminId);

    Announcement updateAnnouncement(Long id, Announcement announcement);

    void deleteAnnouncement(Long id);
}
