package com.zyiot.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.entity.UserFormMap;
import com.zyiot.server.UserServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.JsonUtils;
import com.zyiot.util.MyPage;
import com.zyiot.util.POIUtils;
import com.zyiot.util.PasswordHelper;

@Controller
@RequestMapping("user")
public class UserController extends BaseController {
	Logger log = Logger.getLogger(UserController.class);
	@Autowired
	UserServerI userServer;

	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH + "/system/user/list";
	}

	@RequestMapping("addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH + "/system/user/add";
	}

	@RequestMapping("findUserByPage")
	@ResponseBody
	public MyPage<UserFormMap> findUserByPage(int page, int rows) {
		UserFormMap u = getFormMap(UserFormMap.class);
		List<UserFormMap> users = userServer.findUserByPage(u, rows, page);
		return toMyPage(users);
	}

	@RequestMapping("add")
	@ResponseBody
	public String add() {
		UserFormMap u = getFormMap(UserFormMap.class);
		
		try {
			FormMapUtil.toADDFormMap(u);
		} catch (Exception e) {
			log.error("==Class:UserController==Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}

		try {
			u.put("password", "123456");
			// 加密，及加入credentialsSalt验证
			PasswordHelper passwordHelper = new PasswordHelper();
			passwordHelper.encryptPassword(u);
			userServer.insertUser(u);
		} catch (Exception e) {
			log.error("==Class:UserController==Method:add==Exception:insertUser=="+e);
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping("edit")
	@ResponseBody
	public String edit() {
		UserFormMap u = getFormMap2Edit(UserFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(u);
		} catch (Exception e) {
			log.error("==Class:UserController==Method:edit==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}

		try {
			userServer.updateUser(u);
		} catch (Exception e) {
			log.error("==Class:UserController==Method:edit==Exception:updateUser=="+e);
			return ERROR;
		}

		return SUCCESS;
	}
	/**
	 * 判断帐号是否存在
	 * @return
	 */
	@RequestMapping("isExsit")
	@ResponseBody
	public String isExsit(){
		String account = getPara("account");
		UserFormMap user = new UserFormMap();
		user.put("accountName", account);
		try {
			List<UserFormMap> list = userServer.findUserByAttr(user);
			if(list != null && list.size()>0){
				return SUCCESS;
			}
		} catch (Exception e) {
			log.error("==Class:UserController==Method:isExsit==Exception:findUserByAttr=="+e);
			return ERROR;
		}
		return ERROR;
	}
	
	
	
	@RequestMapping("deleteOne")
	@ResponseBody
	public String deleteOne() {
		String id = getPara("id");
		try {
			userServer.deleteUser("id", id);
		} catch (Exception e) {
			log.error("==Class:UserController==Method:deleteOne==Exception:deleteUser=="+e);
			return ERROR;
		}

		return SUCCESS;
	}
	/**
	 * 初始化密码
	 * @return
	 */
	@RequestMapping("initPwd")
	@ResponseBody
	public String initPwd() {
		try {
			UserFormMap u = userServer.findUserById(Integer.parseInt(getPara("id")));
			if(u != null){
				u.remove("roleName");
				u.remove("roleId");
				u.remove("departmentid");
				u.remove("departmentName");
				u.remove("userName");
				u.remove("locked");
				u.set(Constant.VERSION, u.getLong(Constant.VERSION)+"");
				u.put("password", "123456");
				userServer.editPassword(u);
			}else{
				return ERROR;
			}
		} catch (NumberFormatException e) {
			log.error("==Class:UserController==Method:initPwd==Exception:NumberFormatException=="+e);
			return ERROR;
		} catch (Exception e) {
			log.error("==Class:UserController==Method:initPwd==Exception:editPassword=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}

	@RequestMapping("editUI")
	public String editUI(Model model) {

		try {
			model.addAttribute("userFormMap",
					userServer.findUserById(Integer.parseInt(getPara("id"))));
		} catch (NumberFormatException e) {
			log.error("==Class:UserController==Method:editUI==Exception:NumberFormatException=="+e);
		} catch (Exception e) {
			log.error("==Class:UserController==Method:editUI==Exception:findUserById=="+e);
		}

		return Common.BACKGROUND_PATH + "/system/user/edit";
	}

	// 密码修改
	@RequestMapping("updatePassword")
	public String updatePassword(Model model) throws Exception {
		return Common.BACKGROUND_PATH + "/system/user/updatePassword";
	}

	// 保存新密码
	@RequestMapping("editPassword")
	@ResponseBody
	public String editPassword() {
		// 当验证都通过后，把用户信息放在session里
		UserFormMap userFormMap = getFormMap(UserFormMap.class);
		userFormMap.put("password", userFormMap.get("newpassword"));
		userFormMap.remove("newpassword");
		userFormMap.remove("confirmpassword");
		try {
			userServer.editPassword(userFormMap);
		} catch (Exception e) {
			log.error("==Class:UserController==Method:editPassword==Exception:editPassword=="+e);
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping("/export")
	public void download(HttpServletRequest request,
			HttpServletResponse response) {
		String fileName = "用户列表";
		UserFormMap userFormMap = getFormMapNoName(UserFormMap.class);
		
		String exportData = userFormMap.getStr("exportData");// 列表头的json字符串
		List<Map<String, Object>> listMap = JsonUtils.parseJSONList(exportData);

		List<UserFormMap> lis = null;
		try {
			lis = userServer.findUserByPage(userFormMap, -1, -1);
		} catch (Exception e) {
			log.error("==Class:UserController==Method:download==Exception:findUserByPage=="+e);
		}
		POIUtils.exportToExcel(response, listMap, lis, fileName);
	}

}
