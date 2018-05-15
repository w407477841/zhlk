package com.zyiot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.entity.YingPanLuXiangJiFormMap;
import com.zyiot.server.YingPanLuXiangJiServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("yingpanluxiangji")
public class YingPanLuXiangJiController extends BaseController {
	@Autowired
	YingPanLuXiangJiServerI yingPanLuXiangJiServer;

	@RequestMapping("listUI")
	public String listUI() {

		return Common.BACKGROUND_PATH + "/system/yingpanluxiangji/list";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<YingPanLuXiangJiFormMap> findByPage(int page, int rows) {
		YingPanLuXiangJiFormMap yingPanLuXiangJiFormMap = getFormMap(YingPanLuXiangJiFormMap.class);

		List<YingPanLuXiangJiFormMap> list = yingPanLuXiangJiServer.findByPage(
				yingPanLuXiangJiFormMap, rows, page);

		return toMyPage(list);
	}

	@RequestMapping("findByLocation")
	@ResponseBody
	public List<YingPanLuXiangJiFormMap> findByLocation() {
		YingPanLuXiangJiFormMap yingPanLuXiangJiFormMap = getFormMap(YingPanLuXiangJiFormMap.class);
		yingPanLuXiangJiFormMap.put("location_id", getPara("location_id"));
		return yingPanLuXiangJiServer.findByAttr(yingPanLuXiangJiFormMap);
	}

	@RequestMapping("addUI")
	@Token(save = true)
	public String addUI() {
		return Common.BACKGROUND_PATH + "/system/yingpanluxiangji/add";
	}

	@RequestMapping("add")
	@ResponseBody
	@Token(remove = true)
	public String add() {

		YingPanLuXiangJiFormMap obj = getFormMap(YingPanLuXiangJiFormMap.class);
		try {
			FormMapUtil.toADDFormMap(obj);
		} catch (Exception e) {
			return ERROR;
		}

		try {
			yingPanLuXiangJiServer.add(obj);
		} catch (Exception e) {

			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("edit")
	@ResponseBody
	@Token(remove = true)
	public String edit() {
		YingPanLuXiangJiFormMap obj = getFormMap2Edit(YingPanLuXiangJiFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(obj);
		} catch (Exception e) {
			return ERROR;
		}

		try {
			yingPanLuXiangJiServer.edit(obj);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteOne")
	@ResponseBody
	public String deleteOne() {

		YingPanLuXiangJiFormMap yingPanLuXiangJiFormMap = new YingPanLuXiangJiFormMap();
		yingPanLuXiangJiFormMap.put("id", getPara("id"));

		try {
			FormMapUtil.toDELETEFormMap(yingPanLuXiangJiFormMap);
		} catch (Exception e1) {
			return ERROR;
		}
		try {
			yingPanLuXiangJiServer.deleteByAttr(yingPanLuXiangJiFormMap);
		} catch (Exception e) {
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping("editUI")
	@Token(save = true)
	public String editUI(Model model) {
		YingPanLuXiangJiFormMap yingPanLuXIangjiFormMap = new YingPanLuXiangJiFormMap();
		yingPanLuXIangjiFormMap.put("id", getPara("id"));

		model.addAttribute("yingPanLuXiangJiFormMap", yingPanLuXiangJiServer
				.findByAttr(yingPanLuXIangjiFormMap).get(0));

		return Common.BACKGROUND_PATH + "/system/yingpanluxiangji/edit";
	}
}
