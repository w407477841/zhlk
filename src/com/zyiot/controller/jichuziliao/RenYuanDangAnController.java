package com.zyiot.controller.jichuziliao;

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
import com.zyiot.entity.jichuziliao.RenYuanDangAnFormMap;
import com.zyiot.server.jichuziliao.RenYuanDangAnServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;
@Controller
@RequestMapping("renyuandangan")
public class RenYuanDangAnController extends BaseController {
	Logger log = Logger.getLogger(RenYuanDangAnController.class);
	@Autowired
	private RenYuanDangAnServiceI renYuanDangAnService;
	@RequestMapping("listUI")
	public String listUI(){
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/renyuandanganlist";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<RenYuanDangAnFormMap> findByPage(int page, int rows) {
		
		RenYuanDangAnFormMap renYuanDangAnFormMap =getFormMap(RenYuanDangAnFormMap.class);
		List<RenYuanDangAnFormMap> list = renYuanDangAnService.findByPage(renYuanDangAnFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(RenYuanDangAnFormMap yj:list){
				Date date = yj.getDate("paBirthday");
				if(date != null){
					yj.set("paBirthday", DateUtils.dateFormatToShort(date));
				}
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/renyuandanganadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		
		RenYuanDangAnFormMap renYuanDangAnFormMap = getFormMap(RenYuanDangAnFormMap.class);
		if(!validData(renYuanDangAnFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(renYuanDangAnFormMap);
		} catch (Exception e) {
			log.error("===Class:RenYuanDangAnController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			renYuanDangAnFormMap.set("paDataOperator",session.getAttribute("userSessionId"));
			renYuanDangAnService.addRenYuanDangAn(renYuanDangAnFormMap);
		} catch (Exception e) {
			log.error("===Class:RenYuanDangAnController==Method:addRenYuanDangAn=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		
		RenYuanDangAnFormMap renYuanDangAnFormMap = renYuanDangAnService.findRenYuanDangAnById(Integer.parseInt(getPara("id")));
		Date birth = renYuanDangAnFormMap.getDate("paBirthday");
		if(birth!=null){
			renYuanDangAnFormMap.set("paBirthday", DateUtils.dateFormatToShort(birth));
		}
		model.addAttribute("renYuanDangAnFormMap", renYuanDangAnFormMap);
		
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/renyuandanganedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		RenYuanDangAnFormMap renYuanDangAnFormMap = getFormMap(RenYuanDangAnFormMap.class);
		if(!validData(renYuanDangAnFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(renYuanDangAnFormMap);
		} catch (Exception e) {
			log.error("===Class:RenYuanDangAnController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			renYuanDangAnService.editRenYuanDangAn(renYuanDangAnFormMap);
		} catch (Exception e) {
			log.error("===Class:RenYuanDangAnController==Method:editRenYuanDangAn=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		try {
			renYuanDangAnService.dropRenYuanDangAn(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:RenYuanDangAnController==Method:dropRenYuanDangAn=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("findRenYuanDangAn")
	@ResponseBody
	public List<RenYuanDangAnFormMap> findAllRenYuanDangAn(){
		RenYuanDangAnFormMap renYuanDangAnFormMap = new RenYuanDangAnFormMap();
		
		try {
			FormMapUtil.toADDFormMap(renYuanDangAnFormMap);
		} catch (Exception e) {
			log.error("===Class:RenYuanDangAnController==Method:dropRenYuanDangAn=="+e);
			return null;
		}
		return renYuanDangAnService.findByAttr(renYuanDangAnFormMap);
	}
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String paName = formMap.getStr("paName");
		String paTelephone = formMap.getStr("paTelephone");
		String paEmail = formMap.getStr("paEmail");
		String paOfficePhone = formMap.getStr("paOfficePhone");
		String paNation = formMap.getStr("paNation");
		String paQQ = formMap.getStr("paQQ");
		String paBirthday = formMap.getStr("paBirthday");
		String paDegree = formMap.getStr("paDegree");
		String paHealth = formMap.getStr("paHealth");
		String paWorkLicence = formMap.getStr("paWorkLicence");
		String paDepartment = formMap.getStr("paDepartment");
		String paDuty = formMap.getStr("paDuty");
		
		if(ValidateUtil.isEmpty(paName) || !ValidateUtil.isLength(paName,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(paTelephone) || !ValidateUtil.isLength(paTelephone,Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(paEmail,Constant.INT_64)){
			return false;
		}
		if(!ValidateUtil.isLength(paOfficePhone,Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(paNation,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(paQQ,Constant.INT_12)){
			return false;
		}
		if(!ValidateUtil.isShortDate(paBirthday)){
			return false;
		}
		if(!ValidateUtil.isLength(paDegree,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(paHealth,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(paWorkLicence,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(paDepartment,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(paDuty,Constant.INT_32)){
			return false;
		}
		
		return true;
	}
}
