package com.zyiot.controller.shebeiguanli;

import java.util.List;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiFuJianFormMap;
import com.zyiot.server.shebeiguanli.DaXingSheBeiFuJianServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;
@Controller
@RequestMapping("daXingSheBeiFuJian")
public class DaXingSheBeiFuJianController extends BaseController {
	Logger log = Logger.getLogger(DaXingSheBeiFuJianController.class);
	
	@Autowired
	private DaXingSheBeiFuJianServiceI daXingSheBeiFuJianService;
	@RequestMapping("addUI")
	public String addUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/daxingshebeifujianadd";
	}
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<DaXingSheBeiFuJianFormMap> findByPage(){
		DaXingSheBeiFuJianFormMap daXingSheBeiFuJianFormMap =getFormMap(DaXingSheBeiFuJianFormMap.class);
		Session session = SecurityUtils.getSubject().getSession();
		daXingSheBeiFuJianFormMap.put("leaDataOperator", session.getAttribute("userSessionId"));
		
		List<DaXingSheBeiFuJianFormMap> list = daXingSheBeiFuJianService.findByPage(daXingSheBeiFuJianFormMap);
		return toMyPage(list);
	}
	@RequestMapping("add")
	@ResponseBody
	public String add(){
		DaXingSheBeiFuJianFormMap daXingSheBeiFuJianFormMap =getFormMap(DaXingSheBeiFuJianFormMap.class);
		if(!validData(daXingSheBeiFuJianFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(daXingSheBeiFuJianFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiFuJianController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			daXingSheBeiFuJianFormMap.put("leaDataOperator", session.getAttribute("userSessionId"));
			
			daXingSheBeiFuJianService.addDaXingSheBeiFuJian(daXingSheBeiFuJianFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiFuJianController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(Model model) {
		String id = getPara("id");
		try {
			daXingSheBeiFuJianService.dropDaXingSheBeiFuJian(id);
	
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiFuJianController==Method:dropDaXingSheBeiFuJian=="+e);
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
		String leaName = formMap.getStr("leaName");
		String leaStandard = formMap.getStr("leaStandard");
		String leaNumber = formMap.getStr("leaNumber");
		
		if(ValidateUtil.isEmpty(leaName) || !ValidateUtil.isLength(leaName,Constant.INT_64)){
			return false;
		}
		if(ValidateUtil.isEmpty(leaStandard) || !ValidateUtil.isLength(leaStandard,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isInt(leaNumber)){
			return false;
		}
		
		return true;
	}
}
