package com.zyiot.controller.mobile;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.mobile.MobileResourceFormMap;
import com.zyiot.entity.mobile.MobileRoleFormMap;
import com.zyiot.server.mobile.MobileResourceServerI;
import com.zyiot.server.mobile.MobileRoleServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.TreeObject;
import com.zyiot.util.TreeUtil;
@Controller
@RequestMapping("/mobile/role")
public class MobileRoleController extends BaseController {

	Logger log = Logger.getLogger(MobileRoleController.class);
	@Autowired
	private MobileRoleServerI mobileRoleServer;
	@Autowired
	private MobileResourceServerI mobileResourceServer;
	@RequestMapping("list")
	public String listUI() {
		return Constant.BACKGROUND_PATH + "/mobile/role/list";
	}
	
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<MobileRoleFormMap> findByPage(int rows,int page){
		MobileRoleFormMap mobileRoleFormMap = getFormMap(MobileRoleFormMap.class);
		List<MobileRoleFormMap> list = mobileRoleServer.findByPage(mobileRoleFormMap, rows, page);
		return toMyPage(list);
	}
	
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI() {
		return Constant.BACKGROUND_PATH + "/mobile/role/add";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove = true)
	public String add(){
		MobileRoleFormMap mobileRoleFormMap = getFormMap(MobileRoleFormMap.class);
		
		try {
			FormMapUtil.toADDFormMap(mobileRoleFormMap);
		} catch (Exception e) {
			log.error("===Class:MobileRoleController===Method:add===Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			mobileRoleServer.addMobileRole(mobileRoleFormMap);
		} catch (Exception e) {
			log.error("===Class:MobileRoleController===Method:add===Exception:addMobileRole=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model) {
		String id = getPara("id");
		MobileRoleFormMap mobileRoleFormMap = mobileRoleServer.findByRoleId(Integer.parseInt(id));
		model.addAttribute("mobileRoleFormMap", mobileRoleFormMap);
		return Constant.BACKGROUND_PATH + "/mobile/role/edit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove = true)
	public String edit(){
		MobileRoleFormMap mobileRoleFormMap = getFormMap(MobileRoleFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(mobileRoleFormMap);
		} catch (Exception e) {
			log.error("===Class:MobileRoleController===Method:edit===Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			mobileRoleServer.editMobileRole(mobileRoleFormMap);
		} catch (Exception e) {
			log.error("===Class:MobileRoleController===Method:edit===Exception:editMobileRole=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		try {
			mobileRoleServer.dropMobileRole(id);
		} catch (Exception e) {
			log.error("===Class:MobileRoleController===Method:delete===Exception:dropMobileRole=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("findBySelect")
	@ResponseBody
	public List<MobileRoleFormMap> findBySelect(){
		return mobileRoleServer.findBySelected(new MobileRoleFormMap());
	}
	
	@RequestMapping("editResUI")
	public String editResUI(Model model){
		 List<MobileResourceFormMap> mps= mobileResourceServer.findByAttr(new MobileResourceFormMap());
		 List<TreeObject> list = new ArrayList<TreeObject>();
		for (MobileResourceFormMap map : mps) {
			TreeObject ts = new TreeObject();
			Common.flushObject(ts, map);
			list.add(ts);
		}
		TreeUtil treeUtil = new TreeUtil();
		List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0);
		model.addAttribute("allRes",ns);
		return Common.BACKGROUND_PATH+"/mobile/role/editRes";
	}
	
	@RequestMapping("findRes")
	@ResponseBody
	public List<TreeObject> findRes(){
		
		MobileResourceFormMap mobileResourceFormMap = getFormMap(MobileResourceFormMap.class);
		List<MobileResourceFormMap> mps = mobileResourceServer.findByPermission(mobileResourceFormMap);
		List<TreeObject> list = new ArrayList<TreeObject>();
		for (MobileResourceFormMap map : mps) {
			TreeObject ts = new TreeObject();
			Common.flushObject(ts, map);
			list.add(ts);
		}
		TreeUtil treeUtil = new TreeUtil();
		List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0,"");
		return ns;
		
	}
	
	@RequestMapping("addRoleRes")
	@ResponseBody
	public String addRoleRes(HttpServletRequest request){
		MobileRoleFormMap mobileRoleFormMap=new MobileRoleFormMap();
		mobileRoleFormMap.put("roleId",getPara("roleId"));
		mobileRoleFormMap.put("resId", getParaValues("resId"));
		try {
			mobileRoleServer.editPermission(mobileRoleFormMap);
		} catch (Exception e) {
			log.error("===Class:MobileRoleController===Method:addRoleRes===Exception:editPermission=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
}
