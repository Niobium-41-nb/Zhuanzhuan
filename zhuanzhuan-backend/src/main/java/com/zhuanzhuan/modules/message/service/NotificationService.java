package com.zhuanzhuan.modules.message.service;

import com.zhuanzhuan.modules.message.entity.Notification;
import java.util.List;
import java.util.Map;

public interface NotificationService {
    List<Map<String, Object>> getNotificationList(Long userId, int page, int size);
    void markAsRead(Long userId, Long notificationId);
    int getUnreadCount(Long userId);
    void createNotification(Long userId, String title, String content, String type);
}
