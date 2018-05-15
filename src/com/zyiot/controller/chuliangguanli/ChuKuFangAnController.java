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
import com.zyiot.entity.cunchuguanli.ChuKuFangAnFormMap;
import com.zyiot.server.cunchuguanli.ChuKuFangAnServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;
/**
 * 出库方案
 * @author Lip
 *
 */
@Controller
@RequestMapping("chukufangan")
public class ChuKuFangAnController extends BaseController {
	Logger log = Logger.getLogger(ChuKuFangAnController.class);
	
	@Autowired
	private ChuKuFangAnServerI chuKuFangAnServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/churukufangan/chukufangan";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<ChuKuFangAnFormMap> findByPage(int page, int rows) {
		ChuKuFangAnFormMap chuKuFangAnFormMap = getFormMap(ChuKuFangAnFormMap.class);
		List<ChuKuFangAnFormMap> list = chuKuFangAnServer.findByPage(chuKuFangAnFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(ChuKuFangAnFormMap cf:list){
				cf.set("gspBeginDate", DateUtils.dateFormatToShort(cf.getDate("gspBeginDate")));
				cf.set("gspEndDate", DateUtils.dateFormatToShort(cf.getDate("gspEndDate")));
				cf.set("gspAddDate", DateUtils.dateFormatToLong(cf.getDate("gspAddDate")));
			}
		}
		return toMyPage(list);
	}
	
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/churukufangan/chukufanganadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		
		ChuKuFangAnFormMap chuKuFangAnFormMap = getFormMap(ChuKuFangAnFormMap.class);
		if(!validData(chuKuFangAnFormMap)){
			return ERROR;
		}
		
		
		try {
			FormMapUtil.toADDFormMap(chuKuFangAnFormMap);
		} catch (Exception e) {
			log.error("==Class:ChuKuFangAnController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			chuKuFangAnFormMap.set("gspDataOperator", session.getAttribute("userSessionId"));
			chuKuFangAnFormMap.set("gspAddDate", new Timestamp(System.currentTimeMillis()));
			
			chuKuFangAnServer.addChuKuFangAn(chuKuFangAnFormMap);
		} catch (Exception e) {
			log.error("==Class:ChuKuFangAnController==Method:addChuKuFangAn=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		
		try {
			ChuKuFangAnFormMap chuKuFangAnFormMap = chuKuFangAnServer.findChuKuFangAnById(Integer.parseInt(getPara("id")));
			chuKuFangAnFormMap.set("gspBeginDate", DateUtils.dateFormatToShort(chuKuFangAnFormMap.getDate("gspBeginDate")));
			chuKuFangAnFormMap.set("gspEndDate", DateUtils.dateFormatToShort(chuKuFangAnFormMap.getDate("gspEndDate")));
			model.addAttribute("chuKuFangAnFormMap", chuKuFangAnFormMap);
		} catch (NumberFormatException e) {
			log.error("==Class:ChuKuFangAnController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("==Class:ChuKuFangAnController==Method:findChuKuFangAnById=="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/churukufangan/chukufanganedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		ChuKuFangAnFormMap chuKuFangAnFormMap = getFormMap(ChuKuFangAnFormMap.class);
		if(!validData(chuKuFangAnFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(chuKuFangAnFormMap);
		} catch (Exception e) {
			log.error("==Class:ChuKuFangAnController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			chuKuFangAnServer.editChuKuFangAn(chuKuFangAnFormMap);
		} catch (Exception e) {
			log.error("==Class:ChuKuFangAnController==Method:editChuKuFangAn=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		
		try {
			chuKuFangAnServer.dropChuKuFangAn(getPara("id"));
		} catch (Exception e) {
			log.error("==Class:ChuKuFangAnController==Method:dropChuKuFangAn=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("look")
	public String look(Model model){
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			ChuKuFangAnFormMap chuKuFangAnFormMap = chuKuFangAnServer.lookChuKuFangAnById(Integer.parseInt(getPara("id")));
			
			chuKuFangAnFormMap.set("gspBeginDate", sdf.format(chuKuFangAnFormMap.getDate("gspBeginDate")));
			chuKuFangAnFormMap.set("gspEndDate", sdf.format(chuKuFangAnFormMap.getDate("gspEndDate")));
			
			model.addAttribute("chuKuFangAnFormMap", chuKuFangAnFormMap);
		} catch (NumberFormatException e) {
			log.error("==Class:ChuKuFangAnController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("==Class:ChuKuFangAnController==Method:findChuKuFangAnById=="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/churukufangan/chukufanganlook";
	}
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String gspWId = formMap.getStr("gspWId");
		String gspVariety = formMap.getStr("gspVariety");
		String gspCategory = formMap.getStr("gspCategory");
		
		if(ValidateUtil.isEmpty(gspWId) || !ValidateUtil.isInt(gspWId)){
			return false;
		}
		if(ValidateUtil.isEmpty(gspVariety) || !ValidateUtil.isLength(gspVariety,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(gspCategory) || !ValidateUtil.isLength(gspCategory,Constant.INT_32)){
			return false;
		}
		
		return true;
	}
}
