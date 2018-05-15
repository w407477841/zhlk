package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.VarietyFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 品种资料
 * @author Lip
 * @date 2017年4月25日 上午10:38:46
 */
public interface VarietyMapper extends BaseMapper {
	
	public List<VarietyFormMap> findByPage(VarietyFormMap varietyFormMap);
	
	public List<VarietyFormMap> findAll();
	
	public VarietyFormMap findVarietyById(int id);
	
	/**
	 * 查找可用的品种
	 * @return
	 */
	public List<VarietyFormMap> findEnableVariety();
	/**
	 * 查询首级品种菜单
	 * @return
	 */
	public List<VarietyFormMap> findTopMenuVariety();
}
