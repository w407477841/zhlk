package com.zyiot.controller.shibiedaima;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.shibiedaima.EnterpriseFormMap;
import com.zyiot.server.shibiedaima.EnterpriseServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/qiyexinxiweihu")
public class QiYeXinXiWeiHuController extends BaseController {
	@Autowired
	EnterpriseServerI enterpriseServer;

	@RequestMapping("/listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/qiyexinxiweihulist";
	}

	@RequestMapping("/addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/qiyexinxiweihuadd";
	}

	@RequestMapping("/shibiemaUI")
	public String shibiemaUI(Model model) {
		String id = getPara("id");

		model.addAttribute("enterpriseFormMap", enterpriseServer.findById(id));
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/qiyexinxiweihushibiema";
	}

	@RequestMapping("/editUI")
	public String editUI(Model model) {
		String id = getPara("id");

		model.addAttribute("enterpriseFormMap", enterpriseServer.findById(id));
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/qiyexinxiweihuedit";
	}

	@RequestMapping("/findByPage")
	@ResponseBody
	public MyPage<EnterpriseFormMap> findByPage(int page, int rows) {
		EnterpriseFormMap enterpriseFormMap = getFormMap(EnterpriseFormMap.class);
		List<EnterpriseFormMap> list = enterpriseServer.findByPage(
				enterpriseFormMap, rows, page);

		return toMyPage(list);
	}

	@RequestMapping("add")
	@ResponseBody
	public String add() {
		EnterpriseFormMap enterpriseFormMap = getFormMap(EnterpriseFormMap.class);

		try {
			FormMapUtil.toADDFormMap(enterpriseFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		try {
			enterpriseServer.add(enterpriseFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteOne")
	@ResponseBody
	public String deleteOne() {
		String id = getPara("id");
		try {
			enterpriseServer.delete(id);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("edit")
	@ResponseBody
	public String edit() {
		EnterpriseFormMap enterpriseFormMap = getFormMap(EnterpriseFormMap.class);

		try {
			FormMapUtil.toUPDATEFormMap(enterpriseFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		try {
			enterpriseServer.edit(enterpriseFormMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
}
