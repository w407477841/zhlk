package com.zyiot.mapper.zhiliangguanli;

import java.util.List;

import com.zyiot.entity.zhiliangguanli.QualityManagerFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 质量管理
 * @author Admin
 * @date 2017年7月5日 上午10:31:17
 */
public interface QualityManagerMapper extends BaseMapper {
	/**
	 * 分页查询
	 * @param qualityManagerFormMap
	 * @return
	 */
	public List<QualityManagerFormMap> findQualityManagerByPage(QualityManagerFormMap qualityManagerFormMap);
	/**
	 * 根据id查找
	 * @param id
	 * @return
	 */
	public QualityManagerFormMap findQualityManagerById(int id);
	
	/**
	 * 获取凭证编号
	 * @param dateStr
	 * @return
	 */
	public String findQualityManagerNumber(String dateStr);
}
