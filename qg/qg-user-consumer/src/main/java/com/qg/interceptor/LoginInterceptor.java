package com.qg.interceptor;

import cn.qg.utils.EmptyUtils;
import cn.qg.utils.RedisUtil;
import cn.qg.utils.ReturnResultUtils;
import com.alibaba.fastjson.JSONObject;
import com.qg.ReturnResult;
import com.qg.pojo.QgUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {
   @Autowired
   RedisUtil redisUtil;
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        String token = httpServletRequest.getParameter("token");
        String qgUserJson = redisUtil.getStr(token);
        //判断token是否有效
        if(EmptyUtils.isNotEmpty(token)){
            return false;
        }

        if (EmptyUtils.isNotEmpty(qgUserJson)) {//无效
           return false;
        } else {//无效
            return true;
        }
    }


    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
