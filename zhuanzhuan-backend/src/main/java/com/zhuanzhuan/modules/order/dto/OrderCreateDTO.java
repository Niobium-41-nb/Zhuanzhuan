package com.zhuanzhuan.modules.order.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class OrderCreateDTO {
    @NotNull(message = "请选择商品")
    private Long productId;
    private Long addressId;
    private String remark;
}
