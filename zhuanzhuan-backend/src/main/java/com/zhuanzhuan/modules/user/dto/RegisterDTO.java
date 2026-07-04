package com.zhuanzhuan.modules.user.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class RegisterDTO {
    @NotBlank(message = "用户名不能为空")
    @Pattern(regexp = "^[a-zA-Z0-9_]{2,20}$", message = "用户名格式不正确")
    private String username;

    @NotBlank(message = "密码不能为空")
    @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d).{8,20}$", message = "密码需8-20位，包含字母和数字")
    private String password;

    private String email;

    private String phone;

    @NotBlank(message = "验证码不能为空")
    private String code;
}
