package com.zyiot.mapper.dataDocking;

import com.zyiot.entity.dataDocking.ContrastWarehouseFormMap;
import com.zyiot.mapper.BaseMapper;

public interface ContrastWarehouseMapper extends BaseMapper {
	/**
	 * 根据粮库id获取数据
	 * @param wid 
	 * @return
	 */
	public ContrastWarehouseFormMap findContrastWarehouseByWID(int wid);
}
