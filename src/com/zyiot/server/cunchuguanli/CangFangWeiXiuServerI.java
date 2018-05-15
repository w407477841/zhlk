package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.CangFangWeiXiuFormMap;

public interface CangFangWeiXiuServerI {

	public void addCangFangWeiXiu(CangFangWeiXiuFormMap cangFangWeiXiuFormMap)throws Exception;
	public void editCangFangWeiXiu(CangFangWeiXiuFormMap cangFangWeiXiuFormMap)throws Exception;
	public void dropCangFangWeiXiu(String id)throws Exception;
	
	public List<CangFangWeiXiuFormMap> findByPage(CangFangWeiXiuFormMap cangFangWeiXiuFormMap,int pageIndex,int pageSize);
	
	public CangFangWeiXiuFormMap findCangFangWeiXiuById(int id) throws Exception;
}
