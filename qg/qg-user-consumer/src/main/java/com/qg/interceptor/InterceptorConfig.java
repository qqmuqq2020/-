package com.qg.interceptor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * 配置拦截器
 */
@Configuration //添加到spring容器中进行托管
public class InterceptorConfig extends WebMvcConfigurerAdapter {
    @Bean
    public ExceptionInterceptor exceptionInterceptor(){
        return new ExceptionInterceptor();
    }
    @Bean
    public LoginInterceptor loginInterceptor(){
        return new LoginInterceptor();
    }
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(exceptionInterceptor()).addPathPatterns("api/**");
        registry.addInterceptor(exceptionInterceptor()).addPathPatterns("api/v/**");
        super.addInterceptors(registry);
    }
}
