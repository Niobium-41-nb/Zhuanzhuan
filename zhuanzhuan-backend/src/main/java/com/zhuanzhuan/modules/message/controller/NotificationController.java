package com.zhuanzhuan.modules.message.controller;

import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.message.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/notification")
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;

    private Long getCurrentUserId() {
        return (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }

    @GetMapping("/list")
    public Result<List<Map<String, Object>>> getNotificationList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        return Result.success(notificationService.getNotificationList(getCurrentUserId(), page, size));
    }

    @PutMapping("/read/{id}")
    public Result<Void> markAsRead(@PathVariable Long id) {
        notificationService.markAsRead(getCurrentUserId(), id);
        return Result.success("success");
    }

    @GetMapping("/unread/count")
    public Result<Map<String, Integer>> getUnreadCount() {
        return Result.success(Map.of("count", notificationService.getUnreadCount(getCurrentUserId())));
    }
}
