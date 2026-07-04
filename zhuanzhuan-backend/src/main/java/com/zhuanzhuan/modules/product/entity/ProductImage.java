package com.zhuanzhuan.modules.product.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("product_image")
public class ProductImage {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long productId;
    private String url;
    private Integer sortOrder;
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}
