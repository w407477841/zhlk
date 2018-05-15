package com.zyiot.controller.yaojiguanli;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiShenPiFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiShenQingFormMap;
import com.zyiot.server.yaojiguanli.YaoJiKuCunServiceI;
import com.zyiot.server.yaojiguanli.YaoJiShenPiServiceI;
import com.zyiot.server.yaojiguanli.YaoJiShenQingServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("/yaojilingyongshenpi")
public class YaoJiShenPiController extends BaseController {
	Logger log = Logger.getLogger(YaoJiShenPiController.class);
	@Autowired
	private YaoJiShenQingServiceI yaoJiShenQingService;
	@Autowired
	private YaoJiKuCunServiceI yaoJiKuCunService;
	@Autowired
	private YaoJiShenPiServiceI yaoJiShenPiService;
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/yaojishenpilist";
	}
	@RequestMapping("/listRecordUI")
	public String listRecordUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/yaojishenpijilulist";
	}
	@RequestMapping("/findByPage")
	@ResponseBody
	public MyPage<YaoJiShenQingFormMap> findByPage(int page, int rows){
		YaoJiShenQingFormMap yaoJiShenQingFormMap = getFormMap(YaoJiShenQingFormMap.class);
		List<YaoJiShenQingFormMap> list = yaoJiShenQingService.findShenPiByPage(yaoJiShenQingFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(YaoJiShenQingFormMap yj:list){
				Date date = yj.getDate("maApplyDate");
				yj.set("maApplyDate", DateUtils.dateFormatToLong(date));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("/findRecordByPage")
	@ResponseBody
	public MyPage<YaoJiShenPiFormMap> findRecordByPage(int page, int rows){
		YaoJiShenPiFormMap yaoJiShenPiFormMap = getFormMap(YaoJiShenPiFormMap.class);
		List<YaoJiShenPiFormMap> list = yaoJiShenPiService.findByPage(yaoJiShenPiFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(YaoJiShenPiFormMap yj:list){
				Date date = yj.getDate("maAuditingDate");
				yj.set("maAuditingDate", DateUtils.dateFormatToLong(date));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String AddUI(Model model){
		String id = getPara("id");
		YaoJiShenQingFormMap yaoJiShenQingFormMap = yaoJiShenQingService.findYaoJiShenQingById(Integer.parseInt(id));
		model.addAttribute("yaoJiShenQingFormMap", yaoJiShenQingFormMap);
		try {
			YaoJiKuCunFormMap yaoJiKuCunFormMap = yaoJiKuCunService.findById(yaoJiShenQingFormMap.getInt("maMrId"));
			yaoJiKuCunFormMap.set("mrManufactureDate", DateUtils.dateFormatToShort(yaoJiKuCunFormMap.getTimestamp("mrManufactureDate")));
			model.addAttribute("yaoJiKuCunFormMap", yaoJiKuCunFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenPiController==Methdo:findById=="+e);
		}
		
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/yaojishenpiadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		YaoJiShenQingFormMap yaoJiShenQingFormMap = getFormMap(YaoJiShenQingFormMap.class);
		if(!validData(yaoJiShenQingFormMap)){
			return ERROR;
		}
		String process = yaoJiShenQingFormMap.getStr("maProcess");
		if(process.equals("1")){
			yaoJiShenQingFormMap.set("maProcess", Constant.STATUS_APPLICANT);
		}else{
			yaoJiShenQingFormMap.set("maProcess", Constant.STATUS_BACK);
		}
		
		try {
			FormMapUtil.toUPDATEFormMap(yaoJiShenQingFormMap);
		} catch (Exception e1) {
			log.error("===Class:YaoJiShenPiController==Methdo:toUPDATEFormMap=="+e1);
			return ERROR;
		}
		
		try {
			yaoJiShenPiService.auditingYaoJiShenQing(yaoJiShenQingFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiShenPiController==Methdo:auditingYaoJiShenQing=="+e);
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
		String maOpinion = formMap.getStr("maOpinion");
		
		if(ValidateUtil.isEmpty(maOpinion) || !ValidateUtil.isLength(maOpinion,Constant.INT_256)){
			return false;
		}
		
		return true;
	}
}
