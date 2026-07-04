package com.zhuanzhuan.modules.message.service;

import com.zhuanzhuan.modules.message.entity.Message;
import com.zhuanzhuan.modules.message.vo.ConversationVO;
import java.util.List;
import java.util.Map;

public interface MessageService {
    Message sendMessage(Long fromUserId, Long toUserId, String content, String type);
    List<ConversationVO> getConversations(Long userId);
    List<Map<String, Object>> getConversationMessages(Long userId, Long otherUserId, int page, int size);
    void markAsRead(Long userId, Long otherUserId);
    int getUnreadCount(Long userId);
}
