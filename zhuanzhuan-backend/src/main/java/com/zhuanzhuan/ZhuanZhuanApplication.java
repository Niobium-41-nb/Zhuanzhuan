package com.zhuanzhuan;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
@MapperScan("com.zhuanzhuan.modules.**.mapper")
public class ZhuanZhuanApplication {
    public static void main(String[] args) {
        SpringApplication.run(ZhuanZhuanApplication.class, args);
    }
}
