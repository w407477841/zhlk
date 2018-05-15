package com.zyiot.controller.yaojiguanli;

import java.sql.Timestamp;
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
import com.zyiot.entity.yaojiguanli.CanZhaChuLiFormMap;
import com.zyiot.server.yaojiguanli.CanZhaChuLiServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("canzhachuli")
public class CanZhaChuLiController extends BaseController {
	Logger log = Logger.getLogger(CanZhaChuLiController.class);
	@Autowired
	private CanZhaChuLiServiceI canZhaChuLiService;
	
	@RequestMapping("listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/canzhachulilist";
	}
	
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/canzhachuliadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		
		CanZhaChuLiFormMap canZhaChuLiFormMap = getFormMap(CanZhaChuLiFormMap.class);
		if(!validData(canZhaChuLiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(canZhaChuLiFormMap);
		} catch (Exception e) {
			log.error("===Class:CanZhaChuLiController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			canZhaChuLiFormMap.set("mdOpDate", new Timestamp(System.currentTimeMillis()));
			canZhaChuLiFormMap.set("mdDataOperator", session.getAttribute("userSessionId"));
			
			canZhaChuLiService.addCanZhaChuLi(canZhaChuLiFormMap);
		} catch (Exception e) {
			log.error("===Class:CanZhaChuLiController==Method:addCanZhaChuLi=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<CanZhaChuLiFormMap> findByPage(int page, int rows){
		CanZhaChuLiFormMap canZhaChuLiFormMap =getFormMap(CanZhaChuLiFormMap.class);
		List<CanZhaChuLiFormMap> list = canZhaChuLiService.findByPage(canZhaChuLiFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(CanZhaChuLiFormMap yj:list){
				Date date = yj.getTimestamp("mdFumigateDate");
				yj.set("mdFumigateDate", DateUtils.dateFormatToShort(date));
				date = yj.getTimestamp("mdBeginDate");
				yj.set("mdBeginDate", DateUtils.dateFormatToShort(date));
			}
		}
		return toMyPage(list);
	}
	
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		String id = getPara("id");
		
		try {
			CanZhaChuLiFormMap canZhaChuLiFormMap= canZhaChuLiService.findById(Integer.parseInt(id));
			canZhaChuLiFormMap.set("mdFumigateDate", DateUtils.dateFormatToShort(canZhaChuLiFormMap.getDate("mdFumigateDate")));
			canZhaChuLiFormMap.set("mdBeginDate", DateUtils.dateFormatToShort(canZhaChuLiFormMap.getDate("mdBeginDate")));
			model.addAttribute("canZhaChuLiFormMap", canZhaChuLiFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:CanZhaChuLiController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("===Class:CanZhaChuLiController==Method:findById=="+e);
		}

		return Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/canzhachuliedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		CanZhaChuLiFormMap canZhaChuLiFormMap = getFormMap(CanZhaChuLiFormMap.class);
		if(!validData(canZhaChuLiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(canZhaChuLiFormMap);
		} catch (Exception e) {
			log.error("===Class:CanZhaChuLiController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			canZhaChuLiService.editCanZhaChuLi(canZhaChuLiFormMap);
		} catch (Exception e) {
			log.error("===Class:CanZhaChuLiController==Method:editCanZhaChuLi=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		try {
			canZhaChuLiService.dropCanZhaChuLi(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:CanZhaChuLiController==Method:dropCanZhaChuLi=="+e);
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
		String mdNumber = formMap.getStr("mdNumber");
		String mdParticipant = formMap.getStr("mdParticipant");
		String mdProcessMode = formMap.getStr("mdProcessMode");
		String mdFumigateDate = formMap.getStr("mdFumigateDate");
		String mdBeginDate = formMap.getStr("mdBeginDate");
		
		if(ValidateUtil.isEmpty(mdNumber) || !ValidateUtil.isInt(mdNumber)){
			return false;
		}
		if(ValidateUtil.isEmpty(mdParticipant) || !ValidateUtil.isLength(mdParticipant,Constant.INT_64)){
			return false;
		}
		if(ValidateUtil.isEmpty(mdProcessMode) || !ValidateUtil.isLength(mdProcessMode,Constant.INT_128)){
			return false;
		}
		if(!ValidateUtil.isShortDate(mdFumigateDate)){
			return false;
		}
		if(!ValidateUtil.isShortDate(mdBeginDate)){
			return false;
		}
		
		return true;
	}
}
