package com.zyiot.controller.zijinguankong;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.server.weight.ReportHarborServerI;
import com.zyiot.util.Constant;

@Controller
@RequestMapping("ziJinJieSuan")
public class ZiJinJieSuanController extends BaseController {
	
	@Autowired
	private ReportHarborServerI reportHarborServer;
	@RequestMapping("list")
	public String list(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zijinguankong/zijinjiesuanlist";
	}
	
	@RequestMapping("editUI")
	@Token(save=true)
	public String settleAccountUI(Model model){
		String id = getPara("id");
		
		ReportHarborFormMap reportHarborFormMap = reportHarborServer.findDetailReportHarborById(Integer.parseInt(id));
		
		model.addAttribute("reportHarborFormMap", reportHarborFormMap);
		
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zijinguankong/zijinjiesuanedit";
	}
	
}
