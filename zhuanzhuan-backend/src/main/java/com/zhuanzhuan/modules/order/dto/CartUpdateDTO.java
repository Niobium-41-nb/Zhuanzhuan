package com.zhuanzhuan.modules.order.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.Data;

@Data
public class CartUpdateDTO {
    @Min(value = 1, message = "数量不能小于1")
    @Max(value = 999, message = "数量不能超过999")
    private Integer quantity;

    @Min(value = 0, message = "选择状态无效")
    @Max(value = 1, message = "选择状态无效")
    private Integer selected;
}
