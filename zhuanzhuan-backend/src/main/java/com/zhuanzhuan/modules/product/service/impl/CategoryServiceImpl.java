package com.zhuanzhuan.modules.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.zhuanzhuan.modules.product.entity.Category;
import com.zhuanzhuan.modules.product.mapper.CategoryMapper;
import com.zhuanzhuan.modules.product.service.CategoryService;
import com.zhuanzhuan.modules.product.vo.CategoryVO;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final CategoryMapper categoryMapper;
    private final RedisTemplate<String, Object> redisTemplate;

    @Override
    @SuppressWarnings("unchecked")
    public List<CategoryVO> getCategoryTree() {
        String cacheKey = "category:tree";
        List<CategoryVO> cached = (List<CategoryVO>) redisTemplate.opsForValue().get(cacheKey);
        if (cached != null) return cached;

        List<Category> all = categoryMapper.selectList(
                new LambdaQueryWrapper<Category>().eq(Category::getStatus, 1).orderByAsc(Category::getSortOrder));

        List<CategoryVO> tree = buildTree(all, 0L);
        redisTemplate.opsForValue().set(cacheKey, tree, 24, TimeUnit.HOURS);
        return tree;
    }

    private List<CategoryVO> buildTree(List<Category> all, Long parentId) {
        return all.stream()
                .filter(c -> c.getParentId() != null && c.getParentId().equals(parentId))
                .map(c -> {
                    CategoryVO vo = new CategoryVO();
                    vo.setId(c.getId());
                    vo.setName(c.getName());
                    vo.setIcon(c.getIcon());
                    vo.setChildren(buildTree(all, c.getId()));
                    return vo;
                }).collect(Collectors.toList());
    }
}
