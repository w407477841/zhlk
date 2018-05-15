package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.WeighingVideoConfigFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 称重视频配置
 * @author Lip
 * @date 2017年5月8日 下午4:00:12
 */
public interface WeighingVideoConfigMapper extends BaseMapper {
	
	public List<WeighingVideoConfigFormMap> findByPage(WeighingVideoConfigFormMap weighingVideoConfigFormMap);
	/**
	 * 根据mac获取信息
	 * @param mac
	 * @return
	 */
	public List<WeighingVideoConfigFormMap> findWeighingVideoConfigByMAC(String mac);
	/**
	 * 根据id获取信息
	 * @param id
	 * @return
	 */
	public WeighingVideoConfigFormMap findWeighingVideoConfigById(int id);
	
}
