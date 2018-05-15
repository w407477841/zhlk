package com.zyiot.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.entity.ResFormMap;
import com.zyiot.entity.RoleResFormMap;
import com.zyiot.entity.UserResFormMap;
import com.zyiot.server.ResourcesServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.TreeObject;
import com.zyiot.util.TreeUtil;

@Controller
@RequestMapping("resources")
public class ResoucresController extends BaseController{
	@Autowired
	ResourcesServerI resourcesServer;


@RequestMapping("findResourcesByPage")
@ResponseBody
	public MyPage<ResFormMap> findResourcesByPage(int page, int rows) {
		ResFormMap res=getFormMap(ResFormMap.class);
		List<ResFormMap> l=	resourcesServer.findResByPage(res, page,rows);
		return toMyPage(l);
	}

@RequestMapping("findResTreeGrid")
@ResponseBody
	public List<TreeObject> findResTreeGrid() {
	
	 List<ResFormMap> mps= resourcesServer.findAllRes();
	 List<TreeObject> list = new ArrayList<TreeObject>();
	for (ResFormMap map : mps) {
		TreeObject ts = new TreeObject();
		Common.flushObject(ts, map);
		list.add(ts);
	}
	TreeUtil treeUtil = new TreeUtil();
	List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0);
		return ns;
	}

@RequestMapping("findResTreeList")
@ResponseBody
	public List<TreeObject> findResTreeList() {
	
	 List<ResFormMap> mps= resourcesServer.findAllRes();
	 List<TreeObject> list = new ArrayList<TreeObject>();
	for (ResFormMap map : mps) {
		TreeObject ts = new TreeObject();
		Common.flushObject(ts, map);
		list.add(ts);
	}
	TreeUtil treeUtil = new TreeUtil();
	List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0,"　");
		return ns;
	}

@RequestMapping("findAllParent")
@ResponseBody
	public List<TreeObject> findAllParent() {
	
	 List<ResFormMap> mps= resourcesServer.findAllParent();
	 List<TreeObject> list = new ArrayList<TreeObject>();
	for (ResFormMap map : mps) {
		TreeObject ts = new TreeObject();
		Common.flushObject(ts, map);
		list.add(ts);
	}
	TreeUtil treeUtil = new TreeUtil();
	List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0,"　");
		return ns;
	}


@RequestMapping("findRes")
@ResponseBody
public List<TreeObject> findRes(){
	
	ResFormMap resFormMap = getFormMap(ResFormMap.class);
	List<ResFormMap> mps = resourcesServer.findRes(resFormMap);
	//List<ResFormMap> mps = resourcesMapper.findByWhere(new ResFormMap());
	List<TreeObject> list = new ArrayList<TreeObject>();
	for (ResFormMap map : mps) {
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
	
	ResFormMap res=new ResFormMap();
	res.put("roleId",getPara("roleId"));
	res.put("userId",getPara("userId") );
	res.put("resId", getParaValues("resId"));
	try {
		resourcesServer.editRoleRes(res);
	} catch (Exception e) {
		e.printStackTrace();
		return ERROR;
	}
	
	return SUCCESS;
}

@RequestMapping("editListOne")
@ResponseBody
public String editListOne(){
	
	ResFormMap res=getFormMapNoName(ResFormMap.class);
	if("".equals(res.getStr("name")))   return "error";
	try {
		FormMapUtil.toUPDATEFormMap(res);
	} catch (Exception e) {
		return "error";
	}
	
	try {
		resourcesServer.edit(res);
	} catch (Exception e) {
	  return "error";
	}
	
	return "success";
}
@RequestMapping("deleteOne")
@ResponseBody
public String deleteOne(){
	String id=getPara("id");
	try {
		resourcesServer.deleteByKey("id", id);
	} catch (Exception e) {
		e.printStackTrace();
		return "error";
	}
	
	return "success";
}
@RequestMapping("deleteAll")
@ResponseBody
public String deleteAll(){
	ResFormMap res=getFormMapNoName(ResFormMap.class);
	UserResFormMap uRes=new UserResFormMap();
	RoleResFormMap rRes=new RoleResFormMap();
	uRes.put("resId",res.get("id"));
	rRes.put("resId",res.get("id"));
	try {
		FormMapUtil.toDELETEFormMap(res);
		FormMapUtil.toDELETEFormMap(uRes);
		FormMapUtil.toDELETEFormMap(rRes);
	} catch (Exception e1) {
		return "error";
	}
	
	try {
		resourcesServer.deleteAll(res,uRes,rRes);
	} catch (Exception e) {
		e.printStackTrace();
		return "error";
	}
	
	return "success";
}

@RequestMapping("editOne")
@Token(remove=true)
@ResponseBody
public String editOne(){
	ResFormMap res=	getFormMap2Edit(ResFormMap.class);
	try {
		FormMapUtil.toUPDATEFormMap(res);
	} catch (Exception e) {
		return "error";
	}
	try {
		resourcesServer.edit(res);
	} catch (Exception e) {
		return "error";
	}
	return "success";
}

@RequestMapping("add")
@ResponseBody
public String add(){
	ResFormMap res=	getFormMap(ResFormMap.class);
	try {
		FormMapUtil.toADDFormMap(res);
	} catch (Exception e) {
		return "error";
	}
	try {
		resourcesServer.add(res);
	} catch (Exception e) {
		return "error";
	}
	return "success";
}

@RequestMapping("treeListUI")
public String treeListUI() {
	return Constant.BACKGROUND_PATH + "/system/resources/treelist";
}

@RequestMapping("addUI")
public String addUi(){
	return Common.BACKGROUND_PATH+"/system/resources/add";
}


@RequestMapping("editUI")
@Token(save=true)
public String editUi(Model model){
	model.addAttribute("resFormMap",resourcesServer.findResById(getPara("id")));
	return Common.BACKGROUND_PATH+"/system/resources/edit";
}


/**
 * 页面跳转结束
 */
}
