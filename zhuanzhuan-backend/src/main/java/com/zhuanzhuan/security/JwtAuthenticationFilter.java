package com.zhuanzhuan.security;

import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final UserMapper userMapper;
    private final RedisTemplate<String, Object> redisTemplate;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        String token = extractToken(request);

        if (StringUtils.hasText(token) && jwtUtil.validateToken(token) && !jwtUtil.isRefreshToken(token)) {
            Long userId = jwtUtil.getUserIdFromToken(token);

            // 检查 Token 是否已被吊销
            String tokenId = jwtUtil.getTokenId(token);
            if (tokenId != null && Boolean.TRUE.equals(redisTemplate.hasKey("blacklist:token:" + tokenId))) {
                filterChain.doFilter(request, response);
                return;
            }

            // 从数据库重新读取用户状态和角色
            User user = userMapper.selectById(userId);
            if (user == null || user.getStatus() == 0) {
                log.warn("Token rejected: user {} not found or disabled", userId);
                filterChain.doFilter(request, response);
                return;
            }

            // 使用数据库中的角色，而非 Token 中的 claim
            String role = user.getRole();

            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(userId, null, Collections.singletonList(
                            () -> "ROLE_" + role.toUpperCase()
                    ));
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }

        filterChain.doFilter(request, response);
    }

    private String extractToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }
}
