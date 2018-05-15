package com.zyiot.controller.yaojiguanli;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import com.zyiot.entity.UserFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiShenQingFormMap;
import com.zyiot.server.yaojiguanli.YaoJiShenQingServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("yaojilingyongshenqing")
public class YaoJiShenQingController extends BaseController {
	Logger log = Logger.getLogger(YaoJiShenQingController.class);
	@Autowired
	private YaoJiShenQingServiceI yaoJiShenQingService;
	
	
	
	DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/yaojishenqinglist";
	}
	@RequestMapping("/findByPage")
	@ResponseBody
	public MyPage<YaoJiShenQingFormMap> findByPage(int page, int rows){
		YaoJiShenQingFormMap yaoJiShenQingFormMap = getFormMap(YaoJiShenQingFormMap.class);
		List<YaoJiShenQingFormMap> list = yaoJiShenQingService.findByPage(yaoJiShenQingFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(YaoJiShenQingFormMap yj:list){
				Date date = yj.getDate("maApplyDate");
				yj.set("maApplyDate", sdf.format(date));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/yaojishenqingadd";
	}
	/**
	 * 保存
	 * @return
	 */
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		YaoJiShenQingFormMap yaoJiShenQingFormMap = getFormMap(YaoJiShenQingFormMap.class);
		if(!validData(yaoJiShenQingFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(yaoJiShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenQingController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			yaoJiShenQingFormMap.set("maProcess", Constant.STATUS_SAVE);
			yaoJiShenQingService.addYaoJiShenQing(yaoJiShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenQingController==Method:addYaoJiSHenQing=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 直接 提交审批
	 * @return
	 */
	@RequestMapping("approve")
	@ResponseBody
	@Token(remove=true)
	public String approve(){
		YaoJiShenQingFormMap yaoJiShenQingFormMap = getFormMap(YaoJiShenQingFormMap.class);
		if(!validData(yaoJiShenQingFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(yaoJiShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenQingController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			yaoJiShenQingFormMap.set("maProcess", Constant.STATUS_APPROVE);
			yaoJiShenQingService.addYaoJiShenQing(yaoJiShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenQingController==Method:addYaoJiSHenQing=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 由保存 提交审批
	 * @return
	 */
	@RequestMapping("approveById")
	@ResponseBody
	public String approveById(){
		String id = getPara("id");
		
		YaoJiShenQingFormMap yaoJiShenQingFormMap = new YaoJiShenQingFormMap();
		try {
			FormMapUtil.toUPDATEFormMap(yaoJiShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenQingController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			yaoJiShenQingFormMap.set("maProcess", Constant.STATUS_APPROVE);
			yaoJiShenQingFormMap.set("id", id);
			yaoJiShenQingService.approveYaoJiShenQing(yaoJiShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenQingController==Method:editYaoJiSHenQing=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		String id = getPara("id");
		YaoJiShenQingFormMap yaoJiShenQingFormMap =yaoJiShenQingService.findYaoJiShenQingById(Integer.parseInt(id));
		model.addAttribute("yaoJiShenQingFormMap", yaoJiShenQingFormMap);
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/yaojishenqingedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		YaoJiShenQingFormMap yaoJiShenQingFormMap = getFormMap(YaoJiShenQingFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(yaoJiShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenQingController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		try {
			if(yaoJiShenQingFormMap.getStr("maProcess").equals("2")){
				yaoJiShenQingFormMap.set("maProcess", Constant.STATUS_APPROVE);
			}else{
				yaoJiShenQingFormMap.set("maProcess", Constant.STATUS_SAVE);
			}
			
			yaoJiShenQingService.editYaoJiShenQing(yaoJiShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenQingController==Method:editYaoJiShenQing=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		
		try {
			yaoJiShenQingService.dropYaoJiShenQing(id);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenQingController==Method:dropYaoJiShenQing=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	/**
	 * 根据id获取药剂信息--用于打印页面
	 * @return
	 */
	@RequestMapping("findYaoJiShenQingById")
	@ResponseBody
	public YaoJiShenQingFormMap findYaoJiShenQingById(){
		String id = getPara("bId");
		YaoJiShenQingFormMap yaoJiShenQingFormMap = yaoJiShenQingService.findYaoJiShenQingById(Integer.parseInt(id));
		String process = yaoJiShenQingFormMap.getStr("maProcess");
		if(process.equals("审批通过")){
			Session session = SecurityUtils.getSubject().getSession();
			UserFormMap userFormMap = (UserFormMap) session.getAttribute("userSession");
			yaoJiShenQingFormMap.set("departmentName", userFormMap.getStr("department"));
			Calendar calendar = Calendar.getInstance();
			yaoJiShenQingFormMap.set("year", calendar.get(Calendar.YEAR));
			yaoJiShenQingFormMap.set("month", calendar.get(Calendar.MONTH)+1);
			yaoJiShenQingFormMap.set("day", calendar.get(Calendar.DAY_OF_MONTH));		
			return yaoJiShenQingFormMap;
		}else{
			return null;
		}
	}
	
	
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String maQuantity = formMap.getStr("maQuantity");
		String maApplicant = formMap.getStr("maApplicant");
		String maUsed = formMap.getStr("maUsed");
		
		if(ValidateUtil.isEmpty(maQuantity) || !ValidateUtil.isInt(maQuantity)){
			return false;
		}
		if(ValidateUtil.isEmpty(maApplicant) || !ValidateUtil.isLength(maApplicant,Constant.INT_64)){
			return false;
		}
		if(!ValidateUtil.isLength(maUsed,Constant.INT_256)){
			return false;
		}
		
		return true;
	}
}
