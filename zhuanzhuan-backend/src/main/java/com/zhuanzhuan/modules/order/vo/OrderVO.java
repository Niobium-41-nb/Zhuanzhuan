package com.zhuanzhuan.modules.order.vo;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class OrderVO {
    private Long orderId;
    private String orderNo;
    private Long productId;
    private String productTitle;
    private String productImage;
    private BigDecimal totalPrice;
    private String status;
    private String shippingName;
    private String shippingPhone;
    private String shippingAddress;
    private String logisticsCompany;
    private String logisticsNo;
    private String buyerName;
    private String sellerName;
    private LocalDateTime createdAt;
    private LocalDateTime paidAt;
    private LocalDateTime shippedAt;
    private LocalDateTime receivedAt;
}
