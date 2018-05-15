package com.zyiot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.entity.UserLoginLogFormMap;
import com.zyiot.server.UserLoginLogServerI;
import com.zyiot.util.Common;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("loginlog")
public class LoginLogController extends BaseController {
@Autowired
	UserLoginLogServerI userLoginLogServer;
@RequestMapping("listUI")
	public String listUI(){
		
		return Common.BACKGROUND_PATH+"/loginlog/list";
	}
	@RequestMapping("findLoginLogByPage")
	@ResponseBody
	public MyPage<UserLoginLogFormMap> findLoginLogByPage(int rows,int page){
		UserLoginLogFormMap userLoginLogFormMap=getFormMap(UserLoginLogFormMap.class);
		List<UserLoginLogFormMap> l=userLoginLogServer.findLoginLogByPage(userLoginLogFormMap, rows, page);
		return toMyPage(l);
	}
}
