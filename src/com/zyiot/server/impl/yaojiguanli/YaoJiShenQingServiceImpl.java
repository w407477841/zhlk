package com.zyiot.server.impl.yaojiguanli;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiShenQingFormMap;
import com.zyiot.mapper.yaojiguanli.YaoJiKuCunMapper;
import com.zyiot.mapper.yaojiguanli.YaoJiShenQingMapper;
import com.zyiot.server.yaojiguanli.YaoJiShenQingServiceI;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
@Service("yaoJiShenQingService")
public class YaoJiShenQingServiceImpl implements YaoJiShenQingServiceI {
	@Autowired
	private YaoJiShenQingMapper yaoJiShenQingMapper;
	@Autowired
	private YaoJiKuCunMapper yaoJiKuCunMapper;
	@Override
	@SystemLog(module="药剂申请",methods="添加",description="添加成功")
	@Transactional(readOnly=false)
	public void addYaoJiShenQing(YaoJiShenQingFormMap yaoJiShenQingFormMap)
			throws Exception {
		String mrId = yaoJiShenQingFormMap.getStr("maMrId");
		
		YaoJiKuCunFormMap yaoJiKuCunFormMap = yaoJiKuCunMapper.findYaoJiKuCunById(Integer.parseInt(mrId));
		
		YaoJiKuCunToYaoJiShenQing(yaoJiKuCunFormMap, yaoJiShenQingFormMap);
		
		if(Integer.parseInt(yaoJiShenQingFormMap.getStr("maQuantity"))>yaoJiKuCunFormMap.getInt("mrNumber")){
			throw new Exception("[申请数量大于库存数量]");
		}else{
			yaoJiShenQingMapper.addEntity(yaoJiShenQingFormMap);			
		}
		
	}

