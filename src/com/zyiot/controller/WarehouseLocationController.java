package com.zyiot.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zyiot.annotation.Token;
import com.zyiot.entity.WarehouseLocationFormMap;
import com.zyiot.server.WarehouseLocationServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.FileManager;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("warehouseLocation")
public class WarehouseLocationController extends BaseController {

	Logger log = Logger.getLogger(WarehouseLocationController.class);
	@Autowired
	private WarehouseLocationServerI warehouseLocationServer;

	@RequestMapping("list")
	public String list() {
		return Constant.BACKGROUND_PATH
				+ "/yewuguanlixitong/jichuziliao/liangkulist";
	}

	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI() {
		return Constant.BACKGROUND_PATH
				+ "/yewuguanlixitong/jichuziliao/liangkuadd";
	}

	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model) {
		String id = getPara("id");
		WarehouseLocationFormMap warehouseLocationFormMap = warehouseLocationServer
				.findWarehouseLocationById(id);
		model.addAttribute("warehouseLocationFormMap", warehouseLocationFormMap);
		return Constant.BACKGROUND_PATH
				+ "/yewuguanlixitong/jichuziliao/liangkuedit";
	}
	@RequestMapping("imagePath")
	@ResponseBody
	public String getImagePath(){
		String locationId = getPara("id");
		return warehouseLocationServer.getImagePath(locationId);
	}
	
	
	@RequestMapping("upload")
	public String upload(Model model) {
		String id = getPara("id");
		String type = getPara("type");
		model.addAttribute("type", type);
		model.addAttribute("id", id);
		
		return Constant.BACKGROUND_PATH
				+ "/yewuguanlixitong/jichuziliao/upload";
	}
	
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<WarehouseLocationFormMap> findByPage(int rows, int page) {
		WarehouseLocationFormMap warehouseLocation = getFormMap(WarehouseLocationFormMap.class);
		List<WarehouseLocationFormMap> list = warehouseLocationServer
				.findByPage(warehouseLocation, rows, page);
		return toMyPage(list);
	}

	@RequestMapping("isExist")
	@ResponseBody
	public String isExist() {
		String id = getPara("id");
		WarehouseLocationFormMap warehouseLocation = warehouseLocationServer
				.findWarehouseLocationById(id);
		if (warehouseLocation == null) {
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add() {
		WarehouseLocationFormMap warehouseLocation = getFormMap(WarehouseLocationFormMap.class);
		
		try {
			warehouseLocation.set("id",Integer.parseInt(warehouseLocation.getStr("wNo")));
			FormMapUtil.toADDFormMap(warehouseLocation);
		} catch (Exception e) {
			log.error("===Class:WarehouseLocationController==Method:add==Exception:toADDFormMap=="
					+ e);
			return ERROR;
		}
		try {
			warehouseLocationServer.addWarehouseLocation(warehouseLocation);
		} catch (Exception e) {
			log.error("===Class:WarehouseLocationController==Method:add==Exception:addWarehouseLocation=="
					+ e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit() {
		WarehouseLocationFormMap warehouseLocation = getFormMap(WarehouseLocationFormMap.class);

		try {
			FormMapUtil.toUPDATEFormMap(warehouseLocation);
		} catch (Exception e) {
			log.error("===Class:WarehouseLocationController==Method:edit==Exception:toUPDATEFormMap=="
					+ e);
			return ERROR;
		}
		try {
			warehouseLocationServer.editWarehouseLocation(warehouseLocation);
		} catch (Exception e) {
			log.error("===Class:WarehouseLocationController==Method:edit==Exception:editWarehouseLocation=="
					+ e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		try {
			warehouseLocationServer.dropWarehouseLocation(id);
		} catch (Exception e) {
			log.error("===Class:WarehouseLocationController==Method:delete==Exception:dropWarehouseLocation=="
					+ e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("uploadFile")
	@ResponseBody
	public String uploadForm(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, String dataid,String dataType) {
		try {
			
			String savePath = request.getServletContext().getRealPath("/img/upload");
			
			//获取扩展名
			String oFileName = file.getOriginalFilename();
			String ext = oFileName.substring(oFileName.lastIndexOf("."));
			String fileName = UUID.randomUUID().toString().replace("-", "");
			fileName+=ext;
			// 上传文件
			FileManager.upFile(file, savePath,fileName);

			// 更新表数据
			WarehouseLocationFormMap warehouseLocation = new WarehouseLocationFormMap();
			warehouseLocation.set("id", dataid);
			if(dataType.equals("1")){
				warehouseLocation.set("wImage", "img/upload/"+fileName);
			}else{
				warehouseLocation.set("wPlaneImage", "img/upload/"+fileName);
			}
			
			FormMapUtil.toUPDATEFormMap(warehouseLocation);
			warehouseLocationServer.editWarehouseLocation(warehouseLocation);
		} catch (Exception e) {
			log.error("==Class:WarehouseLocationController==Method:uploadFile==Exception:上传文件=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
}
