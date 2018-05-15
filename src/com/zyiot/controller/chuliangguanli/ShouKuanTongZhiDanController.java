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
import com.zyiot.entity.cunchuguanli.ShouKuanTongZhiDanFormMap;
import com.zyiot.server.cunchuguanli.ShouKuanTongZhiDanServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("shoukuantongzhidan")
public class ShouKuanTongZhiDanController extends BaseController {
	Logger log = Logger.getLogger(ShouKuanTongZhiDanController.class);
	@Autowired
	private ShouKuanTongZhiDanServerI shouKuanTongZhiDanServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/danjuguanli/shoukuantongzhidan";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<ShouKuanTongZhiDanFormMap> findByPage(int page, int rows) {
		ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap = getFormMap(ShouKuanTongZhiDanFormMap.class);
		List<ShouKuanTongZhiDanFormMap> list = shouKuanTongZhiDanServer.findByPage(shouKuanTongZhiDanFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(ShouKuanTongZhiDanFormMap cf:list){
				cf.set("cnMoneyDate", DateUtils.dateFormatToShort(cf.getDate("cnMoneyDate")));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/danjuguanli/shoukuantongzhidanadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap = getFormMap(ShouKuanTongZhiDanFormMap.class);
		if(!validData(shouKuanTongZhiDanFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(shouKuanTongZhiDanFormMap);
		} catch (Exception e) {
			log.error("===Class:ShouKuanTongZhiDanController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			shouKuanTongZhiDanFormMap.set("cnDataOperator", session.getAttribute("userSessionId"));
			shouKuanTongZhiDanFormMap.set("cnAddDate", new Timestamp(System.currentTimeMillis()));
			
			shouKuanTongZhiDanServer.addShouKuanTongZhiDan(shouKuanTongZhiDanFormMap);
		} catch (Exception e) {
			log.error("===Class:ShouKuanTongZhiDanController==Method:addShouKuanTongZhiDan=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		try {
			ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap = shouKuanTongZhiDanServer.findShouKuanTongZhiDanById(Integer.parseInt(getPara("id")));
			shouKuanTongZhiDanFormMap.set("cnMoneyDate", DateUtils.dateFormatToShort(shouKuanTongZhiDanFormMap.getDate("cnMoneyDate")));
			model.addAttribute("shouKuanTongZhiDanFormMap",shouKuanTongZhiDanFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:ShouKuanTongZhiDanController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("===Class:ShouKuanTongZhiDanController==Method:findShouKuanTongZhiDanById=="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/danjuguanli/shoukuantongzhidanedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap = getFormMap(ShouKuanTongZhiDanFormMap.class);
		if(!validData(shouKuanTongZhiDanFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(shouKuanTongZhiDanFormMap);
		} catch (Exception e) {
			log.error("===Class:ShouKuanTongZhiDanController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			shouKuanTongZhiDanServer.editShouKuanTongZhiDan(shouKuanTongZhiDanFormMap);
		} catch (Exception e) {
			log.error("===Class:ShouKuanTongZhiDanController==Method:editShouKuanTongZhiDan=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		try {
			shouKuanTongZhiDanServer.dropShouKuanTongZhiDan(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:ShouKuanTongZhiDanController==Method:dropShouKuanTongZhiDan=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("lookUI")
	@Token(save=true)
	public String lookUI(Model model){
		try {
			ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap = shouKuanTongZhiDanServer.lookShouKuanTongZhiDanById(Integer.parseInt(getPara("id")));
			shouKuanTongZhiDanFormMap.set("cnMoneyDate", convertData(DateUtils.dateFormatToShort(shouKuanTongZhiDanFormMap.getDate("cnMoneyDate"))));
			shouKuanTongZhiDanFormMap.set("cnAddDate", convertData(DateUtils.dateFormatToShort(shouKuanTongZhiDanFormMap.getDate("cnAddDate"))));
			model.addAttribute("shouKuanTongZhiDanFormMap",shouKuanTongZhiDanFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:ShouKuanTongZhiDanController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("===Class:ShouKuanTongZhiDanController==Method:findShouKuanTongZhiDanById=="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/danjuguanli/shoukuantongzhidanlook";
	}
	/**
	 * yyyy-mm-dd  
	 * yyyy年mm月dd日
	 * @param datesrc
	 * @return
	 */
	private String convertData(String datesrc){
		if(datesrc!=null && datesrc.length()>0){
			String[] temp = datesrc.split("-");
			if(temp.length==3){
				return temp[0]+"年"+temp[1]+"月"+temp[2]+"日";
			}else{
				return datesrc;
			}
		}else{
			return datesrc;
			
		}
	}
	
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String cnWId = formMap.getStr("cnWId");
		String cnCustomName = formMap.getStr("cnCustomName");
		String cnYear = formMap.getStr("cnYear");
		String cnProperty = formMap.getStr("cnProperty");
		String cnVariety = formMap.getStr("cnVariety");
		String cnPayment = formMap.getStr("cnPayment");
		String cnMoneyDate = formMap.getStr("cnMoneyDate");
		
		if(ValidateUtil.isEmpty(cnWId) || !ValidateUtil.isInt(cnWId)){
			return false;
		}
		if(ValidateUtil.isEmpty(cnCustomName) || !ValidateUtil.isLength(cnCustomName,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(cnYear) || !ValidateUtil.isLength(cnYear,Constant.INT_4)){
			return false;
		}
		if(ValidateUtil.isEmpty(cnProperty) || !ValidateUtil.isInt(cnProperty)){
			return false;
		}
		
		if(ValidateUtil.isEmpty(cnVariety) || !ValidateUtil.isInt(cnVariety)){
			return false;
		}
		if(ValidateUtil.isEmpty(cnPayment) || !ValidateUtil.isFloat(cnPayment)){
			return false;
		}
		if(ValidateUtil.isEmpty(cnMoneyDate) || !ValidateUtil.isShortDate(cnMoneyDate)){
			return false;
		}
		
		return true;
	}
}
