package com.zyiot.server.weight;

import com.zyiot.entity.weight.QualityCheckFormMap;

/**
 * 报港质检信息
 * @author Lip
 * @date 2017年5月2日 下午4:32:39
 */
public interface QualityCheckServerI {
	public void editQualityCheck(QualityCheckFormMap qualityCheckFormMap) throws Exception;
	/**
	 * 根据单据号获取质检信息
	 * @param bId 单据号
	 * @return
	 */
	public QualityCheckFormMap findQualityCheckByBId(String bId);
}
