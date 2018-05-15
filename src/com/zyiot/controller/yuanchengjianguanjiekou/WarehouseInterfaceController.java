package com.zyiot.controller.yuanchengjianguanjiekou;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.yuanchengjiankongjiekou.WarehouseInterfaceFormMap;
import com.zyiot.server.yuanchengjiankongjiekou.WarehouseInterfaceServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("warehouseInterface")
public class WarehouseInterfaceController extends BaseController {
	Logger log = Logger.getLogger(WarehouseLocationInterfaceController.class);
	@Autowired
	private WarehouseInterfaceServerI warehouseInterfaceServer;
	
	@RequestMapping("list")
	public String listUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/yuanchengjianguanjiekou/cangfangjiekou/list";
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/yuanchengjianguanjiekou/cangfangjiekou/add";
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		String id = getPara("id");
		WarehouseInterfaceFormMap warehouseInterfaceFormMap = warehouseInterfaceServer.findById(id);
		model.addAttribute("warehouseInterfaceFormMap", warehouseInterfaceFormMap);
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/yuanchengjianguanjiekou/cangfangjiekou/edit";
	}
	
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<WarehouseInterfaceFormMap> findByPage(int page,int rows){
		WarehouseInterfaceFormMap warehouseLocation = getFormMap(WarehouseInterfaceFormMap.class);
		List<WarehouseInterfaceFormMap> list = warehouseInterfaceServer.findByPage(warehouseLocation, rows, page);
		return toMyPage(list);
	}
	
	
	@RequestMapping("add")
	@ResponseBody
	@Token(remove = true)
	public String add(){
		WarehouseInterfaceFormMap warehouseInterfaceFormMap = getFormMap(WarehouseInterfaceFormMap.class);
		
		try {
			FormMapUtil.toADDFormMap(warehouseInterfaceFormMap);
		} catch (Exception e) {
			log.error("===Class:WarehouseInterfaceController==Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			warehouseInterfaceServer.addWarehouse(warehouseInterfaceFormMap);
		} catch (Exception e) {
			log.error("===Class:WarehouseInterfaceController==Method:add==Exception:addWarehouse=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove = true)
	public String edit(){
		WarehouseInterfaceFormMap warehouseInterfaceFormMap = getFormMap(WarehouseInterfaceFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(warehouseInterfaceFormMap);
		} catch (Exception e) {
			log.error("===Class:WarehouseInterfaceController==Method:edit==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			warehouseInterfaceServer.editWarehouse(warehouseInterfaceFormMap);
		} catch (Exception e) {
			log.error("===Class:WarehouseInterfaceController==Method:edit==Exception:editWarehouse=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		try {
			warehouseInterfaceServer.dropWarehouse(id);
		} catch (Exception e) {
			log.error("===Class:WarehouseInterfaceController==Method:delete==Exception:dropWarehouse=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
}
