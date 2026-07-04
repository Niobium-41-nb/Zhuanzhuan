package com.zhuanzhuan.modules.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zhuanzhuan.modules.product.entity.Product;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface ProductMapper extends BaseMapper<Product> {

    IPage<Product> selectPageWithCondition(Page<Product> page, @Param("keyword") String keyword,
                                            @Param("categoryId") Long categoryId,
                                            @Param("minPrice") java.math.BigDecimal minPrice,
                                            @Param("maxPrice") java.math.BigDecimal maxPrice,
                                            @Param("condition") String condition,
                                            @Param("status") String status,
                                            @Param("userId") Long userId,
                                            @Param("sort") String sort,
                                            @Param("order") String order);

    @Update("UPDATE product SET view_count = view_count + 1 WHERE id = #{id}")
    void incrementViewCount(Long id);

    @Select("SELECT COUNT(*) FROM product WHERE user_id = #{userId} AND deleted_at IS NULL")
    int countByUserId(Long userId);
}
