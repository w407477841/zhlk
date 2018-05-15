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
import com.zyiot.entity.qualityChain.StoreMsgFormMap;
import com.zyiot.server.StorageServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/chucangzuoyexinxi")
public class ChuCangZuoYeXinXiController extends BaseController {
	
	@Autowired	
	private StorageServerI   sService;
	
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/liangshizhiliangzhuisu/chucangzuoyexinxilist";
	}


	@Token(save = true)
	@RequestMapping("/messageAddPage")
	public String messageAddPage(Model model) {
		return Common.BACKGROUND_PATH+ "/yewuguanlixitong/liangshizhiliangzhuisu/chucangzuoyexinxi/add";
	}
	
	@Token(save = true)
	@RequestMapping("/messageEditPage")
	public String messageEditPage(Model model) {
		try {
			model.addAttribute("StoreMsgFormMap", sService.singleStoreMsg(getPara("id")));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Common.BACKGROUND_PATH+ "/yewuguanlixitong/liangshizhiliangzhuisu/chucangzuoyexinxi/edit";
	}
	
	@RequestMapping(value = "/findByPage", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage queryProjects(int page, int rows) {
		try {
			StoreMsgFormMap formMap = getFormMap(StoreMsgFormMap.class);
			formMap.put("stime", getPara("stime"));
			formMap.put("etime", getPara("etime"));
			List<StoreMsgFormMap> ls = sService.storeMsgLists(page, rows, formMap);
			return toMyPage(ls);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	@Token(remove = true)
	@RequestMapping(value = "addStoreMsg")
	@ResponseBody
	public Map<String, Object> addStoreMsg() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			StoreMsgFormMap formMap = getFormMap(StoreMsgFormMap.class);
			FormMapUtil.toADDFormMap(formMap);
			sService.addStoreMsg(formMap);
			result.put("data", true);
		} catch (Exception e) {
			result.put("data", false);
			e.printStackTrace();
		}
		return result;

	}
	
	@Token(remove = true)
	@RequestMapping("editStoreMsg")
	@ResponseBody
	public String editStoreMsg() {
		StoreMsgFormMap formMap = getFormMap(StoreMsgFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
			sService.editStoreMsg(formMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
	
	
	@RequestMapping("deleteStoreMsg")
	@ResponseBody
	public String deleteStoreMsg() {

		try {
			sService.deleteStoreMsg(getPara("id"));
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
	
}
