package com.zyiot.server.impl.yuanchengjiankongjiekou;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.entity.yuanchengjiankongjiekou.WarehouseInterfaceFormMap;
import com.zyiot.mapper.yuanchengjiankongjiekou.WarehouseInterfaceMapper;
import com.zyiot.server.yuanchengjiankongjiekou.WarehouseInterfaceServerI;
@Service("warehouseInterfaceServer")
public class WarehouseInterfaceServerImpl implements WarehouseInterfaceServerI {
	@Autowired
	private WarehouseInterfaceMapper warehouseInterfaceMapper;
	
	@Override
	public void addWarehouse(WarehouseInterfaceFormMap warehouse)
			throws Exception {
		warehouseInterfaceMapper.addEntity(warehouse);
	}

	@Override
	public void editWarehouse(WarehouseInterfaceFormMap warehouse)
			throws Exception {
		warehouseInterfaceMapper.updateEntity(warehouse);
	}

	@Override
	public void dropWarehouse(String warehoseId) throws Exception {
		warehouseInterfaceMapper.deleteEntityByKey("warehose_id", warehoseId, WarehouseInterfaceFormMap.class);
	}

	@Override
	public List<WarehouseInterfaceFormMap> findByPage(
			WarehouseInterfaceFormMap warehouse, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return warehouseInterfaceMapper.findByPage(warehouse);
	}

	@Override
	public WarehouseInterfaceFormMap findById(String warehouseId) {
		return warehouseInterfaceMapper.findById(warehouseId, WarehouseInterfaceFormMap.class);
	}

}
