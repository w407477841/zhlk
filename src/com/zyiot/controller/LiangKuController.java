package com.zyiot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zyiot.server.WarehouseLocationServerI;
import com.zyiot.util.Common;

@Controller
@RequestMapping("liangku")
public class LiangKuController extends BaseController {
	@Autowired
	private WarehouseLocationServerI warehouseLocationServer;

	@RequestMapping("shipindianwei")
	public String shipindianwei(Model model) {
		String name = getPara("name");
		String imagePath = warehouseLocationServer.getImagePath(name);
		model.addAttribute("imgPath", imagePath);
		return Common.BACKGROUND_PATH + "/liangku/shipindianwei";
	}

	@RequestMapping("viewjiankong")
	public String viewjiankong() {

		return Common.BACKGROUND_PATH + "/liangku/viewjiankong";
	}

}
