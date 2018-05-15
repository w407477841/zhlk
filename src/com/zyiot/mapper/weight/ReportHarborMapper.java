package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.QualityCheckFormMap;
import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.mapper.BaseMapper;

/**
 * 报港信息
 * 
 * @author Lip
 * @date 2017年4月27日 下午3:31:23
 */
public interface ReportHarborMapper extends BaseMapper {

	/**
	 * 未进行称重的报港信息
	 * 
	 * @param reportHarborFormMap
	 * @return
	 */
	public List<ReportHarborFormMap> findByPage(
			ReportHarborFormMap reportHarborFormMap);

	/**
	 * 所有报港信息
	 * 
	 * @param reportHarborFormMap
	 * @return
	 */
	public List<ReportHarborFormMap> findAllByPage(
			ReportHarborFormMap reportHarborFormMap);

	/**
	 * 所有报港质检信息
	 * 
	 * @param qualityCheckFormMap
	 * @return
	 */
	public List<QualityCheckFormMap> findAllCheckByPage(
			QualityCheckFormMap qualityCheckFormMap);

	/**
	 * 所有待结算/结算的单据
	 * 
	 * @param reportHarborFormMap
	 * @return
	 */
	public List<ReportHarborFormMap> findSettleAccountByPage(
			ReportHarborFormMap reportHarborFormMap);

	/**
	 * 所有补录记录
	 * 
	 * @param reportHarborFormMap
	 * @return
	 */
	public List<ReportHarborFormMap> findAdditionalByPage(
			ReportHarborFormMap reportHarborFormMap);

	/**
	 * 根据id查找
	 * 
	 * @param id
	 * @return
	 */
	public ReportHarborFormMap findReportHarborById(int id);

	/**
	 * 根据单据号查找
	 * 
	 * @param bId
	 * @return
	 */
	public ReportHarborFormMap findReportHarborByBId(String bId);
	/**
	 * 根据单据号查找基础信息--用于报港质检
	 * 
	 * @param bId
	 * @return
	 */
	public ReportHarborFormMap findNotCheckReportHarborByBId(String bId);

	/**
	 * 根据日期获取最大编号
	 * 
	 * @param dateformat
	 * @return
	 */
	public String getMaxBId(String dateformat);

	/**
	 * 根据一卡通获取单据信息
	 * 
	 * @param cardId
	 * @return
	 */
	public ReportHarborFormMap findReportHarborByCardId(String cardId);
	/**
	 * 根据一卡通获取是否质检
	 * 
	 * @param cardId
	 * @return
	 */
	public ReportHarborFormMap findIsCheckByCardId(String cardId);

	/**
	 * 二维码打印数据查询
	 * 
	 * @param bId
	 * @return
	 */
	public ReportHarborFormMap printReportHarborByBId(String bId);

	/**
	 * 根据单据号获取详细的数据 --- 凭证打印
	 * 
	 * @param bId
	 * @return
	 */
	public ReportHarborFormMap findDetailReportHarborByBId(String bId);

	/**
	 * 根据id获取详细信息 -- 资金结算
	 * 
	 * @param id
	 * @return
	 */
	public ReportHarborFormMap findDetailReportHarborById(int id);

	/**
	 * 根据Id 查找报港基础信息
	 * 
	 * @param id
	 * @return
	 */
	public ReportHarborFormMap findBasicReportHarborById(int id);

	/**
	 * 根据Id 查找报港质检信息
	 * 
	 * @param id
	 * @return
	 */
	public ReportHarborFormMap findCheckReportHarborById(int id);

	/**
	 * 根据仓号，查找最后绑定的资金计划编号
	 * 
	 * @param wId
	 * @return
	 */
	public String findPayPlanIdByWId(String wId);

	/**
	 * 
	 * 用于市级对接 出入库数据
	 * 
	 * @param lasttime
	 * @return
	 */
	public List<ReportHarborFormMap> shijiduijie(String lasttime);
	
	/**
	 * 根据仓号获取最后一条统仓质检，用户出库报港时，自动填充质检信息
	 * @param wId
	 * @return
	 */
	public QualityCheckFormMap findLastByWId(String wId);
	/**
	 * 查询质检过后的单据--单据打印
	 * 
	 * @param reportHarborFormMap
	 * @return
	 */
	public List<ReportHarborFormMap> findPrintByPage(ReportHarborFormMap reportHarborFormMap);
}
