package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.WarehouseFormMap;

public interface WarehouseMapper extends BaseMapper {
	List<WarehouseFormMap> findAllWarehouseByLocation();

	List<WarehouseFormMap> findWareHouseByLocation(WarehouseFormMap w);

	List<WarehouseFormMap> findWareHouseByLocation2(WarehouseFormMap w);
	
	List<WarehouseFormMap> findByPage(WarehouseFormMap w);
	/**
	 * 分页查询粮情信息
	 * @param warehouseFormMap
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	List<WarehouseFormMap> findWarehouseInfoByPage(WarehouseFormMap warehouseFormMap);
	
	WarehouseFormMap findWarehouseById(int id);
	/**
	 * 查询粮情信息
	 * @param id
	 * @return
	 */
    WarehouseFormMap findWarehouseInfoById(int id);
	/**
	 * 根据粮食品种和库点查找仓号
	 * @param w
	 * @return
	 */
	List<WarehouseFormMap> findWareHouseByLocationAndVariety(WarehouseFormMap w);
}
