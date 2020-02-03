package com.qg;

import com.alibaba.boot.dubbo.annotation.EnableDubboConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan({"com.qg","cn.qg"})
@EnableDubboConfiguration

public class QgApplication {

    public static void main(String[] args) {
        SpringApplication.run(QgApplication.class, args);
    }

}
