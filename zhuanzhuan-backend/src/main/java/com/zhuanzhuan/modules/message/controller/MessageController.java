package com.zhuanzhuan.modules.message.controller;

import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.message.service.MessageService;
import com.zhuanzhuan.modules.message.vo.ConversationVO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/message")
@RequiredArgsConstructor
public class MessageController {

    private final MessageService messageService;

    private Long getCurrentUserId() {
        return (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }

    @GetMapping("/conversations")
    public Result<List<ConversationVO>> getConversations() {
        return Result.success(messageService.getConversations(getCurrentUserId()));
    }

    @GetMapping("/conversation/{userId}")
    public Result<List<Map<String, Object>>> getConversation(
            @PathVariable Long userId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        return Result.success(messageService.getConversationMessages(getCurrentUserId(), userId, page, size));
    }

    @PostMapping("/send")
    public Result<?> sendMessage(@RequestBody Map<String, Object> body) {
        Long toUserId = Long.valueOf(body.get("toUserId").toString());
        String content = (String) body.get("content");
        String type = (String) body.get("type");
        return Result.success(messageService.sendMessage(getCurrentUserId(), toUserId, content, type));
    }

    @PutMapping("/read/{userId}")
    public Result<Void> markAsRead(@PathVariable Long userId) {
        messageService.markAsRead(getCurrentUserId(), userId);
        return Result.success("success");
    }

    @GetMapping("/unread/count")
    public Result<Map<String, Integer>> getUnreadCount() {
        return Result.success(Map.of("count", messageService.getUnreadCount(getCurrentUserId())));
    }
}
