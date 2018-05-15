package com.zyiot.controller.weight;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.UserFormMap;
import com.zyiot.entity.weight.QualityCheckFormMap;
import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.server.weight.ReportHarborServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.PropertiesUtils;
import com.zyiot.util.ValidateUtil;
/**
 * 报港信息
 * @author Lip
 * @date 2017年4月27日 下午3:58:04
 */
@Controller
@RequestMapping("reportHarbor")
public class ReportHarborController extends BaseController {
	Logger log = Logger.getLogger(ReportHarborController.class);
	@Autowired
	private ReportHarborServerI reportHarborServer;
	/**
	 * 报港包含质检信息
	 * @return
	 */
	@RequestMapping("list")
	public String list(){
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/list";
	}
	/**
	 * 只进行简单报港
	 * @return
	 */
	@RequestMapping("onlyReportList")
	public String onlyReportList(){
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/onlyReportList";
	}
	/**
	 * 未进行称重的报港信息
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> findByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		List<ReportHarborFormMap> list = reportHarborServer.findByPage(reportHarborFormMap, page, rows);
		return toMyPage(list);
	}
	/**
	 * 所有报港信息
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findAllByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> findAllByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		List<ReportHarborFormMap> list = reportHarborServer.findAllByPage(reportHarborFormMap, page, rows);
		
		return toMyPage(list);
	}
	
	/**
	 * 所有报港质检信息
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findAllCheckByPage")
	@ResponseBody
	public MyPage<QualityCheckFormMap> findAllCheckByPage(int rows,int page){
		QualityCheckFormMap qualityCheckFormMap = getFormMap(QualityCheckFormMap.class);
		List<QualityCheckFormMap> list = reportHarborServer.findAllCheckByPage(qualityCheckFormMap, page, rows);
		
		return toMyPage(list);
	}
	/**
	 * 入库报港信息
	 * @param model
	 * @return
	 */
	@RequestMapping("addInUI")
	@Token(save=true)
	public String addInUI(Model model){
		return inputOrOutput(model, '2');
	}
	/**
	 * 入库报港信息--仅报港不质检
	 * @param model
	 * @return
	 */
	@RequestMapping("onlyReportAddInUI")
	@Token(save=true)
	public String onlyReportAddInUI(Model model){
		return onlyReportInputOrOutput(model, '2');
	}
	/**
	 * 出库报港信息
	 * @param model
	 * @return
	 */
	@RequestMapping("addOutUI")
	@Token(save=true)
	public String addOutUI(Model model){
		return inputOrOutput(model, '1');
	}
	/**
	 * 出库报港信息--只报港不质检
	 * @param model
	 * @return
	 */
	@RequestMapping("onlyReportAddOutUI")
	@Token(save=true)
	public String onlyReportAddOutUI(Model model){
		return onlyReportInputOrOutput(model, '1');
	}
	/**
	 * 添加报港信息
	 * @return
	 */
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		reportHarborFormMap.set("addDate", DateUtils.dateFormatToLong(new Date()));
		reportHarborFormMap.set("reportDate", DateUtils.dateFormatToLong(new Date()));
		UserFormMap userFormMap = (UserFormMap) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		reportHarborFormMap.set("checker", userFormMap.getStr("userName"));
		reportHarborFormMap.set("isChecked", "1");
		if(!validData(reportHarborFormMap)){
			return ERROR;
		}
		QualityCheckFormMap qualityCheckFormMap = getFormMap(QualityCheckFormMap.class);
		
