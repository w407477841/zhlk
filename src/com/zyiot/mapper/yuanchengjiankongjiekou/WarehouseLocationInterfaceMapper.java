package com.zyiot.mapper.yuanchengjiankongjiekou;

import java.util.List;

import com.zyiot.entity.yuanchengjiankongjiekou.WarehouseLocationInterfaceFormMap;
import com.zyiot.mapper.BaseMapper;

public interface WarehouseLocationInterfaceMapper extends BaseMapper {
	
	public List<WarehouseLocationInterfaceFormMap> findByPage(WarehouseLocationInterfaceFormMap warehouseLocationInterfaceFormMap);
	
	/**
	 * 根据企业信用代码查找企业名称
	 * @param xinyongdaima
	 * @return
	 */
	public WarehouseLocationInterfaceFormMap findByXinYongDaiMa(String xinyongdaima);
	/**
	 * 根据企业信用代码查找所有
	 * @param xinyongdaima
	 * @return
	 */
	public List<WarehouseLocationInterfaceFormMap> findAllByXinYongDaiMa(String xinyongdaima);
	/**
	 * 查询所有企业名称
	 * @return
	 */
	public List<WarehouseLocationInterfaceFormMap> findAllMingCheng();
}
