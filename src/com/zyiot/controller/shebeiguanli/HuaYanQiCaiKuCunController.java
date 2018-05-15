package com.zyiot.controller.shebeiguanli;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.util.Common;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/huayanqicaikucun")
public class HuaYanQiCaiKuCunController extends BaseController {
	@RequestMapping("/listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/huayanqicai/kucunguanlilist";
	}
	@RequestMapping("/findByPage")
	@ResponseBody
	public MyPage findByPage(){
		return null;
	}
	
}
