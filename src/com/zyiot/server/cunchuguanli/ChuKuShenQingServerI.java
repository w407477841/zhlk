package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.ChuKuShenQingFormMap;

public interface ChuKuShenQingServerI {
	public void addChuKuShenQing(ChuKuShenQingFormMap chuKuShenQingFormMap)throws Exception;
	public void editChuKuShenQing(ChuKuShenQingFormMap chuKuShenQingFormMap)throws Exception;
	public void dropChuKuShenQing(String id)throws Exception;
	
	public List<ChuKuShenQingFormMap> findByPage(ChuKuShenQingFormMap chuKuShenQingFormMap,int pageNum,int pageSize);
	//查找需要审批的数据
	public List<ChuKuShenQingFormMap> findShenPiByPage(ChuKuShenQingFormMap chuKuShenQingFormMap,int pageNum,int pageSize);
	
	public ChuKuShenQingFormMap findChuKuShenQingById(int id) throws Exception;
	
	public ChuKuShenQingFormMap lookChuKuShenQingById(int id) throws Exception;
	
	public void approveChuKuShenQing(ChuKuShenQingFormMap chuKuShenQingFormMap)throws Exception;
}
