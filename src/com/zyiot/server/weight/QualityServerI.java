package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.QualityFormMap;

/**
 * 质量国标档案
 * @author Lip
 * @date 2017年4月26日 上午10:56:50
 */
public interface QualityServerI {
	/**
	 * 根据品种档案Id获取信息
	 * @param varietyId
	 * @return
	 */
	public List<QualityFormMap> findByVarietyId(int varietyId);
	
	/**
	 * 根据品种档案id获取全部质检信息，根据国标质检
	 * @param varietyId
	 * @return
	 */
	public List<QualityFormMap> findQualityByVarietyId(int varietyId);
}
