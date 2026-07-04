package com.zhuanzhuan.modules.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.dto.LoginDTO;
import com.zhuanzhuan.modules.user.dto.RegisterDTO;
import com.zhuanzhuan.modules.user.dto.UserUpdateDTO;
import com.zhuanzhuan.modules.user.vo.LoginVO;
import com.zhuanzhuan.modules.user.vo.UserVO;

public interface UserService extends IService<User> {
    UserVO register(RegisterDTO dto);
    LoginVO login(LoginDTO dto);
    LoginVO refreshToken(String refreshToken);
    void sendCode(String target, String type);
    void resetPassword(String email, String code, String newPassword);
    UserVO getUserInfo(Long userId);
    UserVO updateUserInfo(Long userId, UserUpdateDTO dto);
    String uploadAvatar(Long userId, String avatarUrl);
}
