package com.zyiot.controller.weight;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.weight.VarietyFormMap;
import com.zyiot.server.weight.VarietyServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.ValidateUtil;
import com.zyiot.util.VarietyTreeObject;
import com.zyiot.util.VarietyTreeUtil;

/**
 * 品种档案
 * 
 * @author Lip
 * @date 2017年4月25日 上午10:51:01
 */

@Controller
@RequestMapping("variety")
public class VarietyController extends BaseController {
	Logger log = Logger.getLogger(VarietyController.class);

	@Autowired
	private VarietyServerI varietyServer;

	@RequestMapping("list")
	public String list() {
		return Constant.BACKGROUND_PATH + "/weight/variety/list";
	}

	@RequestMapping("findTreeGrid")
	@ResponseBody
	public List<VarietyTreeObject> findTreeGrid() {
		List<VarietyFormMap> mps = varietyServer.findAll();
		List<VarietyTreeObject> list = new ArrayList<VarietyTreeObject>();
		for (VarietyFormMap map : mps) {
			VarietyTreeObject ts = new VarietyTreeObject();
			Common.flushObject(ts, map);
			list.add(ts);
		}
		VarietyTreeUtil treeUtil = new VarietyTreeUtil();
		
		List<VarietyTreeObject> ns = treeUtil.getChildVarietyTreeObjects(list, 0);
		return ns;
	}
	@RequestMapping("lookUI")
	public String lookUI(Model model){
		String id = getPara("id");
		VarietyFormMap varietyFormMap = varietyServer.findVarietyById(Integer.parseInt(id));
		model.addAttribute("varietyFormMap", varietyFormMap);
		return Constant.BACKGROUND_PATH+"/weight/variety/look";
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String edit(Model model){
		String id = getPara("id");
		VarietyFormMap varietyFormMap = varietyServer.findVarietyById(Integer.parseInt(id));
		model.addAttribute("varietyFormMap", varietyFormMap);
		return Constant.BACKGROUND_PATH+"/weight/variety/edit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		VarietyFormMap varietyFormMap = getFormMap(VarietyFormMap.class);
		if(!validData(varietyFormMap)){
			return ERROR;
		}
		String isEnable = varietyFormMap.getStr("isEnable");
		if(isEnable == null){
			varietyFormMap.set("isEnable", "1");
		}
		try {
			FormMapUtil.toUPDATEFormMap(varietyFormMap);
		} catch (Exception e) {
			log.error("==Class:VarietyController==Method:edit==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			varietyServer.editVariety(varietyFormMap);
		} catch (Exception e) {
			log.error("==Class:VarietyController==Method:edit==Exception:editVariety=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("findByVarietyId")
	@ResponseBody
	public VarietyFormMap VarietyFormMap(){
		String id = getPara("id");
		VarietyFormMap varietyFormMap = varietyServer.findVarietyById(Integer.parseInt(id));
		return varietyFormMap;
	}
	/**
	 * 查找可用的品种档案
	 * @return
	 */
	@RequestMapping("findEnableVariety")
	@ResponseBody
	public List<VarietyFormMap> findEnableVariety(){
		return varietyServer.findEnableVariety();
	}
	/**
	 * 查找首级菜单品种档案
	 * @return
	 */
	@RequestMapping("findTopMenuVariety")
	@ResponseBody
	public List<VarietyFormMap> findTopMenuVariety(){
		return varietyServer.findTopMenuVariety();
	}
	
	public boolean validData(VarietyFormMap varietyFormMap){
		String text = varietyFormMap.getStr("text");
		String definedText = varietyFormMap.getStr("definedText");
		String salePrice = varietyFormMap.getStr("salePrice");
		String buyPrice = varietyFormMap.getStr("buyPrice");
		String rankPrice = varietyFormMap.getStr("rankPrice");
		if(ValidateUtil.isEmpty(text) || !ValidateUtil.isLength(text, Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(definedText, Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isFloat(salePrice)){
			return false;
		}
		if(!ValidateUtil.isFloat(buyPrice)){
			return false;
		}
		if(!ValidateUtil.isFloat(rankPrice)){
			return false;
		}
		
		
		return true;
	}
	
}
