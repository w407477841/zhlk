package com.zyiot.server.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.mapper.StorageInfoMapper;
import com.zyiot.server.StorageServiceI;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;

@Service("storageService")
public class StorageServiceImpl implements StorageServiceI {
	@Autowired
	private StorageInfoMapper storageMapper;

	@Override
	public List<StorageInfoFormMap> classifyBykudian(Map<String, String> map) {
		return storageMapper.classifybykudian(map);
	}

	@Override
	public List<StorageInfoFormMap> classifyByNo(Map<String, String> formmap,
			int page, int row) {
		PageHelper.startPage(row, page);
		return storageMapper.classifyByNo(formmap);
	}

	@Override
	public List<StorageInfoFormMap> classifyByquan(Map<String, String> map) {
		return storageMapper.classifybyquan(map);
	}

	@Override
	public List<StorageInfoFormMap> findLocation() {
		return storageMapper.findLocation();
	}

	@Override
	public List<StorageInfoFormMap> queryLibraryInfo(Map<String, String> map,
			int page, int row) {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(page, row));
		}
		return storageMapper.queryLibraryInfo(map);
	}

	@Override
	public List<StorageInfoFormMap> findAll() {
		//
		return storageMapper.findByAttr(new StorageInfoFormMap());
	}

	@Override
	public List<StorageInfoFormMap> findBreeds() {
		return storageMapper.findBreeds();
	}

	@Override
	public List<StorageInfoFormMap> findProperties() {
		return storageMapper.findProperties();
	}

	@Override
	public Map instancWeight(Map map) throws Exception {
		return storageMapper.instancWeight(map);
	}

	@Override
	public List<Map> findContrastLocation() {
		return storageMapper.findContrastLocation();
	}

	@Override
	public List<Map> findContrastStation(Map param) {
		return storageMapper.findContrastStation(param);
	}


	@Override
	public StorageInfoFormMap findVarietyAndPropertyByWarehouseId(
			int warehouseId) {
		return storageMapper.findVarietyAndPropertyByWarehouseId(warehouseId);
	}

	/**
	 * 根据仓库编号修改库存
	 */
	@Transactional(readOnly = false)
	@SystemLog(module = "库存", methods = "修改或添加库存", description = "成功")
	public void editOrAddStorage(StorageInfoFormMap map) throws Exception {

		int rows = storageMapper.updateStorageByStorageID(map);
		if (rows == 1) {
			return;
		} else {
			FormMapUtil.toADDFormMap(map);
			storageMapper.addEntity(map);
		}

	}

	/**
	 * 通过流水单ID 修改库存
	 */
	@Transactional(readOnly = false)
	@SystemLog(module = "库存", methods = "修改或添加库存", description = "成功")
	public void editOrAddStorageByliushui(StorageInfoFormMap map)
			throws Exception {
		storageMapper.updateStorageByLiushui(map);
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "库存", methods = "修改或添加库存", description = "成功")
	public void editOrAddStorageByBasicid(StorageInfoFormMap map)
			throws Exception {
		storageMapper.updateStorageBybasicid(map);

	}

	@Override
	public List<StorageInfoFormMap> findCurrentStorageByPage(
			StorageInfoFormMap storageInfoFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return storageMapper.findCurrentStorageByPage(storageInfoFormMap);
	}

	@Override
	public List<StorageInfoFormMap> findDetailStorageByPage(
			StorageInfoFormMap storageInfoFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return storageMapper.findDetailStorageByPage(storageInfoFormMap);
	}

	@Override
	public List<StorageInfoFormMap> findCurrentTotalWeight(FormMap<String,Object> base) {
		return storageMapper.findCurrentTotalWeight(base);
	}

	@Override
	public List<StorageInfoFormMap> findAllWarehouseLocation() {
		return storageMapper.findAllWarehouseLocation();
	}

	@Override
	public List<StorageInfoFormMap> findAllGrainProperty() {
		return storageMapper.findAllGrainProperty();
	}

	@Override
	public List<StorageInfoFormMap> findAllGrainVariety() {
		return storageMapper.findAllGrainVariety();
	}

	@Override
	public List<StorageInfoFormMap> findSumStorage(FormMap<String, Object> base) {
		return storageMapper.findSumStorage(base);
	}
}
