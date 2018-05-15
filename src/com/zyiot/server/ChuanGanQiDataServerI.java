package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.ChuanGanQiBaoJingFormMap;
import com.zyiot.entity.ChuanGanQiDataFormMap;
import com.zyiot.entity.ChuanGanQiFormMap;

public interface ChuanGanQiDataServerI {
	void batchSave(List<ChuanGanQiFormMap> chuanGanQiFormMaps) throws Exception;

	List<ChuanGanQiDataFormMap> getDatas(ChuanGanQiFormMap chuanGanQiFormMap,int pageNum, int pageSize);
	//分页查询显示,仓内传感器
	List<ChuanGanQiDataFormMap> findByPage(ChuanGanQiDataFormMap formMap,int pageNum, int pageSize);
	//分页查询显示，仓外传感器
	List<ChuanGanQiDataFormMap> findCangWaiByPage(ChuanGanQiDataFormMap formMap,int pageNum, int pageSize);

	List<ChuanGanQiBaoJingFormMap> getBaojing(int pageNum, int pageSize);

	void upDatas() throws Exception;
	/**
	 * 获取最大采集时间
	 * @return
	 */
	public String getMaxCjsj();

}
