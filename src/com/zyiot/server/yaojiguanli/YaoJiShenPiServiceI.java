package com.zyiot.server.yaojiguanli;

import java.util.List;

import com.zyiot.entity.yaojiguanli.YaoJiShenPiFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiShenQingFormMap;

public interface YaoJiShenPiServiceI {
	List<YaoJiShenPiFormMap> findByPage(YaoJiShenPiFormMap yaoJiShenPiFormMap,int pageSize,int pageNum);
	
	void auditingYaoJiShenQing(YaoJiShenQingFormMap yaoJiShenQingFormMap)throws Exception;
}
