package com.zyiot.controller.yaojiguanli;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.server.yaojiguanli.YaoJiKuCunServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/yaojiguanlijiandu")
public class YaoJiGuanLiJianDuController extends BaseController {
	@Autowired
	private YaoJiKuCunServiceI yaoJiKuCunService;
	DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yaojiguanli/yaojiguanlijiandulist";
	}
	@RequestMapping("/findByPage")
	@ResponseBody
	public MyPage<YaoJiKuCunFormMap> findByPage(int page, int rows){
		YaoJiKuCunFormMap yaoJiKuCunFormMap =getFormMap(YaoJiKuCunFormMap.class);
		List<YaoJiKuCunFormMap> list = yaoJiKuCunService.findByPage(yaoJiKuCunFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(YaoJiKuCunFormMap yj:list){
				Date date = yj.getDate("mrManufactureDate");
				yj.set("mrManufactureDate", sdf.format(date));
			}
		}
		return toMyPage(list);
	}
	
}
