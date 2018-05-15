package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.ChuKuFangAnFormMap;

public interface ChuKuFangAnServerI {
	public void addChuKuFangAn(ChuKuFangAnFormMap chuKuFangAnFormMap)throws Exception;
	public void editChuKuFangAn(ChuKuFangAnFormMap chuKuFangAnFormMap)throws Exception;
	public void dropChuKuFangAn(String id)throws Exception;
	
	public List<ChuKuFangAnFormMap> findByPage(ChuKuFangAnFormMap chuKuFangAnFormMap,int pageNum,int pageSize);
	
	public ChuKuFangAnFormMap findChuKuFangAnById(int id)throws Exception;
	/**
	 * 查看详细信息，包含粮库地点、粮库名称等表关联项
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public ChuKuFangAnFormMap lookChuKuFangAnById(int id)throws Exception;
}
