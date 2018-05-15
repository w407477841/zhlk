package com.zyiot.controller.yewuguanli;

import java.io.File;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.BusinessAgreementFormFormMap;
import com.zyiot.entity.BusinessAgreementFormMap;
import com.zyiot.entity.BusinessGuestCompanyFormMap;
import com.zyiot.entity.BusinessGuestIndividualFormMap;
import com.zyiot.entity.BusinessPlanForMapJiakong;
import com.zyiot.entity.BusinessPlaneFormMap;
import com.zyiot.entity.WarehouseLocationFormMap;
import com.zyiot.server.BusinessManagerServerI;
import com.zyiot.server.CommonsFileServerI;
import com.zyiot.util.CalculateUtils;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FileManager;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.JasperHelper;
import com.zyiot.util.MyPage;
import com.zyiot.util.NumberToCN;
import com.zyiot.util.PropertiesUtils;
import com.zyiot.util.ValidateUtil;
/**
 * 计划管理--地储/省储/国储....
 * @author Admin
 * @date 2017年8月1日 下午3:22:31
 */
@Controller
@RequestMapping("/businessManager")
public class BusinessManagerController extends BaseController {
	Logger log = Logger.getLogger(BusinessManagerController.class);
	
	@Autowired
	private BusinessManagerServerI businessServer;
	@Autowired
	private CommonsFileServerI fileManager;
	@Autowired
	private DataSource dataSource;
	/**
	 * 计划管理--地储/省储/国储/...
	 * @param model
	 * @return
	 */
	@RequestMapping("/dichu/listUI")
	public String listUI(Model model) {
		model.addAttribute("planType", getPara("planType"));
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/jihuaguanli/planManager";
	}
	
	
	
	
	
	/**
	 * 架空计划--显示列表页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/jiakongjihua/listUI")
	public String listUI1(Model model) {
		model.addAttribute("planType", getPara("planType"));
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/jihuaguanli/jiakongjihua";
	}
	/**
	 * 合同管理--显示列表页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/agreement/listUI")
	public String listUI2() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/hetongguanli/hetongguanli";
	}
	/**
	 * 合同模版--显示列表页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/agreementForm/listUI")
	public String listFormUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/hetongguanli/form/list";
	}

	@RequestMapping("/supplyCompany/listUI")
	public String listUI3(Model model) {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/kehuguanli/gongyingshang";
	}

	@RequestMapping("/supplyIndividual/listUI")
	public String listUI4(Model model) {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/kehuguanli/kehuguanli";
	}

	/**
	 * 储量计划--添加页面
	 * 计划管理-跳转新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/dichuadd")
	public String add(Model model) {
		model.addAttribute("planType", getPara("planType"));
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/jihuaguanli/plans/add";
	}

	/**
	 * 计划管理-跳转编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/dichuedit")
	public String edit(Model model) {
		model.addAttribute("planType", getPara("planType"));
		BusinessPlaneFormMap businessPlaneFormMap = businessServer.querySinglePlane(getPara("id"));
		businessPlaneFormMap.set("newPlanedAmount", Common.numberConvertString(businessPlaneFormMap.getBigDecimal("newPlanedAmount").longValue()));
		businessPlaneFormMap.set("turnPlannedAmount", Common.numberConvertString(businessPlaneFormMap.getBigDecimal("turnPlannedAmount").longValue()));
		model.addAttribute("BusinessPlaneFormMap",businessPlaneFormMap);

		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/jihuaguanli/plans/edit";
	}

	/**
	 * 计划管理-架空计划-跳转新增页面
	 * 
	*/
	@Token(save = true)
	@RequestMapping("/jiakongadd")
	public String addJiakong(Model model) {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/jihuaguanli/jiakongplan/add";
	}

	/**
	 * 计划管理-架空计划-跳转编辑页面
	 */
	@Token(save = true)
	@RequestMapping("/jiakongedit")
	public String editJiakong(Model model) {
		model.addAttribute("BusinessPlanForMapJiakong",
				businessServer.querySingleJiakongPlane(getPara("id")));

		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/jihuaguanli/jiakongplan/edit";
	}
	
