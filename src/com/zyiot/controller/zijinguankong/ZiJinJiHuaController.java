package com.zyiot.controller.zijinguankong;

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
import com.zyiot.entity.zijinguankong.ZiJinJiHuaFormMap;
import com.zyiot.server.zijinguankong.ZiJinJiHuaServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("zijinjihua")
public class ZiJinJiHuaController extends BaseController {
	Logger log = Logger.getLogger(ZiJinJiHuaController.class);
	@Autowired
	private ZiJinJiHuaServiceI ziJinJiHuaService;
	@RequestMapping("listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/zijinguankong/zijinjihualist";
	}
	
	@Token(save=true)
	@RequestMapping("addUI")
	public String addUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/zijinguankong/zijinjihuaadd";
	}
	
	@Token(remove=true)
	@RequestMapping("add")
	@ResponseBody
	public String add(){
		ZiJinJiHuaFormMap ziJinJiHuaFormMap = getFormMap(ZiJinJiHuaFormMap.class);
		if(!validData(ziJinJiHuaFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(ziJinJiHuaFormMap);
		} catch (Exception e) {
			log.error("===Class:ZiJinJiHuaController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		try {
			Session session = SecurityUtils.getSubject().getSession();
			ziJinJiHuaFormMap.set("bpBill", DateUtils.dateToString(new Date()));
			ziJinJiHuaFormMap.set("bpDataOperator", session.getAttribute("userSessionId"));
			ziJinJiHuaService.addZiJinJiHua(ziJinJiHuaFormMap);
		} catch (Exception e) {
			log.error("===Class:ZiJinJiHuaController==Method:addZiJinJiHua=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<ZiJinJiHuaFormMap> findByPage(int page, int rows){
		
		ZiJinJiHuaFormMap ziJinJiHuaFormMap =getFormMap(ZiJinJiHuaFormMap.class);
		List<ZiJinJiHuaFormMap> list = ziJinJiHuaService.findByPage(ziJinJiHuaFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(ZiJinJiHuaFormMap yj:list){
				Date date = yj.getDate("bpGrandDate");
				yj.set("bpGrandDate", DateUtils.dateFormatToShort(date));
			}
		}
		return toMyPage(list);
	}
	
	@Token(save=true)
	@RequestMapping("editUI")
	public String editUI(Model model){
		ZiJinJiHuaFormMap ziJinJiHuaFormMap = ziJinJiHuaService.findZiJinJiHuaById(Integer.parseInt(getPara("id")));
		ziJinJiHuaFormMap.set("bpGrandDate", DateUtils.dateFormatToShort(ziJinJiHuaFormMap.getDate("bpGrandDate")));
		model.addAttribute("ziJinJiHuaFormMap", ziJinJiHuaFormMap);
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/zijinguankong/zijinjihuaedit";
	}
	@Token(remove=true)
	@RequestMapping("edit")
	@ResponseBody
	public String edit(){
		ZiJinJiHuaFormMap ziJinJiHuaFormMap =getFormMap(ZiJinJiHuaFormMap.class);
		if(!validData(ziJinJiHuaFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(ziJinJiHuaFormMap);
		} catch (Exception e) {
			log.error("===Class:ZiJinJiHuaController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			ziJinJiHuaService.editZiJinJiHua(ziJinJiHuaFormMap);
		} catch (Exception e) {
			log.error("===Class:ZiJinJiHuaController==Method:editZiJinJiHua=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		try {
			ziJinJiHuaService.dropZiJinJiHua(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:ZiJinJiHuaController==Method:dropZiJinJiHua=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("findAllZiJinJiHua")
	@ResponseBody
	public List<ZiJinJiHuaFormMap> findAllZiJinJiHua(){
		return ziJinJiHuaService.findAllZiJinJiHua();
	}
	
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String bpGrandPerson = formMap.getStr("bpGrandPerson");
		String bpPayee = formMap.getStr("bpPayee");
		String bpAccount = formMap.getStr("bpAccount");
		String bpUse = formMap.getStr("bpUse");
		String bpLowerMoney = formMap.getStr("bpLowerMoney");
		String bpGrandDate = formMap.getStr("bpGrandDate");
		
		if(ValidateUtil.isEmpty(bpGrandPerson) || !ValidateUtil.isLength(bpGrandPerson,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(bpPayee) || !ValidateUtil.isLength(bpPayee,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(bpAccount) || !ValidateUtil.isLength(bpAccount,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(bpUse,Constant.INT_128)){
			return false;
		}
		if(!ValidateUtil.isInt(bpLowerMoney)){
			return false;
		}
		if(!ValidateUtil.isShortDate(bpGrandDate)){
			return false;
		}

		return true;
	}
}
