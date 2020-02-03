package cn.qg.constants;

import org.omg.PortableInterceptor.INACTIVE;

/**
 * 常量类
 */
public  class Constants {
    //超时分钟
    public static  final  Long loginExpire=30L;
    //Token前缀
    public static  final  String  tokenprefix="token:";

    public  static final String goodsPrefix="goods:";
    //类里面还会有一个类
    public static final class  StockStatus{
        public static final Integer lock=0;
        public static  final Integer paySuccess=1;
        public static final  Integer payOverTime=2;
    }
}
