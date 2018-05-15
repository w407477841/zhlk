package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.CarFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 车辆档案信息
 * @author Lip
 * @date 2017年4月24日 上午8:49:10
 */
public interface CarMapper extends BaseMapper {
	public CarFormMap findCarById(int id);
	
	public List<CarFormMap> findByPage(CarFormMap carFormMap);
	/**
	 * 查找未分配的车，或者此单据号分配的车
	 * @param bId 单据号
	 * @return
	 */
	public List<CarFormMap> findNotUsedByPage(String bId);
	/**
	 * 查找未使用的车辆
	 * @return
	 */
	public List<CarFormMap> findNotUsedCar();
	
	/**
	 * 判断此卡是否已经绑定
	 * @param rfid
	 * @return
	 */
	public CarFormMap isUsed(String rfid);
	
	/**
	 * 根据单据号获取用车信息
	 * @param bId
	 * @return
	 */
	public List<CarFormMap> findCarByBId(String bId);
	/**
	 * 根据id清除用车绑定
	 * @param id
	 */
	public void ClearUsedCarById(int id);
	/**
	 * 根据单据号清除用车绑定
	 * @param bId
	 */
	public void ClearUsedCarByBId(String bId);
}
