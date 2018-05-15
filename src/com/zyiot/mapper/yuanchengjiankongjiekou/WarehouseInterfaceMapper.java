package com.zyiot.mapper.yuanchengjiankongjiekou;

import java.util.List;

import com.zyiot.entity.yuanchengjiankongjiekou.WarehouseInterfaceFormMap;
import com.zyiot.mapper.BaseMapper;

public interface WarehouseInterfaceMapper extends BaseMapper {
	
	public List<WarehouseInterfaceFormMap> findByPage(WarehouseInterfaceFormMap warehouse);
}
