package com.qg;

import java.io.Serializable;

/**
 * 定义一个类，统一返回数据的格式；
 */
public class ReturnResult<T> implements Serializable {
    //3个重要的属性
    public Integer code;
    public String message;
    public T data;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
