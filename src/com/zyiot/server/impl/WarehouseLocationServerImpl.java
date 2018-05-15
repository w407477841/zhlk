package com.zyiot.server.impl;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.WarehouseLocationFormMap;
import com.zyiot.mapper.WarehouseLocationMapper;
import com.zyiot.server.WarehouseLocationServerI;
import com.zyiot.util.Constant;
@Service("warehouseLocationServer")
public class WarehouseLocationServerImpl implements WarehouseLocationServerI {
	private WarehouseLocationMapper warehouseLocationMapper;
	
	public WarehouseLocationMapper getWarehouseLocationMapper() {
		return warehouseLocationMapper;
	}
	@Autowired
	public void setWarehouseLocationMapper(
			WarehouseLocationMapper warehouseLocationMapper) {
		this.warehouseLocationMapper = warehouseLocationMapper;
	}

	@Override
	@SystemLog(module="粮库地点",methods="添加",description="成功")
	public void addWarehouseLocation(WarehouseLocationFormMap warehouseLocation)
			throws Exception {
		 warehouseLocationMapper.addEntity(warehouseLocation);
	}

	@Override
	@SystemLog(module="粮库地点",methods="修改",description="成功")
	@Transactional(readOnly = false)
	public void editWarehouseLocation(WarehouseLocationFormMap warehouseLocation)
			throws Exception {
		WarehouseLocationFormMap warehouseLocationFormMap = warehouseLocationMapper.findWarehouseLocationById(Integer.parseInt(warehouseLocation.getStr("id")));
		 warehouseLocationMapper.updateEntity(warehouseLocation);
		 addOperatorLog(warehouseLocationFormMap, "update");
	}

	@Override
	@SystemLog(module="粮库地点",methods="删除",description="成功")
	@Transactional(readOnly = false)
	public void dropWarehouseLocation(String id)
			throws Exception {
		WarehouseLocationFormMap warehouseLocationFormMap = warehouseLocationMapper.findWarehouseLocationById(Integer.parseInt(id));
		 warehouseLocationMapper.deleteEntityByKey("id", id, WarehouseLocationFormMap.class);
		 addOperatorLog(warehouseLocationFormMap, "delete");
	}

	@Override
	public List<WarehouseLocationFormMap> findAllWarehouseLocation(
			WarehouseLocationFormMap warehouseLocation){
		return warehouseLocationMapper.findByAttr(warehouseLocation);
	}
	
	@Override
	public List<WarehouseLocationFormMap> findBySelect() {
		return warehouseLocationMapper.findBySelect();
	}
	@Override
	public List<WarehouseLocationFormMap> findByPage(
			WarehouseLocationFormMap warehouseLocation, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return warehouseLocationMapper.findByPage(warehouseLocation);
	}
	
	@Override
	public WarehouseLocationFormMap findWarehouseLocationById(String id) {
		return warehouseLocationMapper.findById(id, WarehouseLocationFormMap.class);
	}
	@Override
	public String getImagePath(String localtionId) {
		return warehouseLocationMapper.getImagePath(localtionId);
	}
	private void addOperatorLog(WarehouseLocationFormMap warehouseLocationFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		warehouseLocationFormMap.set(Constant.ENTITY_TABLE, "t_warehouse_location_his");
		warehouseLocationFormMap.set("execSQL", sql);
		warehouseLocationFormMap.set("execUser", session.getAttribute("userSessionId"));
		warehouseLocationFormMap.set("execType", type);
		warehouseLocationFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		warehouseLocationMapper.addEntity(warehouseLocationFormMap);
	}
}
