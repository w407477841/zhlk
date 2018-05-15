package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.DaoCangGuanLiFormMap;
import com.zyiot.mapper.BaseMapper;

public interface DaoCangGuanLiMapper extends BaseMapper {
	
	public List<DaoCangGuanLiFormMap> findByPage(DaoCangGuanLiFormMap daoCangGuanLiFormMap);
	
	public DaoCangGuanLiFormMap findDaoCangGuanLiById(int id);
	
	public DaoCangGuanLiFormMap findDaoCangGuanLiByWarehouseId(int id);
	
}
