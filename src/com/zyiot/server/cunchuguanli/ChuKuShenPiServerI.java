package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.ChuKuShenPiFormMap;
import com.zyiot.entity.cunchuguanli.ChuKuShenQingFormMap;

public interface ChuKuShenPiServerI {
    public void auditingChuKuShenQing(ChuKuShenQingFormMap chuKuShenQingFormMap)throws Exception;
	
	public List<ChuKuShenPiFormMap> findByPage(ChuKuShenPiFormMap chuKuShenPiFormMap,int pageNum,int pageSize);
	
	public List<ChuKuShenPiFormMap> findByBill(ChuKuShenPiFormMap chuKuShenPiFormMap);
}
