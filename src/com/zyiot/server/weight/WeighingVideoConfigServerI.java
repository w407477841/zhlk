package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.WeighingVideoConfigFormMap;
/**
 * 称重视频配置
 * @author Lip
 * @date 2017年5月8日 下午4:05:40
 */
public interface WeighingVideoConfigServerI {
	
	public void addWeighingVideoConfig(WeighingVideoConfigFormMap weighingVideoConfigFormMap) throws Exception;
	
	public void editWeighingVideoConfig(WeighingVideoConfigFormMap weighingVideoConfigFormMap) throws Exception;
	
	public void dropWeighingVideoConfig(String id) throws Exception;
	
	public List<WeighingVideoConfigFormMap> findByPage(WeighingVideoConfigFormMap weighingVideoConfigFormMap,int pageNum,int pageSize);
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
