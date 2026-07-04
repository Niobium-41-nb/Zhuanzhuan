package com.zhuanzhuan.common.result;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ResultTest {

    @Test
    void testSuccessWithData() {
        Result<Integer> result = Result.success(42);
        assertEquals(200, result.getCode());
        assertEquals(42, (int) result.getData());
    }

    @Test
    void testSuccessWithoutData() {
        Result<Void> result = Result.success();
        assertEquals(200, result.getCode());
        assertEquals("success", result.getMessage());
        assertNull(result.getData());
    }

    @Test
    void testSuccessWithMessageOnly() {
        Result<Void> result = Result.success("操作成功");
        assertEquals(200, result.getCode());
        assertEquals("操作成功", result.getMessage());
    }

    @Test
    void testSuccessWithCustomMessage() {
        Result<String> result = Result.success("自定义消息", "data");
        assertEquals(200, result.getCode());
        assertEquals("自定义消息", result.getMessage());
        assertEquals("data", result.getData());
    }

    @Test
    void testError() {
        Result<String> result = Result.error(400, "参数错误");
        assertEquals(400, result.getCode());
        assertEquals("参数错误", result.getMessage());
        assertNull(result.getData());
    }

    @Test
    void testErrorWithData() {
        Result<String> result = Result.error(500, "服务器错误", "detail");
        assertEquals(500, result.getCode());
        assertEquals("服务器错误", result.getMessage());
        assertEquals("detail", result.getData());
    }

    @Test
    void testPageResultSuccess() {
        PageResult<String> pageResult = PageResult.success(
                java.util.List.of("a", "b"), 10L, 1, 10);
        assertEquals(200, pageResult.getCode());
        assertEquals("success", pageResult.getMessage());
        assertEquals(2, pageResult.getData().size());
        assertEquals(10, pageResult.getTotal());
        assertEquals(1, pageResult.getPage());
        assertEquals(10, pageResult.getSize());
        assertEquals(1, pageResult.getPages());
    }
}
