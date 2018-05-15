package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.entity.weight.WeighingFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 称重信息
 * @author Lip
 * @date 2017年5月5日 下午3:32:16
 */
public interface WeighingMapper extends BaseMapper {
	public List<WeighingFormMap> findByPage(WeighingFormMap weighingFormMap);
	
	/**
	 * 查找可修改的称重信息 -- 结算前称重信息均可修改
	 * @param weighingFormMap
	 * @return
	 */
	public List<WeighingFormMap> findCanUpdateByPage(WeighingFormMap weighingFormMap);
	
	/**
	 * 根据id获取单据信息
	 * @param id
	 * @return
	 */
	public WeighingFormMap findWeighingById(int id);
	
	/**
	 * 根据单据号获取称重信息
	 * @param bId
	 * @return
	 */
	public List<WeighingFormMap> findWeighingByBId(String bId);
	
	/**
	 * 根据称重信息获取最近称重详细信息
	 * @param weighingFormMap  页面称重信息
	 * @return
	 */
	public WeighingFormMap findWeighingByWeighing(WeighingFormMap weighingFormMap);
	
	/**
	 * 根据单据号和车号获取最后一条称重信息
	 * @param bId
	 * @param carId
	 * @return
	 */
	public WeighingFormMap findLastWeighingByBIdAndCarId(String bId,String carId);
	
	/**
	 * 根据单据号查找称重信息
	 * 以车牌号进行分组统计
	 * @param bId
	 * @return
	 */
	public List<WeighingFormMap> getTotalWeightByBId(String bId);
	
	/**
	 * 分页显示散户称重信息，在称重页面显示，只显示未称重完成或未打印的称重信息
	 * @return
	 */
	public List<WeighingFormMap> findRetailWeightByPage();
	
	/**
	 * 分页显示驳车称重信息，在称重页面显示，只显示未称重完成或未打印的称重信息
	 * @return
	 */
	public List<WeighingFormMap> findUsedCarWeightByPage();
	/**
	 * 根据单据号和车牌号获取所有称重信息
	 * @param bId
	 * @param carId
	 * @return
	 */
	public List<WeighingFormMap> findAllWeighingByBIdAndCarId(String bId,String carId);
	/**
	 * 根据单据号或者时间进行查询--生成过磅单
	 * @param reportHarborFormMap
	 * @return
	 */
	public List<WeighingFormMap> findWeighingByAttr(ReportHarborFormMap reportHarborFormMap);
}
