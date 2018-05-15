package com.zyiot.server.yaojiguanli;

import java.util.List;

import com.zyiot.entity.yaojiguanli.YaoJiShenQingFormMap;

public interface YaoJiShenQingServiceI {
	void addYaoJiShenQing(YaoJiShenQingFormMap yaoJiShenQingFormMap) throws Exception;
	void editYaoJiShenQing(YaoJiShenQingFormMap yaoJiShenQingFormMap) throws Exception;
	void dropYaoJiShenQing(String id) throws Exception;
	
	void approveYaoJiShenQing(YaoJiShenQingFormMap yaoJiShenQingFormMap) throws Exception;
	
	List<YaoJiShenQingFormMap> findByPage(YaoJiShenQingFormMap yaoJiShenQingFormMap,int pageSize,int pageNum);
	List<YaoJiShenQingFormMap> findShenPiByPage(YaoJiShenQingFormMap yaoJiShenQingFormMap,int pageSize,int pageNum);
	List<YaoJiShenQingFormMap> findByAttr(YaoJiShenQingFormMap yaoJiShenQingFormMap);
	
	YaoJiShenQingFormMap findYaoJiShenQingById(int id);
	
}
