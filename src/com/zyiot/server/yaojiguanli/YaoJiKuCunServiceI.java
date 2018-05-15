package com.zyiot.server.yaojiguanli;

import java.util.List;

import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;

public interface YaoJiKuCunServiceI {
	void addYaoJiKuCun(YaoJiKuCunFormMap yaoJiKuCunFormMap)throws Exception;
	void editYaoJiKuCun(YaoJiKuCunFormMap yaoJiKuCunFormMap)throws Exception;
	void deleteYaoJiKuCunById(String id)throws Exception;
	
	void increaseYaoJiKuCun(YaoJiKuCunFormMap yaoJiKuCunFormMap)throws Exception;
		
	List<YaoJiKuCunFormMap> findByPage(YaoJiKuCunFormMap yaoJiKuCunFormMap,int pageSize,int pageNum);
	List<YaoJiKuCunFormMap> findByAttr(YaoJiKuCunFormMap yaoJiKuCunFormMap);
	List<YaoJiKuCunFormMap> findAll();
	
	YaoJiKuCunFormMap findById(int id) throws Exception;
	YaoJiKuCunFormMap lookById(int id) throws Exception;
}
