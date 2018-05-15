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
import com.zyiot.entity.yuanchengjiankongjiekou.WarehouseLocationInterfaceFormMap;
import com.zyiot.server.yuanchengjiankongjiekou.WarehouseLocationInterfaceServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
@Controller
@RequestMapping("warehouseLocationInterface")
public class WarehouseLocationInterfaceController extends BaseController {
	Logger log = Logger.getLogger(WarehouseLocationInterfaceController.class);
	@Autowired
	private WarehouseLocationInterfaceServerI warehouseLocationInterfaceServer;
	
	@RequestMapping("list")
	public String listUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/yuanchengjianguanjiekou/cangkujiekou/list";
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/yuanchengjianguanjiekou/cangkujiekou/add";
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		String id = getPara("id");
		WarehouseLocationInterfaceFormMap warehouseLocationInterfaceFormMap = warehouseLocationInterfaceServer.findById(id);
		model.addAttribute("warehouseLocationInterfaceFormMap", warehouseLocationInterfaceFormMap);
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/yuanchengjianguanjiekou/cangkujiekou/edit";
	}
	
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<WarehouseLocationInterfaceFormMap> findByPage(int page,int rows){
		WarehouseLocationInterfaceFormMap warehouseLocation = getFormMap(WarehouseLocationInterfaceFormMap.class);
		List<WarehouseLocationInterfaceFormMap> list = warehouseLocationInterfaceServer.findByPage(warehouseLocation, rows, page);
		return toMyPage(list);
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove = true)
	public String add(){
		WarehouseLocationInterfaceFormMap warehouseLocationInterfaceFormMap = getFormMap(WarehouseLocationInterfaceFormMap.class);
		
		try {
			FormMapUtil.toADDFormMap(warehouseLocationInterfaceFormMap);
		} catch (Exception e) {
			log.error("===Class:WarehouseLocationInterfaceController==Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			warehouseLocationInterfaceServer.addWarehouseLocation(warehouseLocationInterfaceFormMap);
		} catch (Exception e) {
			log.error("===Class:WarehouseLocationInterfaceController==Method:add==Exception:addWarehouseLocation=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove = true)
	public String edit(){
		WarehouseLocationInterfaceFormMap warehouseLocationInterfaceFormMap = getFormMap(WarehouseLocationInterfaceFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(warehouseLocationInterfaceFormMap);
		} catch (Exception e) {
			log.error("===Class:WarehouseLocationInterfaceController==Method:edit==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			warehouseLocationInterfaceServer.editWarehouseLocation(warehouseLocationInterfaceFormMap);
		} catch (Exception e) {
			log.error("===Class:WarehouseLocationInterfaceController==Method:edit==Exception:editWarehouseLocation=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		try {
			warehouseLocationInterfaceServer.dropWarehouseLocation(id);
		} catch (Exception e) {
			log.error("===Class:WarehouseLocationInterfaceController==Method:delete==Exception:dropWarehouseLocation=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("xinyongdaima")
	@ResponseBody
	public WarehouseLocationInterfaceFormMap findByXinYongDaiMa(){
		String xinyongdaima = getPara("id");
		return warehouseLocationInterfaceServer.findByXinYongDaiMa(xinyongdaima);
	}
	@RequestMapping(value = "findAllMingCheng", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<WarehouseLocationInterfaceFormMap> findAllMingCheng(){
		List<WarehouseLocationInterfaceFormMap> list =  warehouseLocationInterfaceServer.findAllMingCheng();
		return list;
	}
	@RequestMapping( value = "findAllByXinYongDaiMa", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<WarehouseLocationInterfaceFormMap> findAllByXinYongDaiMa(){
		String daima = getPara("id");
		return warehouseLocationInterfaceServer.findAllByXinYongDaiMa(daima);
	}
	
}
