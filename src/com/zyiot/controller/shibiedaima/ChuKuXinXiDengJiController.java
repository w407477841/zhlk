package com.zyiot.controller.shibiedaima;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.shibiedaima.OutRegisterFormMap;
import com.zyiot.server.shibiedaima.EnterpriseServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/chukuxinxidengji")
public class ChuKuXinXiDengJiController extends BaseController {
	@Autowired
	EnterpriseServerI enterpriseServer;
	
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shibiedaima/chukuxinxidengjilist";
	}
	@RequestMapping("/addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/chukuxinxidengji/add";
	}

	@RequestMapping("/editUI")
	public String editUI(Model model) {
		String id = getPara("id");

		model.addAttribute("OutRegisterFormMap", enterpriseServer.findOutFormById(id));
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/chukuxinxidengji/edit";
	}
	
	@RequestMapping("/shibiemaUI")
	public String shibiemaUI(Model model) {
		String id = getPara("id");
		
		model.addAttribute("OutRegisterFormMap", enterpriseServer.findOutFormById(id));
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/chukuxinxidengji/code";
	}

	@RequestMapping("/findByPage")
	@ResponseBody
	public MyPage findByPage(int page, int rows) {
		OutRegisterFormMap OutRegisterFormMap = getFormMap(OutRegisterFormMap.class);
		List<OutRegisterFormMap> list = enterpriseServer.findOutFormByPage(OutRegisterFormMap, rows, page);

		return toMyPage(list);
	}

	@RequestMapping("add")
	@ResponseBody
	public String add() {
		OutRegisterFormMap OutRegisterFormMap = getFormMap(OutRegisterFormMap.class);

		try {
			FormMapUtil.toADDFormMap(OutRegisterFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		try {
			enterpriseServer.addOutForm(OutRegisterFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteOne")
	@ResponseBody
	public String deleteOne() {
		OutRegisterFormMap OutRegisterFormMap = new OutRegisterFormMap();
		OutRegisterFormMap.put("id", getPara("id"));
		try {
			FormMapUtil.toDELETEFormMap(OutRegisterFormMap);
			enterpriseServer.deleteOutForm(OutRegisterFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("edit")
	@ResponseBody
	public String edit() {
		OutRegisterFormMap OutRegisterFormMap = getFormMap(OutRegisterFormMap.class);

		try {
			FormMapUtil.toUPDATEFormMap(OutRegisterFormMap);
		} catch (Exception e) {
			return ERROR;
		}
		try {
			enterpriseServer.editOutForm(OutRegisterFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
	
}
