package com.zhuanzhuan.modules.user.service.impl;

import com.zhuanzhuan.common.exception.BusinessException;
import com.zhuanzhuan.common.sms.SmsService;
import com.zhuanzhuan.modules.user.dto.RegisterDTO;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import com.zhuanzhuan.modules.user.vo.UserVO;
import com.zhuanzhuan.security.JwtUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.mockito.Mockito.lenient;

@ExtendWith(MockitoExtension.class)
class UserServiceImplTest {

    @Mock
    private UserMapper userMapper;

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private JwtUtil jwtUtil;

    @Mock
    private RedisTemplate<String, Object> redisTemplate;

    @Mock
    private JavaMailSender mailSender;

    @Mock
    private SmsService smsService;

    @Mock
    private ValueOperations<String, Object> valueOperations;

    private UserServiceImpl userService;

    @BeforeEach
    void setUp() {
        userService = new UserServiceImpl(
                userMapper, passwordEncoder, jwtUtil, redisTemplate, mailSender, smsService);
        lenient().when(redisTemplate.opsForValue()).thenReturn(valueOperations);
    }

    @Test
    void testRegister_Success() {
        // Arrange
        RegisterDTO dto = new RegisterDTO();
        dto.setUsername("newuser");
        dto.setEmail("new@test.com");
        dto.setPassword("password123");
        dto.setCode("123456");

        when(userMapper.selectByUsername("newuser")).thenReturn(null);
        when(userMapper.selectByEmail("new@test.com")).thenReturn(null);
        when(valueOperations.get("captcha:new@test.com")).thenReturn("123456");
        when(passwordEncoder.encode("password123")).thenReturn("$2a$10$hash");
        when(userMapper.insert(any(User.class))).thenReturn(1);

        // Act
        UserVO result = userService.register(dto);

        // Assert
        assertNotNull(result);
        verify(userMapper).insert(any(User.class));
        verify(redisTemplate).delete("captcha:new@test.com");
    }

    @Test
    void testRegister_DuplicateUsername() {
        RegisterDTO dto = new RegisterDTO();
        dto.setUsername("existing");
        dto.setPassword("password123");

        lenient().when(userMapper.selectByUsername("existing")).thenReturn(new User());

        assertThrows(BusinessException.class, () -> userService.register(dto));
    }

    @Test
    void testRegister_WrongCode() {
        RegisterDTO dto = new RegisterDTO();
        dto.setUsername("newuser");
        dto.setEmail("new@test.com");
        dto.setPassword("password123");
        dto.setCode("wrong");

        when(userMapper.selectByUsername("newuser")).thenReturn(null);
        when(userMapper.selectByEmail("new@test.com")).thenReturn(null);
        when(valueOperations.get("captcha:new@test.com")).thenReturn("123456");

        assertThrows(BusinessException.class, () -> userService.register(dto));
    }
}
