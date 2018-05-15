package com.zyiot.controller.fuwupingtai;

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
import com.zyiot.entity.fuwupingtai.XinXiFaBuFormMap;
import com.zyiot.server.fuwupingtai.XinXiFaBuServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("xinxifabu")
public class XinXiFaBuController extends BaseController {
	Logger log = Logger.getLogger(XinXiFaBuController.class);
	
	@Autowired
	private XinXiFaBuServerI xinXiFaBuServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/xinxifabulist";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<XinXiFaBuFormMap> findByPage(int page, int rows) {
		XinXiFaBuFormMap xinXiFaBuFormMap =getFormMap(XinXiFaBuFormMap.class);
		List<XinXiFaBuFormMap> list = xinXiFaBuServer.findByPage(xinXiFaBuFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(XinXiFaBuFormMap yj:list){
				Date date = yj.getDate("irAddDate");
				yj.set("irAddDate", DateUtils.dateFormatToShort(date));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save= true)
	public String addUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/xinxifabuadd";
	}
	
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		XinXiFaBuFormMap xinXiFaBuFormMap = getFormMap(XinXiFaBuFormMap.class);
		if(!validData(xinXiFaBuFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(xinXiFaBuFormMap);
		} catch (Exception e) {
			log.error("===Class:XinXiFaBuController==Method:toADDFormMap==="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			xinXiFaBuFormMap.set("irDataOperator", session.getAttribute("userSessionId"));
			xinXiFaBuFormMap.set("irAddDate", new Timestamp(System.currentTimeMillis()));
			
			xinXiFaBuServer.addXinXiFaBu(xinXiFaBuFormMap);
		} catch (Exception e) {
			log.error("===Class:XinXiFaBuController==Method:toADDFormMap==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		try {
			XinXiFaBuFormMap xinXiFaBuFormMap = xinXiFaBuServer.findXinXiFaBuById(Integer.parseInt(getPara("id")));
			model.addAttribute("xinXiFaBuFormMap", xinXiFaBuFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:XinXiFaBuController==Method:Integer.parseInt==="+e);
		} catch (Exception e) {
			log.error("===Class:XinXiFaBuController==Method:findXinXiFaBuById==="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/xinxifabuedit";
	}
	@ResponseBody
	@RequestMapping("edit")
	@Token(remove=true)
	public String edit(){
		XinXiFaBuFormMap xinXiFaBuFormMap = getFormMap(XinXiFaBuFormMap.class);
		if(!validData(xinXiFaBuFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(xinXiFaBuFormMap);
		} catch (Exception e) {
			log.error("===Class:XinXiFaBuController==Method:toUPDATEFormMap==="+e);
			return ERROR;
		}
		
		try {
			xinXiFaBuServer.editXinXiFaBu(xinXiFaBuFormMap);
		} catch (Exception e) {
			log.error("===Class:XinXiFaBuController==Method:editXinXiFaBu==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("lookUI")
	public String lookUI(Model model){
		try {
			XinXiFaBuFormMap xinXiFaBuFormMap = xinXiFaBuServer.lookXinXiFaBuById(Integer.parseInt(getPara("id")));
			Date date = xinXiFaBuFormMap.getDate("irAddDate");
			xinXiFaBuFormMap.set("irAddDate", DateUtils.dateFormatToShort(date));
			model.addAttribute("xinXiFaBuFormMap", xinXiFaBuFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:XinXiFaBuController==Method:Integer.parseInt==="+e);
		} catch (Exception e) {
			log.error("===Class:XinXiFaBuController==Method:findXinXiFaBuById==="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/xinxifabulook";
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		
		try {
			xinXiFaBuServer.dropXinXiFaBu(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:XinXiFaBuController==Method:dropXinXiFaBu==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("up")
	@ResponseBody
	public String up(){
		return changeLevel(getPara("id"),1);
	}
	@RequestMapping("down")
	@ResponseBody
	public String down(){
		return changeLevel(getPara("id"),0);
	}
	/**
	 * 改变信息显示的顺序
	 * @param id  编号
	 * @param level  显示顺利
	 * @return
	 */
	private String changeLevel(String id,int level){
		XinXiFaBuFormMap xinXiFaBuFormMap;
		XinXiFaBuFormMap xinXiFaBuFormMap2 = new XinXiFaBuFormMap();
		try {
			xinXiFaBuFormMap = xinXiFaBuServer.findXinXiFaBuById(Integer.parseInt(id));
		} catch (NumberFormatException e) {
			log.error("===Class:XinXiFaBuController==Method:Integer.parseInt==="+e);
			return ERROR;
		} catch (Exception e) {
			log.error("===Class:XinXiFaBuController==Method:findXinXiFaBuById==="+e);
			return ERROR;
		}
		
		xinXiFaBuFormMap2.set("id", String.valueOf(xinXiFaBuFormMap.getInt("id")));
		xinXiFaBuFormMap2.set(Constant.VERSION, String.valueOf(xinXiFaBuFormMap.getInt(Constant.VERSION)));
		xinXiFaBuFormMap2.set("irLevel", level);
		
		try {
			FormMapUtil.toUPDATEFormMap(xinXiFaBuFormMap2);
		} catch (Exception e) {
			log.error("===Class:XinXiFaBuController==Method:toUPDATEFormMap==="+e);
			return ERROR;
		}
		
		try {
			xinXiFaBuServer.editXinXiFaBu(xinXiFaBuFormMap2);
		} catch (Exception e) {
			log.error("===Class:XinXiFaBuController==Method:editXinXiFaBu==="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	
	
	@RequestMapping(value="findXinXiType",produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<FormMap<String,Object>> findXinXiType(){
		
		return xinXiFaBuServer.findXinXiType();
	}
	
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String irType = formMap.getStr("irType");
		String irTitle = formMap.getStr("irTitle");
		String irContent = formMap.getStr("irContent");
		
		if(ValidateUtil.isEmpty(irType) || !ValidateUtil.isInt(irType)){
			return false;
		}
		if(ValidateUtil.isEmpty(irTitle) || !ValidateUtil.isLength(irTitle,Constant.INT_128)){
			return false;
		}
		if(ValidateUtil.isEmpty(irContent)){
			return false;
		}

		return true;
	}
}
