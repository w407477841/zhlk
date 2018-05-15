package com.zyiot.controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.zyiot.entity.ResFormMap;
import com.zyiot.entity.UserFormMap;
import com.zyiot.entity.UserLoginLogFormMap;
import com.zyiot.mapper.ResourcesMapper;
import com.zyiot.server.UserLoginLogServerI;
import com.zyiot.server.UserServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.PropertiesUtils;
import com.zyiot.util.RSAUtil;
import com.zyiot.util.TreeObject;
import com.zyiot.util.TreeUtil;

@Controller
@RequestMapping("/")
public class LoginController {
	@Autowired
	UserServerI userServer;
	@Autowired
	UserLoginLogServerI userLoginLogServer;
	@Autowired
	ResourcesMapper resourcesMapper;

	Logger log = Logger.getLogger(LoginController.class);

	@RequestMapping(value = "/login", method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String login(HttpServletRequest request) {
		if (request.getServletContext().getAttribute("needValidateClosed")
				.equals("1")) {
			if (isValidateClose(request)) {
				request.setAttribute("error", "请联系管理员获取授权码！");
				return loginurl(request);
			}
			request.getServletContext().setAttribute("needValidateClosed", "2");
		}
		request.removeAttribute("error");
		return loginurl(request);
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public String login(String username, String password,
			HttpServletRequest request) {
		if (request.getServletContext().getAttribute("needValidateClosed")
				.equals("1")) {
			if (isValidateClose(request)) {
				request.setAttribute("error", "请联系管理员获取授权码！");
				return loginurl(request);
			}
			request.getServletContext().setAttribute("needValidateClosed", "2");
		}
		RSAPrivateKey privateKey = (RSAPrivateKey) request.getSession().getAttribute("privateKey");
		try {
			password = RSAUtil.decryptByPrivateKey(password, privateKey);
		} catch (Exception e1) {
			log.error("===Class:LoginController===Method:loginurl===Exception:=="
					+ e1);
			request.setAttribute("error", "请刷新后登录！");
			return loginurl(request);
		}

		try {

			if (!request.getMethod().equals("POST")) {
				request.setAttribute("error", "支持POST方法提交！");
			}
			if (Common.isEmpty(username) || Common.isEmpty(password)) {
				request.setAttribute("error", "用户名或密码不能为空！");
				return loginurl(request);
			}
			Subject user = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(username,password);
			//用于标识是否登录成功
			boolean flag = true;
			try {
				user.login(token);
			} catch (LockedAccountException lae) {
				token.clear();
				flag = false;
				request.setAttribute("error", "用户已经被锁定不能登录，请与管理员联系！");
			} catch (ExcessiveAttemptsException e) {
				token.clear();
				request.setAttribute("error", "账号：" + username
						+ " 登录失败次数过多，已被锁定！");
				flag = false;
				userServer.lockUserByAccountName(username);
			} catch (AuthenticationException e) {
				token.clear();
				request.setAttribute("error", "用户或密码不正确！");
				flag = false;
			}
			UserLoginLogFormMap userLogin = new UserLoginLogFormMap();
			Session session = SecurityUtils.getSubject().getSession();
			userLogin.put("userId", session.getAttribute("userSessionId"));
			userLogin.put("accountName", username);
			userLogin.put("loginIP", session.getHost());
			userLogin.put("loginTime", DateUtils.format());
			if(flag){ //登录成功
				userLogin.put("description", "<font color=\"green\">登录成功</font>");
			}else{ //登录失败
				userLogin.put("description", "<font color=\"red\">"+request.getAttribute("error")+"</font>");
				FormMapUtil.toADDFormMap(userLogin);
				userLoginLogServer.addLoginLog(userLogin);
				return loginurl(request);
			}
			
			FormMapUtil.toADDFormMap(userLogin);
			userLoginLogServer.addLoginLog(userLogin);
			request.removeAttribute("error");
			String mac = request.getParameter("macAddress");
			// 添加mac地址
			// 为后面硬件设备配置使用
			session.setAttribute(Constant.MAC_ADDr, mac);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "登录异常，请联系管理员！");
			return loginurl(request);
		}
		return "redirect:firstRes.shtml";
	}

	@RequestMapping("firstRes")
	public String firstRes(Model model) throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		UserFormMap userFormMap = (UserFormMap) Common.findUserSession(request);
		ResFormMap resFormMap = new ResFormMap();
		resFormMap.put("userId", userFormMap.get("id"));
		resFormMap.put("parentId", "0");
		List<ResFormMap> mps = resourcesMapper.findFirstRes(resFormMap);
		model.addAttribute("list", mps);

		return "/res";
	}

