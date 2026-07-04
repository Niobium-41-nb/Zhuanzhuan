package com.zhuanzhuan.modules.user.dto;

import lombok.Data;

@Data
public class UserUpdateDTO {
    private String nickname;
    private String bio;
    private Integer gender;
}