	@Override
	@SystemLog(module="药剂申请",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editYaoJiShenQing(YaoJiShenQingFormMap yaoJiShenQingFormMap)
			throws Exception {
        String mrId = yaoJiShenQingFormMap.getStr("maMrId");
		//根据库存编号获取药剂信息
		YaoJiKuCunFormMap yaoJiKuCunFormMap = yaoJiKuCunMapper.findYaoJiKuCunById(Integer.parseInt(mrId));
		
		YaoJiKuCunToYaoJiShenQing(yaoJiKuCunFormMap, yaoJiShenQingFormMap);
		
		YaoJiShenQingFormMap yaoJiShenQingFormMap2 = yaoJiShenQingMapper.findYaoJiShenQingById(Integer.parseInt(yaoJiShenQingFormMap.getStr("id")));
		
		String status = yaoJiShenQingFormMap2.getStr("maProcess");
		if(status.equals(Constant.STATUS_APPROVE) || status.equals(Constant.STATUS_APPLICANT)){   //如果是待审批和审批通过的不允许修改
		  throw new Exception("[数据不能进行修改]");
		}
		if(Integer.parseInt(yaoJiShenQingFormMap.getStr("maQuantity"))>yaoJiKuCunFormMap.getInt("mrNumber")){ //申请数量大于库存数量
			throw new Exception("[申请数量大于库存数量]");
		}else{
			if(Integer.parseInt(yaoJiShenQingFormMap.getStr(Constant.VERSION)) == yaoJiShenQingFormMap2.getInt(Constant.VERSION)){  //修改version判断是否已经被修改
				yaoJiShenQingFormMap.set(Constant.VERSION, yaoJiShenQingFormMap2.getInt(Constant.VERSION)+1);
				yaoJiShenQingMapper.updateEntity(yaoJiShenQingFormMap);	
				
				addOperatorLog(yaoJiShenQingFormMap2,"update");
			}else{
				throw new Exception("[数据已被修改]");
			}
		}
	}

	@Override
	@SystemLog(module="药剂申请",methods="药剂删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropYaoJiShenQing(String id)
			throws Exception {
		YaoJiShenQingFormMap yaoJiShenQingFormMap = yaoJiShenQingMapper.findYaoJiShenQingById(Integer.parseInt(id));
		if(yaoJiShenQingFormMap.getStr("maProcess").equals(Constant.STATUS_APPLICANT)){
			throw new Exception("[数据不能被删除]");
		}else{
			yaoJiShenQingMapper.deleteEntityByKey("id", id, YaoJiShenQingFormMap.class);
			addOperatorLog(yaoJiShenQingFormMap,"delete");			
		}
	}

	@Override
	public List<YaoJiShenQingFormMap> findByPage(
			YaoJiShenQingFormMap yaoJiShenQingFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return yaoJiShenQingMapper.findByPage(yaoJiShenQingFormMap);
	}

	@Override
	public List<YaoJiShenQingFormMap> findByAttr(
			YaoJiShenQingFormMap yaoJiShenQingFormMap) {
		return yaoJiShenQingMapper.findByAttr(yaoJiShenQingFormMap);
	}

	@Override
	public YaoJiShenQingFormMap findYaoJiShenQingById(int id) {
		return yaoJiShenQingMapper.findYaoJiShenQingById(id);
	}
	
	@Override
	@SystemLog(module="药剂申请",methods="提交审批",description="提交审批成功")
	@Transactional(readOnly=false)
	public void approveYaoJiShenQing(YaoJiShenQingFormMap yaoJiShenQingFormMap)
			throws Exception {
	    YaoJiShenQingFormMap yaoJiShenQingFormMap2 = yaoJiShenQingMapper.findYaoJiShenQingById(Integer.parseInt(yaoJiShenQingFormMap.getStr("id")));
		
		String status = yaoJiShenQingFormMap2.getStr("maProcess");
		if(status.equals(Constant.STATUS_APPROVE) || status.equals(Constant.STATUS_APPLICANT)){
		  throw new Exception("[数据不能提交审核]");
		}
		yaoJiShenQingFormMap.set(Constant.VERSION, yaoJiShenQingFormMap2.getInt(Constant.VERSION)+1);
		yaoJiShenQingMapper.updateEntity(yaoJiShenQingFormMap);
		
		addOperatorLog(yaoJiShenQingFormMap2,"approve");
	}

	@Override
	public List<YaoJiShenQingFormMap> findShenPiByPage(
			YaoJiShenQingFormMap yaoJiShenQingFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return yaoJiShenQingMapper.findShenPiByPage(yaoJiShenQingFormMap);
	}

	
	/**
	 * 将药剂库存中的药剂信息填充到药剂申请中
	 * @param yaoJiKuCunFormMap
	 * @param yaoJiShenQingFormMap
	 */
	private void YaoJiKuCunToYaoJiShenQing(YaoJiKuCunFormMap yaoJiKuCunFormMap,YaoJiShenQingFormMap yaoJiShenQingFormMap){
		Session session = SecurityUtils.getSubject().getSession();
		yaoJiShenQingFormMap.set("maMrId", yaoJiKuCunFormMap.getInt("id"));
		yaoJiShenQingFormMap.set("maName", yaoJiKuCunFormMap.getStr("mrName"));
		yaoJiShenQingFormMap.set("maBrand", yaoJiKuCunFormMap.getStr("mrBrand"));
		yaoJiShenQingFormMap.set("maPage", yaoJiKuCunFormMap.getInt("mrPage"));
		yaoJiShenQingFormMap.set("maStandard", yaoJiKuCunFormMap.getStr("mrStandard"));
		yaoJiShenQingFormMap.set("maUnit", yaoJiKuCunFormMap.getStr("mrUnit"));
		yaoJiShenQingFormMap.set("maManufactureDate", yaoJiKuCunFormMap.getTimestamp("mrManufactureDate"));
		yaoJiShenQingFormMap.set("maProductCompany", yaoJiKuCunFormMap.getStr("mrProductCompany"));
		yaoJiShenQingFormMap.set("maBill", "b"+DateUtils.dateToString(new Date()));
		yaoJiShenQingFormMap.set("maDataOperator", session.getAttribute("userSessionId"));
		yaoJiShenQingFormMap.set("maApplyDate", new Timestamp(System.currentTimeMillis()));
	}
	
	private void addOperatorLog(YaoJiShenQingFormMap yaoJiShenQingFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		yaoJiShenQingFormMap.set(Constant.ENTITY_TABLE, "t_medicament_apply_his");
		yaoJiShenQingFormMap.set("mahSQL", sql);
		yaoJiShenQingFormMap.set("mahUser", session.getAttribute("userSessionId"));
		yaoJiShenQingFormMap.set("mahType", type);
		yaoJiShenQingFormMap.set("mahOpDate", new Timestamp(System.currentTimeMillis()));
	    yaoJiShenQingMapper.addEntity(yaoJiShenQingFormMap);
	}

}
