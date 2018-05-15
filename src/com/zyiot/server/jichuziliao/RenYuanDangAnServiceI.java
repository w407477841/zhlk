package com.zyiot.server.jichuziliao;

import java.util.List;

import com.zyiot.entity.jichuziliao.RenYuanDangAnFormMap;

public interface RenYuanDangAnServiceI {
	void addRenYuanDangAn(RenYuanDangAnFormMap renYuanDangAnFormMap) throws Exception;
	void editRenYuanDangAn(RenYuanDangAnFormMap renYuanDangAnFormMap) throws Exception;
	void dropRenYuanDangAn(String id) throws Exception;
	
	List<RenYuanDangAnFormMap> findByPage(RenYuanDangAnFormMap renYuanDangAnFormMap,int pageSize,int pageNum);
	
	List<RenYuanDangAnFormMap> findByAttr(RenYuanDangAnFormMap renYuanDangAnFormMap);
	
	RenYuanDangAnFormMap findRenYuanDangAnById(int id);
}
