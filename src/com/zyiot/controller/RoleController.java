package com.zyiot.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.entity.ResFormMap;
import com.zyiot.entity.RoleFormMap;
import com.zyiot.server.ResourcesServerI;
import com.zyiot.server.RoleServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.TreeObject;
import com.zyiot.util.TreeUtil;

@Controller
@RequestMapping("role")
public class RoleController extends BaseController {
	@Autowired
	RoleServerI roleServer;
	@Autowired
	ResourcesServerI resourcesServer;

	@RequestMapping("findRoleByPage")
	@ResponseBody
	public MyPage<RoleFormMap> findRoleByPage(int page, int rows) {
		RoleFormMap role = getFormMap(RoleFormMap.class);
		List<RoleFormMap> l = roleServer.findRoleByPage(role, rows, page);
		return toMyPage(l);
	}

	@RequestMapping("findAllRole")
	@ResponseBody
	public List<RoleFormMap> findAllRole() {
		return roleServer.findRoleByAttr(new RoleFormMap());
	}

	@RequestMapping("editListOne")
	@ResponseBody
	public String editListOne() {
		RoleFormMap role = getFormMapNoName(RoleFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(role);
		} catch (Exception e) {
			return ERROR;
		}

		try {
			roleServer.edit(role);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteOne")
	@ResponseBody
	public String deleteOne() {
		try {
			roleServer.delete("id", getPara("id"));
		} catch (Exception e) {
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping("add")
	@ResponseBody
	public String add() {
		RoleFormMap role = getFormMap(RoleFormMap.class);
		try {
			FormMapUtil.toADDFormMap(role);
		} catch (Exception e) {
			return ERROR;
		}
		try {
			roleServer.add(role);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH + "/system/role/list";
	}

	@RequestMapping("addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH + "/system/role/add";
	}

	@RequestMapping("editResUI")
	public String editResUI(Model model) {
		List<ResFormMap> mps = resourcesServer.findAllRes();
		List<TreeObject> list = new ArrayList<TreeObject>();
		for (ResFormMap map : mps) {
			TreeObject ts = new TreeObject();
			Common.flushObject(ts, map);
			list.add(ts);
		}
		TreeUtil treeUtil = new TreeUtil();
		List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0);
		model.addAttribute("allRes", ns);
		return Common.BACKGROUND_PATH + "/system/role/editRes";
	}
}
