package com.zhuanzhuan.modules.user.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zhuanzhuan.modules.user.entity.User;
import org.apache.ibatis.annotations.Select;

public interface UserMapper extends BaseMapper<User> {
    @Select("SELECT * FROM user WHERE username = #{username} AND deleted_at IS NULL")
    User selectByUsername(String username);

    @Select("SELECT * FROM user WHERE email = #{email} AND deleted_at IS NULL")
    User selectByEmail(String email);

    @Select("SELECT * FROM user WHERE phone = #{phone} AND deleted_at IS NULL")
    User selectByPhone(String phone);
}
