package com.zyiot.controller.jichuziliao;

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
import com.zyiot.entity.jichuziliao.CangFangXinXiFormMap;
import com.zyiot.server.jichuziliao.CangFangXinXiServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;
@Controller
@RequestMapping("cangfangxinxi")
public class CangFangXinXiController extends BaseController {
	Logger log = Logger.getLogger(CangFangXinXiController.class);
	@Autowired
	private CangFangXinXiServiceI cangFangXinXiService;
	@RequestMapping("listUI")
	public String listUI(){
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/cangfangxinxilist";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<CangFangXinXiFormMap> findByPage(int page, int rows) {
		CangFangXinXiFormMap cangFangXinXiFormMap =getFormMap(CangFangXinXiFormMap.class);
		List<CangFangXinXiFormMap> list = cangFangXinXiService.findByPage(cangFangXinXiFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(CangFangXinXiFormMap yj:list){
				if(yj.getDate("waConstructDate") != null){
					yj.set("waConstructDate", DateUtils.dateFormatToShort(yj.getDate("waConstructDate")));					
				}
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/cangfangxinxiadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		CangFangXinXiFormMap cangFangXinXiFormMap = getFormMap(CangFangXinXiFormMap.class);
		if(!validData(cangFangXinXiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(cangFangXinXiFormMap);
		} catch (Exception e) {
			log.error("===Class:CangFangXinXiController===Method:toADDFormMap==="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			cangFangXinXiFormMap.set("waDataOperator", session.getAttribute("userSessionId"));
			cangFangXinXiService.addCangFangXinXi(cangFangXinXiFormMap);
		} catch (Exception e) {
			log.error("===Class:CangFangXinXiController===Method:addCangFangXinXi==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		CangFangXinXiFormMap cangFangXinXiFormMap = cangFangXinXiService.findCangFangXinXiById(Integer.parseInt(getPara("id")));
		if(cangFangXinXiFormMap.getDate("waConstructDate") != null){
			cangFangXinXiFormMap.set("waConstructDate", DateUtils.dateFormatToShort(cangFangXinXiFormMap.getDate("waConstructDate")));			
		}
		model.addAttribute("cangFangXinXiFormMap", cangFangXinXiFormMap);
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/cangfangxinxiedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		CangFangXinXiFormMap cangFangXinXiFormMap = getFormMap(CangFangXinXiFormMap.class);
		if(!validData(cangFangXinXiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(cangFangXinXiFormMap);
		} catch (Exception e) {
			log.error("===Class:CangFangXinXiController===Method:toUPDATEFormMap==="+e);
			return ERROR;
		}
		
		try {
			cangFangXinXiService.editCangFangXinXi(cangFangXinXiFormMap);
		} catch (Exception e) {
			log.error("===Class:CangFangXinXiController===Method:editCangFangXinXi==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		
		try {
			cangFangXinXiService.dropCangFangXinXi(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:CangFangXinXiController===Method:dropCangFangXinXi==="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping(value = "findStoremanById", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public CangFangXinXiFormMap findStoremanById(){
		String wid = getPara("wId");
		try {
			CangFangXinXiFormMap cangFangXinXiFormMap = cangFangXinXiService.findStoremanBywId(Integer.parseInt(wid));
			return cangFangXinXiFormMap;
		} catch (NumberFormatException e) {
			log.error("===Class:CangFangXinXiController===Method:Integer.parseInt==="+e);
		} catch (Exception e) {
			log.error("===Class:CangFangXinXiController===Method:findStoremanBywId==="+e);
		}
		return null;
	}
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String waHeatInsulator = formMap.getStr("waHeatInsulator");
		String waWindow = formMap.getStr("waWindow");
		String waDoorNumber = formMap.getStr("waDoorNumber");
		String waStructure = formMap.getStr("waStructure");
		String waConstructDate = formMap.getStr("waConstructDate");
		String waDesignCapacity = formMap.getStr("waDesignCapacity");
		String waDesignHeight = formMap.getStr("waDesignHeight");
		String waInnerLong = formMap.getStr("waInnerLong");
		String waInnerWidth = formMap.getStr("waInnerWidth");
		String waSequence = formMap.getStr("waSequence");
		
		if(!ValidateUtil.isLength(waHeatInsulator,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(waWindow) || !ValidateUtil.isInt(waWindow)){
			return false;
		}
		if(ValidateUtil.isEmpty(waDoorNumber) || !ValidateUtil.isInt(waDoorNumber)){
			return false;
		}
		if(!ValidateUtil.isLength(waStructure,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isShortDate(waConstructDate)){
			return false;
		}
		if(!ValidateUtil.isFloat(waDesignCapacity)){
			return false;
		}
		if(ValidateUtil.isEmpty(waDesignHeight) || !ValidateUtil.isFloat(waDesignHeight)){
			return false;
		}
		if(ValidateUtil.isEmpty(waInnerLong) || !ValidateUtil.isFloat(waInnerLong)){
			return false;
		}
		if(ValidateUtil.isEmpty(waInnerWidth) || !ValidateUtil.isFloat(waInnerWidth)){
			return false;
		}
		if(!ValidateUtil.isLength(waSequence,Constant.INT_32)){
			return false;
		}
		return true;
	}
}
