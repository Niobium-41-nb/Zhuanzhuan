package com.zhuanzhuan.modules.message.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zhuanzhuan.modules.message.entity.Message;
import com.zhuanzhuan.modules.message.mapper.MessageMapper;
import com.zhuanzhuan.modules.message.service.MessageService;
import com.zhuanzhuan.modules.message.vo.ConversationVO;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {

    private final MessageMapper messageMapper;
    private final UserMapper userMapper;

    @Override
    @Transactional
    public Message sendMessage(Long fromUserId, Long toUserId, String content, String type) {
        Message msg = new Message();
        msg.setFromUserId(fromUserId);
        msg.setToUserId(toUserId);
        msg.setContent(content);
        msg.setType(type != null ? type : "text");
        msg.setIsRead(0);
        messageMapper.insert(msg);
        return msg;
    }

    @Override
    public List<ConversationVO> getConversations(Long userId) {
        // Query recent messages grouped by conversation partner
        List<Message> recentMessages = messageMapper.selectList(
                new LambdaQueryWrapper<Message>()
                        .and(w -> w.eq(Message::getFromUserId, userId).or().eq(Message::getToUserId, userId))
                        .orderByDesc(Message::getCreatedAt));

        Map<Long, List<Message>> grouped = recentMessages.stream()
                .collect(Collectors.groupingBy(m ->
                        m.getFromUserId().equals(userId) ? m.getToUserId() : m.getFromUserId()));

        return grouped.entrySet().stream().map(entry -> {
            Long otherUserId = entry.getKey();
            List<Message> msgs = entry.getValue();
            Message last = msgs.get(0);

            ConversationVO vo = new ConversationVO();
            vo.setUserId(otherUserId);
            User other = userMapper.selectById(otherUserId);
            if (other != null) {
                vo.setNickname(other.getNickname() != null ? other.getNickname() : other.getUsername());
                vo.setAvatar(other.getAvatar());
            }
            vo.setLastMessage(last.getContent());
            vo.setLastTime(last.getCreatedAt());

            int unread = (int) msgs.stream().filter(m -> m.getToUserId().equals(userId) && m.getIsRead() == 0).count();
            vo.setUnreadCount(unread);
            return vo;
        }).sorted((a, b) -> b.getLastTime().compareTo(a.getLastTime()))
                .collect(Collectors.toList());
    }

    @Override
    public List<Map<String, Object>> getConversationMessages(Long userId, Long otherUserId, int page, int size) {
        Page<Message> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Message> wrapper = new LambdaQueryWrapper<Message>()
                .and(w -> w.and(w2 -> w2.eq(Message::getFromUserId, userId).eq(Message::getToUserId, otherUserId))
                        .or(w2 -> w2.eq(Message::getFromUserId, otherUserId).eq(Message::getToUserId, userId)))
                .orderByDesc(Message::getCreatedAt);
        IPage<Message> result = messageMapper.selectPage(pageParam, wrapper);

        return result.getRecords().stream().map(m -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", m.getId());
            map.put("fromUserId", m.getFromUserId());
            map.put("toUserId", m.getToUserId());
            map.put("content", m.getContent());
            map.put("type", m.getType());
            map.put("isRead", m.getIsRead());
            map.put("createdAt", m.getCreatedAt());
            return map;
        }).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void markAsRead(Long userId, Long otherUserId) {
        messageMapper.update(null, new LambdaQueryWrapper<Message>()
                .eq(Message::getFromUserId, otherUserId)
                .eq(Message::getToUserId, userId)
                .eq(Message::getIsRead, 0)
                .set(Message::getIsRead, 1));
    }

    @Override
    public int getUnreadCount(Long userId) {
        return Math.toIntExact(messageMapper.selectCount(
                new LambdaQueryWrapper<Message>().eq(Message::getToUserId, userId).eq(Message::getIsRead, 0)));
    }
}