	@RequestMapping("index")
	public String index(Model model) throws Exception {
		// 获取登录的bean
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		UserFormMap userFormMap = (UserFormMap) Common.findUserSession(request);
		ResFormMap resFormMap = new ResFormMap();
		resFormMap.put("userId", userFormMap.get("id"));
		List<ResFormMap> mps = resourcesMapper.findRes(resFormMap);
		List<TreeObject> list = new ArrayList<TreeObject>();
		for (ResFormMap map : mps) {
			TreeObject ts = new TreeObject();
			Common.flushObject(ts, map);
			list.add(ts);
		}

		String resId = request.getParameter("res");
		HttpSession session = request.getSession();
		if (resId == null || resId.equals("")) {
			resId = (String) session.getAttribute("res");
			if (resId == null || resId.equals(""))
				return "/res";
		} else {
			session.setAttribute("res", resId);
		}

		TreeUtil treeUtil = new TreeUtil();
		List<TreeObject> ns = treeUtil.getChildTreeObjects(list,
				Integer.parseInt(resId));
		model.addAttribute("list", ns);
		// 登陆的信息回传页面
		model.addAttribute("userFormMap", userFormMap);
		return "/index";
	}

	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout() {
		// 使用权限管理工具进行用户的退出，注销登录
		SecurityUtils.getSubject().logout(); // session
												// 会销毁，在SessionListener监听session销毁，清理权限缓存
		return "redirect:login.shtml";
	}

	@RequestMapping("/welcome")
	public String welcome() {
		if (PropertiesUtils.findPropertiesKey("app").equals("zhlk"))
			return "/welcome";
		else if (PropertiesUtils.findPropertiesKey("app").equals("xjpt"))
			return "/welcomexjpt";
		else
			return "/welcome";
	}

	/**
	 * 是否拥有授权码 没有返回true 有返回false
	 * 
	 * @param request
	 * @return
	 */
	public boolean isValidateClose(HttpServletRequest request) {
		boolean closed = false;
		String licensekey = PropertiesUtils.getProperties().getProperty(
				"licensekey");
		String app = PropertiesUtils.getProperties().getProperty("app");
		List<String> addrs = getMacAddr();
		if (addrs != null) {
			for (String addr : addrs) {
				if (addr != null && !addr.equals("")) {

					if (licensekey != null && !licensekey.equals("")) {

						if (licensekey.equals(toMD5(addr + ":zyiot:" + app))) {
							closed = false;
							break;
						} else {
							closed = true;
						}
					}
				}
			}
		}
		return closed;
	}

	public void ValidateClose(HttpServletRequest request) {
		boolean closed = false;
		String licensekey = PropertiesUtils.getProperties().getProperty(
				"licensekey");
		String app = PropertiesUtils.getProperties().getProperty("app");
		List<String> addrs = getMacAddr();
		if (addrs != null) {
			for (String addr : addrs) {
				if (addr != null && !addr.equals("")) {

					if (licensekey != null && !licensekey.equals("")) {

						if (licensekey.equals(toMD5(addr + ":zyiot:" + app))) {
							closed = false;
							break;
						} else {
							closed = true;
						}
					}
				}
			}
		}

		if (closed) {
			String tomcatRoom = request.getServletContext().getRealPath("/");

			tomcatRoom = tomcatRoom.replace("webapps\\", "");
			String appName = request.getServletContext().getContextPath()
					.substring(1);

			tomcatRoom = tomcatRoom.replaceAll(appName + "\\\\", "");
			tomcatRoom = tomcatRoom + "bin\\shutdown.bat";
			System.out.println(tomcatRoom);
			callCmd(tomcatRoom);
		} else {

		}

	}

