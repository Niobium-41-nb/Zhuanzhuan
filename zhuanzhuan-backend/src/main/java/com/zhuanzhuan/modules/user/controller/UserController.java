package com.zhuanzhuan.modules.user.controller;

import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.user.dto.LoginDTO;
import com.zhuanzhuan.modules.user.dto.RegisterDTO;
import com.zhuanzhuan.modules.user.dto.UserUpdateDTO;
import com.zhuanzhuan.modules.user.entity.Address;
import com.zhuanzhuan.modules.user.service.AddressService;
import com.zhuanzhuan.modules.user.service.UserService;
import com.zhuanzhuan.modules.user.vo.LoginVO;
import com.zhuanzhuan.modules.user.vo.UserVO;
import com.zhuanzhuan.security.JwtUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final AddressService addressService;
    private final JwtUtil jwtUtil;
    private final RedisTemplate<String, Object> redisTemplate;

    private Long getCurrentUserId() {
        return (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }

    @PostMapping("/register")
    public Result<UserVO> register(@Valid @RequestBody RegisterDTO dto) {
        return Result.success("注册成功", userService.register(dto));
    }

    @PostMapping("/login")
    public Result<LoginVO> login(@Valid @RequestBody LoginDTO dto) {
        return Result.success("登录成功", userService.login(dto));
    }

    @PostMapping("/logout")
    public Result<Void> logout(@RequestHeader("Authorization") String authHeader) {
        // 将 Token 加入黑名单
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            String tokenId = jwtUtil.getTokenId(token);
            if (tokenId != null) {
                long expiration = jwtUtil.getExpiration(token);
                long ttl = expiration - System.currentTimeMillis();
                if (ttl > 0) {
                    redisTemplate.opsForValue().set("blacklist:token:" + tokenId, "1",
                            ttl, TimeUnit.MILLISECONDS);
                }
            }
        }
        SecurityContextHolder.clearContext();
        return Result.success("退出成功");
    }

    @PostMapping("/refresh")
    public Result<LoginVO> refresh(@RequestBody Map<String, String> body) {
        return Result.success(userService.refreshToken(body.get("refreshToken")));
    }

    @PostMapping("/code")
    public Result<Void> sendCode(@RequestBody Map<String, String> body) {
        userService.sendCode(body.get("target"), body.get("type"));
        return Result.success("验证码已发送");
    }

    @PostMapping("/password/reset")
    public Result<Void> resetPassword(@RequestBody Map<String, String> body) {
        userService.resetPassword(body.get("target"), body.get("code"), body.get("newPassword"));
        return Result.success("密码重置成功");
    }

    @GetMapping("/info")
    public Result<UserVO> getUserInfo() {
        return Result.success(userService.getUserInfo(getCurrentUserId()));
    }

    @PutMapping("/info")
    public Result<UserVO> updateUserInfo(@RequestBody UserUpdateDTO dto) {
        return Result.success(userService.updateUserInfo(getCurrentUserId(), dto));
    }

    @PostMapping("/avatar")
    public Result<Map<String, String>> uploadAvatar(@RequestBody Map<String, String> body) {
        String url = userService.uploadAvatar(getCurrentUserId(), body.get("avatar"));
        return Result.success(Map.of("avatar", url));
    }

    // === Address Management ===
    @GetMapping("/address")
    public Result<List<Address>> getAddresses() {
        return Result.success(addressService.getUserAddresses(getCurrentUserId()));
    }

    @PostMapping("/address")
    public Result<Address> addAddress(@RequestBody Address address) {
        return Result.success("新增成功", addressService.addAddress(getCurrentUserId(), address));
    }

    @PutMapping("/address/{id}")
    public Result<Address> updateAddress(@PathVariable Long id, @RequestBody Address address) {
        return Result.success(addressService.updateAddress(getCurrentUserId(), id, address));
    }

    @DeleteMapping("/address/{id}")
    public Result<Void> deleteAddress(@PathVariable Long id) {
        addressService.deleteAddress(getCurrentUserId(), id);
        return Result.success("删除成功");
    }

    @PutMapping("/address/{id}/default")
    public Result<Void> setDefaultAddress(@PathVariable Long id) {
        addressService.setDefault(getCurrentUserId(), id);
        return Result.success("设置成功");
    }
}
