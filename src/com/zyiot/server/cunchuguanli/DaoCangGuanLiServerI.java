package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.DaoCangGuanLiFormMap;

public interface DaoCangGuanLiServerI {
	public void addDaoCangGuanLi(DaoCangGuanLiFormMap daoCangGuanLiFormMap) throws Exception;
	
	public List<DaoCangGuanLiFormMap> findByPage(DaoCangGuanLiFormMap daoCangGuanLiFormMap,int pageNum,int pageSize);
	
	public DaoCangGuanLiFormMap findDaoCangGuanLiById(int id) throws Exception;
	/**
	 * 根据仓库编号获取倒仓信息
	 * @author Lip
	 * @param warehouseId 仓库编号
	 * @return
	 * @throws Exception
	 */
	public DaoCangGuanLiFormMap findDaoCangGuanLiByWarehouseId(int warehouseId) throws Exception;
}
