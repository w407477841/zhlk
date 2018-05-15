package com.zyiot.controller.chuliangguanli;

import java.util.List;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.cunchuguanli.ChuKuShenQingTransferToolsFormMap;
import com.zyiot.server.cunchuguanli.ChuKuShenQingTransferToolsServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;
@Controller
@RequestMapping("transfertools")
public class ChuKuShenQingTransferToolsController extends BaseController {
	Logger log = Logger.getLogger(ChuKuShenQingTransferToolsController.class);
	
	@Autowired
	private ChuKuShenQingTransferToolsServerI chuKuShenQingTransferToolsServer;
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<ChuKuShenQingTransferToolsFormMap> findByPage() {
		ChuKuShenQingTransferToolsFormMap chuKuShenQingTransferToolsFormMap =  getFormMap(ChuKuShenQingTransferToolsFormMap.class);
		Session session = SecurityUtils.getSubject().getSession();
		chuKuShenQingTransferToolsFormMap.put("gsaaDataOperator", session.getAttribute("userSessionId"));
		
		List<ChuKuShenQingTransferToolsFormMap> list = chuKuShenQingTransferToolsServer.findByPage(chuKuShenQingTransferToolsFormMap);
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	public String addUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenqingtransfertoolsadd";
		
	}
	@RequestMapping("add")
	@ResponseBody
	public String add(){
		ChuKuShenQingTransferToolsFormMap chuKuShenQingTransferToolsFormMap =  getFormMap(ChuKuShenQingTransferToolsFormMap.class);
		if(!validData(chuKuShenQingTransferToolsFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(chuKuShenQingTransferToolsFormMap);
		} catch (Exception e) {
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			chuKuShenQingTransferToolsFormMap.put("gsaaDataOperator", session.getAttribute("userSessionId"));
			chuKuShenQingTransferToolsServer.addChuKuShenQingTransferTools(chuKuShenQingTransferToolsFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingTransferToolsController==Method:addChuKuShenQingTransferTools=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		try {
			chuKuShenQingTransferToolsServer.dropChuKuShenQingTransferTools(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:ChuKuShenQingTransferToolsController==Method:dropChuKuShenQingTransferTools=="+e);
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
		String gsaaNo = formMap.getStr("gsaaNo");
		String gsaaWeight = formMap.getStr("gsaaWeight");
		
		if(ValidateUtil.isEmpty(gsaaNo) || !ValidateUtil.isLength(gsaaNo,Constant.INT_16)){
			return false;
		}
		if(ValidateUtil.isEmpty(gsaaWeight) || !ValidateUtil.isLength(gsaaWeight,Constant.INT_32)){
			return false;
		}
		return true;
	}
}
