package com.zyiot.mapper;

import java.util.HashMap;
import java.util.List;

import com.zyiot.entity.BusinessAgreementFormFormMap;
import com.zyiot.entity.BusinessAgreementFormMap;
import com.zyiot.entity.BusinessGuestCompanyFormMap;
import com.zyiot.entity.BusinessGuestIndividualFormMap;
import com.zyiot.entity.BusinessPlanForMapJiakong;
import com.zyiot.entity.BusinessPlaneFormMap;
import com.zyiot.entity.CommonsFileFormMap;
import com.zyiot.entity.WarehouseLocationFormMap;
import com.zyiot.util.FormMap;

public interface BusinessManagerMapper extends BaseMapper{
	/**
	 * 储量计划--分页查询
	 * @param m
	 * @return
	 */
	public List<BusinessPlaneFormMap> findPlans(BusinessPlaneFormMap m);
	/**
	 * 根据Id查找储量计划
	 * @param id
	 * @return
	 */
	public BusinessPlaneFormMap findPlansById(int id);
	/**
	 * 查询需要进行完成量重新计算的数据
	 * @return
	 */
	public List<BusinessPlaneFormMap> findNeedCompletePlans();
	/**
	 * 获取需要计算的实时库存数量
	 * @return
	 */
	public List<FormMap<String,Object>> findNeedCompleteStorage(List<Integer> list);
	/**
	 * 架空计划--分页查询
	 * @param m
	 * @return
	 */
	public List<BusinessPlanForMapJiakong> findJiakongPlans(BusinessPlanForMapJiakong m);
	/**
	 * 根据id查找架空计划数据
	 * @param id
	 * @return
	 */
	public BusinessPlanForMapJiakong querySingleJiakongPlane(int id);
	
	
	/**
	 * 分页查找合同模版
	 * @param m
	 * @return
	 */
	public List<BusinessAgreementFormFormMap> findAgreementForm(BusinessAgreementFormFormMap m);
	
	
	
	/**
	 * 合同管理--分页查询
	 * @param m
	 * @return
	 */
	public List<BusinessAgreementFormMap> findAgreements(BusinessAgreementFormMap m);
	/**
	 * 查找所有合同编号
	 * @author Lip
	 * @return
	 */
	public List<BusinessAgreementFormMap> findAllAgreementBill();
	
	public List<BusinessGuestCompanyFormMap> findCompanies(BusinessGuestCompanyFormMap m);
	
	public List<BusinessGuestIndividualFormMap> findIndividuals(BusinessGuestIndividualFormMap m);
	
	public List<WarehouseLocationFormMap> findHouses(WarehouseLocationFormMap m);
	
	public void updateA(HashMap<String, String> map);
	
	public CommonsFileFormMap findBysid(String id);
	
	
}
