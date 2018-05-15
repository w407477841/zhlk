package com.zyiot.server.zhiliangguanli;

import java.util.List;

import com.zyiot.entity.weight.QualityCheckFormMap;
import com.zyiot.entity.zhiliangguanli.QualityManagerFormMap;
/**
 * 质量管理
 * @author Admin
 * @date 2017年7月5日 上午10:34:06
 */
public interface QualityManagerServerI {
	public void addQualityManagerFormMap(QualityManagerFormMap qualityManagerFormMap)throws Exception;
	public void editQualityManagerFormMap(QualityManagerFormMap qualityManagerFormMap)throws Exception;
	public void dropQualityManagerFormMap(String id)throws Exception;
	/**
	 * 分页查询
	 * @param qualityCheckFormMap
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	public List<QualityCheckFormMap> findByPage(QualityCheckFormMap qualityCheckFormMap,int pageSize,int pageNum);
	
	public List<QualityManagerFormMap> findByPage(QualityManagerFormMap qualityManagerFormMap,int pageSize,int pageNum);
	/**
	 * 根据id查找
	 * @param id
	 * @return
	 */
	public QualityManagerFormMap findQualityManagerById(int id);
}
