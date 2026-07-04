package com.zhuanzhuan.modules.order.service;

import com.zhuanzhuan.modules.order.dto.ReviewDTO;
import java.util.Map;

public interface ReviewService {
    Map<String, Object> createReview(Long userId, Long orderId, ReviewDTO dto);
    Map<String, Object> getReviewByOrder(Long orderId);
}
