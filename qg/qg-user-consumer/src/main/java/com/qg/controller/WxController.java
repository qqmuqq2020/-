package com.qg.controller;

import cn.qg.utils.UrlUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;

@Controller
    @RequestMapping("api")
    public class WxController {
        @RequestMapping("/wx/toLogin")
        @ResponseBody
        public String toWxLogin() throws Exception{
            StringBuffer Buffer = new StringBuffer("https://open.weixin.qq.com/connect/qrconnect");
            Buffer.append("?");
            Buffer.append("appid=APPID");
            Buffer.append("&");
           String nn= URLEncoder.encode("localhost%253a8082%252fapi%252fwx%252fcallback","UTF-8");
            Buffer.append("redirect_uri").append(nn);
            Buffer.append("&");
            Buffer.append("response_type=code");
            Buffer.append("&");
            Buffer.append("scope=snsapi_login");
            Buffer.append("&");
            Buffer.append("state=123456#wechat_redirect");
            return "redirect:"+Buffer.toString();
        }

        //获取到code之后 获取accessToken
        //redirect_URI 重定向的地址的映射地址
        @RequestMapping("/wx/callBack")
        public String  getaccessToken(String code) throws Exception{
        /*https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code*/
            StringBuffer Buffer = new StringBuffer("https://api.weixin.qq.com/sns/oauth2/access_token");
            Buffer.append("appid=APPID");
            Buffer.append("&");
            Buffer.append("secret=SECRET");
            Buffer.append("&");
            Buffer.append("grant_type=authorization_code*");
            String json =UrlUtils.loadURL(Buffer.toString());
            return json;

        }

}
