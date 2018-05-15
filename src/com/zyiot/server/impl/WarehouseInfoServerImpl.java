package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.WarehouseInfoFormMap;
import com.zyiot.entity.WarehouseInfoTransformFormMap;
import com.zyiot.mapper.WarehouseInfoMapper;
import com.zyiot.server.WarehouseInfoServerI;
import com.zyiot.util.BatchInsertParameter;

@Service("warehouseInfoServer")
public class WarehouseInfoServerImpl implements WarehouseInfoServerI {
	private WarehouseInfoMapper warehouseInfoMapper;

	public WarehouseInfoMapper getWarehouseInfoMapper() {
		return warehouseInfoMapper;
	}

	@Autowired
	public void setWarehouseInfoMapper(WarehouseInfoMapper warehouseInfoMapper) {
		this.warehouseInfoMapper = warehouseInfoMapper;
	}

	@Override
	public int addWarehouseInfo(WarehouseInfoFormMap warehouseInfo)
			throws Exception {
		return warehouseInfoMapper.addEntity(warehouseInfo);
	}

	@Override
	public int editWarehouseInfo(WarehouseInfoFormMap warehouseInfo)
			throws Exception {
		return warehouseInfoMapper.updateEntity(warehouseInfo);
	}

	@Override
	public int dropWarehouseInfo(WarehouseInfoFormMap warehouseInfo)
			throws Exception {
		return warehouseInfoMapper.updateEntity(warehouseInfo);
	}

	@Override
	public WarehouseInfoFormMap findWarehouseById(String id) throws Exception {
		return warehouseInfoMapper.findById(id, WarehouseInfoFormMap.class);
	}

	@Override
	public List<WarehouseInfoFormMap> findAllByWarehouseId(
			WarehouseInfoFormMap warehouseInfo) throws Exception {
		return warehouseInfoMapper.findByAttr(warehouseInfo);
	}

	@SystemLog(module = "外部接口", methods = "粮情数据接入", description = "成功")
	@Transactional(readOnly = false)
	public void batchSave(List<WarehouseInfoFormMap> l) throws Exception {

		warehouseInfoMapper.batchSave(BatchInsertParameter.wrap(l));

	}

	@Override
	public List<WarehouseInfoFormMap> findDate(
			String warehouseNo) throws Exception {
		return warehouseInfoMapper.findDateBywarehouseNo(warehouseNo);
	}

	@Override
	public List<WarehouseInfoFormMap> findMaxAndMinValuesOfNull() throws Exception {
		return warehouseInfoMapper.findMaxAndMinValueOfNull();
	}

	@Override
	public int bashUpdateMaxAndMinValues(
			List<WarehouseInfoFormMap> warehouseInfoList) throws Exception {
		return warehouseInfoMapper.bashUpdateMaxAndMin(warehouseInfoList);
	}

	@Override
	public List<WarehouseInfoFormMap> findNeedTransformData() throws Exception {
		return warehouseInfoMapper.findNeedTransformData();
	}

	@Override
	public int addWarehouseInfoTransform(
			WarehouseInfoTransformFormMap warehouseInfo) throws Exception {
		return warehouseInfoMapper.addEntity(warehouseInfo);
	}

	@Override
	public WarehouseInfoFormMap findSideAndDataById(int id) {
		return warehouseInfoMapper.findSideAndDataById(id);
	}

	@Override
	@Transactional(readOnly = false)
	public void bathSaveWarehouseInfoTransform(
			BatchInsertParameter<WarehouseInfoTransformFormMap> batchSave)
			throws Exception {
		warehouseInfoMapper.batchSave(batchSave);
	}

	@Override
	public List<WarehouseInfoFormMap> findTemperatureTendency(
			WarehouseInfoFormMap warehouseInfo) {
		return warehouseInfoMapper.findTemperatureTendency(warehouseInfo);
	}

	@Override
	public List<WarehouseInfoFormMap> findTemperatureAlarm(int id) {
		return warehouseInfoMapper.findTemperatureAlarm(id);
	}
}
