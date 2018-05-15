package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.WarehouseInfoFormMap;
import com.zyiot.entity.WarehouseInfoTransformFormMap;
import com.zyiot.util.BatchInsertParameter;

public interface WarehouseInfoServerI {
	int addWarehouseInfo(WarehouseInfoFormMap warehouseInfo) throws Exception;

	int editWarehouseInfo(WarehouseInfoFormMap warehouseInfo) throws Exception;

	int dropWarehouseInfo(WarehouseInfoFormMap warehouseInfo) throws Exception;

	void batchSave(List<WarehouseInfoFormMap> l) throws Exception;

	WarehouseInfoFormMap findWarehouseById(String id) throws Exception;

	List<WarehouseInfoFormMap> findAllByWarehouseId(
			WarehouseInfoFormMap warehouseInfo) throws Exception;
	List<WarehouseInfoFormMap> findDate(String warehouseNo) throws Exception;
	/**
	 * 获取最高温度和最低温度为null的数据行
	 * @author Lip
	 * @return
	 * @throws Exception
	 */
	List<WarehouseInfoFormMap> findMaxAndMinValuesOfNull() throws Exception;
	/**
	 * 批量进行更新，更新最高温度和最低温度
	 * @author Lip
	 * @param warehouseInfoList
	 * @return
	 * @throws Exception
	 */
	int bashUpdateMaxAndMinValues(List<WarehouseInfoFormMap> warehouseInfoList)throws Exception;
	/**
	 * 粮情数据报表显示
	 * 查找需要进行转换的数据
	 * @return
	 * @throws Exception
	 */
	List<WarehouseInfoFormMap> findNeedTransformData() throws Exception;
	/**
	 * 添加转换后的数据
	 * @param warehouseInfo
	 * @return
	 * @throws Exception
	 */
	int addWarehouseInfoTransform(WarehouseInfoTransformFormMap warehouseInfo) throws Exception;
	
	void bathSaveWarehouseInfoTransform(BatchInsertParameter<WarehouseInfoTransformFormMap> batchSave) throws Exception;
	/**
	 * 根据id获取温度信息和三维展示行，列，层
	 * @param id
	 * @return
	 */
	WarehouseInfoFormMap findSideAndDataById(int id);
	/**
	 * 根据仓号，开始时间，结束时间，获取粮温趋势图
	 * @return
	 */
	List<WarehouseInfoFormMap> findTemperatureTendency(WarehouseInfoFormMap warehouseInfo);
	
	/**
	 * 查找需要进行处理报警的数据
	 * 只查询每个仓库的最后一条
	 * @param id 开始id
	 * @return
	 */
	public List<WarehouseInfoFormMap> findTemperatureAlarm(int id);
}
