package com.zyiot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.entity.ShiPinDianWeiFormMap;
import com.zyiot.server.ShiPinDianWeiServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("shipindianwei")
public class ShiPinDianWeiController extends BaseController {

	@Autowired
	ShiPinDianWeiServerI shiPinDianWeiServer;

	/**
	 * 显示视频点位列表---主要用于县级平台
	 * @return
	 */
	@RequestMapping("list")
	public String list(Model model) {
		String source = getPara("source");
		model.addAttribute("source", source);
		return Common.BACKGROUND_PATH + "/liangku/shipinlist";
	}
	
	@RequestMapping("findShiPinByPage")
	@ResponseBody
	public MyPage<ShiPinDianWeiFormMap> findShiPinByPage(int page, int rows) {
		ShiPinDianWeiFormMap formMap = getFormMap(ShiPinDianWeiFormMap.class);
		List<ShiPinDianWeiFormMap> shiPinDianWeis = shiPinDianWeiServer
				.findShiPinDianWeiByPage(formMap, rows, page);
		return toMyPage(shiPinDianWeis);
	}
	
	
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH + "/system/shipindianwei/list";
	}

	@Token(save = true)
	@RequestMapping("addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH + "/system/shipindianwei/add";
	}

	@Token(save = true)
	@RequestMapping("editUI")
	public String editUI(Model model) {

		model.addAttribute("shiPinDianWeiFormMap",
				shiPinDianWeiServer.findShiPinDianWeiById(getPara("id")));

		return Common.BACKGROUND_PATH + "/system/shipindianwei/edit";
	}

	@Token(remove = true)
	@RequestMapping("edit")
	@ResponseBody
	public String edit() {
		ShiPinDianWeiFormMap formMap = getFormMap(ShiPinDianWeiFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
		} catch (Exception e) {
			return ERROR;
		}

		try {
			shiPinDianWeiServer.editShiPinDianWei(formMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteOne")
	@ResponseBody
	public String deleteOne() {
		try {
			shiPinDianWeiServer.deleteShiPinDianWei(getPara("id"));
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@Token(remove = true)
	@RequestMapping("add")
	@ResponseBody
	public String add() {
		ShiPinDianWeiFormMap formMap = getFormMap(ShiPinDianWeiFormMap.class);
		try {
			FormMapUtil.toADDFormMap(formMap);
		} catch (Exception e) {
			return ERROR;
		}
		try {
			shiPinDianWeiServer.addShiPinDianWei(formMap);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("findShiPinDianWeiByPage")
	@ResponseBody
	public MyPage<ShiPinDianWeiFormMap> findShiPinDianWeiByPage(int page, int rows) {
		ShiPinDianWeiFormMap formMap = getFormMap(ShiPinDianWeiFormMap.class);
		List<ShiPinDianWeiFormMap> shiPinDianWeis = shiPinDianWeiServer
				.findShiPinDianWeiByPage(formMap, rows, page);
		return toMyPage(shiPinDianWeis);
	}

	@RequestMapping("findALlByCid")
	@ResponseBody
	public List<ShiPinDianWeiFormMap> findALlByCid() {

		ShiPinDianWeiFormMap shiPinDianWeiFormMap = new ShiPinDianWeiFormMap();
		shiPinDianWeiFormMap.put("location_id", getPara("location_id"));
		return shiPinDianWeiServer
				.findShiPinDianWeiByAttr(shiPinDianWeiFormMap);
	}

}
