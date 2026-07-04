package com.zhuanzhuan.modules.user.service.impl;

import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zhuanzhuan.common.exception.BusinessException;
import com.zhuanzhuan.common.sms.SmsService;
import com.zhuanzhuan.modules.user.dto.LoginDTO;
import com.zhuanzhuan.modules.user.dto.RegisterDTO;
import com.zhuanzhuan.modules.user.dto.UserUpdateDTO;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import com.zhuanzhuan.modules.user.service.UserService;
import com.zhuanzhuan.modules.user.vo.LoginVO;
import com.zhuanzhuan.modules.user.vo.UserVO;
import com.zhuanzhuan.security.JwtUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.concurrent.TimeUnit;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;
    private final RedisTemplate<String, Object> redisTemplate;
    private final JavaMailSender mailSender;
    private final SmsService smsService;

    @Value("${spring.mail.username}")
    private String mailFrom;

    @Override
    @Transactional
    public UserVO register(RegisterDTO dto) {
        // Check username
        if (userMapper.selectByUsername(dto.getUsername()) != null) {
            throw new BusinessException(409, "用户名已存在");
        }
        // Check email
        if (dto.getEmail() != null && userMapper.selectByEmail(dto.getEmail()) != null) {
            throw new BusinessException(409, "邮箱已被注册");
        }
        // Check phone
        if (dto.getPhone() != null && userMapper.selectByPhone(dto.getPhone()) != null) {
            throw new BusinessException(409, "手机号已被注册");
        }
        // Verify code
        String cacheKey = dto.getEmail() != null ? "captcha:" + dto.getEmail() : "captcha:" + dto.getPhone();
        String cachedCode = (String) redisTemplate.opsForValue().get(cacheKey);
        if (!dto.getCode().equals(cachedCode)) {
            throw new BusinessException(1003, "验证码错误或已过期");
        }
        redisTemplate.delete(cacheKey);

        User user = new User();
        user.setUsername(dto.getUsername());
        user.setPasswordHash(passwordEncoder.encode(dto.getPassword()));
        user.setEmail(dto.getEmail());
        user.setPhone(dto.getPhone());
        user.setNickname(dto.getUsername());
        user.setRole("user");
        user.setStatus(1);
        user.setCreditScore(100);
        userMapper.insert(user);

        return toUserVO(user);
    }

    @Override
    public LoginVO login(LoginDTO dto) {
        User user = userMapper.selectByUsername(dto.getAccount());
        if (user == null) {
            user = userMapper.selectByEmail(dto.getAccount());
        }
        if (user == null) {
            user = userMapper.selectByPhone(dto.getAccount());
        }
        if (user == null) {
            throw new BusinessException("账号不存在");
        }
        if (user.getStatus() == 0) {
            throw new BusinessException(1001, "账户已被禁用");
        }
        if (!passwordEncoder.matches(dto.getPassword(), user.getPasswordHash())) {
            throw new BusinessException("密码错误");
        }

        user.setLastLoginAt(LocalDateTime.now());
        userMapper.updateById(user);

        return buildLoginVO(user);
    }

    @Override
    public LoginVO refreshToken(String refreshToken) {
        if (!jwtUtil.validateToken(refreshToken) || !jwtUtil.isRefreshToken(refreshToken)) {
            throw new BusinessException(1004, "Refresh Token 无效或已过期");
        }
        Long userId = jwtUtil.getUserIdFromToken(refreshToken);
        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new BusinessException("用户不存在");
        }
        return buildLoginVO(user);
    }

    @Override
    public void sendCode(String target, String type) {
        String code = RandomUtil.randomNumbers(6);
        String cacheKey = "captcha:" + target;
        redisTemplate.opsForValue().set(cacheKey, code, 5, TimeUnit.MINUTES);

        if ("sms".equals(type)) {
            // 发送短信验证码
            try {
                smsService.sendSmsCode(target, code);
                log.info("短信验证码已发送至手机 {}: {}", target, code);
            } catch (Exception e) {
                log.error("发送短信验证码至 {} 失败: {}", target, e.getMessage());
                throw new BusinessException(500, "短信验证码发送失败，请稍后重试");
            }
        } else {
            // 发送邮件验证码
            try {
                SimpleMailMessage message = new SimpleMailMessage();
                message.setFrom(mailFrom);
                message.setTo(target);
                message.setSubject("转转 - 邮箱验证码");
                message.setText("您的验证码是: " + code + "\n\n验证码有效期为5分钟，请勿泄露给他人。\n\n如果非本人操作，请忽略此邮件。");
                mailSender.send(message);
                log.info("验证码已发送至邮箱 {}: {}", target, code);
            } catch (Exception e) {
                log.error("发送验证码至 {} 失败: {}", target, e.getMessage());
                throw new BusinessException(500, "验证码发送失败，请检查邮箱地址或稍后重试");
            }
        }
    }

    @Override
    @Transactional
    public void resetPassword(String target, String code, String newPassword) {
        String cacheKey = "captcha:" + target;
        String cachedCode = (String) redisTemplate.opsForValue().get(cacheKey);
        if (!code.equals(cachedCode)) {
            throw new BusinessException(1003, "验证码错误或已过期");
        }
        redisTemplate.delete(cacheKey);

        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getEmail, target).or().eq(User::getPhone, target);
        User user = userMapper.selectOne(wrapper);
        if (user == null) {
            throw new BusinessException("用户不存在");
        }
        user.setPasswordHash(passwordEncoder.encode(newPassword));
        userMapper.updateById(user);
    }

    @Override
    public UserVO getUserInfo(Long userId) {
        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new BusinessException("用户不存在");
        }
        UserVO vo = toUserVO(user);
        vo.setProductCount(countProductByUser(userId));
        return vo;
    }

    @Override
    public UserVO updateUserInfo(Long userId, UserUpdateDTO dto) {
        User user = userMapper.selectById(userId);
        if (dto.getNickname() != null) user.setNickname(dto.getNickname());
        if (dto.getBio() != null) user.setBio(dto.getBio());
        if (dto.getGender() != null) user.setGender(dto.getGender());
        userMapper.updateById(user);
        return toUserVO(user);
    }

    @Override
    public String uploadAvatar(Long userId, String avatarUrl) {
        User user = userMapper.selectById(userId);
        user.setAvatar(avatarUrl);
        userMapper.updateById(user);
        return avatarUrl;
    }

    private LoginVO buildLoginVO(User user) {
        String accessToken = jwtUtil.generateAccessToken(user.getId(), user.getRole());
        String refreshToken = jwtUtil.generateRefreshToken(user.getId());

        LoginVO loginVO = new LoginVO();
        loginVO.setAccessToken(accessToken);
        loginVO.setRefreshToken(refreshToken);
        loginVO.setExpiresIn(7200L);
        loginVO.setUser(toUserVO(user));
        return loginVO;
    }

    private UserVO toUserVO(User user) {
        UserVO vo = new UserVO();
        BeanUtils.copyProperties(user, vo);
        vo.setUserId(user.getId());
        if (vo.getNickname() == null) vo.setNickname(user.getUsername());
        // Desensitize
        if (user.getPhone() != null) {
            vo.setPhone(user.getPhone().replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2"));
        }
        if (user.getEmail() != null) {
            vo.setEmail(user.getEmail().replaceAll("(\\w?)(\\w+)(\\w)(@\\w+)", "$1****$3$4"));
        }
        return vo;
    }

    private int countProductByUser(Long userId) {
        return Math.toIntExact(baseMapper.selectCount(
                new LambdaQueryWrapper<User>().eq(User::getId, userId)
        ));
    }

    // ======================== 短信验证码登录 ========================

    @Override
    public LoginVO loginByPhone(LoginDTO dto) {
        // 校验手机号
        User user = userMapper.selectByPhone(dto.getAccount());
        if (user == null) {
            throw new BusinessException("该手机号未注册");
        }
        if (user.getStatus() == 0) {
            throw new BusinessException(1001, "账户已被禁用");
        }
        // 校验短信验证码
        String cacheKey = "captcha:" + dto.getAccount();
        String cachedCode = (String) redisTemplate.opsForValue().get(cacheKey);
        if (!dto.getCode().equals(cachedCode)) {
            throw new BusinessException(1003, "验证码错误或已过期");
        }
        redisTemplate.delete(cacheKey);

        user.setLastLoginAt(LocalDateTime.now());
        userMapper.updateById(user);

        return buildLoginVO(user);
    }

    @Override
    public void sendSmsCode(String phone, String type) {
        sendCode(phone, "sms");
    }

    // ======================== 绑定手机号 ========================

    @Override
    @Transactional
    public UserVO bindPhone(Long userId, String phone, String code) {
        // 校验手机号是否已被其他用户绑定
        User existing = userMapper.selectByPhone(phone);
        if (existing != null && !existing.getId().equals(userId)) {
            throw new BusinessException(409, "该手机号已被其他账号绑定");
        }
        // 校验验证码
        String cacheKey = "captcha:" + phone;
        String cachedCode = (String) redisTemplate.opsForValue().get(cacheKey);
        if (!code.equals(cachedCode)) {
            throw new BusinessException(1003, "验证码错误或已过期");
        }
        redisTemplate.delete(cacheKey);

        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new BusinessException("用户不存在");
        }
        user.setPhone(phone);
        userMapper.updateById(user);

        return toUserVO(user);
    }
}
