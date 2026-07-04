package com.zhuanzhuan.modules.user.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UserUpdateDTO {
    @Size(max = 30, message = "昵称长度不能超过30个字符")
    private String nickname;

    @Size(max = 200, message = "个人简介长度不能超过200个字符")
    private String bio;

    @Min(value = 0, message = "性别值无效")
    @Max(value = 2, message = "性别值无效")
    private Integer gender;
}
