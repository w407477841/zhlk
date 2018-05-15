package com.zyiot.server.impl.yuanchengjiankongjiekou;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.entity.yuanchengjiankongjiekou.WarehouseLocationInterfaceFormMap;
import com.zyiot.mapper.yuanchengjiankongjiekou.WarehouseLocationInterfaceMapper;
import com.zyiot.server.yuanchengjiankongjiekou.WarehouseLocationInterfaceServerI;
import com.zyiot.util.FormMapUtil;

@Service("warehouseLocationInterfaceServer")
public class WarehouseLocationInterfaceServerImpl implements
		WarehouseLocationInterfaceServerI {
	@Autowired
	private WarehouseLocationInterfaceMapper warehouseLocationInterfaceMapper;
	
	@Override
	public void addWarehouseLocation(
			WarehouseLocationInterfaceFormMap warehouseLocation)
			throws Exception {
		warehouseLocationInterfaceMapper.addEntity(warehouseLocation);
	}

	@Override
	@Transactional(readOnly = false)
	public void editWarehouseLocation(
			WarehouseLocationInterfaceFormMap warehouseLocation)
			throws Exception {
		warehouseLocationInterfaceMapper.updateEntity(warehouseLocation);
		
		List<WarehouseLocationInterfaceFormMap> list = warehouseLocationInterfaceMapper.findAllByXinYongDaiMa(warehouseLocation.getStr("tongyixinyongdaima"));
		for(WarehouseLocationInterfaceFormMap form:list){
			if(!form.getStr("qiyemingcheng").equals(warehouseLocation.getStr("qiyemingcheng"))){
				form.set("qiyemingcheng", warehouseLocation.getStr("qiyemingcheng"));
				form.remove("wName");
				FormMapUtil.toUPDATEFormMap(form);
				warehouseLocationInterfaceMapper.updateEntity(form);
			}
		}
	}

	@Override
	public void dropWarehouseLocation(String locationNo) throws Exception {
		warehouseLocationInterfaceMapper.deleteEntityByKey("location_no", locationNo, WarehouseLocationInterfaceFormMap.class);
	}

	@Override
	public List<WarehouseLocationInterfaceFormMap> findByPage(
			WarehouseLocationInterfaceFormMap warehouseLocation, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return warehouseLocationInterfaceMapper.findByPage(warehouseLocation);
	}

	@Override
	public WarehouseLocationInterfaceFormMap findById(String locationNo) {
		return warehouseLocationInterfaceMapper.findById(locationNo, WarehouseLocationInterfaceFormMap.class);
	}

	@Override
	public WarehouseLocationInterfaceFormMap findByXinYongDaiMa(
			String xinyongdaima) {
		return warehouseLocationInterfaceMapper.findByXinYongDaiMa(xinyongdaima);
	}

	@Override
	public List<WarehouseLocationInterfaceFormMap> findAllByXinYongDaiMa(
			String xinyongdaima) {
		return warehouseLocationInterfaceMapper.findAllByXinYongDaiMa(xinyongdaima);
	}

	@Override
	public List<WarehouseLocationInterfaceFormMap> findAllMingCheng() {
		return warehouseLocationInterfaceMapper.findAllMingCheng();
	}

}
