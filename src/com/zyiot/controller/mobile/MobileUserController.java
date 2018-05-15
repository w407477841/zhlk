package com.zyiot.controller.mobile;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.UserFormMap;
import com.zyiot.server.mobile.MobileUserServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("/mobile/user")
public class MobileUserController extends BaseController {
	Logger log = Logger.getLogger(MobileUserController.class);
	@Autowired
	private MobileUserServerI mobileUserServer;
	@RequestMapping("list")
	public String listUI(){
		return Constant.BACKGROUND_PATH+"/mobile/user/list";
	}
	@RequestMapping("findUserByPage")
	@ResponseBody
	public MyPage<UserFormMap> findUserByPage(int page, int rows) {
		UserFormMap u = getFormMap(UserFormMap.class);
		List<UserFormMap> users = mobileUserServer.findByPage(u, rows, page);
		return toMyPage(users);
	}
	
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		model.addAttribute("id", getPara("id"));
		model.addAttribute("roleId", getPara("roleId"));
		return Constant.BACKGROUND_PATH+"/mobile/user/edit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		UserFormMap userFormMap = getFormMap(UserFormMap.class);
		
		try {
			mobileUserServer.addOrEditUserRole(userFormMap);
		} catch (Exception e) {
			log.error("===Class:MobileUserController===Method:edit====Exception:=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
}
