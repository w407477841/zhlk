package com.zyiot.server.fuwupingtai;

import java.util.List;

import com.zyiot.entity.fuwupingtai.YuYueJiaoLiangFormMap;

public interface YuYueJiaoLiangServerI {
	public void addYuYueJiaoLiang(YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap)throws Exception;
	public void editYuYueJiaoLiang(YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap)throws Exception;
	public void dropYuYueJiaoLiang(String id)throws Exception;
	
	public List<YuYueJiaoLiangFormMap> findByPage(YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap,int pageNum,int pageSize);
	
	public YuYueJiaoLiangFormMap findYuYueJiaoLiangById(int id) throws Exception;
}
