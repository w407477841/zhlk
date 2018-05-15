package com.zyiot.server.impl.shebeiguanli;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiWeiXiuFormMap;
import com.zyiot.mapper.shebeiguanli.DaXingSheBeiWeiXiuMapper;
import com.zyiot.server.shebeiguanli.DaXingSheBeiWeiXiuServiceI;
import com.zyiot.util.Constant;
@Service("daXingSheBeiWeiXiuService")
public class DaXingSheBeiWeiXiuServiceImpl implements
		DaXingSheBeiWeiXiuServiceI {

	@Autowired
	private DaXingSheBeiWeiXiuMapper daXingSheBeiWeiXiuMapper;
	@Override
	@SystemLog(module="设备维修",methods="添加",description="添加成功")
	public void addDaXingSheBeiWeiXiu(
			DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap)
			throws Exception {
		daXingSheBeiWeiXiuMapper.addEntity(daXingSheBeiWeiXiuFormMap);
	}

	@Override
	@SystemLog(module="设备维修",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editDaXingSheBeiWeiXiu(
			DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap)
			throws Exception {
		DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap2 = daXingSheBeiWeiXiuMapper.findDaXingSheBeiWeiXiuById(Integer.parseInt(daXingSheBeiWeiXiuFormMap.getStr("id")));
		if(daXingSheBeiWeiXiuFormMap2.getInt(Constant.VERSION) == Integer.parseInt(daXingSheBeiWeiXiuFormMap.getStr(Constant.VERSION))){
			daXingSheBeiWeiXiuFormMap.set(Constant.VERSION, daXingSheBeiWeiXiuFormMap2.getInt(Constant.VERSION)+1);
			
			daXingSheBeiWeiXiuMapper.updateEntity(daXingSheBeiWeiXiuFormMap);
			
			daXingSheBeiWeiXiuFormMap2.remove("leName");
			daXingSheBeiWeiXiuFormMap2.remove("leNo");
			
			addOperatorLog(daXingSheBeiWeiXiuFormMap2, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
		
	}

	@SystemLog(module="设备维修",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropDaXingSheBeiWeiXiu(String id) throws Exception {
		DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap = daXingSheBeiWeiXiuMapper.findDaXingSheBeiWeiXiuById(Integer.parseInt(id));
		daXingSheBeiWeiXiuFormMap.remove("leName");
		daXingSheBeiWeiXiuFormMap.remove("leNo");
		daXingSheBeiWeiXiuMapper.deleteEntityByKey("id", id, DaXingSheBeiWeiXiuFormMap.class);
		addOperatorLog(daXingSheBeiWeiXiuFormMap, "delete");
		
	}

	@Override
	public List<DaXingSheBeiWeiXiuFormMap> findByPage(
			DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return daXingSheBeiWeiXiuMapper.findByPage(daXingSheBeiWeiXiuFormMap);
	}

	@Override
	public List<DaXingSheBeiWeiXiuFormMap> findByAttr(
			DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap) {
		return daXingSheBeiWeiXiuMapper.findByAttr(daXingSheBeiWeiXiuFormMap);
	}

	@Override
	public DaXingSheBeiWeiXiuFormMap findDaXingSheBeiWeiXiuById(int id) {
		return daXingSheBeiWeiXiuMapper.findDaXingSheBeiWeiXiuById(id);
	}
	
	private void addOperatorLog(DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		daXingSheBeiWeiXiuFormMap.remove("wName");
		daXingSheBeiWeiXiuFormMap.set(Constant.ENTITY_TABLE, "t_large_equipment_repair_his");
		daXingSheBeiWeiXiuFormMap.set("lerhSQL", sql);
		daXingSheBeiWeiXiuFormMap.set("lerhUser", session.getAttribute("userSessionId"));
		daXingSheBeiWeiXiuFormMap.set("lerhType", type);
		daXingSheBeiWeiXiuFormMap.set("lerhOpDate", new Timestamp(System.currentTimeMillis()));
		daXingSheBeiWeiXiuMapper.addEntity(daXingSheBeiWeiXiuFormMap);
	}

}
