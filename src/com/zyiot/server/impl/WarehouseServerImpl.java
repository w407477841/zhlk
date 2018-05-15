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
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.WarehouseFormMap;
import com.zyiot.entity.jichuziliao.CangFangXinXiFormMap;
import com.zyiot.mapper.StorageInfoMapper;
import com.zyiot.mapper.WarehouseMapper;
import com.zyiot.mapper.jichuziliao.CangFangXinXiMapper;
import com.zyiot.server.WarehouseServerI;
import com.zyiot.util.BatchInsertParameter;
import com.zyiot.util.Constant;

@Service("warehouseServer'")
public class WarehouseServerImpl implements WarehouseServerI {
	@Autowired
	private WarehouseMapper warehouseMapper;
	@Autowired
	private CangFangXinXiMapper cangFangXinXiMapper;
	@Autowired
	private StorageInfoMapper storageInfoMapper;
	@Override
	public List<WarehouseFormMap> findAllWarehouseByLocationId(
			WarehouseFormMap warehouse) throws Exception {
		return warehouseMapper.findByAttr(warehouse);
	}

	@Override
	public List<WarehouseFormMap> findAllByLocation() throws Exception {
		return warehouseMapper.findAllWarehouseByLocation();
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "外部接口", methods = "添加仓库", description = "成功")
	public void batchSave(List<WarehouseFormMap> l) throws Exception {
		warehouseMapper.batchSave(BatchInsertParameter.wrap(l));
	}

	@Override
	public List<WarehouseFormMap> findWareHouseByLocation(WarehouseFormMap w) {
		return warehouseMapper.findWareHouseByLocation(w);
	}

	@Override
	public List<WarehouseFormMap> findWareHouseByLocation2(WarehouseFormMap w) {
		return warehouseMapper.findWareHouseByLocation2(w);
	}

	@Override
	public List<WarehouseFormMap> findWareHouseByLocationAndVariety(
			WarehouseFormMap w) {
		return warehouseMapper.findWareHouseByLocationAndVariety(w);
	}

	@Override
	@SystemLog(module="仓房",methods="添加",description="成功")
	public void addWarehouse(WarehouseFormMap warehouseFormMap)
			throws Exception {
		warehouseMapper.addEntity(warehouseFormMap);		
	}

	@Override
	@SystemLog(module="仓房",methods="修改",description="成功")
	@Transactional(readOnly = false)
	public void editWarehouse(WarehouseFormMap warehouseFormMap)
			throws Exception {
		WarehouseFormMap warehouse = warehouseMapper.findWarehouseById(Integer.parseInt(warehouseFormMap.getStr("id")));
		warehouseMapper.updateEntity(warehouseFormMap);
		addOperatorLog(warehouse, "update");
	}

	@Override
	@SystemLog(module="仓房",methods="删除",description="成功")
	@Transactional(readOnly = false)
	public void dropWarehouse(String id) throws Exception {
		StorageInfoFormMap storage = storageInfoMapper.findByWarehouseId(id);
		if(storage != null){ //存在库存信息，则只有库存等于0，才可以删除仓房
			String cangKu = storage.getStr("cangKu");
			if(cangKu == null || cangKu.equals("0")){
				//删除库存信息
				warehouseMapper.deleteEntityByKey("id", storage.getInt("id")+"", StorageInfoFormMap.class);
				
				//获取仓房信息,并删除
				CangFangXinXiFormMap cangFangXinXiFormMap = cangFangXinXiMapper.findBywId(Integer.parseInt(id));
				if(cangFangXinXiFormMap != null){
					warehouseMapper.deleteEntityByKey("id", cangFangXinXiFormMap.getInt("id")+"", CangFangXinXiFormMap.class);
					addOperatorLog(cangFangXinXiFormMap, "delete");					
				}
				
				WarehouseFormMap warehouse = warehouseMapper.findWarehouseById(Integer.parseInt(id));
				warehouseMapper.deleteEntityByKey("id", id, WarehouseFormMap.class);
				addOperatorLog(warehouse, "delete");
			}else{
				throw new RuntimeException();
			}
		}else{
			//获取仓房信息,并删除
			CangFangXinXiFormMap cangFangXinXiFormMap = cangFangXinXiMapper.findBywId(Integer.parseInt(id));
			if(cangFangXinXiFormMap != null){
				warehouseMapper.deleteEntityByKey("id", cangFangXinXiFormMap.getInt("id")+"", CangFangXinXiFormMap.class);
				addOperatorLog(cangFangXinXiFormMap, "delete");					
			}
			
			WarehouseFormMap warehouse = warehouseMapper.findWarehouseById(Integer.parseInt(id));
			warehouseMapper.deleteEntityByKey("id", id, WarehouseFormMap.class);
			addOperatorLog(warehouse, "delete");
		}
		
	}

	@Override
	public WarehouseFormMap findById(String id){
		return warehouseMapper.findWarehouseById(Integer.parseInt(id));
	}

	@Override
	public WarehouseFormMap findWarehouseInfoById(String id) {
		return warehouseMapper.findWarehouseInfoById(Integer.parseInt(id));
	}

	@Override
	public List<WarehouseFormMap> findByPage(WarehouseFormMap warehouseFormMap,
			int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return warehouseMapper.findByPage(warehouseFormMap);
	}

	@Override
	public List<WarehouseFormMap> findWarehouseInfoByPage(
			WarehouseFormMap warehouseFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return warehouseMapper.findWarehouseInfoByPage(warehouseFormMap);
	}
	
	private void addOperatorLog(WarehouseFormMap warehouseFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		warehouseFormMap.set(Constant.ENTITY_TABLE, "t_warehouse_his");
		warehouseFormMap.set("execSQL", sql);
		warehouseFormMap.set("execUser", session.getAttribute("userSessionId"));
		warehouseFormMap.set("execType", type);
		warehouseFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		warehouseMapper.addEntity(warehouseFormMap);
	}
	private void addOperatorLog(CangFangXinXiFormMap cangFangXinXiFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		cangFangXinXiFormMap.remove("wLocationId");
		cangFangXinXiFormMap.set(Constant.ENTITY_TABLE, "t_warehouse_archives_his");
		cangFangXinXiFormMap.set("wahSQL", sql);
		cangFangXinXiFormMap.set("wahUser", session.getAttribute("userSessionId"));
		cangFangXinXiFormMap.set("wahType", type);
		cangFangXinXiFormMap.set("wahOpDate", new Timestamp(System.currentTimeMillis()));
	    cangFangXinXiMapper.addEntity(cangFangXinXiFormMap);
	}
}
