package com.zyiot.controller.yewuguanli;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.util.Common;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/shengchujihua")
public class ShengChuJiHuaController extends BaseController {
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/yewuguanli/jihuaguanli/shengchujihua";
	}
	@RequestMapping("/findByPage")
	@ResponseBody
	public MyPage findByPage(){
		return null;
	}
	
}
