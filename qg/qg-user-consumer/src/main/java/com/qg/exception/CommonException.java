package com.qg.exception;

/**
 * 通用异常
 */
public enum CommonException {
      SYSTEM_RXCEPTION(-1,"系统繁忙请稍后重试"),
      USER_NO_LOGIN(1,"用户登录超时");
    /**
     * 通用异常
     */
       private Integer  code;
       private String message;
    //构造方法
    CommonException(Integer code,String message) {
        this.code = code;
    }

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


}
