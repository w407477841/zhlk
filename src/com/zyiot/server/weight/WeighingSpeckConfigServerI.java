package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.WeighingSpeckConfigFormMap;
/**
 * 称重语音播报
 * @author Lip
 * @date 2017年5月22日 上午9:30:06
 */
public interface WeighingSpeckConfigServerI {
	public void addWeighingSpeckConfig(WeighingSpeckConfigFormMap weighingSpeckConfigFormMap)throws Exception;
	
	public void editWeighingSpeckConfig(WeighingSpeckConfigFormMap weighingSpeckConfigFormMap)throws Exception;
	
	public void dropWeighingSpeckConfig(String id)throws Exception;
	
	public List<WeighingSpeckConfigFormMap> findByPage(int pageNum,int pageSize);
	
	public WeighingSpeckConfigFormMap findWeighingSpeckConfigByMac(String mac);
}
