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
import com.zyiot.entity.fuwupingtai.ZhengCeChaXunFormMap;
import com.zyiot.server.fuwupingtai.ZhengCeChaXunServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("zhengcechaxun")
public class ZhengCeChaXunController extends BaseController {
	Logger log = Logger.getLogger(ZhengCeChaXunController.class);
	@Autowired
	private ZhengCeChaXunServerI zhengCeChaXunServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/zhengcechaxunlist";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<ZhengCeChaXunFormMap> findByPage(int page, int rows) {
		ZhengCeChaXunFormMap zhengCeChaXunFormMap =getFormMap(ZhengCeChaXunFormMap.class);
		List<ZhengCeChaXunFormMap> list = zhengCeChaXunServer.findByPage(zhengCeChaXunFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(ZhengCeChaXunFormMap yj:list){
				Date date = yj.getDate("pqAddDate");
				yj.set("pqAddDate", DateUtils.dateFormatToShort(date));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/zhengcechaxunadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		ZhengCeChaXunFormMap zhengCeChaXunFormMap =getFormMap(ZhengCeChaXunFormMap.class);
		if(!validData(zhengCeChaXunFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(zhengCeChaXunFormMap);
		} catch (Exception e) {
			log.error("===Class:ZhengCeChaXunController===Method:toADDFormMap==="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			zhengCeChaXunFormMap.set("pqDataOperator", session.getAttribute("userSessionId"));
			zhengCeChaXunFormMap.set("pqAddDate", new Timestamp(System.currentTimeMillis()));
			
			zhengCeChaXunServer.addZhengCeChaXun(zhengCeChaXunFormMap);
		} catch (Exception e) {
			log.error("===Class:ZhengCeChaXunController===Method:addZhengCeChaXun==="+e);
			return ERROR;
		}
		
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		
		try {
			ZhengCeChaXunFormMap zhengCeChaXunFormMap = zhengCeChaXunServer.findZhengCeChaXunById(Integer.parseInt(getPara("id")));
			model.addAttribute("zhengCeChaXunFormMap", zhengCeChaXunFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:ZhengCeChaXunController===Method:Integer.parseInt==="+e);
		} catch (Exception e) {
			log.error("===Class:ZhengCeChaXunController===Method:findZhengCeChaXunById==="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/zhengcechaxunedit";
	}
	
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		ZhengCeChaXunFormMap zhengCeChaXunFormMap =getFormMap(ZhengCeChaXunFormMap.class);
		if(!validData(zhengCeChaXunFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(zhengCeChaXunFormMap);
		} catch (Exception e) {
			log.error("===Class:ZhengCeChaXunController===Method:toUPDATEFormMap==="+e);
			return ERROR;
		}
		
		try {
			zhengCeChaXunServer.editZhengCeChaXun(zhengCeChaXunFormMap);
		} catch (Exception e) {
			log.error("===Class:ZhengCeChaXunController===Method:editZhengCeChaXun==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		
		try {
			zhengCeChaXunServer.dropZhengCeChaXun(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:ZhengCeChaXunController===Method:dropZhengCeChaXun==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("lookUI")
	public String lookUI(Model model){
		
		try {
			ZhengCeChaXunFormMap zhengCeChaXunFormMap = zhengCeChaXunServer.lookZhengCeChaXunById(Integer.parseInt(getPara("id")));
			Date date = zhengCeChaXunFormMap.getDate("pqAddDate");
			zhengCeChaXunFormMap.set("pqAddDate", DateUtils.dateFormatToShort(date));
			model.addAttribute("zhengCeChaXunFormMap", zhengCeChaXunFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:ZhengCeChaXunController===Method:Integer.parseInt==="+e);
		} catch (Exception e) {
			log.error("===Class:ZhengCeChaXunController===Method:findZhengCeChaXunById==="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/zhengcechaxunlook";
	}
	@RequestMapping(value="findZhengCeType",produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<FormMap<String,Object>> findZhengCeType(){
		
		return zhengCeChaXunServer.findZhengCeType();
	}
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String pqType = formMap.getStr("pqType");
		String pqTitle = formMap.getStr("pqTitle");
		String pqContent = formMap.getStr("pqContent");
		
		if(ValidateUtil.isEmpty(pqType) || !ValidateUtil.isInt(pqType)){
			return false;
		}
		if(ValidateUtil.isEmpty(pqTitle) || !ValidateUtil.isLength(pqTitle,Constant.INT_128)){
			return false;
		}
		if(ValidateUtil.isEmpty(pqContent)){
			return false;
		}

		return true;
	}
	
}
