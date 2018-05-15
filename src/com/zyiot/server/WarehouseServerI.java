package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.WarehouseFormMap;
/**
 * 仓房
 * @author Admin
 * @date 2017年8月9日 上午10:56:20
 */
public interface WarehouseServerI {
	List<WarehouseFormMap> findAllWarehouseByLocationId(
			WarehouseFormMap warehouse) throws Exception;

	void batchSave(List<WarehouseFormMap> l) throws Exception;

	List<WarehouseFormMap> findAllByLocation() throws Exception;

	List<WarehouseFormMap> findWareHouseByLocation(WarehouseFormMap w);

	List<WarehouseFormMap> findWareHouseByLocation2(WarehouseFormMap w);
	/**
	 * 根据粮食品种和库点查找仓号
	 * @param w
	 * @return
	 */
	List<WarehouseFormMap> findWareHouseByLocationAndVariety(WarehouseFormMap w);
	
	
	public void addWarehouse(WarehouseFormMap warehouseFormMap)throws Exception;
	public void editWarehouse(WarehouseFormMap warehouseFormMap)throws Exception;
	public void dropWarehouse(String id)throws Exception;
	
	public WarehouseFormMap findById(String id);
	/**
	 * 查询粮情信息
	 * @param id
	 * @return
	 */
	public WarehouseFormMap findWarehouseInfoById(String id);
	
	public List<WarehouseFormMap> findByPage(WarehouseFormMap warehouseFormMap,int pageSize,int pageNum);

	/**
	 * 分页查询粮情信息
	 * @param warehouseFormMap
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	public List<WarehouseFormMap> findWarehouseInfoByPage(WarehouseFormMap warehouseFormMap,int pageSize,int pageNum);
	
}
