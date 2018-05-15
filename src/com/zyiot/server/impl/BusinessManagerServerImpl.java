package com.zyiot.server.impl;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.BusinessAgreementFormFormMap;
import com.zyiot.entity.BusinessAgreementFormMap;
import com.zyiot.entity.BusinessGuestCompanyFormMap;
import com.zyiot.entity.BusinessGuestIndividualFormMap;
import com.zyiot.entity.BusinessPlanForMapJiakong;
import com.zyiot.entity.BusinessPlaneFormMap;
import com.zyiot.entity.WarehouseLocationFormMap;
import com.zyiot.mapper.BusinessManagerMapper;
import com.zyiot.server.BusinessManagerServerI;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;

@Service("businessServer")
public class BusinessManagerServerImpl implements BusinessManagerServerI {
	@Autowired
	private BusinessManagerMapper bserver;

	@Override
	@SystemLog(module="计划管理",methods="添加",description="添加成功")
	public void addPlanes(BusinessPlaneFormMap map)  throws Exception {
			 bserver.addEntity(map);
	}

	@Override
	@SystemLog(module="计划管理",methods="修改",description="修改成功")
	public void updatePlanes(BusinessPlaneFormMap map)throws Exception {
		bserver.updateEntity(map);
	}

	@Override
	public List<BusinessPlaneFormMap> queryPlanes(int page, int rows,BusinessPlaneFormMap m) {
		
		try {
			updateComplete();
		} catch (Exception e) {
			//e.printStackTrace();
		}
		PageHelper.startPage(page, rows);
		return bserver.findPlans(m);
	}

	@Override
	@SystemLog(module = "计划管理", methods = "删除", description = "成功")
	public void deletePlanes(String id)  throws Exception{
		bserver.deleteEntityByKey("id", id, BusinessPlaneFormMap.class);
	}

	@Override
	@SystemLog(module="合同管理",methods="添加",description="添加成功")
	public void addAgreement(BusinessAgreementFormMap map)throws Exception {
		bserver.addEntity(map);
	}

	@Override
	@SystemLog(module="合同管理",methods="修改",description="修改成功")
	public void updateAgreement(BusinessAgreementFormMap map)throws Exception {
		bserver.updateEntity(map);
	}

	@Override
	public List<BusinessAgreementFormMap> queryAgreements(int page, int rows,
			BusinessAgreementFormMap m) {
		PageHelper.startPage(page, rows);
		return bserver.findAgreements(m);
	}

	@Override
	@Transactional(readOnly = false)
	@SystemLog(module = "业务管理/合同管理", methods = "删除", description = "成功")
	public void deleteAgreement(String id) throws Exception {
		bserver.deleteEntityByKey("id", id, BusinessAgreementFormMap.class);
	}

	@Override
	@SystemLog(module = "业务管理/个人客户管理", methods = "添加", description = "成功")
	public void addCustomerIndividual(BusinessGuestIndividualFormMap map)throws Exception {
		bserver.addEntity(map);
	}

	@Override
	@SystemLog(module = "业务管理/个人客户管理", methods = "新增", description = "成功")
	public void updateCustomerIndividual(BusinessGuestIndividualFormMap map)throws Exception {
		bserver.updateEntity(map);
	}

	@Override
	public List<BusinessGuestIndividualFormMap> queryCustomerIndividuals(
			int page, int rows, BusinessGuestIndividualFormMap m) {
		PageHelper.startPage(page, rows);
		return bserver.findIndividuals(m);
	}

	@Override
	@SystemLog(module = "业务管理/个人客户管理", methods = "删除", description = "成功")
	public void deleteCustomerIndividual(String id)throws Exception {
		bserver.deleteEntityByKey("id", id,
				BusinessGuestIndividualFormMap.class);
	}

	@Override
	@SystemLog(module = "业务管理/单位客户管理", methods = "添加", description = "成功")
	public void addCustomerCompany(BusinessGuestCompanyFormMap map)throws Exception {
		bserver.addEntity(map);
	}

	@Override
	@SystemLog(module = "业务管理/单位客户管理", methods = "修改", description = "成功")
	public void updateCustomerCompany(BusinessGuestCompanyFormMap map)throws Exception {
		bserver.updateEntity(map);
	}

	@Override
	public List<BusinessGuestCompanyFormMap> queryCustomerCompanies(int page,
			int rows, BusinessGuestCompanyFormMap m) {
		PageHelper.startPage(page, rows);
		return bserver.findCompanies(m);
	}

	@Override
	@SystemLog(module = "业务管理/单位客户管理", methods = "删除", description = "成功")
	public void deleteCustomerCompany(String id)throws Exception {
		bserver.deleteEntityByKey("id", id,
				BusinessGuestCompanyFormMap.class);
	}

	@Override
	public BusinessPlaneFormMap querySinglePlane(String id) {
		return bserver.findPlansById(Integer.parseInt(id));
	}

	@Override
	public BusinessAgreementFormMap querySingleAgreement(String id) {
		return bserver.findById(id, BusinessAgreementFormMap.class);
	}

	@Override
	public BusinessGuestIndividualFormMap querySingleCustomerIndividual(
			String id) {
		return bserver.findById(id, BusinessGuestIndividualFormMap.class);
	}

	@Override
	public BusinessGuestCompanyFormMap querySingleCustomerCompany(String id) {
		return bserver.findById(id, BusinessGuestCompanyFormMap.class);
	}

	@Override
	@SystemLog(module = "业务管理/架空计划", methods = "添加", description = "添加成功")
	public void addJiakongPlanes(BusinessPlanForMapJiakong map)throws Exception {
		bserver.addEntity(map);
	}

