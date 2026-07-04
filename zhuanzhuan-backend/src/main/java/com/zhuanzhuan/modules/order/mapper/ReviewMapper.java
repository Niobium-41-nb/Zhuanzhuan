package com.zhuanzhuan.modules.order.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zhuanzhuan.modules.order.entity.Review;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface ReviewMapper extends BaseMapper<Review> {

    @Select("SELECT * FROM review WHERE order_id = #{orderId} AND from_user_id = #{userId} LIMIT 1")
    Review selectByOrderAndUser(@Param("orderId") Long orderId, @Param("userId") Long userId);
}
