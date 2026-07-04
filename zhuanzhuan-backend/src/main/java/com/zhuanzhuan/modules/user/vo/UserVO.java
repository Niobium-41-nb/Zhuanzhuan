package com.zhuanzhuan.modules.user.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UserVO {
    private Long userId;
    private String username;
    private String nickname;
    private String email;
    private String phone;
    private String avatar;
    private String bio;
    private Integer gender;
    private String role;
    private Integer creditScore;
    private Integer productCount;
    private LocalDateTime createdAt;
}
