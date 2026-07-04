package com.zhuanzhuan.modules.upload.controller;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.RandomUtil;
import com.zhuanzhuan.common.result.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Slf4j
@RestController
@RequestMapping("/api/v1/upload")
public class UploadController {

    @Value("${upload.path:/data/zhuanzhuan/uploads}")
    private String uploadPath;

    @PostMapping("/image")
    public Result<Map<String, Object>> uploadImage(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error(400, "请选择文件");
        }

        String originalName = file.getOriginalFilename();
        String ext = originalName != null ? originalName.substring(originalName.lastIndexOf(".")) : ".jpg";
        String fileName = DateUtil.format(new Date(), "yyyyMMdd") + "_" + RandomUtil.randomString(16) + ext;

        try {
            File dir = new File(uploadPath);
            if (!dir.exists()) dir.mkdirs();
            File dest = new File(dir, fileName);
            file.transferTo(dest);

            Map<String, Object> result = new HashMap<>();
            result.put("imageId", RandomUtil.randomLong(100000, 999999));
            result.put("url", "/uploads/" + fileName);
            return Result.success(result);
        } catch (IOException e) {
            log.error("上传失败", e);
            return Result.error(500, "上传失败");
        }
    }
}
