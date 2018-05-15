package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.entity.weight.WeighingFormMap;
/**
 * 称重信息
 * @author Lip
 * @date 2017年5月5日 下午3:42:47
 */
public interface WeighingServerI {
	
	public void addWeighing(WeighingFormMap weighingFormMap)throws Exception;
	
	public void editWeighing(WeighingFormMap weighingFormMap)throws Exception;
	
	public void dropWeighing(String id)throws Exception;
	
	/**
	 * 手动修改称重信息
	 * @param weighingFormMap
	 * @throws Exception
	 */
	public void setWeighing(WeighingFormMap weighingFormMap)throws Exception;
	/**
	 * 驳车添加脚粮--并进行称重信息的统计汇总
	 * @param weighingFormMap
	 * @throws Exception
	 */
	public void addFootGrainWeighing(WeighingFormMap weighingFormMap)throws Exception;
	/**
	 * 散户称重完成，更新称重信息和报港信息，以及实时库存
	 * @param weighingFormMap
	 * @throws Exception
	 */
	public void retailWeighingEnd(WeighingFormMap weighingFormMap) throws Exception;
	/**
	 * 分页查询
	 * @param weighingFormMap
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	public List<WeighingFormMap> findByPage(WeighingFormMap weighingFormMap,int pageSize,int pageNum);
	
	
	/**
	 * 查找可修改的称重信息 -- 结算前称重信息均可修改
	 * @param weighingFormMap
	 * @return
	 */
	public List<WeighingFormMap> findCanUpdateByPage(WeighingFormMap weighingFormMap,int pageSize,int pageNum);
	/**
	 * 根据id查找
	 * @param id
	 * @return
	 */
	public WeighingFormMap findWeighingById(int id);
	
	/**
	 * 根据单据号查找
	 * @param bId 单据号
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
	 * 分页显示散户称重信息，在称重页面显示，只显示未称重完成或未打印的称重信息
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	public List<WeighingFormMap> findRetailWeightByPage(int pageSize,int pageNum);
	
	/**
	 * 分页显示驳车称重信息，在称重页面显示，只显示未称重完成或未打印的称重信息
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	public List<WeighingFormMap> findUsedCarWeightByPage(int pageSize,int pageNum);
	
	/**
	 * 根据单据号和车牌号获取所有称重信息
	 * @param pageSize
	 * @param pageNum
	 * @param bId
	 * @param carId
	 * @return
	 */
	public List<WeighingFormMap> findAllWeighingByBIdAndCarId(int pageSize,int pageNum,String bId,String carId);
	
	/**
	 * 根据单据号查找所有称重信息，分页显示
	 * @param pageSize
	 * @param pageNum
	 * @param bId
	 * @return
	 */
	public List<WeighingFormMap> findAllWeighingByBId(int pageSize,int pageNum,String bId);
	/**
	 * 根据单据号或者时间进行查询--生成过磅单
	 * @param reportHarborFormMap
	 * @return
	 */
	public List<WeighingFormMap> findWeighingByAttr(ReportHarborFormMap reportHarborFormMap);
}
