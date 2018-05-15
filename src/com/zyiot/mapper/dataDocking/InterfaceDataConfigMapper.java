package com.zyiot.mapper.dataDocking;

import java.util.List;

import com.zyiot.entity.dataDocking.InterfaceDataConfigFormMap;
import com.zyiot.mapper.BaseMapper;
import com.zyiot.util.FormMap;

public interface InterfaceDataConfigMapper extends BaseMapper {
	/**
	 * 查询大于某个值的数据
	 * @return
	 */
	public List<FormMap<String,Object>> findGreatThanData(InterfaceDataConfigFormMap interfaceDataConfig);
	
	public InterfaceDataConfigFormMap findInterfaceDataConfigByTableName(String tableName);
}
