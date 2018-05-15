package com.zyiot.controller.shebeiguanli;

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
import com.zyiot.entity.shebeiguanli.DaXingSheBeiWeiXiuFormMap;
import com.zyiot.server.shebeiguanli.DaXingSheBeiWeiXiuServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("daxingshebeiweixiu")
public class DaXingSheBeiWeiXiuController extends BaseController {
	Logger log = Logger.getLogger(DaXingSheBeiWeiXiuController.class);
	@Autowired
	private DaXingSheBeiWeiXiuServiceI daXingSheBeiWeiXiuService;
	@RequestMapping("listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/weixiujilulist";
	}
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<DaXingSheBeiWeiXiuFormMap> findByPage(int page, int rows){
		DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap =getFormMap(DaXingSheBeiWeiXiuFormMap.class);
		List<DaXingSheBeiWeiXiuFormMap> list = daXingSheBeiWeiXiuService.findByPage(daXingSheBeiWeiXiuFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(DaXingSheBeiWeiXiuFormMap yj:list){
				Date date = yj.getDate("lerAddDate");
				yj.set("lerAddDate", DateUtils.dateFormatToLong(date));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/weixiujiluadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap =getFormMap(DaXingSheBeiWeiXiuFormMap.class);
		if(!validData(daXingSheBeiWeiXiuFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(daXingSheBeiWeiXiuFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiWeiXiuController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			daXingSheBeiWeiXiuFormMap.put("lerDataOperator", session.getAttribute("userSessionId"));
			daXingSheBeiWeiXiuFormMap.put("lerAddDate", new Timestamp(new Date().getTime()));
			
			daXingSheBeiWeiXiuService.addDaXingSheBeiWeiXiu(daXingSheBeiWeiXiuFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiWeiXiuController==Method:addDaXingSheBeiWeiXiu=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap = daXingSheBeiWeiXiuService.findDaXingSheBeiWeiXiuById(Integer.parseInt(getPara("id")));
		model.addAttribute("daXingSheBeiWeiXiuFormMap", daXingSheBeiWeiXiuFormMap);
		
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/weixiujiluedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap =getFormMap(DaXingSheBeiWeiXiuFormMap.class);
		if(!validData(daXingSheBeiWeiXiuFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(daXingSheBeiWeiXiuFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiWeiXiuController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			daXingSheBeiWeiXiuService.editDaXingSheBeiWeiXiu(daXingSheBeiWeiXiuFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiWeiXiuController==Method:editDaXingSheBeiWeiXiu=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		try {
			daXingSheBeiWeiXiuService.dropDaXingSheBeiWeiXiu(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiWeiXiuController==Method:dropDaXingSheBeiWeiXiu=="+e);
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
		String lerContent = formMap.getStr("lerContent");
		String lerRepairDate = formMap.getStr("lerRepairDate");
		String lerRepairUser = formMap.getStr("lerRepairUser");
		
		if(ValidateUtil.isEmpty(lerContent) || !ValidateUtil.isLength(lerContent,Constant.INT_256)){
			return false;
		}
		if(ValidateUtil.isEmpty(lerRepairDate) || !ValidateUtil.isShortDate(lerRepairDate)){
			return false;
		}
		if(ValidateUtil.isEmpty(lerRepairUser) || !ValidateUtil.isLength(lerRepairUser,Constant.INT_32)){
			return false;
		}
		
		return true;
	}
}
