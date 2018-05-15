package com.zyiot.server.shebeiguanli;

import java.util.List;

import com.zyiot.entity.shebeiguanli.DaXingSheBeiBaoFeiFormMap;

public interface DaXingSheBeiBaoFeiServiceI {
	void addDaXingSheBeiBaoFei(DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap)throws Exception;
	void editDaXingSheBeiBaoFei(DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap)throws Exception;
	void dropDaXingSheBeiBaoFei(String id)throws Exception;
	
	List<DaXingSheBeiBaoFeiFormMap> findByPage(DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap,int pageSize,int pageNum);
	List<DaXingSheBeiBaoFeiFormMap> findByAttr(DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap);
	
	DaXingSheBeiBaoFeiFormMap findDaXingSheBeiBaoFeiById(int id);
}
