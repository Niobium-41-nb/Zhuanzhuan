package com.zhuanzhuan.modules.product.vo;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Map;

@Data
public class ProductListVO {
    private Long id;
    private String title;
    private BigDecimal price;
    private BigDecimal originalPrice;
    private String coverImage;
    private String condition;
    private String status;
    private Integer viewCount;
    private Integer favoriteCount;
    private String categoryName;
    private Map<String, Object> seller;
    private LocalDateTime createdAt;
}
