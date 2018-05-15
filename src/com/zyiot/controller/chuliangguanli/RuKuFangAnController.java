package com.zyiot.controller.chuliangguanli;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
import com.zyiot.entity.cunchuguanli.RuKuFangAnFormMap;
import com.zyiot.server.cunchuguanli.RuKuFangAnServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;
/**
 * 入库方案
 * @author Lip
 *
 */
@Controller
@RequestMapping("rukufangan")
public class RuKuFangAnController extends BaseController {
	Logger log = Logger.getLogger(RuKuFangAnController.class);
	
	@Autowired
	private RuKuFangAnServerI ruKuFangAnServer;

	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/churukufangan/rukufangan";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<RuKuFangAnFormMap> findByPage(int page, int rows) {
		RuKuFangAnFormMap ruKuFangAnFormMap = getFormMap(RuKuFangAnFormMap.class);
		List<RuKuFangAnFormMap> list = ruKuFangAnServer.findByPage(ruKuFangAnFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(RuKuFangAnFormMap cf:list){
				cf.set("pspBeginDate", DateUtils.dateFormatToShort(cf.getDate("pspBeginDate")));
				cf.set("pspEndDate", DateUtils.dateFormatToShort(cf.getDate("pspEndDate")));
				cf.set("pspAddDate", DateUtils.dateFormatToLong(cf.getDate("pspAddDate")));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/churukufangan/rukufanganadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		
		RuKuFangAnFormMap ruKuFangAnFormMap = getFormMap(RuKuFangAnFormMap.class);
		if(!validData(ruKuFangAnFormMap)){
			return ERROR;
		}
		String endTime = ruKuFangAnFormMap.getStr("pspEndDate");
		if(endTime == null || endTime.equals("")){
			return ERROR;
		}
		
		try {
			FormMapUtil.toADDFormMap(ruKuFangAnFormMap);
		} catch (Exception e) {
			log.error("==Class:RuKuFangAnController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			ruKuFangAnFormMap.set("pspDataOperator", session.getAttribute("userSessionId"));
			ruKuFangAnFormMap.set("pspAddDate", new Timestamp(System.currentTimeMillis()));
			
			ruKuFangAnServer.addRuKuFangAn(ruKuFangAnFormMap);
		} catch (Exception e) {
			log.error("==Class:RuKuFangAnController==Method:addRuKuFangAn=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		
		try {
			RuKuFangAnFormMap ruKuFangAnFormMap = ruKuFangAnServer.findRuKuFangAnById(Integer.parseInt(getPara("id")));
			ruKuFangAnFormMap.set("pspBeginDate", DateUtils.dateFormatToShort(ruKuFangAnFormMap.getDate("pspBeginDate")));
			ruKuFangAnFormMap.set("pspEndDate", DateUtils.dateFormatToShort(ruKuFangAnFormMap.getDate("pspEndDate")));
			model.addAttribute("ruKuFangAnFormMap", ruKuFangAnFormMap);
		} catch (NumberFormatException e) {
			log.error("==Class:RuKuFangAnController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("==Class:RuKuFangAnController==Method:findRuKuFangAnById=="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/churukufangan/rukufanganedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		RuKuFangAnFormMap ruKuFangAnFormMap = getFormMap(RuKuFangAnFormMap.class);
		if(!validData(ruKuFangAnFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(ruKuFangAnFormMap);
		} catch (Exception e) {
			log.error("==Class:RuKuFangAnController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			ruKuFangAnServer.editRuKuFangAn(ruKuFangAnFormMap);
		} catch (Exception e) {
			log.error("==Class:RuKuFangAnController==Method:editRuKuFangAn=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		
		try {
			ruKuFangAnServer.dropRuKuFangAn(getPara("id"));
		} catch (Exception e) {
			log.error("==Class:RuKuFangAnController==Method:dropRuKuFangAn=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("look")
	public String look(Model model){
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			RuKuFangAnFormMap ruKuFangAnFormMap = ruKuFangAnServer.lookRuKuFangAnById(Integer.parseInt(getPara("id")));
			
			ruKuFangAnFormMap.set("pspBeginDate", sdf.format(ruKuFangAnFormMap.getDate("pspBeginDate")));
			ruKuFangAnFormMap.set("pspEndDate", sdf.format(ruKuFangAnFormMap.getDate("pspEndDate")));
			
			model.addAttribute("ruKuFangAnFormMap", ruKuFangAnFormMap);
		} catch (NumberFormatException e) {
			log.error("==Class:RuKuFangAnController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("==Class:RuKuFangAnController==Method:findRuKuFangAnById=="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/churukufangan/rukufanganlook";
	}
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String pspWId = formMap.getStr("pspWId");
		String pspVariety = formMap.getStr("pspVariety");
		String pspCategory = formMap.getStr("pspCategory");
		String pspWeight = formMap.getStr("pspWeight");
		String pspBeginDate = formMap.getStr("pspBeginDate");
		String pspEndDate = formMap.getStr("pspEndDate");
		String pspContent = formMap.getStr("pspContent");
		String pspFileName = formMap.getStr("pspFileName");
		
		if(ValidateUtil.isEmpty(pspWId) || !ValidateUtil.isInt(pspWId)){
			return false;
		}
		if(ValidateUtil.isEmpty(pspVariety) || !ValidateUtil.isLength(pspVariety,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(pspCategory) || !ValidateUtil.isLength(pspCategory,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(pspWeight) || !ValidateUtil.isFloat(pspWeight)){
			return false;
		}
		
		if(!ValidateUtil.isShortDate(pspBeginDate)){
			return false;
		}
		if(!ValidateUtil.isShortDate(pspEndDate)){
			return false;
		}
		if(!ValidateUtil.isLength(pspContent,Constant.INT_512)){
			return false;
		}
		if(!ValidateUtil.isLength(pspFileName,Constant.INT_64)){
			return false;
		}
		
		return true;
	}
}
