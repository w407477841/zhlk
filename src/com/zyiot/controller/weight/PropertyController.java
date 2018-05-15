package com.zyiot.controller.weight;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.weight.PropertyFormMap;
import com.zyiot.server.weight.PropertyServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.TreeObject;
import com.zyiot.util.TreeUtil;
/**
 * 粮食性质
 * @author Lip
 * @date 2017年7月14日 下午5:17:46
 */
@Controller
@RequestMapping("property")
public class PropertyController extends BaseController {
	Logger log = Logger.getLogger(PropertyController.class);
	@Autowired
	private PropertyServerI propertyServer;
	@RequestMapping("list")
	public String listUI(){
		return Constant.BACKGROUND_PATH+"/weight/property/list";
	}
	
	public String editUI(){
		return Constant.BACKGROUND_PATH+"";
	}
	
	@RequestMapping("findAll")
	@ResponseBody
	public List<TreeObject> findAll(){
		List<PropertyFormMap> list = propertyServer.findAllProperty();
		List<TreeObject> treeList = new ArrayList<TreeObject>();
		for(PropertyFormMap property:list){
			TreeObject tree = new TreeObject();
			Common.flushObject(tree, property);
			treeList.add(tree);
		}
		TreeUtil treeUtil = new TreeUtil();
		return treeUtil.getChildTreeObjects(treeList, 0);
	}
	
	@RequestMapping("findEnable")
	@ResponseBody
	public List<PropertyFormMap> findEnable(){
		return propertyServer.findEnableProperty();
	}
	
	@RequestMapping("findAllProperty")
	@ResponseBody
	public List<PropertyFormMap> findAllProperty(){
		return propertyServer.findAllProperty();
	}
	@RequestMapping("edit")
	@ResponseBody
	public String edit(){
		String id = getPara("id");
		String isEnable = getPara("isEnable");
		PropertyFormMap  propertyFormMap = new PropertyFormMap();
		propertyFormMap.set("id", id);
		propertyFormMap.set("isEnable", isEnable);
		
		try {
			FormMapUtil.toUPDATEFormMap(propertyFormMap);
		} catch (Exception e) {
			log.error("===Class:PropertyController===Method:edit===Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			propertyServer.editPropertyFormMap(propertyFormMap);
		} catch (Exception e) {
			log.error("===Class:PropertyController===Method:edit===Exception:editPropertyFormMap=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
}
