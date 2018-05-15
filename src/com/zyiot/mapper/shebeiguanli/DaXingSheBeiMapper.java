package com.zyiot.mapper.shebeiguanli;

import java.util.List;

import com.zyiot.entity.shebeiguanli.DaXingSheBeiFormMap;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiWeiXiuFormMap;
import com.zyiot.mapper.BaseMapper;

public interface DaXingSheBeiMapper extends BaseMapper {
	List<DaXingSheBeiFormMap> findByPage(DaXingSheBeiFormMap daXingSheBeiFormMap);
	
	List<DaXingSheBeiFormMap> findAllName();
	
	DaXingSheBeiFormMap findDaXingSheBeiById(int id);
	/**
	 * 去历史表中查找删除的数据
	 * @param id
	 * @return
	 */
	DaXingSheBeiFormMap findHistoryById(int id);
	/**
	 * 删除历史数据--数据恢复后删除
	 * @param id
	 */
	
	List<DaXingSheBeiWeiXiuFormMap> findRepairHistoryById(int id);
	
	
	List<DaXingSheBeiFormMap> findDataDocking(String beginDate);
	
}
