package com.qg.service;

import com.qg.ReturnResult;

/**
 * 本地实现业务的接口
 */
public interface LocalUserService {
    //验证Token的Service
    public ReturnResult validateToken(String phone, String password)throws Exception;
    //用户注销
    public ReturnResult removeToken(String token)throws  Exception;
}
