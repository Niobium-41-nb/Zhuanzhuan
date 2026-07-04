package com.zhuanzhuan.modules.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zhuanzhuan.modules.product.entity.Favorite;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

public interface FavoriteMapper extends BaseMapper<Favorite> {
    @Select("SELECT * FROM favorite WHERE user_id = #{userId} AND product_id = #{productId}")
    Favorite selectByUserAndProduct(Long userId, Long productId);

    @Delete("DELETE FROM favorite WHERE user_id = #{userId} AND product_id = #{productId}")
    void deleteByUserAndProduct(Long userId, Long productId);

    @Select("SELECT COUNT(*) FROM favorite WHERE product_id = #{productId}")
    int countByProductId(Long productId);
}
