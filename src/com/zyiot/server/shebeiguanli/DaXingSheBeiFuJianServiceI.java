package com.zyiot.server.shebeiguanli;

import java.util.List;

import com.zyiot.entity.shebeiguanli.DaXingSheBeiFuJianFormMap;

public interface DaXingSheBeiFuJianServiceI {
	void addDaXingSheBeiFuJian(DaXingSheBeiFuJianFormMap daXingSheBeiFuJianFormMap)throws Exception;
	void dropDaXingSheBeiFuJian(String id)throws Exception;
	void clearNotUsedData(int dataOperator) throws Exception;
	List<DaXingSheBeiFuJianFormMap> findByPage(DaXingSheBeiFuJianFormMap daXingSheBeiFuJianFormMap);

	List<DaXingSheBeiFuJianFormMap> findByleId(List<Integer> ids);
}
