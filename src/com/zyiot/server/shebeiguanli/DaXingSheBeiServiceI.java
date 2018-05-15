package com.zyiot.server.shebeiguanli;

import java.util.List;

import com.zyiot.entity.shebeiguanli.DaXingSheBeiFormMap;

public interface DaXingSheBeiServiceI {
	void addDaXingSheBei(DaXingSheBeiFormMap daXingSheBeiFormMap) throws Exception;
	void editDaXingSheBei(DaXingSheBeiFormMap daXingSheBeiFormMap) throws Exception;
	void dropDaXingSheBei(String id) throws Exception;
	
	List<DaXingSheBeiFormMap> findByPage(DaXingSheBeiFormMap daXingSheBeiFormMap,int pageSize,int pageNum);
	List<DaXingSheBeiFormMap> findByAttr(DaXingSheBeiFormMap daXingSheBeiFormMap);
	
	DaXingSheBeiFormMap findDaXingSheBeiById(int id);
	
	List<DaXingSheBeiFormMap> findAllName();
}
