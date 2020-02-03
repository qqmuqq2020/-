package com.qg.controller;

import com.qg.ReturnResult;
import com.qg.service.LocalUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("api")
public class UserController {
    @Autowired
    LocalUserService localUserService;
    //用户登录验证的 接口
    @RequestMapping(value = "login",method = RequestMethod.POST)
    @ResponseBody
    public ReturnResult qyeryLogin(String phone, String password, HttpServletResponse response)throws Exception {
        response.setHeader("Access-Control-Allow-Origin", "*");
        return localUserService.validateToken(phone, password);
    }

    /**
     * 用户注销的方法
     */

    @RequestMapping(value = "/v/loginOut",method = RequestMethod.POST)
    @ResponseBody
    public  ReturnResult loginOut(String token, HttpServletResponse response)throws  Exception{
     response.setHeader("Access-Control-Allow-Origin", "*");
    return localUserService.removeToken(token);
    }


}
