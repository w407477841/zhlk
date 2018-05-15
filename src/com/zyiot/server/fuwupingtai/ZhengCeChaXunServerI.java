package com.zyiot.server.fuwupingtai;

import java.util.List;

import com.zyiot.entity.fuwupingtai.ZhengCeChaXunFormMap;
import com.zyiot.util.FormMap;

public interface ZhengCeChaXunServerI {
	
	void addZhengCeChaXun(ZhengCeChaXunFormMap zhengCeChaXunFormMap)throws Exception;
	void editZhengCeChaXun(ZhengCeChaXunFormMap zhengCeChaXunFormMap)throws Exception;
	void dropZhengCeChaXun(String id)throws Exception;
	
    List<ZhengCeChaXunFormMap> findByPage(ZhengCeChaXunFormMap zhengCeChaXunFormMap,int pageNum,int pageSize);
	
    ZhengCeChaXunFormMap findZhengCeChaXunById(int id) throws Exception;
	
    ZhengCeChaXunFormMap lookZhengCeChaXunById(int id) throws Exception;
	/**
	 * 查询政策类型
	 * @return
	 */
	List<FormMap<String, Object>> findZhengCeType();
}
