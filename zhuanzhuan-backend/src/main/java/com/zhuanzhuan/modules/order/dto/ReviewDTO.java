package com.zhuanzhuan.modules.order.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ReviewDTO {
    @NotNull(message = "请给出评分")
    @Min(value = 1, message = "最低1分")
    @Max(value = 5, message = "最高5分")
    private Integer rating;
    private String content;
}
