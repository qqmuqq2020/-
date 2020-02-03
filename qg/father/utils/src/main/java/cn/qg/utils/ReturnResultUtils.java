package cn.qg.utils;

import com.qg.ReturnResult;

/**
 * 封装的操作对象的工具类：同意返回工具类
 */

public class ReturnResultUtils{
    /**
     * 测试 success 不带数据
     * @return
     */
    public static ReturnResult returnResult(){
    ReturnResult returnResult = new ReturnResult();
    returnResult.setCode(0);
    return returnResult;
}

        /**
         * 测试 success 带数据
         * @return
         */
        public static ReturnResult returnSuccess(Object data){
            ReturnResult returnResult = new ReturnResult();
            returnResult.setCode(0);
            returnResult.setData(data);
            return returnResult;
        }

        /**
         * 测试 失败 不带数据 返还提示信息
         * @return
         */
        public static ReturnResult returnFail(Integer code,String message){
            ReturnResult returnResult = new ReturnResult();
            returnResult.setCode(0);
            returnResult.setMessage(message);
            return returnResult;
        }

}
