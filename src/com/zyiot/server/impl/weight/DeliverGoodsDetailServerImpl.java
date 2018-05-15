package com.zyiot.server.impl.weight;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.weight.DeliverGoodsDetailFormMap;
import com.zyiot.mapper.weight.DeliverGoodsDetailMapper;
import com.zyiot.server.weight.DeliverGoodsDetailServerI;
import com.zyiot.util.Constant;
@Service("deliverGoodsDetailServer")
public class DeliverGoodsDetailServerImpl implements DeliverGoodsDetailServerI {
	@Autowired
	private DeliverGoodsDetailMapper deliverGoodsDetailMapper;
	
	@Override
	@SystemLog(module="发货明细",methods="添加",description="添加成功")
	public void addDeliverGoodsDetail(
			DeliverGoodsDetailFormMap deliverGoodsDetailFormMap)
			throws Exception {
		deliverGoodsDetailMapper.addEntity(deliverGoodsDetailFormMap);
	}

	@Override
	@SystemLog(module="发货明细",methods="修改",description="修改成功")
	@Transactional(readOnly = false)
	public void editDeliverGoodsDetail(
			DeliverGoodsDetailFormMap deliverGoodsDetailFormMap)
			throws Exception {
		DeliverGoodsDetailFormMap deliverGoodsDetail = deliverGoodsDetailMapper.findDeliverGoodsDetailById(Integer.parseInt(deliverGoodsDetailFormMap.getStr("id")));
		if(deliverGoodsDetail.getInt(Constant.VERSION) == Integer.parseInt(deliverGoodsDetailFormMap.getStr(Constant.VERSION))){
			deliverGoodsDetailFormMap.set(Constant.VERSION, deliverGoodsDetail.getInt(Constant.VERSION)+1);
			deliverGoodsDetailMapper.updateEntity(deliverGoodsDetailFormMap);
			addOperatorLog(deliverGoodsDetail, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
	}

	@Override
	@SystemLog(module="发货明细",methods="文件上传",description="上传成功")
	@Transactional(readOnly = false)
	public void uploadFile(DeliverGoodsDetailFormMap deliverGoodsDetailFormMap)
			throws Exception {
		DeliverGoodsDetailFormMap deliverGoodsDetail = deliverGoodsDetailMapper.findDeliverGoodsDetailById(Integer.parseInt(deliverGoodsDetailFormMap.getStr("id")));
		deliverGoodsDetailFormMap.set(Constant.VERSION, deliverGoodsDetail.getInt(Constant.VERSION)+1);
		deliverGoodsDetailMapper.updateEntity(deliverGoodsDetailFormMap);
		addOperatorLog(deliverGoodsDetail, "update");
	}

	@Override
	@SystemLog(module="发货明细",methods="删除",description="删除成功")
	@Transactional(readOnly = false)
	public void dropDeliverGoodsDetail(String id) throws Exception {
		DeliverGoodsDetailFormMap deliverGoodsDetail = deliverGoodsDetailMapper.findDeliverGoodsDetailById(Integer.parseInt(id));
		deliverGoodsDetailMapper.deleteEntityByKey("id", id, DeliverGoodsDetailFormMap.class);
		addOperatorLog(deliverGoodsDetail, "delete");
	}

	@Override
	public List<DeliverGoodsDetailFormMap> findByPage(
			DeliverGoodsDetailFormMap deliverGoodsDetailFormMap, int pageNum,
			int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return deliverGoodsDetailMapper.findByPage(deliverGoodsDetailFormMap);
	}

	@Override
	public DeliverGoodsDetailFormMap findById(int id) {
		return deliverGoodsDetailMapper.findDeliverGoodsDetailById(id);
	}
	private void addOperatorLog(DeliverGoodsDetailFormMap deliverGoodsDetailFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		deliverGoodsDetailFormMap.set(Constant.ENTITY_TABLE, "t_deliver_goods_detail_his");
		deliverGoodsDetailFormMap.set("execSQL", sql);
		deliverGoodsDetailFormMap.set("execUser", session.getAttribute("userSessionId"));
		deliverGoodsDetailFormMap.set("execType", type);
		deliverGoodsDetailFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		deliverGoodsDetailMapper.addEntity(deliverGoodsDetailFormMap);
	}
}
