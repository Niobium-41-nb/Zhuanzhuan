package com.zhuanzhuan.modules.product.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import java.math.BigDecimal;
import java.util.List;

@Data
public class ProductPublishDTO {
    @NotBlank(message = "商品标题不能为空")
    @Size(min = 5, max = 50, message = "标题长度5-50字")
    private String title;

    private String description;

    @NotNull(message = "价格不能为空")
    @DecimalMin(value = "0.01", message = "价格必须大于0")
    private BigDecimal price;

    private BigDecimal originalPrice;

    @NotBlank(message = "请选择成色")
    private String condition;

    @NotNull(message = "请选择分类")
    private Long categoryId;

    private List<Long> imageIds;
}
