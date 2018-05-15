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
import com.zyiot.entity.shebeiguanli.DaXingSheBeiBaoFeiFormMap;
import com.zyiot.server.shebeiguanli.DaXingSheBeiBaoFeiServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("daxingshebeibaofei")
public class DaXingSheBeiBaoFeiController extends BaseController {
	Logger log = Logger.getLogger(DaXingSheBeiBaoFeiController.class);
	@Autowired
	private DaXingSheBeiBaoFeiServiceI daXingSheBeiBaoFeiService;
	@RequestMapping("listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/baofeijilulist";
	}
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<DaXingSheBeiBaoFeiFormMap> findByPage(int page,int rows){
		DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap =getFormMap(DaXingSheBeiBaoFeiFormMap.class);
		List<DaXingSheBeiBaoFeiFormMap> list = daXingSheBeiBaoFeiService.findByPage(daXingSheBeiBaoFeiFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(DaXingSheBeiBaoFeiFormMap yj:list){
				Date date = yj.getDate("lewAddDate");
				yj.set("lewAddDate", DateUtils.dateFormatToLong(date));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/baofeijiluadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap =getFormMap(DaXingSheBeiBaoFeiFormMap.class);
		if(!validData(daXingSheBeiBaoFeiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(daXingSheBeiBaoFeiFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiBaoFeiController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			daXingSheBeiBaoFeiFormMap.put("lewDataOperator", session.getAttribute("userSessionId"));
			daXingSheBeiBaoFeiFormMap.put("lewAddDate", new Timestamp(new Date().getTime()));
			
			daXingSheBeiBaoFeiService.addDaXingSheBeiBaoFei(daXingSheBeiBaoFeiFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiBaoFeiController==Method:addDaXingSheBeiBaoFei=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		
		DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap = daXingSheBeiBaoFeiService.findDaXingSheBeiBaoFeiById(Integer.parseInt(getPara("id")));
		model.addAttribute("daXingSheBeiBaoFeiFormMap", daXingSheBeiBaoFeiFormMap);
		
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/baofeijiluedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap =getFormMap(DaXingSheBeiBaoFeiFormMap.class);
		if(!validData(daXingSheBeiBaoFeiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(daXingSheBeiBaoFeiFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiBaoFeiController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			daXingSheBeiBaoFeiService.editDaXingSheBeiBaoFei(daXingSheBeiBaoFeiFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiBaoFeiController==Method:editDaXingSheBeiBaoFei=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		try {
			daXingSheBeiBaoFeiService.dropDaXingSheBeiBaoFei(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiBaoFeiController==Method:dropDaXingSheBeiBaoFei=="+e);
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
		String lewCause = formMap.getStr("lewCause");
		String lewDate = formMap.getStr("lewDate");
		
		if(ValidateUtil.isEmpty(lewCause) || !ValidateUtil.isLength(lewCause,Constant.INT_256)){
			return false;
		}
		if(ValidateUtil.isEmpty(lewDate) || !ValidateUtil.isShortDate(lewDate)){
			return false;
		}
		
		return true;
	}
}
