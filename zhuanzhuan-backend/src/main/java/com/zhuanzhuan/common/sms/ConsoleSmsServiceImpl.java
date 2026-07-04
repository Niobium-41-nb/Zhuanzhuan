package com.zhuanzhuan.common.sms;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.stereotype.Service;

/**
 * 控制台短信服务实现 — 将验证码打印到日志
 * 接入真实 SMS 供应商后，创建新实现并加上 @Primary 即可覆盖
 */
@Slf4j
@Service
@ConditionalOnMissingBean(SmsService.class)
public class ConsoleSmsServiceImpl implements SmsService {

    @Override
    public void sendSmsCode(String phone, String code) {
        log.info("========== SMS Verification Code ==========");
        log.info("Phone : {}", phone);
        log.info("Code  : {}", code);
        log.info("===========================================");
    }
}
