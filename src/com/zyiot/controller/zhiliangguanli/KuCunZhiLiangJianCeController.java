package com.zyiot.controller.zhiliangguanli;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.qualityChain.InstanceMsgFormMap;
import com.zyiot.entity.shouchu.InstorageQualityFormMap;
import com.zyiot.server.StorageServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/kucunzhiliangjiance")
public class KuCunZhiLiangJianCeController extends BaseController {
	
	@Autowired	
	private StorageServerI   sService;
	
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/zhiliangjiance/kucunzhiliangjiancelist";
	}
	@Token(save = true)
	@RequestMapping("/messageAddPage")
	public String messageAddPage(Model model) {
		return Common.BACKGROUND_PATH+ "/yewuguanlixitong/zhiliangguanli/zhiliangjiance/kucunzhiliangjiance/add";
	}
	
	@Token(save = true)
	@RequestMapping("/messageEditPage")
	public String messageEditPage(Model model) {
		try {
			model.addAttribute("InstanceMsgFormMap", sService.singleInstanceMsg(getPara("id")));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Common.BACKGROUND_PATH+ "/yewuguanlixitong/zhiliangguanli/zhiliangjiance/kucunzhiliangjiance/edit";
	}
	
	
	@RequestMapping(value = "/findByPage", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage queryProjects(int page, int rows) {
		try {
			InstanceMsgFormMap formMap = getFormMap(InstanceMsgFormMap.class);
			
			formMap.put("inorout", 2);
			List<Map> ls = sService.instanceMsgLists(page, rows, formMap);
			return toMyPage(ls);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	@Token(remove = true)
	@RequestMapping(value = "addInstanceMsg")
	@ResponseBody
	public Map<String, Object> addInstanceMsg() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			InstanceMsgFormMap formMap = getFormMap(InstanceMsgFormMap.class);
			InstorageQualityFormMap  formMap1 = getFormMap(InstorageQualityFormMap.class);
			
			String uuid=UUID.randomUUID().toString();
			
			FormMapUtil.toADDFormMap(formMap);
			formMap.put("qualityid", uuid);
			
			
			FormMapUtil.toADDFormMap(formMap1);
			formMap1.put("ID", uuid);
			
			sService.addInstanceMsg(formMap);
			sService.addQuailty(formMap1);
			
			result.put("data", true);
		} catch (Exception e) {
			result.put("data", false);
			e.printStackTrace();
		}
		return result;

	}
	
	@Token(remove = true)
	@RequestMapping("editInstanceMsg")
	@ResponseBody
	public String editInstanceMsg() {
		InstanceMsgFormMap formMap = getFormMap(InstanceMsgFormMap.class);
		
		InstorageQualityFormMap  formMap1 = getFormMap(InstorageQualityFormMap.class);
		
		
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
			
			FormMapUtil.toUPDATEFormMap(formMap1);
			
			sService.editInstanceMsg(formMap);
			sService.editQuailty(formMap1);
			
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

		return SUCCESS;
	}
	
	
	@RequestMapping("deleteInstanceMsg")
	@ResponseBody
	public String deleteInstanceMsg() {

		try {
			sService.deleteInstanceMsg(getPara("id"));
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
}
