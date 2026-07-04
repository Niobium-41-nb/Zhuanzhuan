package com.zhuanzhuan.modules.order.dto;

import lombok.Data;

@Data
public class CartUpdateDTO {
    private Integer quantity;
    private Integer selected;
}
