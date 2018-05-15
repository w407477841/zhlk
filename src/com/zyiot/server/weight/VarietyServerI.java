package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.VarietyFormMap;
/**
 * 品种档案
 * @author Lip
 * @date 2017年4月25日 上午10:45:09
 */
public interface VarietyServerI {
	public void addVariety(VarietyFormMap varietyFormMap)throws Exception;
	public void editVariety(VarietyFormMap varietyFormMap)throws Exception;
	public void dropVariety(String id)throws Exception;
	
	public VarietyFormMap findVarietyById(int id);
	
	public List<VarietyFormMap> findByPage(VarietyFormMap varietyFormMap,int pageSize,int pageNum);
	
	public List<VarietyFormMap> findAll();
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
