package com.zyiot.server.jichuziliao;

import java.util.List;

import com.zyiot.entity.jichuziliao.CangFangXinXiFormMap;

public interface CangFangXinXiServiceI {
	void addCangFangXinXi(CangFangXinXiFormMap cangFangXinXiFormMap)throws Exception;
	void editCangFangXinXi(CangFangXinXiFormMap cangFangXinXiFormMap)throws Exception;
	void dropCangFangXinXi(String id)throws Exception;
	
	List<CangFangXinXiFormMap> findByPage(CangFangXinXiFormMap cangFangXinXiFormMap,int pageSize,int pageNum);
	CangFangXinXiFormMap findCangFangXinXiById(int id);
	
	CangFangXinXiFormMap findStoremanBywId(int id) throws Exception;
}
