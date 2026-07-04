package com.zhuanzhuan.modules.order.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class OrderShipDTO {
    @NotBlank(message = "请选择物流公司")
    private String logisticsCompany;
    @NotBlank(message = "请输入物流单号")
    private String logisticsNo;
}
