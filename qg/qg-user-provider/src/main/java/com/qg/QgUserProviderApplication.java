package com.qg;

import com.alibaba.boot.dubbo.annotation.EnableDubboConfiguration;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
@MapperScan("com.qg.mapper")
@EnableDubboConfiguration
/*@ComponentScan({"com.qg","cn.qg"})*/
public class QgUserProviderApplication {


    public static void main(String[] args) {
        SpringApplication.run(QgUserProviderApplication.class, args);
    }

}