	/**
	 * 合同模版-跳转新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/agreementFormAdd")
	public String addAgreementFormUI(Model model) {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/hetongguanli/form/add";
	}
	
	/**
	 * 合同模版-跳转编辑页面
	 */
	@Token(save = true)
	@RequestMapping("/agreementFormEdit")
	public String editAgreementFormUI(Model model) {
		model.addAttribute("businessAgreementFormFormMap",
				businessServer.findAgreementFormById(getPara("id")));

		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/hetongguanli/form/edit";
	}
	
	/**
	 * 合同模版-跳转文件上传页面
	 * */
	@Token(save = true)
	@RequestMapping("/uploadFormFiles")
	public String uploadFormFiles(Model model) {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/hetongguanli/form/upload";
	}

	/**
	 * 合同管理-跳转新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/agreementadd")
	public String addAgreement(Model model) {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/hetongguanli/add";
	}

	/**
	 * 合同管理-跳转编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/agreementedit")
	public String editAgreement(Model model) {
		model.addAttribute("BusinessAgreementFormMap",
				businessServer.querySingleAgreement(getPara("id")));

		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/hetongguanli/edit";
	}

	/**
	 * 合同管理-跳转文件上传页面
	 * */
	@Token(save = true)
	@RequestMapping("/uploadFiles")
	public String uploadFiles(Model model) {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/hetongguanli/upload";
	}

	/**
	 * 客户管理-供应商管理-跳转新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/companyadd")
	public String addCompany(Model model) {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/kehuguanli/company/add";
	}

	/**
	 * 客户管理-供应商管理-跳转编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/companyedit")
	public String editCompany(Model model) {
		model.addAttribute("BusinessGuestCompanyFormMap",
				businessServer.querySingleCustomerCompany(getPara("id")));

		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/kehuguanli/company/edit";
	}

	/**
	 * 客户管理-客户管理-跳转新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/individualadd")
	public String addIndividual(Model model) {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/kehuguanli/individual/add";
	}

	/**
	 * 客户管理-客户管理-跳转编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/individualedit")
	public String editIndividual(Model model) {
		model.addAttribute("BusinessGuestIndividualFormMap",
				businessServer.querySingleCustomerIndividual(getPara("id")));

		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/yewuguanli/kehuguanli/individual/edit";
	}
	
	
	/**
	 * 分页查询--储量计划-地储/省储....
	 * @param page
	 * @param rows
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "queryPlans", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<BusinessPlaneFormMap> queryData(int page, int rows, HttpServletRequest request) {
		BusinessPlaneFormMap m = getFormMap(BusinessPlaneFormMap.class);
		List<BusinessPlaneFormMap> ls = businessServer.queryPlanes(page,rows, m);
		return toMyPage(ls);
		
	}
	/**
	 * 架空计划---分页显示
	 * @param page
	 * @param rows
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "queryJiakongPlans", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<BusinessPlanForMapJiakong> queryJiakongData(int page, int rows) {
		BusinessPlanForMapJiakong m = getFormMap(BusinessPlanForMapJiakong.class);
		List<BusinessPlanForMapJiakong> ls = businessServer.queryJiakongPlanes(page, rows, m);
		return toMyPage(ls);
	}
	/**
	 * 合同模版--分页显示
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping(value = "queryAgreementForm", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<BusinessAgreementFormFormMap> queryAgreementFormData(int page, int rows) {
		BusinessAgreementFormFormMap m = getFormMap(BusinessAgreementFormFormMap.class);
		List<BusinessAgreementFormFormMap> ls = businessServer.findAgreementForm(page, rows, m);
		return toMyPage(ls);
	}
	
	/**
	 * 合同管理分页查询
	 * @param page
	 * @param rows
	 * @param request
	 * @return
	 */
	