	@Override
	@SystemLog(module = "业务管理/架空计划", methods = "修改", description = "修改成功")
	public void updateJiakongPlanes(BusinessPlanForMapJiakong map)throws Exception {
		bserver.updateEntity(map);
	}

	@Override
	public List<BusinessPlanForMapJiakong> queryJiakongPlanes(int page,int rows, BusinessPlanForMapJiakong m) {
		PageHelper.startPage(page, rows);
		return bserver.findJiakongPlans(m);
	}

	@Override
	public BusinessPlanForMapJiakong querySingleJiakongPlane(String id) {
		return bserver.querySingleJiakongPlane(Integer.parseInt(id));
	}

	@Override
	@SystemLog(module = "业务管理/架空计划", methods = "删除", description = "成功")
	public void deleteJiakongPlanes(String id) throws Exception {
		bserver.deleteEntityByKey("id", id, BusinessPlanForMapJiakong.class);
	}

	@Override
	public List<WarehouseLocationFormMap> findHouses(WarehouseLocationFormMap m) {
		return bserver.findHouses(m);
	}

	@Override
	@SystemLog(module="合同管理",methods="修改",description="修改成功")
	public void updateAgreement(HashMap<String, String> map)throws Exception {
				bserver.updateA(map);
	}

	@Override
	public List<BusinessAgreementFormMap> findAllArgeementBill() {
		return bserver.findAllAgreementBill();
	}
	
	public void updateComplete() throws Exception{
		//获取需要进行重新计算完成率的数据
		List<BusinessPlaneFormMap> list = bserver.findNeedCompletePlans();
		//有需要进行计算的数据
		if(list != null && list.size()>0){
			//存放需要获取的仓库号
			List<Integer> warehouseIds = new ArrayList<Integer>();
			//遍历获取仓号
			for(BusinessPlaneFormMap bp:list){
				String wId = bp.getStr("wId");
				String[] temp = wId.split(",");
				for(String str:temp){
					if(!warehouseIds.contains(Integer.parseInt(str))){
						warehouseIds.add(Integer.parseInt(str));
					}
				}
			}
			
			List<FormMap<String,Object>> storageList = bserver.findNeedCompleteStorage(warehouseIds);
			//遍历需要计算的计划
			for(BusinessPlaneFormMap bp:list){
				String wId = bp.getStr("wId");
				String[] temp = wId.split(",");
				float totalComplete = 0;
				//遍历累加实时库存和
				for(String str:temp){//仓号
					//遍历实时库存
					for(FormMap<String,Object> fm:storageList){
						if(Integer.parseInt(str)==Integer.parseInt(fm.getStr("storageID"))){
							totalComplete+=Float.parseFloat(fm.getStr("cangKu"));
						}
					}
				}
				String type = bp.getStr("type");
				
				if(type.equals("1")){ //出库
					if(bp.getBigDecimal("originalWeight") == null){  //初始
						bp.set("originalWeight", new BigDecimal(totalComplete));
						bp.put("completedAmount", 0);
					}else{
						bp.put("completedAmount", bp.getBigDecimal("originalWeight").floatValue() - totalComplete);
					}
				}else{//入库
					if(bp.getBigDecimal("originalWeight") == null){ 
						bp.set("originalWeight", new BigDecimal(totalComplete));
						bp.put("completedAmount", new BigDecimal(totalComplete));	
					}else{
						bp.put("completedAmount", new BigDecimal(totalComplete));	
					}
				}
				//完成100%时，标记已经完成
				if(bp.getBigDecimal("totalAmount").longValue()<=bp.getBigDecimal("completedAmount").longValue()){
					bp.put("needComplete", "2");
				}else{  //当未完成100%时，则看是否到截至日期
					String planedTimeEnd = bp.getStr("planedTimeEnd");
					
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date endDate = null;
					Date nowDate = new Date();
					endDate = df.parse(planedTimeEnd+" 23:59:59");

					//说明截至日期已过
					if(endDate.getTime()<nowDate.getTime()){
						bp.put("needComplete", "2");
					}
				}
				//进行数据更新
				FormMapUtil.toUPDATEFormMap(bp);
				bserver.updateEntity(bp);
			}
		}
	}

	@Override
	public List<BusinessAgreementFormFormMap> findAgreementForm(int page,
			int rows, BusinessAgreementFormFormMap m) {
		PageHelper.startPage(page, rows);
		return bserver.findAgreementForm(m);
	}

	@Override
	@SystemLog(module="合同模版",methods="添加",description="添加成功")
	public void addAgreementForm(BusinessAgreementFormFormMap formMap)
			throws Exception {
		bserver.addEntity(formMap);
	}

	@Override
	@SystemLog(module="合同模版",methods="修改",description="修改成功")
	public void editAgreementForm(BusinessAgreementFormFormMap formMap)
			throws Exception {
		bserver.updateEntity(formMap);
	}

	@Override
	@SystemLog(module="合同模版",methods="删除",description="删除成功")
	public void dropAgreementForm(String id) throws Exception {
		bserver.deleteEntityByKey("id", id, BusinessAgreementFormFormMap.class);
	}

	@Override
	public BusinessAgreementFormFormMap findAgreementFormById(String id) {
		return bserver.findById(id, BusinessAgreementFormFormMap.class);
	}

	@Override
	public List<BusinessAgreementFormFormMap> findAllAgreementForm() {
		return bserver.findByAttr(new BusinessAgreementFormFormMap());
	}
	
}
