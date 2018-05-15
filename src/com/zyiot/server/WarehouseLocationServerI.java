package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.WarehouseLocationFormMap;
/**
 * 粮库地点
 * @author Admin
 * @date 2017年8月8日 下午3:58:48
 */
public interface WarehouseLocationServerI {
	void addWarehouseLocation(WarehouseLocationFormMap warehouseLocation) throws Exception;
	void editWarehouseLocation(WarehouseLocationFormMap warehouseLocation) throws Exception;
	void dropWarehouseLocation(String id) throws Exception;
	
	List<WarehouseLocationFormMap> findAllWarehouseLocation(WarehouseLocationFormMap warehouseLocation);
	
	List<WarehouseLocationFormMap> findBySelect();
	
	List<WarehouseLocationFormMap> findByPage(WarehouseLocationFormMap warehouseLocation,int pageSize,int pageNum);
	
	WarehouseLocationFormMap findWarehouseLocationById(String id);
	/**
	 * 根据粮库地点获取平面展示图
	 * @param localtionId
	 * @return
	 */
	String getImagePath(String localtionId);
}
