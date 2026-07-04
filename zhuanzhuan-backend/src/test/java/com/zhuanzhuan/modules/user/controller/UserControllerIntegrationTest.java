package com.zhuanzhuan.modules.user.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zhuanzhuan.TestMockConfig;
import com.zhuanzhuan.modules.user.dto.RegisterDTO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * 集成测试：验证控制器层的参数校验
 */
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@Import(TestMockConfig.class)
class UserControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void testRegister_ValidationFailure() throws Exception {
        RegisterDTO dto = new RegisterDTO();
        dto.setUsername("");
        dto.setPassword("short");
        dto.setCode("");

        mockMvc.perform(post("/api/v1/user/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(dto)))
                .andExpect(jsonPath("$.code").value(422));
    }

    @Test
    void testLogin_EmptyAccount() throws Exception {
        com.zhuanzhuan.modules.user.dto.LoginDTO dto = new com.zhuanzhuan.modules.user.dto.LoginDTO();
        dto.setAccount("");
        dto.setPassword("");

        mockMvc.perform(post("/api/v1/user/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(dto)))
                .andExpect(jsonPath("$.code").value(422));
    }
}
