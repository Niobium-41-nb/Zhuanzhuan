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

    /** 短信验证码登录 */
    LoginVO loginByPhone(LoginDTO dto);

    /** 发送手机短信验证码 */
    void sendSmsCode(String phone, String type);

    /** 绑定手机号到当前用户 */
    UserVO bindPhone(Long userId, String phone, String code);
}
