package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.QualityCheckFormMap;
import com.zyiot.entity.weight.ReportHarborFormMap;

/**
 * 报港信息
 * 
 * @author Lip
 * @date 2017年4月27日 下午3:40:12
 */
public interface ReportHarborServerI {

	public String addReportHarbor(ReportHarborFormMap reportHarborFormMap,
			QualityCheckFormMap qualityCheckFormMap) throws Exception;
	/**
	 * 仅添加报港信息
	 * @param reportHarborFormMap
	 * @return
	 * @throws Exception
	 */
	public String addReportHarbor(ReportHarborFormMap reportHarborFormMap) throws Exception;
	/**
	 * 添加质检信息并进行报港信息的修改
	 * @param reportHarborFormMap
	 * @param qualityCheckFormMap
	 * @return
	 * @throws Exception
	 */
	public String addQualityCheck(ReportHarborFormMap reportHarborFormMap,QualityCheckFormMap qualityCheckFormMap) throws Exception;

	/**
	 * 出入库补录
	 * 
	 * @param reportHarborFormMap
	 * @param qualityCheckFormMap
	 * @return
	 * @throws Exception
	 */
	public String additionalReportHarbor(
			ReportHarborFormMap reportHarborFormMap,
			QualityCheckFormMap qualityCheckFormMap) throws Exception;

	public void editReportHarbor(ReportHarborFormMap reportHarborFormMap)
			throws Exception;

	/**
	 * 修改基础信息
	 * 
	 * @param reportHarborFormMap
	 * @throws Exception
	 */
	public void editBasicReportHarbor(ReportHarborFormMap reportHarborFormMap)
			throws Exception;

	/**
	 * 修改质检信息
	 * 
	 * @param reportHarborFormMap
	 * @param qualityCheckFormMap
	 * @throws Exception
	 */
	public void editCheckReportHarbor(ReportHarborFormMap reportHarborFormMap,
			QualityCheckFormMap qualityCheckFormMap) throws Exception;

	public void dropReportHarbor(String id) throws Exception;

	/**
	 * 删除补录的信息
	 * 
	 * @param id
	 * @throws Exception
	 */
	public void dropAdditionalReportHarbor(String id) throws Exception;

	/**
	 * 未进行称重的报港信息
	 * 
	 * @param reportHarborFormMap
	 * @return
	 */
	public List<ReportHarborFormMap> findByPage(
			ReportHarborFormMap reportHarborFormMap, int pageNum, int pageSize);

	/**
	 * 所有报港信息
	 * 
	 * @param reportHarborFormMap
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public List<ReportHarborFormMap> findAllByPage(
			ReportHarborFormMap reportHarborFormMap, int pageNum, int pageSize);

	/**
	 * 所有待结算/结算的单据
	 * 
	 * @param reportHarborFormMap
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public List<ReportHarborFormMap> findSettleAccountByPage(
			ReportHarborFormMap reportHarborFormMap, int pageNum, int pageSize);

	/**
	 * 所有补录记录
	 * 
	 * @param reportHarborFormMap
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public List<ReportHarborFormMap> findAdditionalByPage(
			ReportHarborFormMap reportHarborFormMap, int pageNum, int pageSize);

	/**
	 * 所有报港质检信息
	 * 
	 * @param qualityCheckFormMap
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public List<QualityCheckFormMap> findAllCheckByPage(
			QualityCheckFormMap qualityCheckFormMap, int pageNum, int pageSize);

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
	 * 根据一卡通获取报港信息
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
	public ReportHarborFormMap findDetailReportHarborByBId(String bId)
			throws Exception;

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
	public void shijiduijie() throws Exception;
	
	/**
	 * 根据仓号获取最后一条统仓质检，用户出库报港时，自动填充质检信息
	 * @param wId
	 * @return
	 */
	public QualityCheckFormMap findLastByWId(String wId);
	/**
	 * 根据单据号查找打印检验单数据信息
	 * @param bId
	 * @return
	 */
	public QualityCheckFormMap findPrintCheckByBId(String bId);
	
	/**
	 * 查询质检过后的单据--单据打印列表
	 * 
	 * @param reportHarborFormMap
	 * @return
	 */
	public List<ReportHarborFormMap> findPrintByPage(
			ReportHarborFormMap reportHarborFormMap, int pageNum, int pageSize);
}
