package com.zyiot.controller.chuliangguanli;

import java.sql.Timestamp;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.cunchuguanli.CangFangWeiXiuFormMap;
import com.zyiot.server.cunchuguanli.CangFangWeiXiuServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("cangfangweixiu")
public class CangFangWeiXiuController extends BaseController {
	Logger log = Logger.getLogger(CangFangWeiXiuController.class);
	@Autowired
	private CangFangWeiXiuServerI cangFangWeiXiuServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/cunchuguanli/cangkuguanli/cangfangweixiulist";
	}
	 
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<CangFangWeiXiuFormMap> findByPage(int page, int rows) {
		CangFangWeiXiuFormMap cangFangWeiXiuFormMap =getFormMap(CangFangWeiXiuFormMap.class);
		List<CangFangWeiXiuFormMap> list = cangFangWeiXiuServer.findByPage(cangFangWeiXiuFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(CangFangWeiXiuFormMap cf:list){
				cf.set("wrDate", DateUtils.dateFormatToShort(cf.getDate("wrDate")));
				cf.set("wrAddDate", DateUtils.dateFormatToShort(cf.getDate("wrAddDate")));
			}
		}
		return toMyPage(list);
	}
	
	
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUi(){
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/cunchuguanli/cangkuguanli/cangfangweixiuadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		CangFangWeiXiuFormMap cangFangWeiXiuFormMap = getFormMap(CangFangWeiXiuFormMap.class);
		if(!validData(cangFangWeiXiuFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(cangFangWeiXiuFormMap);
		} catch (Exception e) {
			log.error("===Class:CangFangWeiXiuController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			cangFangWeiXiuFormMap.set("wrOperator", session.getAttribute("userSessionId"));
			cangFangWeiXiuFormMap.set("wrAddDate", new Timestamp(System.currentTimeMillis()));
			cangFangWeiXiuServer.addCangFangWeiXiu(cangFangWeiXiuFormMap);
		} catch (Exception e) {
			log.error("===Class:CangFangWeiXiuController==Method:addCangFangWeiXiu=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		String id = getPara("id");
		try {
			CangFangWeiXiuFormMap cangFangWeiXiuFormMap = cangFangWeiXiuServer.findCangFangWeiXiuById(Integer.parseInt(id));
			cangFangWeiXiuFormMap.set("wrDate", DateUtils.dateFormatToShort(cangFangWeiXiuFormMap.getDate("wrDate")));
			cangFangWeiXiuFormMap.set("wrMaturity", DateUtils.dateFormatToShort(cangFangWeiXiuFormMap.getDate("wrMaturity")));
			model.addAttribute("cangFangWeiXiuFormMap", cangFangWeiXiuFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:CangFangWeiXiuController==Method:Integer.parseInt=="+e);
			return ERROR;
		} catch (Exception e) {
			log.error("===Class:CangFangWeiXiuController==Method:findCangFangWeiXiuById=="+e);
			return ERROR;
		}
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/cunchuguanli/cangkuguanli/cangfangweixiuedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		CangFangWeiXiuFormMap cangFangWeiXiuFormMap = getFormMap(CangFangWeiXiuFormMap.class);
		if(!validData(cangFangWeiXiuFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(cangFangWeiXiuFormMap);
		} catch (Exception e) {
			log.error("===Class:CangFangWeiXiuController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			cangFangWeiXiuServer.editCangFangWeiXiu(cangFangWeiXiuFormMap);
		} catch (Exception e) {
			log.error("===Class:CangFangWeiXiuController==Method:editCangFangWeiXiu=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		
		try {
			cangFangWeiXiuServer.dropCangFangWeiXiu(id);
		} catch (Exception e) {
			log.error("===Class:CangFangWeiXiuController==Method:dropCangFangWeiXiu=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String wrDate = formMap.getStr("wrDate");
		String wrWarranty = formMap.getStr("wrWarranty");
		String wrMaturity = formMap.getStr("wrMaturity");
		String wrContent = formMap.getStr("wrContent");
		String wrSummary = formMap.getStr("wrSummary");
		String wrEffect = formMap.getStr("wrEffect");
		
		if(!ValidateUtil.isShortDate(wrDate)){
			return false;
		}
		if(!ValidateUtil.isInt(wrWarranty)){
			return false;
		}
		if(!ValidateUtil.isShortDate(wrMaturity)){
			return false;
		}
		if(!ValidateUtil.isLength(wrContent,Constant.INT_256)){
			return false;
		}
		if(!ValidateUtil.isLength(wrSummary,Constant.INT_256)){
			return false;
		}
		if(!ValidateUtil.isLength(wrEffect,Constant.INT_256)){
			return false;
		}
		return true;
	}
}
