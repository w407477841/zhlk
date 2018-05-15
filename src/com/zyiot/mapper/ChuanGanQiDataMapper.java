package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.ChuanGanQiDataFormMap;
import com.zyiot.entity.ChuanGanQiFormMap;

public interface ChuanGanQiDataMapper extends BaseMapper {
	List<ChuanGanQiDataFormMap> getDatas(ChuanGanQiFormMap chuanGanQiFormMap);
	
	List<ChuanGanQiDataFormMap> findByPage(ChuanGanQiDataFormMap formMap);
	List<ChuanGanQiDataFormMap> findCangWaiByPage(ChuanGanQiDataFormMap formMap);

	List<ChuanGanQiDataFormMap> getAllDatas();

	List<ChuanGanQiDataFormMap> find_g_lasttime(ChuanGanQiDataFormMap cjsj);
	/**
	 * 根据传感器id，获取最后一条有效数据
	 * @param id
	 * @return
	 */
	String findDataById(String id);
	/**
	 * 获取最大采集时间
	 * @return
	 */
	String getMaxCjsj();
}
