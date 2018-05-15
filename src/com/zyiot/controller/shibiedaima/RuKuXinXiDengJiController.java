package com.zyiot.controller.shibiedaima;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.shibiedaima.InRegisterFormMap;
import com.zyiot.server.shibiedaima.EnterpriseServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/rukuxinxidengji")
public class RuKuXinXiDengJiController extends BaseController {
	
	@Autowired
	EnterpriseServerI enterpriseServer;
	
	
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shibiedaima/rukuxinxidengjilist";
	}


	@RequestMapping("/addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/rukuxinxidengji/add";
	}


	@RequestMapping("/editUI")
	public String editUI(Model model) {
		String id = getPara("id");
		model.addAttribute("InRegisterFormMap", enterpriseServer.findInFormById(id));
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/rukuxinxidengji/edit";
	}
	
	@RequestMapping("/shibiemaUI")
	public String shibiemaUI(Model model) {
		String id = getPara("id");
		
		model.addAttribute("InRegisterFormMap", enterpriseServer.findOneInForm(id));
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/rukuxinxidengji/code";
	}

	@RequestMapping("/findByPage")
	@ResponseBody
	public MyPage findByPage(int page, int rows) {
		InRegisterFormMap InRegisterFormMap = getFormMap(InRegisterFormMap.class);
		List<InRegisterFormMap> list = enterpriseServer.findInFormByPage(InRegisterFormMap, rows, page);

		return toMyPage(list);
	}

	@RequestMapping("add")
	@ResponseBody
	public String add() {
		InRegisterFormMap InRegisterFormMap = getFormMap(InRegisterFormMap.class);

		try {
			FormMapUtil.toADDFormMap(InRegisterFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		try {
			enterpriseServer.addInForm(InRegisterFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteOne")
	@ResponseBody
	public String deleteOne() {
		InRegisterFormMap InRegisterFormMap = new InRegisterFormMap();
		InRegisterFormMap.put("id", getPara("id"));
		try {
			FormMapUtil.toDELETEFormMap(InRegisterFormMap);
			enterpriseServer.deleteInForm(InRegisterFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("edit")
	@ResponseBody
	public String edit() {
		InRegisterFormMap InRegisterFormMap = getFormMap(InRegisterFormMap.class);

		try {
			FormMapUtil.toUPDATEFormMap(InRegisterFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		try {
			enterpriseServer.editInForm(InRegisterFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
	
}
