package com.zyiot.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.server.StoreInfoServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("store")
public class StoreInfoController extends BaseController {
	Logger log = Logger.getLogger(StoreInfoController.class);
	
	@Autowired
	StoreInfoServerI storeInfoServer;

	/**
	 * 首页显示实时库存
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<StorageInfoFormMap> findByPage(int page, int rows) {
		List<StorageInfoFormMap> list = storeInfoServer.findByPage(rows, page);
		return toMyPage(list);
	}

	/**
	 * 实时库存 一个
	 */
	@RequestMapping("findCurrentStorageOne")
	@ResponseBody
	public StorageInfoFormMap findCurrentStorageOne() {
		StorageInfoFormMap s = getFormMap(StorageInfoFormMap.class);
		s.put("source", getPara("source"));
		s.put("storageID", getPara("storageID"));

		return storeInfoServer.findStorageByStorageID(s);
	}
	/**
	 * 识别代码
	 * @return
	 */
	@RequestMapping("findCurrentStorageByPage")
	@ResponseBody
	public MyPage<StorageInfoFormMap> findCurrentStorageByPage(int page, int rows){
		StorageInfoFormMap storageInfoFormMap = getFormMap(StorageInfoFormMap.class);
		List<StorageInfoFormMap> list = storeInfoServer.findCurrentStorageByPage(storageInfoFormMap, rows, page);
		return toMyPage(list);
	}

	/**
	 * 实时库存 一个
	 */
	@RequestMapping("shibiema")
	public String shibiema(Model model) {
		String id = getPara("id");
		StorageInfoFormMap storageInfoFormMap = storeInfoServer.findStorageById(Integer.parseInt(id));
		model.addAttribute("storageInfoFormMap",storageInfoFormMap);
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/liangquantongjishibiema";
	}

	@RequestMapping("findCurrentStorageByCategory")
	@ResponseBody
	public List<StorageInfoFormMap> findCurrentStorageByCategory() {

		return storeInfoServer.findCurrentStorageByCategory();
	}
	/**
	 * 仓号定品种列表页面
	 * @author Lip
	 * @date 2017-07-12 09:05:52
	 * @return
	 */
	@RequestMapping("list")
	public String listUI(){
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/cunchuguanli/kucunguanli/warehousevaritylist";
	}
	/**
	 * 仓号定品种分页别表
	 * @author Lip
	 * @date 2017-07-12 10:48:02
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("findStorageByPage")
	@ResponseBody
	public MyPage<StorageInfoFormMap> findStorageByPage(int page, int rows){
		StorageInfoFormMap storageInfoFormMap = getFormMap(StorageInfoFormMap.class);
		List<StorageInfoFormMap> list = storeInfoServer.findStorageByPage(storageInfoFormMap, rows, page);
		return toMyPage(list);
	}
	
	@RequestMapping("addUI")
	@Token(save = true)
	public String addUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/cunchuguanli/kucunguanli/warehousevarityadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		StorageInfoFormMap storageInfoFormMap = getFormMap(StorageInfoFormMap.class);
		if(!validData(storageInfoFormMap)){
			return ERROR;
		}
		
		try {
			FormMapUtil.toADDFormMap(storageInfoFormMap);
		} catch (Exception e) {
			log.error("===Class:StoreInfoController===Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			storageInfoFormMap.set("cangKu", "0");
			storeInfoServer.addStorageInfo(storageInfoFormMap);
		} catch (Exception e) {
			log.error("===Class:StoreInfoController===Method:add==Exception:addStorageInfo=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("editUI")
	@Token(save = true)
	public String editUI(Model model){
		String wId = getPara("wId");
		StorageInfoFormMap storageInfoFormMap = storeInfoServer.findStorageByWarehouseId(Integer.parseInt(wId));
		model.addAttribute("storageInfoFormMap", storageInfoFormMap);
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/cunchuguanli/kucunguanli/warehousevarityedit";
	}
	
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		StorageInfoFormMap storageInfoFormMap = getFormMap(StorageInfoFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(storageInfoFormMap);
		} catch (Exception e) {
			log.error("===Class:StoreInfoController===Method:edit==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			storeInfoServer.editStorageInfo(storageInfoFormMap);
		} catch (Exception e) {
			log.error("===Class:StoreInfoController===Method:edit==Exception:editStorageInfo=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String wId = getPara("wId");
		
		try {
			storeInfoServer.dropStorageInfo(wId);
		} catch (Exception e) {
			log.error("===Class:StoreInfoController===Method:delete==Exception:dropStorageInfo=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("findById")
	@ResponseBody
	public StorageInfoFormMap findById(){
		String wId = getPara("wId");
		return storeInfoServer.findStorageByWarehouseId(Integer.parseInt(wId));
	}
	
	
	private boolean validData(StorageInfoFormMap storageInfoFormMap){
		String source = storageInfoFormMap.getStr("source");
		String storageID = storageInfoFormMap.getStr("storageID");
		String name = storageInfoFormMap.getStr("name");
		String quanzhong = storageInfoFormMap.getStr("quanZhong");
		String buyYear = storageInfoFormMap.getStr("buyYear");
		String packageWay = storageInfoFormMap.getStr("packageWay");
		
		if(ValidateUtil.isEmpty(source)){
			return false;
		}
		if(ValidateUtil.isEmpty(storageID)){
			return false;
		}
		if(ValidateUtil.isEmpty(name)){
			return false;
		}
		if(ValidateUtil.isEmpty(quanzhong)){
			return false;
		}
		if(ValidateUtil.isEmpty(buyYear)){
			return false;
		}
		if(ValidateUtil.isEmpty(packageWay)){
			return false;
		}
		
		return true;
	}
}
