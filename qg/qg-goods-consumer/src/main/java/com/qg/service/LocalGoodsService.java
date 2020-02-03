package com.qg.service;

import com.qg.ReturnResult;

public interface LocalGoodsService {

    public ReturnResult queryGoodsById(String id) throws Exception;

    public ReturnResult getGoods(String token,String goodsId)throws Exception;
}
