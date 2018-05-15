package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.LunHuanChuKuBaoGuanHaoFormMap;

public interface LunHuanChuKuBaoGuanHaoServerI {
	
	public void addLunHuanChuKuBaoGuanHao(LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap)throws Exception;
	public void editLunHuanChuKuBaoGuanHao(LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap)throws Exception;
	public void dropLunHuanChuKuBaoGuanHao(String id)throws Exception;
	
	public List<LunHuanChuKuBaoGuanHaoFormMap> findByPage(LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap,int pageNumber,int pageSize);
	
	public LunHuanChuKuBaoGuanHaoFormMap findLunHuanChuKuBaoGuanHaoById(int id)throws Exception;
	
	public LunHuanChuKuBaoGuanHaoFormMap findCheckDetailById(int id);
}
