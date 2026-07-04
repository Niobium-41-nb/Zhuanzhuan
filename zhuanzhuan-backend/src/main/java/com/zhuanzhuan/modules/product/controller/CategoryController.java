package com.zhuanzhuan.modules.product.controller;

import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.product.service.CategoryService;
import com.zhuanzhuan.modules.product.vo.CategoryVO;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class CategoryController {

    private final CategoryService categoryService;

    @GetMapping("/category/list")
    public Result<List<CategoryVO>> getCategoryList() {
        return Result.success(categoryService.getCategoryTree());
    }
}
