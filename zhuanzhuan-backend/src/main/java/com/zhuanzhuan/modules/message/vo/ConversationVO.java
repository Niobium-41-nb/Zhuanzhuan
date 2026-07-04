package com.zhuanzhuan.modules.message.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ConversationVO {
    private Long userId;
    private String nickname;
    private String avatar;
    private String lastMessage;
    private LocalDateTime lastTime;
    private Integer unreadCount;
}