	@RequestMapping(value = "queryAgreements", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<BusinessAgreementFormMap> queryAgreementData(int page, int rows,
			HttpServletRequest request) {
		BusinessAgreementFormMap m = getFormMap(BusinessAgreementFormMap.class);
		List<BusinessAgreementFormMap> ls = businessServer.queryAgreements(
				page, rows, m);
		return toMyPage(ls);
	}

	@RequestMapping(value = "queryCompany", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<BusinessGuestCompanyFormMap> queryCompanyData(int page, int rows,
			HttpServletRequest request) {
		BusinessGuestCompanyFormMap m = getFormMap(BusinessGuestCompanyFormMap.class);
		List<BusinessGuestCompanyFormMap> ls = businessServer
				.queryCustomerCompanies(page, rows, m);
		return toMyPage(ls);
	}

	@RequestMapping(value = "queryIndividual", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<BusinessGuestIndividualFormMap> queryIndividualData(int page, int rows,
			HttpServletRequest request) {
		BusinessGuestIndividualFormMap m = getFormMap(BusinessGuestIndividualFormMap.class);
		List<BusinessGuestIndividualFormMap> ls = businessServer
				.queryCustomerIndividuals(page, rows, m);
		return toMyPage(ls);
	}
	/**
	 * 储量计划---添加操作
	 * @param request
	 * @return
	 */
	@Token(remove = true)
	@RequestMapping(value = "addPlan")
	@ResponseBody
	public String addPlan(HttpServletRequest request) {
		BusinessPlaneFormMap formMap = getFormMap(BusinessPlaneFormMap.class);
		if(!validDataPlane(formMap)){
			return ERROR;
		}
		
		float newPlanedAmount = Float.parseFloat(formMap.getStr("newPlanedAmount"));
		float turnPlannedAmount = Float.parseFloat(formMap.getStr("turnPlannedAmount"));
		formMap.set("totalAmount", newPlanedAmount+turnPlannedAmount);
		try {
			FormMapUtil.toADDFormMap(formMap);
		} catch (Exception e1) {
			log.error("===Class:BusinessManagerController==Method:addPlan==Exception:toADDFormMap=="+e1);
			return ERROR;
		}
		
		try {
			businessServer.addPlanes(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:addPlan==Exception:addPlanes=="+e);
			return ERROR;
		}
		return SUCCESS;

	}
	/**
	 * 架空计划--添加操作
	 * @param request
	 * @return
	 */
	@Token(remove = true)
	@RequestMapping(value = "addJiakongPlan")
	@ResponseBody
	public String addJiakongPlan(HttpServletRequest request) {
		BusinessPlanForMapJiakong formMap = getFormMap(BusinessPlanForMapJiakong.class);
		if(!validDataJiaKong(formMap)){
			return ERROR;
		}
		
		String startDate = formMap.getStr("timestart");
		String endDate = formMap.getStr("timeend");
		int diffDays = 0;
		
		Date date1 = DateUtils.parseDate(startDate);
		Date date2 = DateUtils.parseDate(endDate);
		if(date1.getTime()<=date2.getTime()){
			diffDays = DateUtils.getDayDiff(date1, date2);
			diffDays++;
		}
	
		formMap.put("days", diffDays);
		try {
			FormMapUtil.toADDFormMap(formMap);
		} catch (Exception e1) {
			log.error("===Class:BusinessManagerController==Method:addJiakongPlan==Exception:toADDFormMap=="+e1);
			return ERROR;
		}
		try {
			businessServer.addJiakongPlanes(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:addJiakongPlan==Exception:addJiakongPlanes=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 合同模版--添加操作
	 * @return
	 */
	@Token(remove=true)
	@RequestMapping("addAgreementForm")
	@ResponseBody
	public String addAgreementForm(){
		BusinessAgreementFormFormMap formMap = getFormMap(BusinessAgreementFormFormMap.class);
		
		try {
			FormMapUtil.toADDFormMap(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:addAgreementForm==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			businessServer.addAgreementForm(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:addAgreementForm==Exception:addAgreementForm=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	
	/**
	 * 合同管理---添加
	 * @param request
	 * @return
	 */
	@Token(remove = true)
	@RequestMapping(value = "addAgreement")
	@ResponseBody
	public String addAgreement(HttpServletRequest request) {
		BusinessAgreementFormMap formMap = getFormMap(BusinessAgreementFormMap.class);
		try {
			FormMapUtil.toADDFormMap(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:addAgreement==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		try {
			businessServer.addAgreement(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:addAgreement==Exception:addAgreement=="+e);
			return ERROR;
		}
		
		return SUCCESS;

	}
	/**
	 * 供应商
	 * @param request
	 * @return
	 */
	@Token(remove = true)
	@RequestMapping(value = "addCompany")
	@ResponseBody
	public String addCompanies(HttpServletRequest request) {
		BusinessGuestCompanyFormMap formMap = getFormMap(BusinessGuestCompanyFormMap.class);
		try {
			FormMapUtil.toADDFormMap(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:addCompanies==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		try {
			businessServer.addCustomerCompany(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:addCompanies==Exception:addCustomerCompany=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 客户--添加
	 * @param request
	 * @return
	 */
	@Token(remove = true)
	@RequestMapping(value = "addIndividual")
	@ResponseBody
	public String addIndividuals(HttpServletRequest request) {
		BusinessGuestIndividualFormMap formMap = getFormMap(BusinessGuestIndividualFormMap.class);
		try {
			FormMapUtil.toADDFormMap(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:addIndividuals==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		try {
			businessServer.addCustomerIndividual(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:addIndividuals==Exception:addCustomerIndividual=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 修改储量计划
	 * @return
	 */
	@Token(remove = true)
	@RequestMapping("editPlan")
	@ResponseBody
	public String editplan() {
		BusinessPlaneFormMap formMap = getFormMap(BusinessPlaneFormMap.class);
		if(!validDataPlane(formMap)){
			return ERROR;
		}
		double total = CalculateUtils.add(formMap.getStr("newPlanedAmount"), formMap.getStr("turnPlannedAmount"));
		
		formMap.set("totalAmount", Common.numberConvertString(total, 0));
		formMap.put("needComplete", "1");
		
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
		} catch (Exception e1) {
			log.error("===Class:BusinessManagerController==Method:editplan==Exception:toUPDATEFormMap=="+e1);
			return ERROR;
		}
		try {
			businessServer.updatePlanes(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:editplan==Exception:updatePlanes=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 架空计划--修改操作
	 * @return
	 */
	@Token(remove = true)
	@RequestMapping("editJiakongPlan")
	@ResponseBody
	public String editJiakongplan() {
		BusinessPlanForMapJiakong formMap = getFormMap(BusinessPlanForMapJiakong.class);
		if(!validDataJiaKong(formMap)){
			return ERROR;
		}
		String startDate = formMap.getStr("timestart");
		String endDate = formMap.getStr("timeend");
		int diffDays = 0;
		
		Date date1 = DateUtils.parseDate(startDate);
		Date date2 = DateUtils.parseDate(endDate);
		if(date1.getTime()<=date2.getTime()){
			diffDays = DateUtils.getDayDiff(date1, date2);
			diffDays++;
		}
		formMap.put("days", diffDays);
		
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
		} catch (Exception e1) {
			log.error("===Class:BusinessManagerController==Method:editJiakongplan==Exception:toUPDATEFormMap=="+e1);
			return ERROR;
		}
		
		try {
			businessServer.updateJiakongPlanes(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:editJiakongplan==Exception:updateJiakongPlanes=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 合同模版--修改
	 * @return
	 */
	@Token(remove=true)
	@RequestMapping("editAgreementForm")
	@ResponseBody
	public String editAgreementForm(){
		BusinessAgreementFormFormMap formMap = getFormMap(BusinessAgreementFormFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:editAgreementForm==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			businessServer.editAgreementForm(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:editAgreementForm==Exception:editAgreementForm=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	/**
	 * 合同管理--修改
	 * @return
	 */
	
	@Token(remove = true)
	@RequestMapping("editAgreement")
	@ResponseBody
	public String editAgreement() {
		BusinessAgreementFormMap formMap = getFormMap(BusinessAgreementFormMap.class);

		try {
			FormMapUtil.toUPDATEFormMap(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:editAgreement==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		try {
			businessServer.updateAgreement(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:editAgreement==Exception:updateAgreement=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	/**
	 * 供应商--修改
	 * @return
	 */
	@Token(remove = true)
	@RequestMapping("editCompany")
	@ResponseBody
	public String editCompanies() {
		BusinessGuestCompanyFormMap formMap = getFormMap(BusinessGuestCompanyFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
		} catch (Exception e1) {
			log.error("===Class:BusinessManagerController==Method:editCompanies==Exception:toUPDATEFormMap=="+e1);
			return ERROR;
		}

		try {
			businessServer.updateCustomerCompany(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:editCompanies==Exception:updateCustomerCompany=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@Token(remove = true)
	@RequestMapping("editIndividual")
	@ResponseBody
	public String editIndividuals() {
		BusinessGuestIndividualFormMap formMap = getFormMap(BusinessGuestIndividualFormMap.class);

		try {
			FormMapUtil.toUPDATEFormMap(formMap);
		} catch (Exception e1) {
			log.error("===Class:BusinessManagerController==Method:editIndividuals==Exception:toUPDATEFormMap=="+e1);
			return ERROR;
		}
		try {
			businessServer.updateCustomerIndividual(formMap);
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:editIndividuals==Exception:updateCustomerIndividual=="+e);
			return ERROR;
		}

		return SUCCESS;
	}
	@RequestMapping("report")
	public void report(HttpServletRequest request,HttpServletResponse response){
		//合同id
		String id = request.getParameter("id");
		//获取合同数据
		BusinessAgreementFormMap agreement = businessServer.querySingleAgreement(id);
		String templates = agreement.getStr("templates");
		//是否选择模版
		if(!Common.isEmpty(templates)){
			
			BusinessAgreementFormFormMap agreementForm = businessServer.findAgreementFormById(templates);
			
			String fileName = agreementForm.getStr("fFile");
			//模版是否上传文件
			if(!Common.isEmpty(fileName)){
				//参数
				FormMap<String,Object> param = new FormMap<String,Object>();
				String amounts = agreement.getStr("amounts");
				Object obj = agreement.get("price");
				BigDecimal price;
				if(obj.equals(null) || obj.toString().equals("")){
					price = new BigDecimal(0);
				}else{
					price = agreement.getBigDecimal("price");
				}
				 //price = agreement.getBigDecimal("price");
				if(Common.isEmpty(amounts)){
					amounts = "0";
				}
				BigDecimal weight = new BigDecimal(amounts);
				double  money = CalculateUtils.mul(weight+"", price+"");
				String cnMoney = NumberToCN.number2CNMontrayUnit(new BigDecimal(money));
				param.put("cnMoney", cnMoney);
				param.put("id", id);
				JasperHelper.export("pdf", agreement.getStr("agreementID"), "form/"+fileName, param, dataSource, request, response);
			}
		}
	}
	
	
	
	
	/**
	 * 储量计划--删除操作
	 * @return
	 */
	@RequestMapping("deleteOne")
	@ResponseBody
	public String deleteOne() {

		try {
			businessServer.deletePlanes(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:deleteOne==Exception:deletePlanes=="+e);
			return ERROR;
		}

		return SUCCESS;
	}
	/**
	 * 架空计划--删除操作
	 * @return
	 */
	@RequestMapping("deleteJiakongOne")
	@ResponseBody
	public String deleteJiakongOne() {

		try {
			businessServer.deleteJiakongPlanes(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:deleteJiakongOne==Exception:deleteJiakongPlanes=="+e);
			return ERROR;
		}

		return SUCCESS;
	}
	/**
	 * 合同模版--删除
	 * @return
	 */
	@RequestMapping("deleteAgreementForm")
	@ResponseBody
	public String deleteAgreementForm(){
		
		try {
			businessServer.dropAgreementForm(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:BusinessManagerController==Method:deleteAgreementForm==Exception:dropAgreementForm=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	
	@RequestMapping("deleteAgreement")
	@ResponseBody
	public String deleteAgreement() {

		try {
			businessServer.deleteAgreement(getPara("id"));
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteCompany")
	@ResponseBody
	public String deleteCompany() {

		try {
			businessServer.deleteCustomerCompany(getPara("id"));
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteIndividual")
	@ResponseBody
	public String deleteIndividual() {
		try {
			businessServer.deleteCustomerIndividual(getPara("id"));
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("findHouses")
	@ResponseBody
	public Map<String, Object> findHouses() {
		Map<String, Object> rs = new HashMap<>();
		try {
			WarehouseLocationFormMap m = new WarehouseLocationFormMap();
			m.put("wno", getPara("wno"));
			List<WarehouseLocationFormMap> ls = businessServer.findHouses(m);
			rs.put("result", ls);
			rs.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			rs.put("success", false);
		}
		return rs;
	}
	
	/**
	 * 查找所有合同模版
	 * 用户合同选择时，下拉列表
	 * @return
	 */
	@RequestMapping("allAgreementForm")
	@ResponseBody
	public List<BusinessAgreementFormFormMap> findAllAgreementForm(){
		return businessServer.findAllAgreementForm();
	}

	@RequestMapping("download")
	@ResponseBody
	public void download(HttpServletRequest request,HttpServletResponse response) {
		try {
			String fileName = getPara("id");
			String savePath = PropertiesUtils.getPropertyByName(
					"fileManager.properties").getProperty("savePath");
			
			File file = new File(savePath + "\\" + fileName);
				
			String lastName=new String(fileName.getBytes("utf-8"),"ISO-8859-1");
			//IE
			if(request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT")>0){
				lastName = URLEncoder.encode(fileName, "UTF-8");  
			}
			 OutputStream os = response.getOutputStream();  
			 response.reset();  
			 response.setHeader("Content-Disposition", "attachment; filename="+lastName);  
			 response.setContentType("application/octet-stream; charset=utf-8");  
		     os.write(FileUtils.readFileToByteArray(file));  
		     os.flush();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@RequestMapping("uploadFile")
	@ResponseBody
	public String uploadCodeItem(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, String dataid) {
		try {
			String savePath = PropertiesUtils.getPropertyByName(
					"fileManager.properties").getProperty("savePath");
			//获取扩展名
			String oFileName = file.getOriginalFilename();
			String ext = oFileName.substring(oFileName.lastIndexOf("."));
			String fileName = UUID.randomUUID().toString().replace("-", "");
			fileName+=ext;
			// 上传文件
			FileManager.upFile(file, savePath,fileName);

			// 更新表数据
			HashMap<String, String> map = new HashMap<>();
			map.put("state", "1");
			map.put("files", fileName);
			map.put("dataid", dataid);
			businessServer.updateAgreement(map);

		} catch (Exception e) {
			log.error("==Class:BusinessManagerController==Method:uploadCodeItem==Exception:上传文件=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 查找所有合同编号
	 * @author Lip
	 * @return
	 */
	@RequestMapping(value = "findAllAgreementBill", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<BusinessAgreementFormMap> findBusinessAgreementBill(){
		return businessServer.findAllArgeementBill();
	}
	
	
	@RequestMapping("uploadFormFile")
	@ResponseBody
	public String uploadForm(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, String dataid) {
		try {
			
			String savePath = request.getServletContext().getRealPath("/WEB-INF");
			savePath+="/classes/jasper/form/";
			
			//获取扩展名
			String oFileName = file.getOriginalFilename();
			String ext = oFileName.substring(oFileName.lastIndexOf("."));
			String fileName = UUID.randomUUID().toString().replace("-", "");
			fileName+=ext;
			// 上传文件
			FileManager.upFile(file, savePath,fileName);

			// 更新表数据
			BusinessAgreementFormFormMap formMap = new BusinessAgreementFormFormMap();
			formMap.set("id", dataid);
			formMap.set("fFile", fileName);
			FormMapUtil.toUPDATEFormMap(formMap);
			businessServer.editAgreementForm(formMap);

		} catch (Exception e) {
			log.error("==Class:BusinessManagerController==Method:uploadForm==Exception:上传文件=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("downloadFormFile")
	@ResponseBody
	public void downloadFormFile(HttpServletRequest request,HttpServletResponse response) {
		try {
			String fileName = getPara("fileName");
			String savePath = request.getServletContext().getRealPath("/WEB-INF");
			savePath+="/classes/jasper/form/";
			File file = new File(savePath + "\\" + fileName);
			String lastName=new String(fileName.getBytes("utf-8"),"ISO-8859-1");
			//IE
			if(request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT")>0){
				lastName = URLEncoder.encode(fileName, "UTF-8");  
			}
			 OutputStream os = response.getOutputStream();  
			 response.reset();  
			 response.setHeader("Content-Disposition", "attachment; filename="+lastName);  
			 response.setContentType("application/octet-stream; charset=utf-8");  
		     os.write(FileUtils.readFileToByteArray(file));  
		     os.flush();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	/**
	 * 储量计划--数据验证
	 * @return
	 */
	private boolean validDataPlane(BusinessPlaneFormMap formMap){
		String planId = formMap.getStr("planId");
		String wId = formMap.getStr("wId");
		String breed = formMap.getStr("breed");
		String newPlanedAmount = formMap.getStr("newPlanedAmount");
		String turnPlannedAmount = formMap.getStr("turnPlannedAmount");
		String type = formMap.getStr("type");
		String achieveYear = formMap.getStr("achieveYear");
		String planedPrice = formMap.getStr("planedPrice");
		String planedTimeStart = formMap.getStr("planedTimeStart");
		String planedTimeEnd = formMap.getStr("planedTimeEnd");
		
		if(ValidateUtil.isEmpty(wId)){
			return false;
		}else{
			//末尾是逗号，则处理逗号
			if(wId.lastIndexOf(",") == wId.length()-1){
				formMap.set("wId", wId.subSequence(0, wId.length()-1));				
			}
		}
		if(ValidateUtil.isEmpty(planId) || !ValidateUtil.isLength(planId, Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(breed)){
			return false;
		}
		if(ValidateUtil.isEmpty(newPlanedAmount) || !ValidateUtil.isFloat(newPlanedAmount)){
			return false;
		}
		if(ValidateUtil.isEmpty(turnPlannedAmount) || !ValidateUtil.isFloat(turnPlannedAmount)){
			return false;
		}
		if(ValidateUtil.isEmpty(planedPrice) || !ValidateUtil.isFloat(planedPrice)){
			return false;
		}
		if(ValidateUtil.isEmpty(type)){
			return false;
		}
		if(ValidateUtil.isEmpty(achieveYear) || !ValidateUtil.isLength(achieveYear, Constant.INT_4)){
			return false;
		}
		if(ValidateUtil.isEmpty(planedTimeStart) || !ValidateUtil.isShortDate(planedTimeStart)){
			return false;
		}
		if(ValidateUtil.isEmpty(planedTimeEnd) || !ValidateUtil.isShortDate(planedTimeEnd)){
			return false;
		}
		
		return true;
	}
	
	/**
	 * 架空计划校验
	 * @param formMap
	 * @return
	 */
	public boolean validDataJiaKong(BusinessPlanForMapJiakong formMap){
		String wId = formMap.getStr("wId");
		String breed = formMap.getStr("breed");
		String property = formMap.getStr("property");
		String timestart = formMap.getStr("timestart");
		String timeend = formMap.getStr("timeend");
		String amount = formMap.getStr("amount");
		if(ValidateUtil.isEmpty(wId)){
			return false;
		}
		if(ValidateUtil.isEmpty(breed)){
			return false;
		}
		if(ValidateUtil.isEmpty(property)){
			return false;
		}
		if(ValidateUtil.isEmpty(timestart)){
			return false;
		}
		if(ValidateUtil.isEmpty(timeend)){
			return false;
		}
		if(ValidateUtil.isEmpty(amount)){
			return false;
		}
		return true;
	}
	
	
}
