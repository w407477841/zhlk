package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.DeliverGoodsDetailFormMap;
import com.zyiot.mapper.BaseMapper;

/**
 * 发货明细表
 * @author Admin
 * @date 2018年1月12日 下午1:16:58
 */
public interface DeliverGoodsDetailMapper extends BaseMapper {
	
	public List<DeliverGoodsDetailFormMap> findByPage(DeliverGoodsDetailFormMap deliverGoodsDetailFormMap);
	
	public DeliverGoodsDetailFormMap findDeliverGoodsDetailById(int id);
}
