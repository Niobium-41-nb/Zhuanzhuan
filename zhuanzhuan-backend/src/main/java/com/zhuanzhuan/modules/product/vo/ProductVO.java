package com.zhuanzhuan.modules.product.vo;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Data
public class ProductVO {
    private Long id;
    private String title;
    private String description;
    private BigDecimal price;
    private BigDecimal originalPrice;
    private String condition;
    private String status;
    private String coverImage;
    private Integer viewCount;
    private Integer favoriteCount;
    private Boolean isFavorited;
    private List<Map<String, Object>> images;
    private Map<String, Object> category;
    private Map<String, Object> seller;
    private LocalDateTime createdAt;
}
