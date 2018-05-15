package com.zyiot.server.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.Module;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.StorageDetailFormMap;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.StoreInfoFormMap;
import com.zyiot.entity.qualityChain.InstanceMsgFormMap;
import com.zyiot.mapper.BaseMapper;
import com.zyiot.mapper.StorageDetailMapper;
import com.zyiot.mapper.StorageInfoMapper;
import com.zyiot.mapper.StorageMapper;
import com.zyiot.mapper.StoreInfoMapper;
import com.zyiot.server.StoreInfoServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;

@Service("storeInfoServer")
@Module(module = "仓库存粮")
public class StoreInfoServerImpl extends
		BaseServerImpl<StoreInfoFormMap, BaseMapper> implements
		StoreInfoServerI {
	@Autowired
	StoreInfoMapper storeInfoMapper;
	@Autowired
	StorageInfoMapper storageInfoMapper;
	@Autowired
	StorageDetailMapper storageDetailMapper;
	@Autowired
	StorageMapper smapper;

	

	@Override
	public List<StorageInfoFormMap> findCurrentStorageByPage(
			StorageInfoFormMap s, int pageSize, int pageNum) {

		PageHelper.startPage(pageNum, pageSize);
		return storeInfoMapper.findCurrentStorageByPage(s);
	}

	@Override
	public List<Map> findCurrentStorageByPage(Map s, int pageSize, int pageNum) {
		return storeInfoMapper.findStorageByPage1(s);
	}

	@Override
	public StorageInfoFormMap findCurrentStorageOne(StorageInfoFormMap s) {

		List<StorageInfoFormMap> l = storeInfoMapper.findStorageByPage(s);

		if (l != null && l.size() > 0)
			return l.get(0);

		return new StorageInfoFormMap();
	}

	@Override
	public List<StorageInfoFormMap> findCurrentStorageByCategory() {
		return storeInfoMapper.findStorageByCategory();
	}

	/**
	 * 
	 */
	@SystemLog(module = "外部接口", methods = "实时库存更新", description = "成功")
	public void batchSaveStorageInfo(List<StorageInfoFormMap> l)
			throws Exception {
		for (StorageInfoFormMap s : l) {
			storeInfoMapper.updateStorage(s);
		}
	}

	@Override
	public StorageInfoFormMap findStorageByStorageID(StorageInfoFormMap s) {
		return storeInfoMapper.findStorageByStorageID(s);
	}

	@Override
	public List<StoreInfoFormMap> findAll() {
		return storeInfoMapper.findByAttr(new StoreInfoFormMap());
	}

	@Override
	public List<StorageDetailFormMap> findAllDetail() {
		return storeInfoMapper.findByAttr(new StorageDetailFormMap());
	}

	public List<InstanceMsgFormMap> findAllTongcang() {

		return storeInfoMapper.findByAttr(new InstanceMsgFormMap());
	}

	@Override
	public List<StorageInfoFormMap> findByPage(int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return storeInfoMapper.findByPage();
	}

	@Override
	public List<StorageInfoFormMap> findStorageByPage(StorageInfoFormMap s,
			int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return storeInfoMapper.findStoreByPage(s);
	}

	@Override
	@SystemLog(module="仓库定性",methods="定性添加",description="添加成功")
	public void addStorageInfo(StorageInfoFormMap storageInfoFormMap)
			throws Exception {
		StorageInfoFormMap storageInfo = storeInfoMapper.findStorageByWarehouse(storageInfoFormMap.getStr("source"), storageInfoFormMap.getStr("storageID"));
		if(storageInfo != null){
			throw new Exception();
		}else{
			storeInfoMapper.addEntity(storageInfoFormMap);
		}
	}

	@Override
	@SystemLog(module="仓库定性",methods="定性修改",description="修改成功")
	public void editStorageInfo(StorageInfoFormMap storageInfoFormMap)
			throws Exception {
		StorageInfoFormMap storageInfo = storeInfoMapper.findStorageInfoById(Integer.parseInt(storageInfoFormMap.getStr("id")));
		if(storageInfo.getStr("cangKu") == null || storageInfo.getStr("cangKu").equals("0")){
			storeInfoMapper.updateEntity(storageInfoFormMap);
		}else{ //只进行年份修改
			storageInfoFormMap.remove("source");
			storageInfoFormMap.remove("storageID");
			storageInfoFormMap.remove("quanZhong");
			storageInfoFormMap.remove("name");
			storeInfoMapper.updateEntity(storageInfoFormMap);
		}
	}

	@Override
	@SystemLog(module="仓库定性",methods="定性删除",description="删除成功")
	public void dropStorageInfo(String id)
			throws Exception {
		StorageInfoFormMap storageInfo = storeInfoMapper.findByWarehouseId(Integer.parseInt(id));
		if(storageInfo.getStr("cangKu") == null || storageInfo.getStr("cangKu").equals("0")){
			storeInfoMapper.deleteEntityByKey("storageID", id, StorageInfoFormMap.class);
		}else{
			throw new Exception();
		}
	}

	@Override
	public StorageInfoFormMap findStorageByWarehouseId(int warehouseId) {
		return storeInfoMapper.findByWarehouseId(warehouseId);
	}

	@Override
	public StorageInfoFormMap findStorageById(int id) {
		return storeInfoMapper.findStorageById(id);
	}
	
	
}
