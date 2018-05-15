package com.zyiot.controller.chuliangguanli;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.cunchuguanli.ChuKuShenQingFormMap;
import com.zyiot.entity.cunchuguanli.ChuKuShenQingTransferToolsFormMap;
import com.zyiot.server.cunchuguanli.ChuKuShenQingServerI;
import com.zyiot.server.cunchuguanli.ChuKuShenQingTransferToolsServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("chukushenqing")
public class ChuKuShenQingController extends BaseController {
	Logger log = Logger.getLogger(ChuKuShenQingController.class);
	
	@Autowired
	private ChuKuShenQingServerI chuKuShenQingServer;
	@Autowired
	private ChuKuShenQingTransferToolsServerI chuKuShenQingTransferToolsServer;
	@RequestMapping("listUI")
	public String listUI() {
		clearNoUserData();
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenqing";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<ChuKuShenQingFormMap> findByPage(int page, int rows) {
		ChuKuShenQingFormMap chuKuShenQingFormMap =  getFormMap(ChuKuShenQingFormMap.class);
		List<ChuKuShenQingFormMap> list = chuKuShenQingServer.findByPage(chuKuShenQingFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(ChuKuShenQingFormMap cf:list){
				if(cf.getDate("gsaSendOutDate") != null){
					cf.set("gsaSendOutDate", DateUtils.dateFormatToShort(cf.getDate("gsaSendOutDate")));					
				}
				cf.set("gsaAddDate", DateUtils.dateFormatToLong(cf.getDate("gsaAddDate")));
			}
		}
		return toMyPage(list);
	}
	
	
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenqingadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		ChuKuShenQingFormMap chuKuShenQingFormMap = getFormMap(ChuKuShenQingFormMap.class);
		if(!validData(chuKuShenQingFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(chuKuShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:toADDFormMap==="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			chuKuShenQingFormMap.set("gsaDataOperator", session.getAttribute("userSessionId"));
			chuKuShenQingFormMap.set("gsaAddDate", new Timestamp(System.currentTimeMillis()));
			chuKuShenQingFormMap.set("gsaProcess", Constant.STATUS_SAVE);
			chuKuShenQingServer.addChuKuShenQing(chuKuShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:addChuKuShenQing==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("approve")
	@ResponseBody
	@Token(remove=true)
	public String approve(){
		ChuKuShenQingFormMap chuKuShenQingFormMap = getFormMap(ChuKuShenQingFormMap.class);
		if(!validData(chuKuShenQingFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(chuKuShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:toADDFormMap==="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			chuKuShenQingFormMap.set("gsaDataOperator", session.getAttribute("userSessionId"));
			chuKuShenQingFormMap.set("gsaAddDate", new Timestamp(System.currentTimeMillis()));
			chuKuShenQingFormMap.set("gsaProcess", Constant.STATUS_APPROVE);
			chuKuShenQingServer.addChuKuShenQing(chuKuShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:addChuKuShenQing==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("approveById")
	@ResponseBody
	public String approveById(){
		ChuKuShenQingFormMap chuKuShenQingFormMap = new ChuKuShenQingFormMap();
		
		chuKuShenQingFormMap.set("id", getPara("id"));
		chuKuShenQingFormMap.set("gsaProcess", Constant.STATUS_APPROVE);
		
		try {
			FormMapUtil.toUPDATEFormMap(chuKuShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:toUPDATEFormMap==="+e);
			return ERROR;
		}
		
		try {
			chuKuShenQingServer.approveChuKuShenQing(chuKuShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:editChuKuShenQing==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		clearNoUserData();
		try {
			ChuKuShenQingFormMap chuKuShenQingFormMap = chuKuShenQingServer.findChuKuShenQingById(Integer.parseInt(getPara("id")));
			if(chuKuShenQingFormMap.getDate("gsaSendOutDate") != null){
				chuKuShenQingFormMap.set("gsaSendOutDate", DateUtils.dateFormatToShort(chuKuShenQingFormMap.getDate("gsaSendOutDate")));				
			}
			model.addAttribute("chuKuShenQingFormMap", chuKuShenQingFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:ChuKuShenQingController===Method:Integer.parseInt==="+e);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:findChuKuShenQingById==="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenqingedit";
	}
	
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		ChuKuShenQingFormMap chuKuShenQingFormMap = getFormMap(ChuKuShenQingFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(chuKuShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:toUPDATEFormMap==="+e);
			return ERROR;
		}
		
		try {
			chuKuShenQingServer.editChuKuShenQing(chuKuShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:editChuKuShenQing==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		try {
			chuKuShenQingServer.dropChuKuShenQing(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:dropChuKuShenQing==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("throughUI")
	public String throughUI(Model model){
		try {
			ChuKuShenQingFormMap chuKuShenQingFormMap = chuKuShenQingServer.lookChuKuShenQingById(Integer.parseInt(getPara("id")));
			model.addAttribute("gsaRemark", chuKuShenQingFormMap.getStr("gsaRemark"));
			model.addAttribute("userName", chuKuShenQingFormMap.getStr("userName"));
		} catch (NumberFormatException e) {
			log.error("===Class:ChuKuShenQingController===Method:Integer.parseInt==="+e);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:findChuKuShenQingById==="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenqingopinion";
	}
	
	@RequestMapping("look")
	public String look(Model model){
		try {
			ChuKuShenQingFormMap chuKuShenQingFormMap = chuKuShenQingServer.lookChuKuShenQingById(Integer.parseInt(getPara("id")));
			if(chuKuShenQingFormMap.getDate("gsaSendOutDate") != null){
				chuKuShenQingFormMap.set("gsaSendOutDate", DateUtils.dateFormatToShort(chuKuShenQingFormMap.getDate("gsaSendOutDate")));				
			}
			model.addAttribute("chuKuShenQingFormMap", chuKuShenQingFormMap);
			
			List<Integer> ids = new ArrayList<Integer>();
			String transferTools = chuKuShenQingFormMap.getStr("gsaTransferTools");
			if(!Common.isEmpty(transferTools)){
				String[] temp = transferTools.split(",");
				for(String t:temp){
					ids.add(Integer.parseInt(t));
				}
			}
			
			if(ids!=null && ids.size()>0){
				List<ChuKuShenQingTransferToolsFormMap> lists = chuKuShenQingTransferToolsServer.findByIds(ids);
				model.addAttribute("lists", lists);
			}
			
		} catch (NumberFormatException e) {
			log.error("===Class:ChuKuShenQingController===Method:Integer.parseInt==="+e);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:findChuKuShenQingById==="+e);
		}
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenqinglook";
	}
	
	
	
	
	/**
	 * 清除无用的传输工具
	 */
	private void clearNoUserData(){
		Session session = SecurityUtils.getSubject().getSession();
		try {
			chuKuShenQingTransferToolsServer.clearNoUsedData((Integer)session.getAttribute("userSessionId"));
		} catch (InvalidSessionException e) {
			log.error("===Class:ChuKuShenQingController===Method:(Integer)session.getAttribute==="+e);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingController===Method:clearNoUsedData==="+e);
		}
	}
	
	
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String gsaApplyBill = formMap.getStr("gsaApplyBill");
		String gsaSendOutDate = formMap.getStr("gsaSendOutDate");
		String gsaPurchaser = formMap.getStr("gsaPurchaser");
		String gsaPaymentSituation = formMap.getStr("gsaPaymentSituation");
		String gsaPlanOutWeight = formMap.getStr("gsaPlanOutWeight");
		String gsaWId = formMap.getStr("gsaWId");
		String gsaCurrentWeight = formMap.getStr("gsaCurrentWeight");
		String gsaApplyPerson = formMap.getStr("gsaApplyPerson");
		String gsaApplyDepartment = formMap.getStr("gsaApplyDepartment");
		String gsaTransferTools = formMap.getStr("gsaTransferTools");
		String gsaProcess = formMap.getStr("gsaProcess");
		
		if(ValidateUtil.isEmpty(gsaApplyBill) || !ValidateUtil.isLength(gsaApplyBill,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isShortDate(gsaSendOutDate)){
			return false;
		}
		if(ValidateUtil.isEmpty(gsaPurchaser) || !ValidateUtil.isLength(gsaPurchaser,Constant.INT_32)){
			return false;
		}
		
		if(!ValidateUtil.isLength(gsaPaymentSituation,Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isFloat(gsaPlanOutWeight)){
			return false;
		}
		if(ValidateUtil.isEmpty(gsaWId) || !ValidateUtil.isInt(gsaWId)){
			return false;
		}
		if(!ValidateUtil.isFloat(gsaCurrentWeight)){
			return false;
		}
		if(!ValidateUtil.isLength(gsaApplyPerson,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(gsaApplyDepartment) || !ValidateUtil.isInt(gsaApplyDepartment)){
			return false;
		}
		if(!ValidateUtil.isLength(gsaTransferTools,Constant.INT_64)){
			return false;
		}
		if(!ValidateUtil.isLength(gsaProcess,Constant.INT_32)){
			return false;
		}
		
		return true;
	}
}
