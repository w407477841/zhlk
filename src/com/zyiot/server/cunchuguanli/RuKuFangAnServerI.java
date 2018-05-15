package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.RuKuFangAnFormMap;

public interface RuKuFangAnServerI {
	public void addRuKuFangAn(RuKuFangAnFormMap ruKuFangAnFormMap)throws Exception;
	public void editRuKuFangAn(RuKuFangAnFormMap ruKuFangAnFormMap)throws Exception;
	public void dropRuKuFangAn(String id)throws Exception;
	
	public List<RuKuFangAnFormMap> findByPage(RuKuFangAnFormMap ruKuFangAnFormMap,int pageNum,int pageSize);
	
	public RuKuFangAnFormMap findRuKuFangAnById(int id)throws Exception;
	/**
	 * 查看详细信息，包含粮库地点、粮库名称等表关联项
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public RuKuFangAnFormMap lookRuKuFangAnById(int id)throws Exception;
	
}
