package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.SupplierFormMap;
/**
 * 供应商
 * @author Lip
 * @date 2017年4月20日 下午3:34:30
 */
public interface SupplierServerI {
	public void addSupplier(SupplierFormMap supplierFormMap)throws Exception;
	public void editSupplier(SupplierFormMap supplierFormMap)throws Exception;
	public void dropSupplier(String id)throws Exception;
	
	public SupplierFormMap findSupplierById(int id);
	
	public List<SupplierFormMap> findByPage(SupplierFormMap supplierFormMap,int pageSize,int pageNum);
	/**
	 * 根据身份证或者电话号码查找供应商
	 * @param param
	 * @return
	 */
	public List<SupplierFormMap> findSupplierByIDCardOrPhone(String param);
}
