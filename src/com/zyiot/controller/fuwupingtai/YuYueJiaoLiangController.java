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
import com.zyiot.entity.fuwupingtai.YuYueJiaoLiangFormMap;
import com.zyiot.server.fuwupingtai.YuYueJiaoLiangServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("yuyuejiaoliang")
public class YuYueJiaoLiangController extends BaseController {
	Logger log = Logger.getLogger(YuYueJiaoLiangController.class);
	
	@Autowired
	private YuYueJiaoLiangServerI yuYueJiaoLiangServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/yuyuejiaolianglist";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<YuYueJiaoLiangFormMap> findByPage(int page, int rows) {
		YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap =getFormMap(YuYueJiaoLiangFormMap.class);
		List<YuYueJiaoLiangFormMap> list = yuYueJiaoLiangServer.findByPage(yuYueJiaoLiangFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(YuYueJiaoLiangFormMap yj:list){
				Date date = yj.getDate("agAppointmentDate");
				yj.set("agAppointmentDate", DateUtils.dateFormatToShort(date));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/yuyuejiaoliangadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		
		YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap = getFormMap(YuYueJiaoLiangFormMap.class);
		if(!validData(yuYueJiaoLiangFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(yuYueJiaoLiangFormMap);
		} catch (Exception e) {
			log.error("===Class:YuYueJiaoLiangController===Method:toADDFormMap==="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			yuYueJiaoLiangFormMap.set("agDataOperator", session.getAttribute("userSessionId"));
			yuYueJiaoLiangFormMap.set("agAddDate", new Timestamp(System.currentTimeMillis()));
			yuYueJiaoLiangFormMap.set("agBill", DateUtils.dateToString(new Date()));
			
			yuYueJiaoLiangServer.addYuYueJiaoLiang(yuYueJiaoLiangFormMap);
		} catch (Exception e) {
			log.error("===Class:YuYueJiaoLiangController===Method:addYuYueJiaoLiang==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		try {
			YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap = yuYueJiaoLiangServer.findYuYueJiaoLiangById(Integer.parseInt(getPara("id")));
			Date date = yuYueJiaoLiangFormMap.getDate("agAppointmentDate");
			yuYueJiaoLiangFormMap.set("agAppointmentDate", DateUtils.dateFormatToShort(date));
			
			model.addAttribute("yuYueJiaoLiangFormMap", yuYueJiaoLiangFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:YuYueJiaoLiangController===Method:Integer.parseInt==="+e);
		} catch (Exception e) {
			log.error("===Class:YuYueJiaoLiangController===Method:findYuYueJiaoLiangById==="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/fuwupingtai/yuyuejiaoliangedit";
	}
	
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap = getFormMap(YuYueJiaoLiangFormMap.class);
		if(!validData(yuYueJiaoLiangFormMap)){
			return ERROR;
		}
		
		try {
			FormMapUtil.toUPDATEFormMap(yuYueJiaoLiangFormMap);
		} catch (Exception e) {
			log.error("===Class:YuYueJiaoLiangController===Method:toUPDATEFormMap==="+e);
			return ERROR;
		}
		
		try {
			yuYueJiaoLiangServer.editYuYueJiaoLiang(yuYueJiaoLiangFormMap);
		} catch (Exception e) {
			log.error("===Class:YuYueJiaoLiangController===Method:editYuYueJiaoLiang==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		
		try {
			yuYueJiaoLiangServer.dropYuYueJiaoLiang(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:YuYueJiaoLiangController===Method:dropYuYueJiaoLiang==="+e);
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
		String agIDCard = formMap.getStr("agIDCard");
		String agName = formMap.getStr("agName");
		String agVariety = formMap.getStr("agVariety");
		String agNumber = formMap.getStr("agNumber");
		String agAppointmentDate = formMap.getStr("agAppointmentDate");
		String agAddress = formMap.getStr("agAddress");
		
		if(!ValidateUtil.isLength(agIDCard,Constant.INT_18)){
			return false;
		}
		if(ValidateUtil.isEmpty(agName) || !ValidateUtil.isLength(agName,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(agVariety) || !ValidateUtil.isInt(agVariety)){
			return false;
		}
		if(ValidateUtil.isEmpty(agNumber) || !ValidateUtil.isFloat(agNumber)){
			return false;
		}
		if(ValidateUtil.isEmpty(agAppointmentDate) || !ValidateUtil.isShortDate(agAppointmentDate)){
			return false;
		}
		if(!ValidateUtil.isLength(agAddress,Constant.INT_128)){
			return false;
		}

		return true;
	}
}