	private void callCmd(String locationCmd) {
		try {
			Process child = Runtime.getRuntime().exec(
					"cmd.exe /C start " + locationCmd);
			InputStream in = child.getInputStream();
			while (in.read() != -1) {
			}
			in.close();
			try {
				child.waitFor();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println("done");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private String toMD5(String plainText) {
		try {
			// 生成实现指定摘要算法的 MessageDigest 对象。
			MessageDigest md = MessageDigest.getInstance("MD5");
			// 使用指定的字节数组更新摘要。
			md.update(plainText.getBytes());
			// 通过执行诸如填充之类的最终操作完成哈希计算。
			byte b[] = md.digest();
			// 生成具体的md5密码到buf数组
			int i;
			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			// System.out.println("32位: " + buf.toString());// 32位的加密
			return buf.toString();
			// System.out.println("16位: " + buf.toString().substring(8, 24));//
			// 16位的加密，其实就是32位加密后的截取
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private List<String> getMacAddr() {
		List<String> addrs = new ArrayList<String>();
		// 初始化 网卡信息容器
		Enumeration<NetworkInterface> allNetDevices = null;
		// 初始化一张网卡对象
		NetworkInterface networkInterface = null;
		// 等到网卡的byte数组信息
		byte[] networkbyte = null;
		// 盛放 封装的网卡信息字符串
		StringBuffer stringBuffer = null;
		try {
			// 获取网卡信息容器
			allNetDevices = NetworkInterface.getNetworkInterfaces();
			while (allNetDevices.hasMoreElements()) {
				// 获取单张网卡对象 迭代输出网卡信息
				networkInterface = allNetDevices.nextElement();
				// 获得正在 运行的 网卡信息
				if (networkInterface.isUp()) {
					// 转换字节后用到的网卡地址容器
					stringBuffer = new StringBuffer();
					// 网卡mac地址字节容器
					networkbyte = networkInterface.getHardwareAddress();
					if (networkbyte != null) {
						for (int i = 0; i < networkbyte.length; i++) {
							// 单个数组值 就是一个地址位数添加分隔符
							if (i != 0) {
								stringBuffer.append("-");
							}
							// 字节转换为16进制数
							int number = networkbyte[i] & 0xff;
							String strAddr = Integer.toHexString(number);
							// 当转换的值是 个位数时，在前面补0
							if (strAddr.length() == 1) {
								stringBuffer.append("0" + strAddr);
							} else {
								stringBuffer.append(strAddr);
							}
						}
						// 输出转换后的mac地址

						addrs.add(stringBuffer.toString().toUpperCase());
					}
				}
			}
		} catch (SocketException e) {
			e.printStackTrace();
		}
		return addrs;
	}

	private String loginurl(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			map = RSAUtil.getKeys();
			// 生成公钥和私钥
			RSAPublicKey publicKey = (RSAPublicKey) map.get("public");
			RSAPrivateKey privateKey = (RSAPrivateKey) map.get("private");
			HttpSession session = request.getSession();
			session.setAttribute("privateKey", privateKey);// 私钥保存在session中，用于解密

			// 公钥信息保存在页面，用于加密
			String publicKeyExponent = publicKey.getPublicExponent().toString(
					16);
			String publicKeyModulus = publicKey.getModulus().toString(16);
			request.setAttribute("publicKeyExponent", publicKeyExponent);
			request.setAttribute("publicKeyModulus", publicKeyModulus);
		} catch (NoSuchAlgorithmException e) {
			log.error("===Class:LoginController===Method:loginurl===Exception:=="
					+ e);
		}
		return "/login";
	}
}
