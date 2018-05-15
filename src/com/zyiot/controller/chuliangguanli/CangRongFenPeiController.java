package com.zyiot.controller.chuliangguanli;

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
import com.zyiot.entity.cunchuguanli.CangRongFenPeiFormMap;
import com.zyiot.server.cunchuguanli.CangRongFenPeiServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("cangrongfenpei")
public class CangRongFenPeiController extends BaseController {
	
	Logger log = Logger.getLogger(CangRongFenPeiController.class);
	@Autowired
	private CangRongFenPeiServerI cangRongFenPeiServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/cangkuguanli/cangrongfenpei";
	}
 
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<CangRongFenPeiFormMap> findByPage(int page, int rows) {
		CangRongFenPeiFormMap cangRongFenPeiFormMap =getFormMap(CangRongFenPeiFormMap.class);
		List<CangRongFenPeiFormMap> list = cangRongFenPeiServer.findByPage(cangRongFenPeiFormMap, page, rows);
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/cangkuguanli/cangrongfenpeiadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		CangRongFenPeiFormMap cangRongFenPeiFormMap = getFormMap(CangRongFenPeiFormMap.class);
		if(!validData(cangRongFenPeiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(cangRongFenPeiFormMap);
		} catch (Exception e) {
			log.error("===Class:CangRongFenPeiController===Class:toADDFormMap==="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			cangRongFenPeiFormMap.set("wscDataOperator", session.getAttribute("userSessionId"));
			cangRongFenPeiServer.addCangRongFenPei(cangRongFenPeiFormMap);
		} catch (Exception e) {
			log.error("===Class:CangRongFenPeiController===Class:addCangRongFenPei==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		
		try {
			CangRongFenPeiFormMap cangRongFenPeiFormMap = cangRongFenPeiServer.findCangRongFenPeiById(Integer.parseInt(getPara("id")));
			model.addAttribute("cangRongFenPeiFormMap", cangRongFenPeiFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:CangRongFenPeiController===Class:Integer.parseInt==="+e);
		} catch (Exception e) {
			log.error("===Class:CangRongFenPeiController===Class:findCangRongFenPeiById==="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/cangkuguanli/cangrongfenpeiedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
       CangRongFenPeiFormMap cangRongFenPeiFormMap = getFormMap(CangRongFenPeiFormMap.class);
       if(!validData(cangRongFenPeiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(cangRongFenPeiFormMap);
		} catch (Exception e) {
			log.error("===Class:CangRongFenPeiController===Class:toUPDATEFormMap==="+e);
			return ERROR;
		}
		
		try {
			
			cangRongFenPeiServer.editCangRongFenPei(cangRongFenPeiFormMap);
		} catch (Exception e) {
			log.error("===Class:CangRongFenPeiController===Class:editCangRongFenPei==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		
		try {
			cangRongFenPeiServer.dropCangRongFenPei(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:CangRongFenPeiController===Class:dropCangRongFenPei==="+e);
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
		String wscLimitHeight = formMap.getStr("wscLimitHeight");
		String wscInnerLong = formMap.getStr("wscInnerLong");
		String wscInnerWidth = formMap.getStr("wscInnerWidth");
		String wscJaponicaRiceDensity = formMap.getStr("wscJaponicaRiceDensity");
		String wscWheatDensity = formMap.getStr("wscWheatDensity");
		String wscJaponicaRiceWeight = formMap.getStr("wscJaponicaRiceWeight");
		String wscWheatWeight = formMap.getStr("wscWheatWeight");
		
		if(ValidateUtil.isEmpty(wscLimitHeight) || !ValidateUtil.isFloat(wscLimitHeight)){
			return false;
		}
		if(ValidateUtil.isEmpty(wscInnerLong) || !ValidateUtil.isFloat(wscInnerLong)){
			return false;
		}
		if(ValidateUtil.isEmpty(wscInnerWidth) || !ValidateUtil.isFloat(wscInnerWidth)){
			return false;
		}
		if(ValidateUtil.isEmpty(wscJaponicaRiceDensity) || !ValidateUtil.isFloat(wscJaponicaRiceDensity)){
			return false;
		}
		
		if(ValidateUtil.isEmpty(wscWheatDensity) || !ValidateUtil.isFloat(wscWheatDensity)){
			return false;
		}
		if(!ValidateUtil.isFloat(wscJaponicaRiceWeight)){
			return false;
		}
		if(!ValidateUtil.isFloat(wscWheatWeight)){
			return false;
		}
		
		return true;
	}
}
