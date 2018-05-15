package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.DeliverGoodsDetailFormMap;

/**
 * 发货明细
 * @author Admin
 * @date 2018年1月12日 下午1:18:47
 */
public interface DeliverGoodsDetailServerI {
	
	public void addDeliverGoodsDetail(DeliverGoodsDetailFormMap deliverGoodsDetailFormMap)throws Exception;
	
	public void editDeliverGoodsDetail(DeliverGoodsDetailFormMap deliverGoodsDetailFormMap)throws Exception;
	
	public void uploadFile(DeliverGoodsDetailFormMap deliverGoodsDetailFormMap)throws Exception;
	
	public void dropDeliverGoodsDetail(String id)throws Exception;
	
	public List<DeliverGoodsDetailFormMap> findByPage(DeliverGoodsDetailFormMap deliverGoodsDetailFormMap,int pageNum,int pageSize);
	
	public DeliverGoodsDetailFormMap findById(int id);
	
}
