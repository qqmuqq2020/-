package com.qg.interceptor;

import cn.qg.utils.EmptyUtils;
import cn.qg.utils.PrintUtil;
import cn.qg.utils.ReturnResultUtils;
import com.alibaba.fastjson.JSONObject;
import com.qg.ReturnResult;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/***
 * 异常统一处理的拦截器
 */
public class ExceptionInterceptor implements HandlerInterceptor{



    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }
    /***
     * @param request
     * @param response
     * @param o
     * @param e
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object o, Exception e) throws Exception {
        //出现异常进行处理
        if(EmptyUtils.isNotEmpty(e)){
            response.setContentType("text/html;charset=UTF-8");
            PrintUtil printUtil=new PrintUtil(response);
            ReturnResult returnResult=ReturnResultUtils.returnFail(-1,"系统繁忙请稍后重试");
            printUtil.print(JSONObject.toJSON(returnResult));
        }
    }
}
