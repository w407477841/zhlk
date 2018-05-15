package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.QualityCheckFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 报港质检信息
 * @author Lip
 * @date 2017年5月2日 下午4:30:00
 */
public interface QualityCheckMapper extends BaseMapper {
	/**
	 * 根据单据号获取质检信息
	 * @param bId 单据号
	 * @return
	 */
	public QualityCheckFormMap findQualityCheckByBId(String bId);
	/**
	 * 显示出入库质检记录，在质量检测页面显示
	 * @param qualityCheckFormMap
	 * @return
	 */
	public List<QualityCheckFormMap> findQualityCheck(QualityCheckFormMap qualityCheckFormMap);
	
	/**
	 * 根据单据号查找打印检验单数据信息
	 * @param bId
	 * @return
	 */
	public QualityCheckFormMap findPrintCheckByBId(String bId);
}
