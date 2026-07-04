package com.zhuanzhuan.modules.upload.controller;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.RandomUtil;
import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.product.entity.ProductImage;
import com.zhuanzhuan.modules.product.mapper.ProductImageMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Slf4j
@RestController
@RequestMapping("/api/v1/upload")
public class UploadController {

    private static final Set<String> ALLOWED_EXTENSIONS = Set.of(".jpg", ".jpeg", ".png", ".gif", ".webp");
    private static final Set<String> ALLOWED_MIME_TYPES = Set.of(
            "image/jpeg", "image/png", "image/gif", "image/webp"
    );
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

    @Value("${upload.path:/data/zhuanzhuan/uploads}")
    private String uploadPath;

    private final ProductImageMapper productImageMapper;

    public UploadController(ProductImageMapper productImageMapper) {
        this.productImageMapper = productImageMapper;
    }

    @PostMapping("/image")
    public Result<Map<String, Object>> uploadImage(@RequestParam("file") MultipartFile file) {
        // 认证检查
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getPrincipal())) {
            return Result.error(401, "请先登录");
        }

        if (file.isEmpty()) {
            return Result.error(400, "请选择文件");
        }

        // 文件大小限制
        if (file.getSize() > MAX_FILE_SIZE) {
            return Result.error(413, "文件大小不能超过5MB");
        }

        String originalName = file.getOriginalFilename();
        if (originalName == null || originalName.isEmpty()) {
            return Result.error(400, "文件名无效");
        }

        // 文件扩展名白名单
        String ext = "";
        int dotIndex = originalName.lastIndexOf(".");
        if (dotIndex > 0) {
            ext = originalName.substring(dotIndex).toLowerCase();
        }
        if (!ALLOWED_EXTENSIONS.contains(ext)) {
            return Result.error(400, "不支持的文件类型，仅允许 jpg/jpeg/png/gif/webp");
        }

        // MIME 类型验证
        String mimeType = file.getContentType();
        if (mimeType != null && !ALLOWED_MIME_TYPES.contains(mimeType)) {
            return Result.error(400, "不支持的文件类型");
        }

        String fileName = DateUtil.format(new Date(), "yyyyMMdd") + "_" + RandomUtil.randomString(16) + ext;

        try {
            File dir = new File(uploadPath);
            if (!dir.exists()) dir.mkdirs();
            File dest = new File(dir, fileName);
            file.transferTo(dest);

            // 写入 product_image 表，供发布商品时使用
            ProductImage image = new ProductImage();
            image.setProductId(0L);
            image.setUrl("/uploads/" + fileName);
            image.setSortOrder(0);
            productImageMapper.insert(image);

            Map<String, Object> result = new HashMap<>();
            result.put("imageId", image.getId());
            result.put("url", "/uploads/" + fileName);
            return Result.success(result);
        } catch (IOException e) {
            log.error("上传失败", e);
            return Result.error(500, "上传失败");
        }
    }
}
