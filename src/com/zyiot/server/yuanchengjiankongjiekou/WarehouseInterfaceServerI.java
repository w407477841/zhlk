package com.zyiot.server.yuanchengjiankongjiekou;

import java.util.List;

import com.zyiot.entity.yuanchengjiankongjiekou.WarehouseInterfaceFormMap;
/**
 * 仓房对接配置
 * @author Admin
 * @date 2017年8月15日 上午10:17:51
 */
public interface WarehouseInterfaceServerI {
	public void addWarehouse(WarehouseInterfaceFormMap warehouse)throws Exception;
	public void editWarehouse(WarehouseInterfaceFormMap warehouse)throws Exception;
	public void dropWarehouse(String warehoseId)throws Exception;
	
	public List<WarehouseInterfaceFormMap> findByPage(WarehouseInterfaceFormMap warehouse,int pageSize,int pageNum);
	
	public WarehouseInterfaceFormMap findById(String warehouseId);
}
