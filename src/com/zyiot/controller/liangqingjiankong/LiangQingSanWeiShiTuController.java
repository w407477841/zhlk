package com.zyiot.controller.liangqingjiankong;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.util.Common;
import com.zyiot.util.MyPage;
@Controller
@RequestMapping("/liangqingsanweizhanshi")
public class LiangQingSanWeiShiTuController extends BaseController {

	@RequestMapping("/listUI")
	public String listUI(){
		return Common.BACKGROUND_PATH+"/cangkuzhinenghuaxitong/liangqingjiankong/liangqingsanweizhanshilist";
	}

@RequestMapping("/findByPage")
@ResponseBody
public MyPage findByPage(int page,int rows ){
	return null;
}
	
}
