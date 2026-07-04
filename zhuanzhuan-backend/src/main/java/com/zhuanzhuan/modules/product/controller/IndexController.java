package com.zhuanzhuan.modules.product.controller;

import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.message.entity.Announcement;
import com.zhuanzhuan.modules.message.mapper.AnnouncementMapper;
import com.zhuanzhuan.modules.order.entity.Order;
import com.zhuanzhuan.modules.order.mapper.OrderMapper;
import com.zhuanzhuan.modules.product.entity.Product;
import com.zhuanzhuan.modules.product.mapper.ProductMapper;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class IndexController {

    private final AnnouncementMapper announcementMapper;
    private final UserMapper userMapper;
    private final ProductMapper productMapper;
    private final OrderMapper orderMapper;

    @GetMapping("/index/recommend")
    public Result<List<com.zhuanzhuan.modules.product.vo.ProductListVO>> getRecommend() {
        return Result.success(List.of());
    }

    @GetMapping("/index/statistics")
    public Result<Map<String, Object>> getStatistics() {
        long userCount = userMapper.selectCount(null);
        long productCount = productMapper.selectCount(
                new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Product>()
                        .eq(Product::getStatus, "在售"));
        long orderCount = orderMapper.selectCount(null);
        Map<String, Object> stats = new HashMap<>();
        stats.put("userCount", userCount);
        stats.put("productCount", productCount);
        stats.put("orderCount", orderCount);
        return Result.success(stats);
    }

    @GetMapping("/announcement/list")
    public Result<List<Announcement>> getAnnouncementList() {
        List<Announcement> list = announcementMapper.selectList(
                new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Announcement>()
                        .eq(Announcement::getStatus, 1)
                        .orderByDesc(Announcement::getCreatedAt)
                        .last("LIMIT 10"));
        return Result.success(list);
    }
}
