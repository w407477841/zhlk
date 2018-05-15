package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.CangRongFenPeiFormMap;

public interface CangRongFenPeiServerI {
	public void addCangRongFenPei(CangRongFenPeiFormMap cangRongFenPeiFormMap)throws Exception;
	public void editCangRongFenPei(CangRongFenPeiFormMap cangRongFenPeiFormMap)throws Exception;
	public void dropCangRongFenPei(String id)throws Exception;
	
	public List<CangRongFenPeiFormMap> findByPage(CangRongFenPeiFormMap cangRongFenPeiFormMap,int pageNum,int pageSize);
	
	public CangRongFenPeiFormMap findCangRongFenPeiById(int id)throws Exception;
}
