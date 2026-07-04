package com.zhuanzhuan.common.sms;

/**
 * 短信服务接口
 * 当前实现为控制台输出（模拟），接入真实 SMS 供应商后替换实现即可
 */
public interface SmsService {

    /**
     * 发送短信验证码
     * @param phone 手机号
     * @param code  验证码
     */
    void sendSmsCode(String phone, String code);
}
