package com.qg.exception;

public enum  UserException {
   USER_PSSWORD_ERRPR(1001,"用户名或密码错误");


    private Integer  code;
    private String message;
    //构造方法
    UserException(Integer code,String message) {
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
