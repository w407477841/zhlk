package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.ChuKuShenQingTransferToolsFormMap;

public interface ChuKuShenQingTransferToolsServerI {
	List<ChuKuShenQingTransferToolsFormMap> findByPage(ChuKuShenQingTransferToolsFormMap c);
	
	void addChuKuShenQingTransferTools(ChuKuShenQingTransferToolsFormMap c)throws Exception;
	void dropChuKuShenQingTransferTools(String id)throws Exception;
	
	void clearNoUsedData(int dataOperator)throws Exception;
	
	List<ChuKuShenQingTransferToolsFormMap> findByIds(List<Integer> ids) throws Exception;
}
