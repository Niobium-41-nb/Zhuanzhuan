package com.zhuanzhuan.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class JwtUtilTest {

    private JwtUtil jwtUtil;

    @BeforeEach
    void setUp() {
        jwtUtil = new JwtUtil(
                "TestSecretKeyForJUnitTestingOnly12345678901234567890",
                3600000L,
                604800000L);
    }

    @Test
    void testGenerateAndValidateAccessToken() {
        String token = jwtUtil.generateAccessToken(1L, "user");
        assertNotNull(token);
        assertTrue(jwtUtil.validateToken(token));
        assertEquals(1L, jwtUtil.getUserIdFromToken(token));
        assertFalse(jwtUtil.isRefreshToken(token));
    }

    @Test
    void testGenerateAndValidateRefreshToken() {
        String token = jwtUtil.generateRefreshToken(2L);
        assertNotNull(token);
        assertTrue(jwtUtil.validateToken(token));
        assertEquals(2L, jwtUtil.getUserIdFromToken(token));
        assertTrue(jwtUtil.isRefreshToken(token));
    }

    @Test
    void testInvalidToken() {
        assertFalse(jwtUtil.validateToken("invalid.token.here"));
    }
}
