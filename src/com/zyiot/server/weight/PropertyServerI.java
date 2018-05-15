package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.PropertyFormMap;

/**
 * 粮食性质
 * @author Admin
 * @date 2017年7月14日 下午5:01:06
 */
public interface PropertyServerI {
	
	public void editPropertyFormMap(PropertyFormMap propertyFormMap)throws Exception;
	/**
	 * 查找所有
	 * @return
	 */
	public List<PropertyFormMap> findAllProperty();
	/**
	 * 查找可用
	 * @return
	 */
	public List<PropertyFormMap> findEnableProperty();
	
}
