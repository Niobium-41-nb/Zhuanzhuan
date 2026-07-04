package com.zhuanzhuan;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class ZhuanZhuanApplication {
    public static void main(String[] args) {
        SpringApplication.run(ZhuanZhuanApplication.class, args);
    }
}
