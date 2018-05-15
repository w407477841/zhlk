package com.zyiot.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;
import com.zyiot.entity.CodeFormMap;
import com.zyiot.entity.CodeItemFormMap;
import com.zyiot.entity.ResFormMap;
import com.zyiot.server.CodeServerI;
import com.zyiot.util.Common;
import com.zyiot.util.EhcacheUtils;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.POIUtils;
import com.zyiot.util.TreeObject;
import com.zyiot.util.TreeUtil;

@Controller
@RequestMapping("code")
public class CodeController extends BaseController {
	@Autowired
	CodeServerI codeServer;
	
@RequestMapping("listUI")
	public String ListUI(){
		
		return Common.BACKGROUND_PATH+"/system/code/list";
	}
@RequestMapping("findCodeByPage")
@ResponseBody
public MyPage findCodeByPage(int page,int rows){
	CodeFormMap codeFormMap=getFormMap(CodeFormMap.class);
	List<CodeFormMap> l=codeServer.findCodeByPage(codeFormMap, rows, page);
	PageInfo ret=new PageInfo(l);
	MyPage<CodeFormMap> retpage=new MyPage<CodeFormMap>();
	retpage.setRows(ret.getList());
	retpage.setTotal(ret.getTotal());
	retpage.setPageSize(ret.getPageSize());
	retpage.setPageNum(ret.getPageNum());	
	return retpage;
}
@RequestMapping("findCodeItemTreeGrid")
@ResponseBody
public List<TreeObject> findCodeItemTreeGrid(){
	CodeItemFormMap codeItemFormMap=getFormMap(CodeItemFormMap.class);
	 List<CodeItemFormMap> mps= codeServer.findCodeItemByAttr(codeItemFormMap);
	 List<TreeObject> list = new ArrayList<TreeObject>();
	for (CodeItemFormMap map : mps) {
		TreeObject ts = new TreeObject();
		Common.flushObject(ts, map);
		list.add(ts);
	}
	TreeUtil treeUtil = new TreeUtil();
	List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0);
		return ns;
}
@RequestMapping("editCodeListOne")
@ResponseBody
public String editCodeListOne(){
	CodeFormMap codeFormMap=getFormMapNoName(CodeFormMap.class);
	if(codeFormMap.get("id")==null||codeFormMap.get("id").equals("")){
		try {
			FormMapUtil.toADDFormMap(codeFormMap);
		} catch (Exception e) {
			return ERROR;
		}
		
		try {
			codeServer.addCode(codeFormMap);
		} catch (Exception e) {
			return ERROR;
		}
		
	}
	else{
	
	try {
		FormMapUtil.toUPDATEFormMap(codeFormMap);
	} catch (Exception e) {
		return ERROR;
	}
	
	try {
		codeServer.editCode(codeFormMap);
	} catch (Exception e) {
		return ERROR;
		}
	
	}
	return SUCCESS;
}
@RequestMapping("editCodeItemListOne")
@ResponseBody
public String editCodeItemListOne(){
	CodeItemFormMap codeItemFormMap=getFormMapNoName(CodeItemFormMap.class);
	if(codeItemFormMap.get("id")==null||codeItemFormMap.get("id").equals("")){
		try {
			FormMapUtil.toADDFormMap(codeItemFormMap);
		} catch (Exception e) {
			return ERROR;
		}
		try {
			codeServer.addCodeItem(codeItemFormMap);
		} catch (Exception e) {
			return ERROR;
		}
		
	}
	else{
		
		try {
			FormMapUtil.toUPDATEFormMap(codeItemFormMap);
		} catch (Exception e) {
			return ERROR;
		}
		
		try {
			codeServer.editCodeItem(codeItemFormMap);
		} catch (Exception e) {
			return ERROR;
		}
	}
	
	
	return SUCCESS;
}
@RequestMapping("deleteCodeItemAll")
@ResponseBody
public String deleteCodeItemAll(){
	
	String id= getPara("id");
	CodeItemFormMap codeItemFormMap=new CodeItemFormMap();
	codeItemFormMap.put("value",id);
	
	try {
		FormMapUtil.toDELETEFormMap(codeItemFormMap);
	} catch (Exception e) {
		return ERROR;
	}
	
	try {
		codeServer.deleteCodeItem(codeItemFormMap);
	} catch (Exception e) {
		return ERROR;
	}
	
	return SUCCESS;
}

@RequestMapping("deleteCodeOne")
@ResponseBody
public String deleteCodeOne(int id){
	try {
		codeServer.deleteCode(id);
	} catch (Exception e) {
		return ERROR;
	}
	
	return SUCCESS;
}

@RequestMapping("uploadCodeItem")
@ResponseBody
public String uploadCodeItem(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, ModelMap model){
	List<CodeItemFormMap> l=null;
	try {
		l=POIUtils.getList(file.getInputStream(), new CodeItemFormMap(),null, null);
	} catch (Exception e) {
		return "POI异常";
	}
	
	try {
		codeServer.batchSaveCodeItem(l);
	} catch (Exception e) {
		List<String> errorList= (List<String>) EhcacheUtils.get(Thread.currentThread().getName());
		String error="";
		EhcacheUtils.remove(Thread.currentThread().getName());//删除错误信息
		for(int i=0;i<errorList.size();i++){
			System.out.println(errorList.get(i));
			error+=errorList.get(i);
		}
		return error;
	}
	List<String> errorList= (List<String>) EhcacheUtils.get(Thread.currentThread().getName());
	String error="";
	EhcacheUtils.remove(Thread.currentThread().getName());//删除错误信息
	for(int i=0;errorList!=null&&i<errorList.size();i++){
		System.out.println(errorList.get(i));
		error+=errorList.get(i);
		}
	return SUCCESS+error;
	}
}