		try {
			FormMapUtil.toADDFormMap(qualityCheckFormMap);
			FormMapUtil.toADDFormMap(reportHarborFormMap);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			String bId = reportHarborServer.addReportHarbor(reportHarborFormMap,qualityCheckFormMap);
			return bId;
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:add==Exception:addReportHarbor=="+e);
			return ERROR;
		}
	}
	/**
	 * 添加报港信息 -- 仅添加报港信息
	 * @return
	 */
	@RequestMapping("onlyReportAdd")
	@ResponseBody
	@Token(remove=true)
	public String onlyReportAdd(){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		reportHarborFormMap.set("addDate", DateUtils.dateFormatToLong(new Date()));
		reportHarborFormMap.set("reportDate", DateUtils.dateFormatToLong(new Date()));
		UserFormMap userFormMap = (UserFormMap) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		reportHarborFormMap.set("checker", userFormMap.getStr("userName"));
		reportHarborFormMap.set("isChecked", "2");
		if(!validDataOnlyReport(reportHarborFormMap)){
			return ERROR;
		}
		
		try {
			FormMapUtil.toADDFormMap(reportHarborFormMap);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			String bId = reportHarborServer.addReportHarbor(reportHarborFormMap);
			return bId;
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:add==Exception:addReportHarbor=="+e);
			return ERROR;
		}
	}
	/**
	 * 报港时添加驳车页面
	 * @param model
	 * @return
	 */
	@RequestMapping("usedCar")
	public String usedCarUI(Model model){
		String bId = getPara("bId");
		model.addAttribute("bId", bId);
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/usedCar";
	}
	/**
	 * 跳转二维码页面
	 * @param model
	 * @return
	 */
	@RequestMapping("createQRC")
	public String createQRC(Model model){
		String bId = getPara("bId");
		model.addAttribute("bId", bId);
		ReportHarborFormMap reportHarborFormMap = reportHarborServer.printReportHarborByBId(bId);
		model.addAttribute("reportHarborFormMap", reportHarborFormMap);
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/createQRC";
	}
	/**
	 * 删除报港信息
	 * @return
	 */
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		
		try {
			reportHarborServer.dropReportHarbor(id);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:delete==Exception:dropReportHarbor=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	/**
	 * 补二维码（一卡通）
	 * @param model
	 * @return
	 */
	@RequestMapping("repair")
	public String repair(Model model){
		String bId = getPara("bId");
		model.addAttribute("bId",bId);
		
		Properties properties = PropertiesUtils.getPropertyByName("weightConfig.properties");
		String usedOrNot = properties.getProperty("usedOrNot");
		model.addAttribute("usedOrNot",usedOrNot);
		
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/repair";
	}
	/**
	 * 根据单据号查找报港信息
	 * @return
	 */
	@RequestMapping("findByBId")
	@ResponseBody
	public ReportHarborFormMap findByBId(){
		String bId = getPara("bId");
		if(bId != null && !bId.equals("")){
			return reportHarborServer.findReportHarborByBId(bId);			
		}
		return null;
	}
	
	/**
	 * 根据单据号修改驳车
	 * @return
	 */
	@RequestMapping("editUsedCar")
	public String editUsedCarUI(Model model){
		String bId = getPara("bId");
		model.addAttribute("bId", bId);
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/editUsedCar";
	}
	
	/**
	 * 根据一卡通获取信息
	 * @return
	 */
	@RequestMapping("findByCardId")
	@ResponseBody
	public ReportHarborFormMap findByCardId(){
		String cardId = getPara("cardId");
		if(cardId == null || cardId.equals("") ){
			return null;
		}
		ReportHarborFormMap reportHarbor = reportHarborServer.findReportHarborByCardId(cardId);
		return reportHarbor;
	}
	/**
	 * 根据一卡通获取信息
	 * @return
	 */
	@RequestMapping("findIsCheckByCardId")
	@ResponseBody
	public ReportHarborFormMap findIsCheckByCardId(){
		String cardId = getPara("cardId");
		if(cardId == null || cardId.equals("") ){
			return null;
		}
		ReportHarborFormMap reportHarbor = reportHarborServer.findIsCheckByCardId(cardId);
		return reportHarbor;
	}
	
	/**
	 * 出库报港还是入库报港
	 * @param model 参数传递
	 * @param inOrout 1：出库，2：入库
	 * @return
	 */
	public String inputOrOutput(Model model,char inOrOut){
		//判断是否启用一卡通
		Properties properties = PropertiesUtils.getPropertyByName("weightConfig.properties");
		String usedOrNot = properties.getProperty("usedOrNot");
		model.addAttribute("usedOrNot",usedOrNot);
		model.addAttribute("inOrOut", inOrOut);
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/add";
	}
	/**
	 * 出库报港还是入库报港--仅报港不质检
	 * @param model 参数传递
	 * @param inOrout 1：出库，2：入库
	 * @return
	 */
	public String onlyReportInputOrOutput(Model model,char inOrOut){
		//判断是否启用一卡通
		Properties properties = PropertiesUtils.getPropertyByName("weightConfig.properties");
		String usedOrNot = properties.getProperty("usedOrNot");
		model.addAttribute("usedOrNot",usedOrNot);
		model.addAttribute("inOrOut", inOrOut);
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/onlyReportAdd";
	}
	/**
	 * 绑定一卡通
	 * @return
	 */
	@RequestMapping("bindOneCard")
	@ResponseBody
	public String bindOneCard(){
		String bId = getPara("bId");
		String oneCard = getPara("oneCard");
		ReportHarborFormMap reportHarborFormMap = reportHarborServer.findReportHarborByBId(bId);
		if(reportHarborFormMap == null){
			return ERROR;
		}else{
			reportHarborFormMap.set("cardId", oneCard);
			
			try {
				reportHarborFormMap.set("id", reportHarborFormMap.getInt("id")+"");
				reportHarborFormMap.set(Constant.VERSION, reportHarborFormMap.getInt(Constant.VERSION)+"");
				
				FormMapUtil.toUPDATEFormMap(reportHarborFormMap);
				
				reportHarborServer.editReportHarbor(reportHarborFormMap);
			} catch (Exception e) {
				log.error("===Class:ReportHarborController==Method:bindOneCard==Exception:editReportHarbor=="+e);
				return ERROR;
			}
		}
		
		return SUCCESS;
	}
	/**
	 * 根据单据号查找详细信息
	 * @return
	 */
	@RequestMapping("findDetailByBill")
	@ResponseBody
	public ReportHarborFormMap findDetailByBill(){
		String bId = getPara("bId");
		String[] level = {"一等","二等","三等","四等","五等","等外"};
		try {
			ReportHarborFormMap reportHarborFormMap = reportHarborServer.findDetailReportHarborByBId(bId);
			BigDecimal money = reportHarborFormMap.getBigDecimal("sumMoney");
			String sumMoneyUp = Common.numberConvertUp(money.toString());
			reportHarborFormMap.set("sumMoneyUp", sumMoneyUp);
			String lv = reportHarborFormMap.getStr("level");
			if(!lv.equals("等外")){
				reportHarborFormMap.set("level", level[Integer.parseInt(lv)-1]);
			}
			reportHarborFormMap.set("nowDate", DateUtils.dateFormatToShort(new Date()));
			
			String companyName = PropertiesUtils.getPropertyByName("weightConfig.properties").getProperty("companyName");
			reportHarborFormMap.set("companyName", companyName);
			
			return reportHarborFormMap;
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:findDetailByBill==Exception:findDetailReportHarborByBId=="+e);
		}
		return null;
	}
	/**
	 * 修改报港基础信息列表
	 * @return
	 */
	@RequestMapping("editbasiclistUI")
	public String editBasicListUI(){
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/editbasiclist";
	}
	
	@RequestMapping("editBasicUI")
	@Token(save=true)
	public String editBasicUI(Model model){
		String id = getPara("id");
		try {
			ReportHarborFormMap reportHarbor = reportHarborServer.findBasicReportHarborById(Integer.parseInt(id));
			model.addAttribute("reportHarborFormMap", reportHarbor);
		} catch (NumberFormatException e) {
			log.error("===Class:ReportHarborController==Method:findBasicReportHarborById==Exception:NumberFormatException=="+e);
		}
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/editbasic";
	}
	@RequestMapping("editBasic")
	@ResponseBody
	@Token(remove=true)
	public String editBasic(){
		ReportHarborFormMap reportHarbor  = getFormMap(ReportHarborFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(reportHarbor);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:editBasic==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			reportHarborServer.editBasicReportHarbor(reportHarbor);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:editBasic==Exception:editBasicReportHarbor=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	/**
	 * 修改报港质检信息列表
	 * @return
	 */
	@RequestMapping("editchecklistUI")
	public String editCheckListUI(){
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/editchecklist";
	}
	
	@RequestMapping("editCheckUI")
	@Token(save=true)
	public String editCheckUI(Model model){
		String id = getPara("id");
		try {
			ReportHarborFormMap reportHarbor = reportHarborServer.findCheckReportHarborById(Integer.parseInt(id));
			model.addAttribute("reportHarborFormMap", reportHarbor);
		} catch (NumberFormatException e) {
			log.error("===Class:ReportHarborController==Method:findCheckReportHarborById==Exception:NumberFormatException=="+e);
		}
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/editcheck";
	}
	@RequestMapping("editcheck")
	@ResponseBody
	@Token(remove=true)
	public String editCheck(){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		QualityCheckFormMap qualityCheckFormMap = getFormMap(QualityCheckFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(reportHarborFormMap);
			FormMapUtil.toUPDATEFormMap(qualityCheckFormMap);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:editCheck==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			reportHarborServer.editCheckReportHarbor(reportHarborFormMap, qualityCheckFormMap);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:editCheck==Exception:editCheckReportHarbor=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	/**
	 * 资金结算列表
	 * @return
	 */
	@RequestMapping("settleAccountList")
	public String settleAccountList(){
		return Constant.BACKGROUND_PATH+"/weight/settleAccount/list";
	}
	/**
	 * 资金结算
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findSettleAccountByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> findSettleAccountByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		List<ReportHarborFormMap> list = reportHarborServer.findSettleAccountByPage(reportHarborFormMap, page, rows);
		return toMyPage(list);
	}
	
	@RequestMapping("settleAccountUI")
	@Token(save=true)
	public String settleAccountUI(Model model){
		String id = getPara("id");
		
		ReportHarborFormMap reportHarborFormMap = reportHarborServer.findDetailReportHarborById(Integer.parseInt(id));
		
		model.addAttribute("reportHarborFormMap", reportHarborFormMap);
		
		return Constant.BACKGROUND_PATH+"/weight/settleAccount/payMoney";
	}
	@RequestMapping("settleAccount")
	@ResponseBody
	@Token(remove=true)
	public String settleAccount(){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(reportHarborFormMap);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:settleAccount==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			
			UserFormMap userFormMap = (UserFormMap) SecurityUtils.getSubject().getSession().getAttribute("userSession");
			reportHarborFormMap.set("payAuthor", userFormMap.getStr("userName"));
			reportHarborFormMap.set("payDate", DateUtils.dateFormatToLong(new Date()));
			reportHarborFormMap.set("payStatus", "结算完成");
			reportHarborFormMap.set("cardId", null);
			
			reportHarborServer.editReportHarbor(reportHarborFormMap);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:settleAccount==Exception:editReportHarbor=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("payPlanId")
	@ResponseBody
	public String payPlanId(){
		String wId = getPara("wId");
		String result = reportHarborServer.findPayPlanIdByWId(wId);
		if(result == null){
			result = "";
		}
		return result;
	}
	/**
	 * 出入库补录
	 * @return
	 */
	@RequestMapping("additionalList")
	public String additionalList(){
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/additionallist";
	}
	/**
	 * 出入库补录分页显示
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findAdditionalByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> findAdditionalByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		List<ReportHarborFormMap> list = reportHarborServer.findAdditionalByPage(reportHarborFormMap, page, rows);
		return toMyPage(list);
	}
	
	/**
	 * 出入库补录添加
	 * @return
	 */
	@RequestMapping("additionalAddUI")
	@Token(save=true)
	public String lastAddUI(Model model){
		String inOrOut = getPara("inOrOut");
		
		Properties properties = PropertiesUtils.getPropertyByName("weightConfig.properties");
		String usedOrNot = properties.getProperty("usedOrNot");
		model.addAttribute("usedOrNot",usedOrNot);
		model.addAttribute("inOrOut",inOrOut);
		
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/additionaladd";
	}
	@RequestMapping("additionalAdd")
	@ResponseBody
	@Token(remove=true)
	public String additionalAdd(){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		
		if(!validData(reportHarborFormMap)){
			return ERROR;
		}
		QualityCheckFormMap qualityCheckFormMap = getFormMap(QualityCheckFormMap.class);
		
		try {
			FormMapUtil.toADDFormMap(qualityCheckFormMap);
			FormMapUtil.toADDFormMap(reportHarborFormMap);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			reportHarborFormMap.set("addDate", DateUtils.dateFormatToLong(new Date()));
			String bId = reportHarborServer.additionalReportHarbor(reportHarborFormMap,qualityCheckFormMap);
			return bId;
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:additionalAdd==Exception:additionalReportHarbor=="+e);
			return ERROR;
		}
		
		
	}
	
	@RequestMapping("additionalDelete")
	@ResponseBody
	public String additionalDelete(){
		String id = getPara("id");
		try {
			reportHarborServer.dropAdditionalReportHarbor(id);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:additionalDelete==Exception:dropAdditionalReportHarbor=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	/**
	 * 根据仓号获取最后一条统仓质检，用户出库报港时，自动填充质检信息
	 * @return
	 */
	@RequestMapping("findLastByWId")
	@ResponseBody
	public QualityCheckFormMap findLastByWId(){
		String wId = getPara("wId");
		return reportHarborServer.findLastByWId(wId);
	}
	/**
	 * 未进行质检操作的报港信息列表页面
	 * @return
	 */
	@RequestMapping("notCheckListUI")
	public String notCheckListUI(){
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/notchecklist";
	}
	/**
	 * 未进行质检操作的报港信息分页查询
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findNotCheckByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> findNotCheckByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		//未进行质检的报港数据
		reportHarborFormMap.set("isChecked", "2");
		List<ReportHarborFormMap> list = reportHarborServer.findByPage(reportHarborFormMap, page, rows);
		return toMyPage(list);
	}
	/**
	 * 对为进行质检的数据进行质检操作
	 * @return
	 */
	@RequestMapping("addCheckUI")
	@Token(save=true)
	public String addCheckUI(Model model){
		//获取单据号
		String pId = getPara("pId");
		ReportHarborFormMap reportHarborFormMap = reportHarborServer.findNotCheckReportHarborByBId(pId);
		model.addAttribute("reportHarborFormMap", reportHarborFormMap);
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/onlyCheckAdd";
	}
	/**
	 * 添加质检信息
	 * @return
	 */
	@RequestMapping("addCheck")
	@ResponseBody
	@Token(remove=true)
	public String addCheck(){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		//标识已被质检
		reportHarborFormMap.set("isChecked", "1");
		
		QualityCheckFormMap qualityCheckFormMap = getFormMap(QualityCheckFormMap.class);
		
		try {
			//添加质检信息
			FormMapUtil.toADDFormMap(qualityCheckFormMap);
			//修改报港信息
			FormMapUtil.toUPDATEFormMap(reportHarborFormMap);
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			String bId = reportHarborServer.addQualityCheck(reportHarborFormMap,qualityCheckFormMap);
			return bId;
		} catch (Exception e) {
			log.error("===Class:ReportHarborController==Method:addCheck==Exception:addQualityCheck=="+e);
			return ERROR;
		}
	}
	/**
	 * 查找质检单数据，进行打印数据填充
	 * @return
	 */
	@RequestMapping("findPrintCheckByBId")
	@ResponseBody
	public QualityCheckFormMap findPrintCheckByBId(){
		String bId = getPara("bId");
		QualityCheckFormMap qualityCheck = reportHarborServer.findPrintCheckByBId(bId);
		if(qualityCheck != null){
			Properties properties = PropertiesUtils.getPropertyByName("weightConfig.properties");
			qualityCheck.set("companyName", properties.getProperty("companyName"));
			String[] level = {"一等","二等","三等","四等","五等","等外"};
			String lv = qualityCheck.getStr("level");
			if(!lv.equals("等外")){
				qualityCheck.set("level", level[Integer.parseInt(lv)-1]);
			}
			float rz = qualityCheck.getFloat("rz");
			if(rz<100){ //进行容重/出糙区分
				qualityCheck.remove("rz");
				qualityCheck.set("cc", rz);
			}
			Calendar calendar = Calendar.getInstance();
			qualityCheck.set("year", calendar.get(Calendar.YEAR));
			qualityCheck.set("month", calendar.get(Calendar.MONTH)+1);
			qualityCheck.set("day", calendar.get(Calendar.DAY_OF_MONTH));
		}
		return qualityCheck;
	}
	/**
	 * 检验单打印操作列表
	 * @return
	 */
	@RequestMapping("printListUI")
	public String printListUI(){
		return Constant.BACKGROUND_PATH+"/weight/reportHarbor/inoroutcheckbilllist";
	}
	
	@RequestMapping("findPrintByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> findPrintByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		//未进行质检的报港数据
		reportHarborFormMap.set("isChecked", "1");
		List<ReportHarborFormMap> list = reportHarborServer.findPrintByPage(reportHarborFormMap, page, rows);
		return toMyPage(list);
	}
	
	public boolean validData(ReportHarborFormMap reportHarbor){
		String IDCard = reportHarbor.getStr("IDCard");
		String userName = reportHarbor.getStr("userName");
		String phoneNumber = reportHarbor.getStr("phoneNumber");
		String address = reportHarbor.getStr("address");
		String shipId = reportHarbor.getStr("shipId");
		String wId = reportHarbor.getStr("wId");
		String grainVariety = reportHarbor.getStr("grainVariety");
		String grainProperty = reportHarbor.getStr("grainProperty");
		String buyPrice = reportHarbor.getStr("buyPrice");
		if(!ValidateUtil.isLength(IDCard, Constant.INT_18)){
			return false;
		}
		if(ValidateUtil.isEmpty(userName) || !ValidateUtil.isLength(userName, Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(phoneNumber, Constant.INT_12)){
			return false;
		}
		if(ValidateUtil.isEmpty(shipId) || !ValidateUtil.isLength(shipId, Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(address, Constant.INT_64)){
			return false;
		}
		if(ValidateUtil.isEmpty(wId) || !ValidateUtil.isInt(wId)){
			return false;
		}
		if(ValidateUtil.isEmpty(buyPrice) || !ValidateUtil.isFloat(buyPrice)){
			return false;
		}
		if(ValidateUtil.isEmpty(grainVariety)){
			return false;
		}
		if(ValidateUtil.isEmpty(grainProperty)){
			return false;
		}
		return true;
	}
	public boolean validDataOnlyReport(ReportHarborFormMap reportHarbor){
		String IDCard = reportHarbor.getStr("IDCard");
		String userName = reportHarbor.getStr("userName");
		String phoneNumber = reportHarbor.getStr("phoneNumber");
		String address = reportHarbor.getStr("address");
		String shipId = reportHarbor.getStr("shipId");
		String wId = reportHarbor.getStr("wId");
		String grainVariety = reportHarbor.getStr("grainVariety");
		String grainProperty = reportHarbor.getStr("grainProperty");
		if(!ValidateUtil.isLength(IDCard, Constant.INT_18)){
			return false;
		}
		if(ValidateUtil.isEmpty(userName) || !ValidateUtil.isLength(userName, Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(phoneNumber, Constant.INT_12)){
			return false;
		}
		if(ValidateUtil.isEmpty(shipId) || !ValidateUtil.isLength(shipId, Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(address, Constant.INT_64)){
			return false;
		}
		if(ValidateUtil.isEmpty(wId) || !ValidateUtil.isInt(wId)){
			return false;
		}
		if(ValidateUtil.isEmpty(grainVariety)){
			return false;
		}
		if(ValidateUtil.isEmpty(grainProperty)){
			return false;
		}
		return true;
	}
}
