package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.ShouKuanTongZhiDanFormMap;

public interface ShouKuanTongZhiDanServerI {
	public void addShouKuanTongZhiDan(ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap)throws Exception;
	public void editShouKuanTongZhiDan(ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap)throws Exception;
	public void dropShouKuanTongZhiDan(String id)throws Exception;
	
	public List<ShouKuanTongZhiDanFormMap> findByPage(ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap,int pageNum,int pageSize);
	
	public ShouKuanTongZhiDanFormMap findShouKuanTongZhiDanById(int id) throws Exception;
	
	public ShouKuanTongZhiDanFormMap lookShouKuanTongZhiDanById(int id) throws Exception;
}
