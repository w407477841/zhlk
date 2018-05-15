package com.zyiot.controller.qitijiankong;

import java.util.Properties;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zyiot.controller.BaseController;
import com.zyiot.util.Common;
import com.zyiot.util.PropertiesUtils;
@Controller
@RequestMapping("/qitibaojingshezhi")
public class QiTiBaoJingSheZhiController extends BaseController {

	@RequestMapping("/listUI")
	public String listUI(Model model){
		Properties properties = PropertiesUtils.getPropertyByName("qitibaojing.properties");
		
		String lhq = properties.getProperty("lhq");
		String yq = properties.getProperty("yq");
		String eyht = properties.getProperty("eyht");
		String dataFilter = properties.getProperty("dataFilter");
		String execSpace = properties.getProperty("execSpace");
		 model.addAttribute("lhq", lhq);
		 model.addAttribute("yq", yq);
		 model.addAttribute("eyht", eyht);
		 model.addAttribute("dataFilter", dataFilter);
		 model.addAttribute("execSpace", execSpace);
		return Common.BACKGROUND_PATH+"/cangkuzhinenghuaxitong/qitijiankong/qitibaojingshezhilist";
	}	
}
