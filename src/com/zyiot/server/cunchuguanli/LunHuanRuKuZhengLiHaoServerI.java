package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.LunHuanRuKuZhengLiHaoFormMap;

public interface LunHuanRuKuZhengLiHaoServerI {
	
	public void addLunHuanRuKuZhengLiHao(LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap)throws Exception;
	public void editLunHuanRuKuZhengLiHao(LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap)throws Exception;
	public void dropLunHuanRuKuZhengLiHao(String id)throws Exception;
	
	public List<LunHuanRuKuZhengLiHaoFormMap> findByPage(LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap,int pageNum,int pageSize);
	
	public LunHuanRuKuZhengLiHaoFormMap findLunHuanRuKuZhengLiHaoById(int id)throws Exception;
	public LunHuanRuKuZhengLiHaoFormMap findCheckDetailById(int id);
}
