package com.zyiot.server;

import java.util.HashMap;
import java.util.List;

import com.zyiot.entity.BusinessAgreementFormFormMap;
import com.zyiot.entity.BusinessAgreementFormMap;
import com.zyiot.entity.BusinessGuestCompanyFormMap;
import com.zyiot.entity.BusinessGuestIndividualFormMap;
import com.zyiot.entity.BusinessPlanForMapJiakong;
import com.zyiot.entity.BusinessPlaneFormMap;
import com.zyiot.entity.WarehouseLocationFormMap;

public interface BusinessManagerServerI {
	
	public void addPlanes(BusinessPlaneFormMap map) throws Exception;
	public void updatePlanes(BusinessPlaneFormMap map) throws Exception;
	/**
	 * 储量计划分页查询
	 * @param page
	 * @param rows
	 * @param m
	 * @return
	 */
	public List<BusinessPlaneFormMap> queryPlanes(int page,int rows,BusinessPlaneFormMap m);
	public BusinessPlaneFormMap querySinglePlane(String id);
	public void deletePlanes(String id)  throws Exception;
	/**
	 * 添加架空计划
	 * @param map
	 * @throws Exception
	 */
	public void addJiakongPlanes(BusinessPlanForMapJiakong map)throws Exception;
	public void updateJiakongPlanes(BusinessPlanForMapJiakong map)throws Exception;
	public List<BusinessPlanForMapJiakong> queryJiakongPlanes(int page,int rows,BusinessPlanForMapJiakong m);
	/**
	 * 根据id查找架空计划
	 * @param id
	 * @return
	 */
	public BusinessPlanForMapJiakong querySingleJiakongPlane(String id);
	public void deleteJiakongPlanes(String id)  throws Exception;
	
	/**
	 * 添加合同模版
	 * @param formMap
	 * @throws Exception
	 */
	public void addAgreementForm(BusinessAgreementFormFormMap formMap)throws Exception;
	public void editAgreementForm(BusinessAgreementFormFormMap formMap)throws Exception;
	public void dropAgreementForm(String id)throws Exception;
	public BusinessAgreementFormFormMap findAgreementFormById(String id);
	
	public List<BusinessAgreementFormFormMap> findAllAgreementForm();
	/**
	 * 分页查找合同模版
	 * @param page
	 * @param rows
	 * @param m
	 * @return
	 */
	public List<BusinessAgreementFormFormMap> findAgreementForm(int page,int rows,BusinessAgreementFormFormMap m);
	
	
	public void addAgreement(BusinessAgreementFormMap map)throws Exception;
	public void updateAgreement(BusinessAgreementFormMap map)throws Exception;
	public void updateAgreement(HashMap<String, String> map)throws Exception;
	public List<BusinessAgreementFormMap> queryAgreements(int page,int rows,BusinessAgreementFormMap m);
	public BusinessAgreementFormMap querySingleAgreement(String id);
	public void deleteAgreement(String id) throws Exception;
	/**
	 * 查找所有合同编号
	 * @author Lip
	 * @return
	 */
	public List<BusinessAgreementFormMap> findAllArgeementBill();
	
	/**
	 * 添加客户
	 * @param map
	 * @return
	 */
	public void addCustomerIndividual(BusinessGuestIndividualFormMap map)throws Exception;
	public void updateCustomerIndividual(BusinessGuestIndividualFormMap map)throws Exception;
	public List<BusinessGuestIndividualFormMap> queryCustomerIndividuals(int page,int rows,BusinessGuestIndividualFormMap m);
	public BusinessGuestIndividualFormMap querySingleCustomerIndividual(String id);
	public void deleteCustomerIndividual(String id)throws Exception;
	
	/**
	 * 添加供应商
	 * @param map
	 * @throws Exception
	 */
	public void addCustomerCompany(BusinessGuestCompanyFormMap map)throws Exception;
	public void updateCustomerCompany(BusinessGuestCompanyFormMap map)throws Exception;
	public List<BusinessGuestCompanyFormMap> queryCustomerCompanies(int page ,int rows,BusinessGuestCompanyFormMap m);
	public BusinessGuestCompanyFormMap querySingleCustomerCompany(String id);
	public void deleteCustomerCompany(String id)throws Exception;
	
	public List<WarehouseLocationFormMap> findHouses(WarehouseLocationFormMap m);
}
