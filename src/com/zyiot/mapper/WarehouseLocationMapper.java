package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.WarehouseLocationFormMap;
/**
 * 粮库地点
 * @author Admin
 * @date 2017年8月9日 上午8:45:14
 */
public interface WarehouseLocationMapper extends BaseMapper {
	WarehouseLocationFormMap findTopOne();
	
	List<WarehouseLocationFormMap> findByPage(WarehouseLocationFormMap warehouseLocation);
	
	List<WarehouseLocationFormMap> findBySelect();
	/**
	 * 根据id获取
	 * @param id
	 * @return
	 */
	WarehouseLocationFormMap findWarehouseLocationById(int id);
	/**
	 * 根据粮库地点获取平面展示图
	 * @param localtionId
	 * @return
	 */
	String getImagePath(String localtionId);
}
