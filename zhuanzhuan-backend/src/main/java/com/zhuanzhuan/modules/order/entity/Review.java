package com.zhuanzhuan.modules.order.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("review")
public class Review {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long orderId;
    private Long fromUserId;
    private Long toUserId;
    private Integer rating;
    private String content;
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}
