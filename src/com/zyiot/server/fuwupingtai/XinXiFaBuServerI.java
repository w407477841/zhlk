package com.zyiot.server.fuwupingtai;

import java.util.List;

import com.zyiot.entity.fuwupingtai.XinXiFaBuFormMap;
import com.zyiot.util.FormMap;

public interface XinXiFaBuServerI {
	void addXinXiFaBu(XinXiFaBuFormMap xinXiFaBuFormMap) throws Exception;
	void editXinXiFaBu(XinXiFaBuFormMap xinXiFaBuFormMap) throws Exception;
	void dropXinXiFaBu(String id) throws Exception;
	
	List<XinXiFaBuFormMap> findByPage(XinXiFaBuFormMap xinXiFaBuFormMap,int pageNum,int pageSize);
	
	XinXiFaBuFormMap findXinXiFaBuById(int id) throws Exception;
	
	XinXiFaBuFormMap lookXinXiFaBuById(int id) throws Exception;
	/**
	 * 查询信息发布类型
	 * @return
	 */
	List<FormMap<String, Object>> findXinXiType();
}
