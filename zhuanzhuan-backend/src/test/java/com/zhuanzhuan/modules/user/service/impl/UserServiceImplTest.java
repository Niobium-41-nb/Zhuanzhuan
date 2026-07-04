package com.zhuanzhuan.modules.user.service.impl;

import com.zhuanzhuan.common.exception.BusinessException;
import com.zhuanzhuan.modules.product.mapper.ProductMapper;
import com.zhuanzhuan.modules.user.dto.LoginDTO;
import com.zhuanzhuan.modules.user.dto.RegisterDTO;
import com.zhuanzhuan.modules.user.dto.UserUpdateDTO;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import com.zhuanzhuan.modules.user.vo.LoginVO;
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
import org.springframework.test.util.ReflectionTestUtils;

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
    private ProductMapper productMapper;

    @Mock
    private ValueOperations<String, Object> valueOperations;

    private UserServiceImpl userService;

    @BeforeEach
    void setUp() {
        userService = new UserServiceImpl(
                userMapper, passwordEncoder, jwtUtil, redisTemplate, mailSender, productMapper);
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

    // ======================== Login ========================

    @Test
    void testLogin_Success_ByUsername() {
        LoginDTO dto = new LoginDTO();
        dto.setAccount("testuser");
        dto.setPassword("password123");

        User user = new User();
        user.setId(1L);
        user.setUsername("testuser");
        user.setPasswordHash("$2a$10$hash");
        user.setRole("user");
        user.setStatus(1);

        when(userMapper.selectByUsername("testuser")).thenReturn(user);
        when(passwordEncoder.matches("password123", "$2a$10$hash")).thenReturn(true);
        when(jwtUtil.generateAccessToken(1L, "user")).thenReturn("access-token");
        when(jwtUtil.generateRefreshToken(1L)).thenReturn("refresh-token");

        LoginVO result = userService.login(dto);

        assertNotNull(result);
        assertEquals("access-token", result.getAccessToken());
        assertEquals("refresh-token", result.getRefreshToken());
        verify(userMapper).updateById(any(User.class));
    }

    @Test
    void testLogin_UserNotFound() {
        LoginDTO dto = new LoginDTO();
        dto.setAccount("nonexistent");
        dto.setPassword("password123");

        when(userMapper.selectByUsername("nonexistent")).thenReturn(null);
        when(userMapper.selectByEmail("nonexistent")).thenReturn(null);
        when(userMapper.selectByPhone("nonexistent")).thenReturn(null);

        assertThrows(BusinessException.class, () -> userService.login(dto));
    }

    @Test
    void testLogin_DisabledUser() {
        LoginDTO dto = new LoginDTO();
        dto.setAccount("disabled");
        dto.setPassword("password123");

        User user = new User();
        user.setStatus(0);

        when(userMapper.selectByUsername("disabled")).thenReturn(user);

        BusinessException ex = assertThrows(BusinessException.class, () -> userService.login(dto));
        assertEquals(1001, ex.getCode());
    }

    @Test
    void testLogin_WrongPassword() {
        LoginDTO dto = new LoginDTO();
        dto.setAccount("testuser");
        dto.setPassword("wrong");

        User user = new User();
        user.setPasswordHash("$2a$10$hash");
        user.setStatus(1);

        when(userMapper.selectByUsername("testuser")).thenReturn(user);
        when(passwordEncoder.matches("wrong", "$2a$10$hash")).thenReturn(false);

        assertThrows(BusinessException.class, () -> userService.login(dto));
    }

    // ======================== Refresh Token ========================

    @Test
    void testRefreshToken_Success() {
        when(jwtUtil.validateToken("valid-refresh-token")).thenReturn(true);
        when(jwtUtil.isRefreshToken("valid-refresh-token")).thenReturn(true);
        when(jwtUtil.getUserIdFromToken("valid-refresh-token")).thenReturn(1L);

        User user = new User();
        user.setId(1L);
        user.setUsername("testuser");
        user.setRole("user");

        when(userMapper.selectById(1L)).thenReturn(user);
        when(jwtUtil.generateAccessToken(1L, "user")).thenReturn("new-access-token");
        when(jwtUtil.generateRefreshToken(1L)).thenReturn("new-refresh-token");

        LoginVO result = userService.refreshToken("valid-refresh-token");

        assertNotNull(result);
        assertEquals("new-access-token", result.getAccessToken());
    }

    @Test
    void testRefreshToken_Invalid() {
        when(jwtUtil.validateToken("bad-token")).thenReturn(false);

        assertThrows(BusinessException.class, () -> userService.refreshToken("bad-token"));
    }

    @Test
    void testRefreshToken_NotRefreshType() {
        when(jwtUtil.validateToken("access-token")).thenReturn(true);
        when(jwtUtil.isRefreshToken("access-token")).thenReturn(false);

        assertThrows(BusinessException.class, () -> userService.refreshToken("access-token"));
    }

    // ======================== Reset Password ========================

    @Test
    void testResetPassword_Success() {
        when(valueOperations.get("captcha:user@test.com")).thenReturn("123456");

        User user = new User();
        user.setId(1L);
        user.setEmail("user@test.com");
        when(userMapper.selectOne(any())).thenReturn(user);
        when(passwordEncoder.encode("newPass123")).thenReturn("$2a$10$newhash");

        userService.resetPassword("user@test.com", "123456", "newPass123");

        verify(redisTemplate).delete("captcha:user@test.com");
        verify(userMapper).updateById(user);
        assertEquals("$2a$10$newhash", user.getPasswordHash());
    }

    @Test
    void testResetPassword_WrongCode() {
        when(valueOperations.get("captcha:user@test.com")).thenReturn("123456");

        assertThrows(BusinessException.class,
                () -> userService.resetPassword("user@test.com", "wrong", "newPass123"));
    }

    // ======================== User Info ========================

    @Test
    void testGetUserInfo_Success() {
        User user = new User();
        user.setId(1L);
        user.setUsername("testuser");
        user.setNickname("Test");
        user.setEmail("test@test.com");

        when(userMapper.selectById(1L)).thenReturn(user);
        when(productMapper.countByUserId(1L)).thenReturn(5);

        UserVO result = userService.getUserInfo(1L);

        assertNotNull(result);
        assertEquals("Test", result.getNickname());
        assertEquals(5, result.getProductCount());
    }

    @Test
    void testGetUserInfo_NotFound() {
        when(userMapper.selectById(999L)).thenReturn(null);
        assertThrows(BusinessException.class, () -> userService.getUserInfo(999L));
    }

    @Test
    void testUpdateUserInfo() {
        User user = new User();
        user.setId(1L);
        user.setNickname("old");

        when(userMapper.selectById(1L)).thenReturn(user);

        UserUpdateDTO dto = new UserUpdateDTO();
        dto.setNickname("new-nick");
        dto.setBio("hello");
        dto.setGender(1);

        UserVO result = userService.updateUserInfo(1L, dto);

        assertEquals("new-nick", result.getNickname());
        verify(userMapper).updateById(user);
    }

    @Test
    void testUploadAvatar() {
        User user = new User();
        user.setId(1L);
        when(userMapper.selectById(1L)).thenReturn(user);

        String url = userService.uploadAvatar(1L, "http://example.com/avatar.jpg");

        assertEquals("http://example.com/avatar.jpg", url);
        assertEquals("http://example.com/avatar.jpg", user.getAvatar());
        verify(userMapper).updateById(user);
    }
}
