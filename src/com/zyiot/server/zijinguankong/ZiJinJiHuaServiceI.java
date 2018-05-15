package com.zyiot.server.zijinguankong;

import java.util.List;

import com.zyiot.entity.zijinguankong.ZiJinJiHuaFormMap;

public interface ZiJinJiHuaServiceI {
	void addZiJinJiHua(ZiJinJiHuaFormMap ziJinJiHuaFormMap)throws Exception;
	void editZiJinJiHua(ZiJinJiHuaFormMap ziJinJiHuaFormMap)throws Exception;
	void dropZiJinJiHua(String id)throws Exception;
	
	List<ZiJinJiHuaFormMap> findByPage(ZiJinJiHuaFormMap ziJinJiHuaFormMap,int pageSize,int pageNum);
	
	ZiJinJiHuaFormMap findZiJinJiHuaById(int id);
	/**
	 * 查找所有资金计划
	 * @return
	 */
	List<ZiJinJiHuaFormMap> findAllZiJinJiHua();
}
