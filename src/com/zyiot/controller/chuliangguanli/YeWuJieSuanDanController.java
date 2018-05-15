package com.zyiot.controller.chuliangguanli;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.util.Common;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("yewujiesuandan")
public class YeWuJieSuanDanController extends BaseController {
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/danjuguanli/yewujiesuandan";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage findByPage(int page, int rows) {
		return null;
	}
}
