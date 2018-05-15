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
import com.zyiot.entity.cunchuguanli.YiJiaoGuanLiFormMap;
import com.zyiot.server.cunchuguanli.YiJiaoGuanLiServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("yijiaoguanli")
public class YiJiaoGuanLiController extends BaseController {
	Logger log = Logger.getLogger(YiJiaoGuanLiController.class);
	@Autowired
	private YiJiaoGuanLiServerI yiJiaoGuanLiServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/cunchuguanli/cangkuguanli/yijiaoguanlilist";
	}
	

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<YiJiaoGuanLiFormMap> findByPage(int page, int rows) {
		YiJiaoGuanLiFormMap yiJiaoGuanLiFormMap =getFormMap(YiJiaoGuanLiFormMap.class);
		List<YiJiaoGuanLiFormMap> list = yiJiaoGuanLiServer.findByPage(yiJiaoGuanLiFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(YiJiaoGuanLiFormMap cf:list){
				cf.set("wtTransferDate", DateUtils.dateFormatToShort(cf.getDate("wtTransferDate")));
				cf.set("wtAddDate",  DateUtils.dateFormatToShort(cf.getDate("wtAddDate")));
			}
		}
		return toMyPage(list);
	}
	
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI() {
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/cunchuguanli/cangkuguanli/yijiaoguanliadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		YiJiaoGuanLiFormMap yiJiaoGuanLiFormMap = getFormMap(YiJiaoGuanLiFormMap.class);
		if(!validData(yiJiaoGuanLiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(yiJiaoGuanLiFormMap);
		} catch (Exception e) {
			log.error("===Class:YiJiaoGuanLiController==Method:toADDFormMap==="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			yiJiaoGuanLiFormMap.set("wtDataOperator", session.getAttribute("userSessionId"));
			yiJiaoGuanLiFormMap.set("wtAddDate", new Timestamp(System.currentTimeMillis()));
			yiJiaoGuanLiServer.addYiJiaoGuanLi(yiJiaoGuanLiFormMap);
		} catch (Exception e) {
			log.error("===Class:YiJiaoGuanLiController==Method:addYiJiaoGuanLi==="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("look")
	public String lookUI(Model model){
		String id = getPara("id");
		
		try {
			YiJiaoGuanLiFormMap yiJiaoGuanLiFormMap = yiJiaoGuanLiServer.findYiJiaoGuanLiById(Integer.parseInt(id));
			yiJiaoGuanLiFormMap.set("wtTransferDate", DateUtils.dateFormatToShort(yiJiaoGuanLiFormMap.getDate("wtTransferDate")));
			yiJiaoGuanLiFormMap.set("wtAddDate", DateUtils.dateFormatToShort(yiJiaoGuanLiFormMap.getDate("wtAddDate")));
			model.addAttribute("yiJiaoGuanLiFormMap", yiJiaoGuanLiFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:YiJiaoGuanLiController==Method:Integer.parseInt==="+e);
			return ERROR;
		} catch (Exception e) {
			log.error("===Class:YiJiaoGuanLiController==Method:findYiJiaoGuanLiById==="+e);
			return ERROR;
		}
		
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/cunchuguanli/cangkuguanli/yijiaoguanlilook";
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		
		try {
			yiJiaoGuanLiServer.dropYiJiaoGuanLi(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:YiJiaoGuanLiController==Method:dropYiJiaoGuanLi==="+e);
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
		String wtTransferDate = formMap.getStr("wtTransferDate");
		String wtRemark = formMap.getStr("wtRemark");
		
		if(!ValidateUtil.isShortDate(wtTransferDate)){
			return false;
		}
		
		if(!ValidateUtil.isLength(wtRemark,Constant.INT_256)){
			return false;
		}
		
		return true;
	}
}
