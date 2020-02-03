package com.qg;

import com.alibaba.boot.dubbo.annotation.EnableDubboConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = {"cn.qg","com.qg"})
@SpringBootApplication
@EnableDubboConfiguration
public class QgUserConsumerApplication {

    public static void main(String[] args) {
        SpringApplication.run(QgUserConsumerApplication.class, args);
    }

}
