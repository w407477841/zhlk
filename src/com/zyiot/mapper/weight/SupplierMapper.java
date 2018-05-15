package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.SupplierFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 供应商
 * @author Lip
 * @date 2017年4月20日 下午3:29:35
 */
public interface SupplierMapper extends BaseMapper {
	public SupplierFormMap findSupplierById(int id);
	
	public List<SupplierFormMap> findByPage(SupplierFormMap supplierFormMap);
	
	/**
	 * 根据身份证或者电话号码查找供应商
	 * @param param
	 * @return
	 */
	public List<SupplierFormMap> findSupplierByIDCardOrPhone(String param);
}
