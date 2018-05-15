package com.zyiot.server.shebeiguanli;

import java.util.List;

import com.zyiot.entity.shebeiguanli.DaXingSheBeiWeiXiuFormMap;

public interface DaXingSheBeiWeiXiuServiceI {
	void addDaXingSheBeiWeiXiu(DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap)throws Exception;
	void editDaXingSheBeiWeiXiu(DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap)throws Exception;
	void dropDaXingSheBeiWeiXiu(String id)throws Exception;
	
	List<DaXingSheBeiWeiXiuFormMap> findByPage(DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap,int pageSize,int pageNum);
	List<DaXingSheBeiWeiXiuFormMap> findByAttr(DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap);
	
	DaXingSheBeiWeiXiuFormMap findDaXingSheBeiWeiXiuById(int id);
	
}
