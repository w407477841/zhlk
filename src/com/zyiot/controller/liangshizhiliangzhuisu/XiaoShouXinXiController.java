package com.zyiot.controller.liangshizhiliangzhuisu;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.qualityChain.SellMsgFormMap;
import com.zyiot.server.StorageServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/xiaoshouxinxi")
public class XiaoShouXinXiController extends BaseController {
	
	@Autowired	
	private StorageServerI   sService;
	
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/liangshizhiliangzhuisu/xiaoshouxinxilist";
	}
	
	@Token(save = true)
	@RequestMapping("/messageAddPage")
	public String messageAddPage(Model model) {
		return Common.BACKGROUND_PATH+ "/yewuguanlixitong/liangshizhiliangzhuisu/xiaoshouxinxi/add";
	}
	
	@Token(save = true)
	@RequestMapping("/messageEditPage")
	public String messageEditPage(Model model) {
		try {
			model.addAttribute("SellMsgFormMap", sService.singleSellMsg(getPara("id")));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Common.BACKGROUND_PATH+ "/yewuguanlixitong/liangshizhiliangzhuisu/xiaoshouxinxi/edit";
	}
	
	@RequestMapping(value = "/findByPage", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage queryProjects(int page, int rows) {
		try {
			SellMsgFormMap formMap = getFormMap(SellMsgFormMap.class);
			formMap.put("location", getPara("location"));
			formMap.put("houseid", getPara("houseid"));
			formMap.put("breed", getPara("breed"));
			List<SellMsgFormMap> ls = sService.sellMsgLists(page, rows, formMap);
			return toMyPage(ls);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	@Token(remove = true)
	@RequestMapping(value = "addSellMsg")
	@ResponseBody
	public Map<String, Object> addSellMsg() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			SellMsgFormMap formMap = getFormMap(SellMsgFormMap.class);
			FormMapUtil.toADDFormMap(formMap);
			sService.addSellMsg(formMap);
			result.put("data", true);
		} catch (Exception e) {
			result.put("data", false);
			e.printStackTrace();
		}
		return result;

	}
	
	@Token(remove = true)
	@RequestMapping("editSellMsg")
	@ResponseBody
	public String editSellMsg() {
		SellMsgFormMap formMap = getFormMap(SellMsgFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
			sService.editSellMsg(formMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
	
	
	@RequestMapping("deleteSellMsg")
	@ResponseBody
	public String deleteSellMsg() {

		try {
			sService.deleteSellMsg(getPara("id"));
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
	
}
