package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.PropertyFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 粮食性质
 * @author Lip
 * @date 2017年7月14日 下午4:59:26
 */
public interface PropertyMapper extends BaseMapper {
	
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
