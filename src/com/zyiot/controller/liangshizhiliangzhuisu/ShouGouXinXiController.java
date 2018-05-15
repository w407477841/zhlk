package com.zyiot.controller.liangshizhiliangzhuisu;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.FoodStoragePlanFormMap;
import com.zyiot.entity.FoodStorageProjectFormMap;
import com.zyiot.entity.FoodStorageWindFormMap;
import com.zyiot.entity.qualityChain.BuyMsgFormMap;
import com.zyiot.server.StorageServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/shougouxinxi")
public class ShouGouXinXiController extends BaseController {
	
	@Autowired	
	private StorageServerI   sService;
	
	
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/liangshizhiliangzhuisu/shougouxinxilist";
	}
	
	@Token(save = true)
	@RequestMapping("/messageAddPage")
	public String messageAddPage(Model model) {
		return Common.BACKGROUND_PATH+ "/yewuguanlixitong/liangshizhiliangzhuisu/shougouxinxi/add";
	}
	
	@Token(save = true)
	@RequestMapping("/messageEditPage")
	public String messageEditPage(Model model) {
		try {
			model.addAttribute("BuyMsgFormMap", sService.singleBuyMsg(getPara("id")));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Common.BACKGROUND_PATH+ "/yewuguanlixitong/liangshizhiliangzhuisu/shougouxinxi/edit";
	}
	
	@RequestMapping(value = "/findByPage", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage queryProjects(int page, int rows) {
		try {
			BuyMsgFormMap formMap = getFormMap(BuyMsgFormMap.class);
			formMap.put("company", getPara("company"));
			formMap.put("breed", getPara("breed"));
			List<BuyMsgFormMap> ls = sService.msgLists(page, rows, formMap);
			return toMyPage(ls);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	@Token(remove = true)
	@RequestMapping(value = "addBuyMsg")
	@ResponseBody
	public Map<String, Object> addBuyMsg() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			BuyMsgFormMap formMap = getFormMap(BuyMsgFormMap.class);
			FormMapUtil.toADDFormMap(formMap);
			sService.addBuyMsg(formMap);
			result.put("data", true);
		} catch (Exception e) {
			result.put("data", false);
			e.printStackTrace();
		}
		return result;

	}
	
	@Token(remove = true)
	@RequestMapping("editBuyMsg")
	@ResponseBody
	public String editBuyMsg() {
		BuyMsgFormMap formMap = getFormMap(BuyMsgFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
			sService.editBuyMsg(formMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
	
	
	@RequestMapping("deleteBuyMsg")
	@ResponseBody
	public String deleteBuyMsg() {

		try {
			sService.deleteBuyMsg(getPara("id"));
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
	
}
