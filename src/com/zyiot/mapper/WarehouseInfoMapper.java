package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.WarehouseInfoFormMap;

public interface WarehouseInfoMapper extends BaseMapper {
	/**
	 * 根据仓库地点，仓号查询日期
	 * @param warehouseLocationNo 仓库编号
	 * @param warehouseNo  仓号编号
	 * @return
	 */
	public List<WarehouseInfoFormMap> findDateBywarehouseNo(String warehouseNo);
	
	/**
	 * 查找最高温度和最低温度为null的数据
	 * @author Lip
	 * @return
	 */
	public List<WarehouseInfoFormMap> findMaxAndMinValueOfNull();
	
	/**
	 * 批量更新最高温度和最低温度值
	 * @author Lip
	 * @param warehouseInfoList
	 * @return
	 */
	public int bashUpdateMaxAndMin(List<WarehouseInfoFormMap> warehouseInfoList);
	
	/**
	 * 温度报表
	 * 查找需要温度进行转换的数据
	 * @return
	 */
	public List<WarehouseInfoFormMap> findNeedTransformData();
	/**
	 * 根据id获取温度和三维的行，列，层
	 * @param id
	 * @return
	 */
	public WarehouseInfoFormMap findSideAndDataById(int id);
	
	/**
	 * 根据仓号，开始时间，结束时间获取粮温趋势图
	 * @param warehouseInfo
	 * @return
	 */
	public List<WarehouseInfoFormMap> findTemperatureTendency(WarehouseInfoFormMap warehouseInfo);
	
	/**
	 * 查找需要进行处理报警的数据
	 * 只查询每个仓库的最后一条
	 * @param id 开始id
	 * @return
	 */
	public List<WarehouseInfoFormMap> findTemperatureAlarm(int id);
}
