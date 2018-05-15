package com.zyiot.controller.mobile;

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
import com.zyiot.entity.mobile.MobileResourceFormMap;
import com.zyiot.server.mobile.MobileResourceServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.TreeObject;
import com.zyiot.util.TreeUtil;

@Controller
@RequestMapping("/mobile/resource")
public class MobileResourceController extends BaseController {
	Logger log = Logger.getLogger(MobileResourceController.class);
	@Autowired
	private MobileResourceServerI mobileResourceServer;

	@RequestMapping("list")
	public String listUI() {
		return Constant.BACKGROUND_PATH + "/mobile/resource/list";
	}

	@RequestMapping("findResTreeGrid")
	@ResponseBody
	public List<TreeObject> findResTreeGrid() {
		List<MobileResourceFormMap> mps = mobileResourceServer
				.findByAttr(new MobileResourceFormMap());
		List<TreeObject> list = new ArrayList<TreeObject>();
		for (MobileResourceFormMap map : mps) {
			TreeObject ts = new TreeObject();
			Common.flushObject(ts, map);
			list.add(ts);
		}
		TreeUtil treeUtil = new TreeUtil();
		List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0);
		return ns;
	}

	@RequestMapping("addUI")
	@Token(save = true)
	public String addUI() {
		return Constant.BACKGROUND_PATH + "/mobile/resource/add";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		MobileResourceFormMap mobileResourceFormMap = getFormMap(MobileResourceFormMap.class);
		try {
			FormMapUtil.toADDFormMap(mobileResourceFormMap);
		} catch (Exception e) {
			log.error("===Class:MobileResourceController===Method:add===Exception:toADDFormMap==="+e);
			return ERROR;
		}
		try {
			mobileResourceServer.addMobileResource(mobileResourceFormMap);
		} catch (Exception e) {
			log.error("===Class:MobileResourceController===Method:add===Exception:addMobileResource==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save = true)
	public String editUI(Model model) {
		String id = getPara("id");
		MobileResourceFormMap mobileResourceFormMap = mobileResourceServer.findById(Integer.parseInt(id));
		model.addAttribute("mobileResourceFormMap", mobileResourceFormMap);
		return Constant.BACKGROUND_PATH + "/mobile/resource/edit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		MobileResourceFormMap mobileResourceFormMap = getFormMap(MobileResourceFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(mobileResourceFormMap);
		} catch (Exception e) {
			log.error("===Class:MobileResourceController===Method:edit===Exception:toUPDATEFormMap==="+e);
			return ERROR;
		}
		try {
			mobileResourceServer.editMobileResource(mobileResourceFormMap);
		} catch (Exception e) {
			log.error("===Class:MobileResourceController===Method:edit===Exception:editMobileResource==="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("deleteAll")
	@ResponseBody
	public String deleteAll(){
		String id = getPara("id");
		String[] ids = id.split(",");
		List<String> list = new ArrayList<String>();
		if(ids != null && ids.length>0){
			for(String s:ids){
				list.add(s);
			}
		}
		
		try {
			mobileResourceServer.dropMobileResource(list);
		} catch (Exception e) {
			log.error("===Class:MobileResourceController===Method:deleteAll===Exception:dropMobileResource==="+e);
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping("findAllParent")
	@ResponseBody
	public List<TreeObject> findAllParent() {
		List<MobileResourceFormMap> mps = mobileResourceServer
				.findByAttr(new MobileResourceFormMap());
		List<TreeObject> list = new ArrayList<TreeObject>();
		for (MobileResourceFormMap map : mps) {
			TreeObject ts = new TreeObject();
			Common.flushObject(ts, map);
			list.add(ts);
		}
		TreeUtil treeUtil = new TreeUtil();
		List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0, "　");
		return ns;
	}

}
