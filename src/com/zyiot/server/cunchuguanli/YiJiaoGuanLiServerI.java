package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.YiJiaoGuanLiFormMap;

public interface YiJiaoGuanLiServerI {
	
	public void addYiJiaoGuanLi(YiJiaoGuanLiFormMap yiJiaoGuanLiFormMap)throws Exception;
	public void dropYiJiaoGuanLi(String id)throws Exception;
	
	public List<YiJiaoGuanLiFormMap> findByPage(YiJiaoGuanLiFormMap yiJiaoGuanLiFormMap,int pageNum,int pageSize);
	
	public YiJiaoGuanLiFormMap findYiJiaoGuanLiById(int id) throws Exception;
}
