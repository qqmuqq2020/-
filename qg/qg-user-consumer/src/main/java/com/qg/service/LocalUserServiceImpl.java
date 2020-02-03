package com.qg.service;
import cn.qg.constants.Constants;
import cn.qg.service.QgUserService;
import cn.qg.utils.EmptyUtils;
import cn.qg.utils.RedisUtil;
import cn.qg.utils.ReturnResultUtils;
import cn.qg.utils.TokenUtils;
import com.alibaba.boot.dubbo.annotation.DubboConsumer;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.qg.ReturnResult;
import com.qg.pojo.QgUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
    public class LocalUserServiceImpl  implements LocalUserService{
        @DubboConsumer
        QgUserService qgUserService;
        @Autowired
        private RedisUtil redisUtil;
        /**
         * 根据用户名和密码生成Token
         */
        @Override
        public ReturnResult validateToken(String phone, String password) throws Exception {
            //1调用接口实现用户名和密码的验证
            QgUser qgUser = null;
            String token = null;
            ReturnResult returnResult=null;
            try {
                qgUser = qgUserService.queryUserByPhoneAndPwd(phone, password);
                //2.验证通过返回成功
                if (qgUser != null) {
                    String oldToken = redisUtil.getStr(qgUser.getId());
                    //如果不等于空的话删除Token
                    if (!EmptyUtils.isEmpty(oldToken)) {
                        redisUtil.del(oldToken);
                        redisUtil.del(qgUser.getId());
                    }
                    //（1）生成Tocken，保存到Redis中
                    token =Constants.tokenprefix+ TokenUtils.createToken(qgUser.getId(), qgUser.getPhone());
                    redisUtil.setStr(token,JSONArray.toJSONString(qgUser), Constants.loginExpire);//用户登录
                    redisUtil.setStr(qgUser.getId(), token,Constants.loginExpire);//用户重复登录的解救办法
                    Map<String ,Object> result = new HashMap<String ,Object>();
                    result.put("token",token);
                     returnResult=ReturnResultUtils.returnSuccess(result);
                }else{
                   returnResult=ReturnResultUtils.returnFail(1001,"用户名或者密码错误");
                }
            } catch (Exception e) {
                e.printStackTrace();

            } finally {
                return returnResult;
            }
        }

    @Override
    public ReturnResult removeToken(String token) throws Exception {
        ReturnResult returnResult =null;
        String qgUserJson = redisUtil.getStr(token);
       //判断token是否有效
        if(EmptyUtils.isNotEmpty(qgUserJson)){
        redisUtil.del(token);
        QgUser qgUser = JSONObject.parseObject(qgUserJson,QgUser.class);
        redisUtil.del(qgUser.getId());
            returnResult=ReturnResultUtils.returnResult();
        }else{
            //五i奥
            returnResult=ReturnResultUtils.returnFail(1001,"用户未登录");
        }
        return returnResult;
    }
}


