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
import com.zyiot.entity.qualityChain.InstanceMsgFormMap;
import com.zyiot.entity.shouchu.InstorageQualityFormMap;
import com.zyiot.entity.shouchu.StorageFormMap;
import com.zyiot.entity.shouchu.WeightingFormMap;
import com.zyiot.server.StorageServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/rukuzhiliangxinxi")
public class RuKuZhiLiangXinXiController extends BaseController {
	
	@Autowired	
	private StorageServerI   sService;
	
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/liangshizhiliangzhuisu/rukuzhiliangxinxilist";
	}
	
	
	@Token(save = true)
	@RequestMapping("/messageAddPage")
	public String messageAddPage(Model model) {
		return Common.BACKGROUND_PATH+ "/yewuguanlixitong/liangshizhiliangzhuisu/churukubulu/add";
	}
	
	@Token(save = true)
	@RequestMapping("/messageEditPage")
	public String messageEditPage(Model model) {
		try {
			Map params=new HashMap();
			params.put("id", getPara("id"));
			model.addAttribute("StorageFormMap", sService.singleInstorage(params));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Common.BACKGROUND_PATH+ "/yewuguanlixitong/liangshizhiliangzhuisu/churukubulu/edit";
	}
	
	
	@RequestMapping(value = "/findByPage", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage queryProjects(int page, int rows) {
		try {
			Map formMap = new HashMap();
			formMap.put("location", getPara("location"));
			formMap.put("houseid",getPara("houseid") );
			formMap.put("id",getPara("id") );
			List<Map> ls = sService.tweenInstorage(page, rows, formMap);
			return toMyPage(ls);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	@RequestMapping("deleteInstanceMsg")
	@ResponseBody
	public String deleteInstanceMsg() {

		try {
			sService.removeInstorage(getPara("basicid"));
			sService.removeQuality(getPara("id"));
			sService.removeWeight(getPara("id" +
					""));
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
	
	
	@RequestMapping("updateInstorage_tween")
	@ResponseBody
	public String updateInstorage_tween() {

		try {
			InstorageQualityFormMap formMap1=getFormMap(InstorageQualityFormMap.class);
			
			WeightingFormMap formMap2=getFormMap(WeightingFormMap.class);
					
			StorageFormMap forMap3=getFormMap(StorageFormMap.class);
			
			FormMapUtil.toUPDATEFormMap(formMap1);
			
			FormMapUtil.toUPDATEFormMap(formMap2);
			
			FormMapUtil.toUPDATEFormMap(forMap3);
			
			sService.updateInstorage(forMap3);
			
			sService.updateWeight(formMap2);
			
			sService.updateQuality(formMap1);
			
			
			
			
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}
	
}
