package com.zyiot.server.yaojiguanli;

import java.util.List;

import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiLingYongFormMap;

public interface YaoJiLingYongServiceI {
	void addYaoJiLingYong(YaoJiLingYongFormMap yaoJiLingYongFormMap,YaoJiKuCunFormMap yaoJiKuCunFormMap)throws Exception;
	void editYaoJiLingYong(YaoJiLingYongFormMap yaoJiLingYongFormMap)throws Exception;
	void deleteYaoJiLingYongById(String id)throws Exception;
	
	List<YaoJiLingYongFormMap> findByPage(YaoJiLingYongFormMap yaoJiLingYongFormMap,int pageSize,int pageNum);
	List<YaoJiLingYongFormMap> findByAttr(YaoJiLingYongFormMap yaoJiLingYongFormMap);
	
	YaoJiLingYongFormMap findById(int id) throws Exception;
}
