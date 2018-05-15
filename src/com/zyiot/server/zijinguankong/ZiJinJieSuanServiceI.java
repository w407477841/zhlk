package com.zyiot.server.zijinguankong;

import java.util.List;

import com.zyiot.entity.zijinguankong.ZiJinJieSuanFormMap;

public interface ZiJinJieSuanServiceI {
	void addZiJinJieSuan(ZiJinJieSuanFormMap ziJinJieSuanFormMap)throws Exception;
	void editZiJinJieSuan(ZiJinJieSuanFormMap ziJinJieSuanFormMap)throws Exception;
	void dropZiJinJieSuan(String id)throws Exception;
	
	List<ZiJinJieSuanFormMap> findByPage(ZiJinJieSuanFormMap ziJinJieSuanFormMap,int pageSize,int pageNum);
	ZiJinJieSuanFormMap findZiJinJieSuanById(int id);
}
