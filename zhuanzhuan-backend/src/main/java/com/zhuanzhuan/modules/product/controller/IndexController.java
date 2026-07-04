package com.zhuanzhuan.modules.product.controller;

import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.message.entity.Announcement;
import com.zhuanzhuan.modules.message.mapper.AnnouncementMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class IndexController {

    private final AnnouncementMapper announcementMapper;

    @GetMapping("/index/recommend")
    public Result<List<com.zhuanzhuan.modules.product.vo.ProductListVO>> getRecommend() {
        return Result.success(List.of());
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
