package com.qg.service.impl;

import cn.qg.constants.Constants;
import cn.qg.service.QgGoodsService;
import cn.qg.service.QgGoodsTempStockService;
import cn.qg.utils.IdWorker;
import cn.qg.utils.RedisUtil;
import cn.qg.utils.ReturnResultUtils;
import com.alibaba.boot.dubbo.annotation.DubboConsumer;
import com.alibaba.fastjson.JSONObject;
import com.qg.ReturnResult;
import com.qg.exception.GoodsException;
import com.qg.pojo.QgGoods;
import com.qg.pojo.QgGoodsTempStock;
import com.qg.pojo.QgUser;
import com.qg.service.LocalGoodsService;
import com.qg.vo.GoodsVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static com.qg.exception.GoodsException.GOODS_IS_CLEAR;
import static com.qg.exception.GoodsException.USER_REPEAT_GET;


@Component
public class LocalGoodsServiceImpl implements LocalGoodsService {

    @DubboConsumer
    private QgGoodsService qgGoodsService;
    @DubboConsumer
    private QgGoodsTempStockService qgGoodsTempStockService;
    @Autowired
    private LocalGoodsService localGoodsService;
    @Autowired
    private RedisUtil redisUtil;
    @Override
    public ReturnResult queryGoodsById(String id) throws Exception {
       //高并发的情况下，减少用户在数据库的查询解决办法
        // 1.首先从redis中进行获取，
        // 2.如果redsi中没有就走数据库查询并将结果 写进redis
        // 3.如果redis数据库中有就走redis不走数据库
        GoodsVo goodsVo=null;
        String goodMessage=  redisUtil.getStr(Constants.goodsPrefix+id);
        if(goodMessage==null){
            //获取商品信息
           QgGoods qgGoods=qgGoodsService.getQgGoodsById(id);
           goodsVo= new GoodsVo();
            /*spring中提供的数据拷贝的工具*/
            BeanUtils.copyProperties(qgGoods,goodsVo);
            //获取临时库存表中目前含有效的goods_id 为id 的有效记录数-用户已经消费或准本消费的记录数
            Map param =new HashMap();
            param.put("goodsid",id);
            param.put("active",1);
            //被用户已经消费或者锁定的商品数
            Integer avtiveCount=qgGoodsTempStockService.getQgGoodsTempStockCountByMap(param);// 查询数目的方法
            //实际库存
            Integer currentCount= goodsVo.getStock()-avtiveCount;
            goodsVo.setCurrentStock(currentCount);
            //放在Redis中
            redisUtil.setStr(Constants.goodsPrefix,JSONObject.toJSONString(goodsVo));
        }else{
            goodsVo = JSONObject.parseObject(goodMessage,GoodsVo.class);
        }
        return ReturnResultUtils.returnSuccess(goodsVo);
    }

    @Override
    public ReturnResult getGoods(String token, String goodsId) throws Exception {
        return null;
    }

/*    @Override
    public ReturnResult getGoods(String token, String goodsId) {
        //1.根据token知道是哪个用户 获取用户信息
        String userJson=redisUtil.getStr(token); //跟怒token从redis中查出用户信息
        QgUser qgUser=JSONObject.parseObject(userJson,QgUser.class); //把字符串转换为对象
        //2.查看用户是否已经抢购过该商品，如果用户有抢购成功未支付的货已经支付成功的记录，则不能抢购
        Map param = new HashMap<>();
        param.put("goodsId",goodsId);
        param.put("active",1);
        param.put("userId",qgUser.getId());
        Integer activeCount = null;
        try {
            activeCount = qgGoodsTempStockService.getQgGoodsTempStockCountByMap(param);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(activeCount>0){
            //用户抢购过了
            return ReturnResultUtils.returnFail(USER_REPEAT_GET.getCode(),GOODS_IS_CLEAR.getMessage() );
        }
        //3判断库存是否大于0，如果大于0则进入抢购环节
        Date date =new Date();
        String goodsVoJson =redisUtil.getStr(Constants.goodsPrefix+goodsId);
        GoodsVo goodsVo = JSONObject.parseObject(goodsVoJson,GoodsVo.class);
        if(goodsVo.getCurrentStock()<=0){
            //已经被抢购一空
            ReturnResultUtils.returnFail(GoodsException.GOODS_IS_CLEAR.getCode(),GoodsException.GOODS_IS_CLEAR.getMessage());
        }
        //4.更新临时库存表， 更新临时库存表（插入记录）以及更新redis数据
        QgGoodsTempStock qgGoodsTempStock=new QgGoodsTempStock();
        qgGoodsTempStock.setUserId(IdWorker.getId());
        qgGoodsTempStock.setGoodsId(goodsVo.getId());
        qgGoodsTempStock.setCreatedTime(new Timestamp(date.getTime()));
        qgGoodsTempStock.setId(goodsVo.getId());
        qgGoodsTempStock.setUpdatedTime(new Timestamp(date.getTime()));
        qgGoodsTempStock.setStatus(Constants.StockStatus.lock);
        try {
            qgGoodsTempStockService.qdtxAddQgGoodsTempStock(qgGoodsTempStock);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //原有库存减少1
        goodsVo.setCurrentStock(goodsVo.getCurrentStock()-1);
        redisUtil.setStr(Constants.goodsPrefix+goodsId,JSONObject.toJSONString(goodsVo));
        //5生成订单
        //TODO
        //6返回执行结果
        return ReturnResultUtils.returnResult();
    }*/
}
