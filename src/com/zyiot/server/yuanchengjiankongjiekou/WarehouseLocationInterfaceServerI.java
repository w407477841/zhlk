package com.zyiot.server.yuanchengjiankongjiekou;

import java.util.List;

import com.zyiot.entity.yuanchengjiankongjiekou.WarehouseLocationInterfaceFormMap;
/**
 * 粮库地点对接配置
 * @author Admin
 * @date 2017年8月15日 上午10:16:36
 */
public interface WarehouseLocationInterfaceServerI {
	
	public void addWarehouseLocation(WarehouseLocationInterfaceFormMap warehouseLocation)throws Exception;
	public void editWarehouseLocation(WarehouseLocationInterfaceFormMap warehouseLocation)throws Exception;
	public void dropWarehouseLocation(String locationNo)throws Exception;
	
	public List<WarehouseLocationInterfaceFormMap> findByPage(WarehouseLocationInterfaceFormMap warehouseLocation,int pageSize,int pageNum);
	
	public WarehouseLocationInterfaceFormMap findById(String locationNo);
	/**
	 * 根据企业信用代码查找数据
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
