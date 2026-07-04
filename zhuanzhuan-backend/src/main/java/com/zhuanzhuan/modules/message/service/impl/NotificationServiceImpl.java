package com.zhuanzhuan.modules.message.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zhuanzhuan.common.exception.BusinessException;
import com.zhuanzhuan.modules.message.entity.Notification;
import com.zhuanzhuan.modules.message.mapper.NotificationMapper;
import com.zhuanzhuan.modules.message.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {

    private final NotificationMapper notificationMapper;

    @Override
    public List<Map<String, Object>> getNotificationList(Long userId, int page, int size) {
        Page<Notification> pageParam = new Page<>(page, size);
        IPage<Notification> result = notificationMapper.selectPage(pageParam,
                new LambdaQueryWrapper<Notification>().eq(Notification::getUserId, userId)
                        .orderByDesc(Notification::getCreatedAt));
        return result.getRecords().stream().map(n -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", n.getId());
            map.put("title", n.getTitle());
            map.put("content", n.getContent());
            map.put("type", n.getType());
            map.put("isRead", n.getIsRead());
            map.put("createdAt", n.getCreatedAt());
            return map;
        }).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void markAsRead(Long userId, Long notificationId) {
        Notification notif = notificationMapper.selectById(notificationId);
        if (notif == null || !notif.getUserId().equals(userId)) throw new BusinessException(404, "通知不存在");
        notif.setIsRead(1);
        notificationMapper.updateById(notif);
    }

    @Override
    public int getUnreadCount(Long userId) {
        return Math.toIntExact(notificationMapper.selectCount(
                new LambdaQueryWrapper<Notification>().eq(Notification::getUserId, userId).eq(Notification::getIsRead, 0)));
    }

    @Override
    @Transactional
    public void createNotification(Long userId, String title, String content, String type) {
        Notification n = new Notification();
        n.setUserId(userId);
        n.setTitle(title);
        n.setContent(content);
        n.setType(type);
        n.setIsRead(0);
        notificationMapper.insert(n);
    }
}
