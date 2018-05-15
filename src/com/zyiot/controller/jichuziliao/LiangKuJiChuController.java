package com.zyiot.controller.jichuziliao;

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
import com.zyiot.entity.jichuziliao.LiangKuJiChuFormMap;
import com.zyiot.server.jichuziliao.LiangKuJiChuServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;
@Controller
@RequestMapping("liangkujichu")
public class LiangKuJiChuController extends BaseController {
	Logger log = Logger.getLogger(LiangKuJiChuController.class);
	@Autowired
	private LiangKuJiChuServiceI liangKuJiChuService;
	@RequestMapping("listUI")
	public String listUI(){
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/liangkujichulist";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<LiangKuJiChuFormMap> findByPage(int page, int rows) {
		LiangKuJiChuFormMap liangKuJiChuFormMap =getFormMap(LiangKuJiChuFormMap.class);
		List<LiangKuJiChuFormMap> list = liangKuJiChuService.findByPage(liangKuJiChuFormMap, rows, page);
		return toMyPage(list);
	}
	
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/liangkujichuadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		LiangKuJiChuFormMap liangKuJiChuFormMap = getFormMap(LiangKuJiChuFormMap.class);
		if(!validData(liangKuJiChuFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(liangKuJiChuFormMap);
		} catch (Exception e) {
			log.error("==Class:LiangKuJiChuController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			liangKuJiChuFormMap.set("wlaDataOperator", session.getAttribute("userSessionId"));
			liangKuJiChuService.addLiangKuJiChu(liangKuJiChuFormMap);
		} catch (Exception e) {
			log.error("==Class:LiangKuJiChuController==Method:addLiangKuJiChu=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		LiangKuJiChuFormMap liangKuJiChuFormMap = liangKuJiChuService.findLiangKuJiChuById(Integer.parseInt(getPara("id")));
		model.addAttribute("liangKuJiChuFormMap", liangKuJiChuFormMap);
		
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/liangkujichuedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		LiangKuJiChuFormMap liangKuJiChuFormMap = getFormMap(LiangKuJiChuFormMap.class);
		if(!validData(liangKuJiChuFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(liangKuJiChuFormMap);
		} catch (Exception e) {
			log.error("==Class:LiangKuJiChuController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			liangKuJiChuService.editLiangKuJiChu(liangKuJiChuFormMap);
		} catch (Exception e) {
			log.error("==Class:LiangKuJiChuController==Method:editLiangKuJiChu=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		try {
			liangKuJiChuService.dropLiangKuJiChu(getPara("id"));
		} catch (Exception e) {
			log.error("==Class:LiangKuJiChuController==Method:dropLiangKuJiChu=="+e);
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
		String wlaNo = formMap.getStr("wlaNo");
		String wlaGovernor = formMap.getStr("wlaGovernor");
		String wlaPhoneNumber = formMap.getStr("wlaPhoneNumber");
		String wlaCapacity = formMap.getStr("wlaCapacity");
		String wlaFloorSpace = formMap.getStr("wlaFloorSpace");
		String wlaPersonNumber = formMap.getStr("wlaPersonNumber");
		String wlaPrivince = formMap.getStr("wlaPrivince");
		String wlaCity = formMap.getStr("wlaCity");
		String wlaAddress = formMap.getStr("wlaAddress");
		String wlaCounty = formMap.getStr("wlaCounty");
		String wlaOrganization = formMap.getStr("wlaOrganization");
		String wlaAdministrativeCode = formMap.getStr("wlaAdministrativeCode");
		String wlaFaxNumber = formMap.getStr("wlaFaxNumber");
		
		if(ValidateUtil.isEmpty(wlaNo) || !ValidateUtil.isLength(wlaNo,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(wlaGovernor) || !ValidateUtil.isLength(wlaGovernor,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(wlaPhoneNumber,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(wlaCapacity) || !ValidateUtil.isFloat(wlaCapacity)){
			return false;
		}
		if(ValidateUtil.isEmpty(wlaFloorSpace) || !ValidateUtil.isLength(wlaFloorSpace,Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isInt(wlaPersonNumber)){
			return false;
		}
		if(ValidateUtil.isEmpty(wlaPrivince) || !ValidateUtil.isLength(wlaPrivince,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(wlaCity) || !ValidateUtil.isLength(wlaCity,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(wlaAddress) || !ValidateUtil.isLength(wlaAddress,Constant.INT_256)){
			return false;
		}
		if(ValidateUtil.isEmpty(wlaCounty) || !ValidateUtil.isLength(wlaCounty,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(wlaOrganization,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(wlaAdministrativeCode,Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(wlaFaxNumber,Constant.INT_16)){
			return false;
		}
		return true;
	}
}
