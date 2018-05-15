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
import com.zyiot.entity.yaojiguanli.YaoJiLingYongFormMap;
import com.zyiot.server.yaojiguanli.YaoJiKuCunServiceI;
import com.zyiot.server.yaojiguanli.YaoJiLingYongServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("yaojilingyongguanli")
public class YaoJiLingYongGuanLiController extends BaseController {
	Logger log = Logger.getLogger(YaoJiLingYongGuanLiController.class);
	@Autowired
	private YaoJiKuCunServiceI yaoJiKuCunService;
	
	@Autowired
	private YaoJiLingYongServiceI yaoJiLingYongService;
	
	@RequestMapping("listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/yaojilingyongguanlilist";
	}
	
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(Model model) {
		try {
			int id = Integer.parseInt(getPara("id"));
			YaoJiKuCunFormMap yaoJiKuCunFormMap = yaoJiKuCunService.lookById(id);
			yaoJiKuCunFormMap.set("mrManufactureDate", DateUtils.dateFormatToShort(yaoJiKuCunFormMap.getDate("mrManufactureDate")));
			model.addAttribute("yaoJiKuCunFormMap", yaoJiKuCunFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:YaoJiLingYongGuanLiController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("===Class:YaoJiLingYongGuanLiController==Method:findById=="+e);
		}
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/yaojiguanli/yaojilingyongadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		YaoJiLingYongFormMap yaoJiLingYongFormMap = getFormMap(YaoJiLingYongFormMap.class);
		
		YaoJiKuCunFormMap yaoJiKuCunFormMap = getFormMap(YaoJiKuCunFormMap.class);
		if(!validData(yaoJiLingYongFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(yaoJiLingYongFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiLingYongGuanLiController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			FormMapUtil.toUPDATEFormMap(yaoJiKuCunFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiLingYongGuanLiController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			yaoJiLingYongService.addYaoJiLingYong(yaoJiLingYongFormMap,yaoJiKuCunFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiLingYongGuanLiController==Method:addYaoJiLingYong=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<YaoJiLingYongFormMap> findByPage(int page, int rows){
		YaoJiLingYongFormMap yaoJiLingYongFormMap =getFormMap(YaoJiLingYongFormMap.class);
		List<YaoJiLingYongFormMap> list = yaoJiLingYongService.findByPage(yaoJiLingYongFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(YaoJiLingYongFormMap yj:list){
				Date date = yj.getDate("muUsedDate");
				yj.set("muUsedDate", DateUtils.dateFormatToShort(date));
				date = yj.getDate("muManufactureDate");
				yj.set("muManufactureDate", DateUtils.dateFormatToShort(date));
			}
		}
		return toMyPage(list);
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(Model model){
		String id = getPara("id");
		try {
			yaoJiLingYongService.deleteYaoJiLingYongById(id);
		} catch (Exception e) {
			log.error("===Class:YaoJiLingYongGuanLiController==Method:deleteYaoJiLingYongById=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("view")
	public String view(Model model){
		try {
			int id = Integer.parseInt(getPara("id"));
			
			YaoJiLingYongFormMap yaoJiLingYongFormMap = yaoJiLingYongService.findById(id);
			yaoJiLingYongFormMap.set("muUsedDate", DateUtils.dateFormatToShort(yaoJiLingYongFormMap.getDate("muUsedDate")));
			yaoJiLingYongFormMap.set("muManufactureDate", DateUtils.dateFormatToShort(yaoJiLingYongFormMap.getDate("muManufactureDate")));
			model.addAttribute("yaoJiLingYongFormMap", yaoJiLingYongFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiLingYongGuanLiController==Method:findById=="+e);
		}
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/yaojiguanli/yaojilingyongview";
	}
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String muQuantity = formMap.getStr("muQuantity");
		String muApplicant = formMap.getStr("muApplicant");
		String muAuditor = formMap.getStr("muAuditor");
		String muSupervisor = formMap.getStr("muSupervisor");
		String muUsed = formMap.getStr("muUsed");
		String muUsedDate = formMap.getStr("muUsedDate");
		String muWLNo = formMap.getStr("muWLNo");
		
		
		if(ValidateUtil.isEmpty(muQuantity) || !ValidateUtil.isInt(muQuantity)){
			return false;
		}
		if(ValidateUtil.isEmpty(muWLNo) || !ValidateUtil.isInt(muWLNo)){
			return false;
		}
		if(!ValidateUtil.isLength(muApplicant,Constant.INT_64)){
			return false;
		}
		if(!ValidateUtil.isLength(muAuditor,Constant.INT_64)){
			return false;
		}
		if(!ValidateUtil.isLength(muSupervisor,Constant.INT_64)){
			return false;
		}
		if(!ValidateUtil.isLength(muUsed,Constant.INT_256)){
			return false;
		}
		if(!ValidateUtil.isShortDate(muUsedDate)){
			return false;
		}
		
		return true;
	}
}
