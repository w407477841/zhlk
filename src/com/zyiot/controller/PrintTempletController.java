package com.zyiot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zyiot.util.Common;

@Controller
@RequestMapping("printtemplet")
public class PrintTempletController extends BaseController {

	@RequestMapping("listUI")
	public String listUI(){
		return Common.BACKGROUND_PATH+"/system/printtemplet/list";
	}
	@RequestMapping("addUI")
	public String addUI(){
		return Common.BACKGROUND_PATH+"/system/printtemplet/add";
	}
	
	
}
