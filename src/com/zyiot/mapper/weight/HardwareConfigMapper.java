package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.HardwareConfigFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 硬件设备配置
 * @author Lip
 * @date 2017年4月25日 下午4:13:00
 */
public interface HardwareConfigMapper extends BaseMapper {
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
	public List<HardwareConfigFormMap> findByCarType(String carType);
}
