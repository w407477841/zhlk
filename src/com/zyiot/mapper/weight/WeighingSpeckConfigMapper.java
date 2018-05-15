package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.WeighingSpeckConfigFormMap;
import com.zyiot.mapper.BaseMapper;

/**
 * 称重语音
 * @author Lip
 * @date 2017年5月22日 上午9:25:00
 */
public interface WeighingSpeckConfigMapper extends BaseMapper {
	
	public List<WeighingSpeckConfigFormMap> findByPage();
	/**
	 * 根据mac地址查找
	 * @param mac
	 * @return
	 */
	public WeighingSpeckConfigFormMap findByMAC(String mac);
}
