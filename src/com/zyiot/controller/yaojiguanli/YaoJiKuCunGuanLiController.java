package com.zyiot.controller.yaojiguanli;

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
import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.server.yaojiguanli.YaoJiKuCunServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("yaojikucunguanli")
public class YaoJiKuCunGuanLiController extends BaseController {
	Logger log = Logger.getLogger(YaoJiKuCunGuanLiController.class);
	@Autowired
	private YaoJiKuCunServiceI yaoJiKuCunService;
	@RequestMapping("listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/yaojikucunguanlilist";
	}
	
	
	
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<YaoJiKuCunFormMap> findByPage(int page, int rows){
		YaoJiKuCunFormMap yaoJiKuCunFormMap =getFormMap(YaoJiKuCunFormMap.class);
		List<YaoJiKuCunFormMap> list = yaoJiKuCunService.findByPage(yaoJiKuCunFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(YaoJiKuCunFormMap yj:list){
				Date date = yj.getDate("mrManufactureDate");
				yj.set("mrManufactureDate", DateUtils.dateFormatToShort(date));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI() {
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/yaojiguanli/yaojikucunguanliadd";
	}
	
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		YaoJiKuCunFormMap yaoJiKuCunFormMap = getFormMap(YaoJiKuCunFormMap.class);
		if(!validData(yaoJiKuCunFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(yaoJiKuCunFormMap);
		} catch (Exception e1) {
			log.error("====Class:YaoJiKuCunGuanLiController==Method:FormMapUtil.toADDFormMap=="+e1);
			return ERROR;
		}
		try {
			String dateStr = yaoJiKuCunFormMap.getStr("mrManufactureDate")+" 12:00:00";
			Timestamp ts = Timestamp.valueOf(dateStr);
			yaoJiKuCunFormMap.set("mrManufactureDate",ts);
			
			Session session = SecurityUtils.getSubject().getSession();
			yaoJiKuCunFormMap.put("mrDataOperator", session.getAttribute("userSessionId"));
			
			yaoJiKuCunService.addYaoJiKuCun(yaoJiKuCunFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:addYaoJiKuCun=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model) {
		try {
			int id = Integer.parseInt(getPara("id"));
			YaoJiKuCunFormMap yaoJiKuCunFormMap = yaoJiKuCunService.findById(id);
			yaoJiKuCunFormMap.set("mrManufactureDate", DateUtils.dateFormatToShort(yaoJiKuCunFormMap.getDate("mrManufactureDate")));
			model.addAttribute("yaoJiKuCunFormMap",yaoJiKuCunFormMap );
		} catch (NumberFormatException e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:findById=="+e);
		}
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/yaojiguanli/yaojikucunguanliedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		YaoJiKuCunFormMap yaoJiKuCunFormMap = getFormMap(YaoJiKuCunFormMap.class);
		if(!validData(yaoJiKuCunFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(yaoJiKuCunFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		try {
			yaoJiKuCunService.editYaoJiKuCun(yaoJiKuCunFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:edit()=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("increaseUI")
	@Token(save=true)
	public String increaseUI(Model model) {
		try {
			int id = Integer.parseInt(getPara("id"));
			YaoJiKuCunFormMap yaoJiKuCunFormMap = yaoJiKuCunService.lookById(id);
			yaoJiKuCunFormMap.set("mrManufactureDate", DateUtils.dateFormatToShort(yaoJiKuCunFormMap.getDate("mrManufactureDate")));
			model.addAttribute("yaoJiKuCunFormMap",yaoJiKuCunFormMap );
		} catch (NumberFormatException e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:findById=="+e);
		}
		return Common.BACKGROUND_PATH + "/yewuguanlixitong/yaojiguanli/yaojikucunguanliincrease";
	}
	
	
	@RequestMapping("increase")
	@ResponseBody
	@Token(remove=true)
	public String increase(){
		YaoJiKuCunFormMap yaoJiKuCunFormMap = getFormMap(YaoJiKuCunFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(yaoJiKuCunFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		try {
			yaoJiKuCunService.increaseYaoJiKuCun(yaoJiKuCunFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:edit()=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(Model model) {
		String id = getPara("id");
		try {
			yaoJiKuCunService.deleteYaoJiKuCunById(id);
			
			
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:deleteYaoJiKuCunById=="+e);
			return ERROR;
		}

		return SUCCESS;
	}
	
	@RequestMapping("findAll")
	@ResponseBody
	public List<YaoJiKuCunFormMap> getAllYaoJiKuCun(){
		List<YaoJiKuCunFormMap> list = yaoJiKuCunService.findAll();
		return list;
	}
	
	@RequestMapping("findByLocationId")
	@ResponseBody
	public List<YaoJiKuCunFormMap> getYaoJiKuCunByLocationId(){
		String locationId = getPara("location_id");
		YaoJiKuCunFormMap yaoJiKuCun = new YaoJiKuCunFormMap();
		yaoJiKuCun.set("mrWLNo", locationId);
		List<YaoJiKuCunFormMap> list = yaoJiKuCunService.findByAttr(yaoJiKuCun);
		return list;
	}
	
	
	@RequestMapping(value="findById",produces="application/json;charset=UTF-8")
	@ResponseBody
	public YaoJiKuCunFormMap findById(){
		String id = getPara("id");
		try {
			YaoJiKuCunFormMap yaoJiKuCunFormMap = yaoJiKuCunService.lookById(Integer.parseInt(id));
			yaoJiKuCunFormMap.set("mrManufactureDate", DateUtils.dateFormatToShort(yaoJiKuCunFormMap.getTimestamp("mrManufactureDate")));
			return yaoJiKuCunFormMap;
		} catch (NumberFormatException e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:findById=="+e);
		}
		return null;
	}
	
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String mrName = formMap.getStr("mrName");
		String mrDrug = formMap.getStr("mrDrug");
		String mrBrand = formMap.getStr("mrBrand");
		String mrPage = formMap.getStr("mrPage");
		String mrStandard = formMap.getStr("mrStandard");
		String mrPrice = formMap.getStr("mrPrice");
		String mrNumber = formMap.getStr("mrNumber");
		String mrUnit = formMap.getStr("mrUnit");
		String mrManufactureDate = formMap.getStr("mrManufactureDate");
		String mrProductCompany = formMap.getStr("mrProductCompany");
		String mrOperator = formMap.getStr("mrOperator");
		String mrAuditor = formMap.getStr("mrAuditor");
		String mrRemark = formMap.getStr("mrRemark");
		String mrWLNo = formMap.getStr("mrWLNo");
		
		if(ValidateUtil.isEmpty(mrName) || !ValidateUtil.isLength(mrName,Constant.INT_128)){
			return false;
		}
		if(!ValidateUtil.isLength(mrBrand,Constant.INT_128)){
			return false;
		}
		if(ValidateUtil.isEmpty(mrPage) || !ValidateUtil.isInt(mrPage)){
			return false;
		}
		if(!ValidateUtil.isLength(mrStandard,Constant.INT_64)){
			return false;
		}
		if(!ValidateUtil.isFloat(mrPrice)){
			return false;
		}
		if(ValidateUtil.isEmpty(mrNumber) || !ValidateUtil.isInt(mrNumber)){
			return false;
		}
		if(ValidateUtil.isEmpty(mrDrug) || !ValidateUtil.isInt(mrDrug)){
			return false;
		}
		if(!ValidateUtil.isLength(mrUnit,Constant.INT_128)){
			return false;
		}
		if(!ValidateUtil.isShortDate(mrManufactureDate)){
			return false;
		}
		if(!ValidateUtil.isLength(mrProductCompany,Constant.INT_128)){
			return false;
		}
		if(!ValidateUtil.isLength(mrOperator,Constant.INT_64)){
			return false;
		}
		if(!ValidateUtil.isLength(mrAuditor,Constant.INT_64)){
			return false;
		}
		if(!ValidateUtil.isLength(mrRemark,Constant.INT_256)){
			return false;
		}
		if(ValidateUtil.isEmpty(mrWLNo) || !ValidateUtil.isInt(mrWLNo)){
			return false;
		}
		return true;
	}
}
