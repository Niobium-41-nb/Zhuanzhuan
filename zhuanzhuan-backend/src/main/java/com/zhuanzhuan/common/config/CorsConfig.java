package com.zhuanzhuan.common.config;

import org.springframework.context.annotation.Configuration;

/**
 * CORS 配置已迁移至 SecurityConfig.corsConfigurationSource()
 * 由 Spring Security 统一管理，确保预检请求在鉴权前处理
 */
@Configuration
public class CorsConfig {
}
