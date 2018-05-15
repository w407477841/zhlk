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
import com.zyiot.entity.cunchuguanli.ChuKuShenQingFormMap;
import com.zyiot.server.cunchuguanli.ChuKuShenPiServerI;
import com.zyiot.server.cunchuguanli.ChuKuShenQingServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("chukushenpi")
public class ChuKuShenPiController extends BaseController {
    Logger log = Logger.getLogger(ChuKuShenPiController.class);
	
	@Autowired
	private ChuKuShenQingServerI chuKuShenQingServer;
	@Autowired
	private ChuKuShenPiServerI chuKuShenPiServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenpi";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<ChuKuShenQingFormMap> findByPage(int page, int rows) {
		ChuKuShenQingFormMap chuKuShenQingFormMap =  getFormMap(ChuKuShenQingFormMap.class);
		List<ChuKuShenQingFormMap> list = chuKuShenQingServer.findShenPiByPage(chuKuShenQingFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(ChuKuShenQingFormMap cf:list){
				if(cf.getDate("gsaSendOutDate") != null){
					cf.set("gsaSendOutDate", DateUtils.dateFormatToShort(cf.getDate("gsaSendOutDate")));					
				}
				cf.set("gsaAddDate", DateUtils.dateFormatToLong(cf.getDate("gsaAddDate")));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("approveUI")
	@Token(save=true)
	public String approveUI(Model model){
		try {
			ChuKuShenQingFormMap chuKuShenQingFormMap = chuKuShenQingServer.lookChuKuShenQingById(Integer.parseInt(getPara("id")));
			if(chuKuShenQingFormMap.getDate("gsaSendOutDate") != null){
				chuKuShenQingFormMap.set("gsaSendOutDate", DateUtils.dateFormatToShort(chuKuShenQingFormMap.getDate("gsaSendOutDate")));					
			}
			model.addAttribute("chuKuShenQingFormMap", chuKuShenQingFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:ChuKuShenPiController===Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenPiController===Method:lookChuKuShenQingById=="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenpiadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		ChuKuShenQingFormMap chuKuShenQingFormMap =  getFormMap(ChuKuShenQingFormMap.class);
		if(!validData(chuKuShenQingFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(chuKuShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenPiController===Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		String process = chuKuShenQingFormMap.getStr("gsaProcess");
		if(process !=null && process.equals("1")){
			chuKuShenQingFormMap.set("gsaProcess", Constant.STATUS_APPLICANT);
		}else{
			chuKuShenQingFormMap.set("gsaProcess", Constant.STATUS_BACK);
		}
		
		Session session = SecurityUtils.getSubject().getSession();
		chuKuShenQingFormMap.set("gsaAuditor", session.getAttribute("userSessionId"));
		chuKuShenQingFormMap.set("gsaAuditingDate", new Timestamp(System.currentTimeMillis()));
		
		try {
			chuKuShenPiServer.auditingChuKuShenQing(chuKuShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:ChuKuShenPiController===Method:editChuKuShenQing=="+e);
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
		String gsaRemark = formMap.getStr("gsaRemark");
		
		if(ValidateUtil.isEmpty(gsaRemark) || !ValidateUtil.isLength(gsaRemark,Constant.INT_128)){
			return false;
		}
		return true;
	}
}
