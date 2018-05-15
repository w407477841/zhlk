package com.zyiot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.util.Common;
import com.zyiot.util.MyPage;
@Controller
@RequestMapping("/liangqingqitibaojing")
public class LiangQingQiTiBaoJingController extends BaseController {

	@RequestMapping("/listUI")
	public String listUI(){
		return Common.BACKGROUND_PATH+"/cangkuzhinenghuaxitong/liangqingqitibaojinglist";
	}

@RequestMapping("/findByPage")
@ResponseBody
public MyPage findByPage(int page,int rows ){
	return null;
}
	
}
