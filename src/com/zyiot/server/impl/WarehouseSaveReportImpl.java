package com.zyiot.server.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyiot.entity.WarehouseSaveReportFormMap;
import com.zyiot.mapper.WarehouseSaveReportMapper;
import com.zyiot.server.WarehouseSaveReportI;

@Service("warehouseSaveReport")
public class WarehouseSaveReportImpl implements WarehouseSaveReportI {
	@Autowired
	WarehouseSaveReportMapper warehouseSaveReportMapper;

	public void add(WarehouseSaveReportFormMap w) throws Exception {
		warehouseSaveReportMapper.addEntity(w);
	}

}
