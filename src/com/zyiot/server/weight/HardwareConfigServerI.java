package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.HardwareConfigFormMap;
/**
 * 硬件设备配置
 * @author Lip
 * @date 2017年4月25日 下午4:19:19
 */
public interface HardwareConfigServerI {
	
	public void addHardwareConfig(HardwareConfigFormMap hardwareConfigFormMap)throws Exception;
	public void editHardwareConfig(HardwareConfigFormMap hardwareConfigFormMap)throws Exception;
	public void dropHardwareConfig(String id)throws Exception;
	
	/**
	 * 根据mac和卡类型获取数据
	 * @param mac MAC地址
	 * @param carType 卡类型
	 * @return
	 */
	public HardwareConfigFormMap findByMacAndType(String mac,String carType);
	
	/**
	 * 根据卡类型获取配置信息
	 * @param carType
	 * @return
	 */
	public List<HardwareConfigFormMap> findByCarType(String carType,int pageNum,int pageSize);
}
