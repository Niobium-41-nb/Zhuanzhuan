package com.zhuanzhuan.modules.order.service.impl;

import com.zhuanzhuan.common.exception.BusinessException;
import com.zhuanzhuan.modules.order.dto.ReviewDTO;
import com.zhuanzhuan.modules.order.entity.Order;
import com.zhuanzhuan.modules.order.entity.Review;
import com.zhuanzhuan.modules.order.mapper.OrderMapper;
import com.zhuanzhuan.modules.order.mapper.ReviewMapper;
import com.zhuanzhuan.modules.order.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {

    private final ReviewMapper reviewMapper;
    private final OrderMapper orderMapper;

    @Override
    @Transactional
    public Map<String, Object> createReview(Long userId, Long orderId, ReviewDTO dto) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) throw new BusinessException(404, "订单不存在");
        if (!"已完成".equals(order.getStatus())) throw new BusinessException(3001, "订单未完成，无法评价");

        Review review = new Review();
        review.setOrderId(orderId);
        review.setFromUserId(userId);
        review.setToUserId(order.getBuyerId().equals(userId) ? order.getSellerId() : order.getBuyerId());
        review.setRating(dto.getRating());
        review.setContent(dto.getContent());
        reviewMapper.insert(review);

        Map<String, Object> result = new HashMap<>();
        result.put("reviewId", review.getId());
        result.put("rating", dto.getRating());
        return result;
    }

    @Override
    public Map<String, Object> getReviewByOrder(Long orderId) {
        Review review = reviewMapper.selectOne(
                new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Review>()
                        .eq(Review::getOrderId, orderId));
        if (review == null) return null;
        Map<String, Object> result = new HashMap<>();
        result.put("rating", review.getRating());
        result.put("content", review.getContent());
        result.put("createdAt", review.getCreatedAt());
        return result;
    }
}
