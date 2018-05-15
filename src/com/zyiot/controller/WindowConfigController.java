package com.zyiot.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Scanner;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.support.json.JSONUtils;
import com.zyiot.entity.WindowConfigFormMap;
import com.zyiot.server.WarehouseLocationServerI;
import com.zyiot.server.WindowConfigServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.SensorUtil;

@Controller
@RequestMapping("windowConfig")
public class WindowConfigController extends BaseController {
	@Autowired
	WindowConfigServerI windowConfigServer;
	@Autowired
	private WarehouseLocationServerI warehouseLocationServer;
	Logger logger = Logger.getLogger(WindowConfigController.class);

	@RequestMapping(value = "listUI", method = RequestMethod.POST)
	public String windowConfigListUI() {
		return Common.BACKGROUND_PATH + "/system/windowconfig/list";
	}

	@RequestMapping(value = "findByPage")
	@ResponseBody
	public MyPage findByPage(int page, int rows) {
		WindowConfigFormMap windowConfigFormMap = getFormMap(WindowConfigFormMap.class);

		return toMyPage(windowConfigServer.findWindowConfigByPage(
				windowConfigFormMap, rows, page));
	}

	@RequestMapping(value = "addUI")
	public String addUI() {

		return Common.BACKGROUND_PATH + "/system/windowconfig/add";
	}

	@RequestMapping(value = "add")
	@ResponseBody
	public String add() {

		WindowConfigFormMap windowConfigFormMap = getFormMap(WindowConfigFormMap.class);

		try {
			FormMapUtil.toADDFormMap(windowConfigFormMap);
			windowConfigServer.add(windowConfigFormMap);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping(value = "edit")
	@ResponseBody
	public String edit() {
		WindowConfigFormMap windowConfigFormMap = getFormMap(WindowConfigFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(windowConfigFormMap);
			windowConfigServer.edit(windowConfigFormMap);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping(value = "editUI")
	public String editUI(Model model) {
		WindowConfigFormMap u = new WindowConfigFormMap();
		u.put("id", getPara("id"));
		List<WindowConfigFormMap> list = windowConfigServer
				.findWindowConfigByPage(u, 1, 1);
		if (list != null && list.size() > 0) {
			model.addAttribute("windowConfigFormMap", list.get(0));
		}
		return Common.BACKGROUND_PATH + "/system/windowconfig/edit";
	}

	@RequestMapping(value = "deleteOne")
	@ResponseBody
	public String deleteOne() {
		try {
			windowConfigServer.delete(getPara("id"));
		} catch (Exception e) {
			logger.error(e.getMessage());
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping(value = "option")
	@ResponseBody
	public String option() {
		String jsonString = getPara("data");
		String option = getPara("option");
		List<LinkedHashMap<String, Object>> list = (List<LinkedHashMap<String, Object>>) JSONUtils
				.parse(jsonString);

		for (LinkedHashMap map : list) {
			if (option != null && option.equals("open")) {
				String openNeed = (String) map.get("openNeed");
				if (openNeed.equals("1")) {
					sendOption(map, "close2");
					sendOption(map, "open1");
				} else {
					sendOption(map, "open1");
				}
			} else if (option != null && option.equals("close")) {
				String closeNeed = (String) map.get("closeNeed");
				if (closeNeed.equals("1")) {
					sendOption(map, "open2");
					sendOption(map, "close1");
				} else {
					sendOption(map, "close1");
				}
			}

			else if (option != null && option.equals("pause")) {
				sendOption(map, "open2");
				sendOption(map, "close2");
			}
		}

		return jsonString;
	}

	@RequestMapping(value = "windowsUI")
	public String windowsUI(Model model) {
		String kd = getPara("kd");
		String imagePath = warehouseLocationServer.getImagePath(kd);
		model.addAttribute("imgPath", imagePath);
		
		WindowConfigFormMap windowConfigFormMap = new WindowConfigFormMap();
		windowConfigFormMap.set("location_id", kd);
		model.addAttribute("list",windowConfigServer.findCangKuDianWei(windowConfigFormMap));
		return Common.BACKGROUND_PATH + "/system/windowconfig/windows";
	}

	@RequestMapping(value = "optionUI")
	public String optionUI(Model model) {
		WindowConfigFormMap u = new WindowConfigFormMap();
		u.put("cangkudianwei", getPara("cangkudianwei"));
		List<WindowConfigFormMap> list = windowConfigServer
				.findWindowConfigByPage(u, -1, -1);

		model.addAttribute("list", list);

		list = windowConfigServer.findShipin(u);

		model.addAttribute("shipin", list);

		return Common.BACKGROUND_PATH + "/system/windowconfig/option";
	}

	public static void aaa() {
		Socket socket = null;
		InputStream is = null;
		OutputStream os = null;
		try {
			socket = new Socket();
			InetSocketAddress iadd = new InetSocketAddress("192.168.10.231",
					4001);
			socket.connect(iadd, 2000);// 设置连接超时时间为2秒
			is = socket.getInputStream();
			os = socket.getOutputStream();
			os.write(SensorUtil.hexStringToByte("5501110000000269"));
			os.flush();
			byte[] words = new byte[8];
			is.read(words);
			System.out.println(SensorUtil.bytesToHexString(words));
			// Thread t1 = new Thread(new ThreadIn(is), "in");
			// t1.start();

			// Thread t2 = new Thread(new ThreadOut(os), "out");
			// t2.start();
			// Thread.sleep(500);
			// Thread.sleep(500);

			//
			// Thread.sleep(1000);
			// os.write(SensorUtil.hexStringToByte("5501120000000169"));
			// os.flush();
			// Thread.sleep(6000);
			// os.write(SensorUtil.hexStringToByte("5501110000000168"));
			// Thread.sleep(500);
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println(e.getMessage() + "  [连接超时：检查ip、port，或者被占用]");
		} finally {
			if (os != null) {
				try {
					os.close();
				} catch (IOException e) {
				}
			}
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
				}
			}
			if (socket != null) {
				try {
					socket.close();
				} catch (IOException e) {
				}
			}
		}

	}

	public String sendOption(LinkedHashMap map, String type) {
		Socket socket = null;
		InputStream is = null;
		OutputStream os = null;
		String retString = "";
		try {
			socket = new Socket();
			InetSocketAddress iadd = new InetSocketAddress(
					(String) map.get("ip"), Integer.parseInt((String) map
							.get("port")));
			socket.connect(iadd, 500);// 设置连接超时时间为2秒
			is = socket.getInputStream();
			os = socket.getOutputStream();
			os.write(SensorUtil.hexStringToByte((String) map.get(type)));
			os.flush();
			byte[] words = new byte[8];
			is.read(words);
			retString = SensorUtil.bytesToHexString(words);
			System.out.println(retString);
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println(e.getMessage() + "  [连接超时：检查ip、port，或者被占用]");
		} finally {
			if (os != null) {
				try {
					os.close();
				} catch (IOException e) {
				}
			}
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
				}
			}
			if (socket != null) {
				try {
					socket.close();
				} catch (IOException e) {
				}
			}
		}

		return retString;
	}

	public static void main(String[] args) {
		aaa();
		// bbb();
		// ccc();
	}
}

class ThreadIn implements Runnable {
	InputStream is = null;

	public ThreadIn(InputStream is) {
		this.is = is;
	}

	public void run() {

		byte[] words = new byte[8];
		try {
			while (true) {
				System.out.println(is.available());
				is.read(words);
				System.out.println(SensorUtil.bytesToHexString(words));
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}

class ThreadOut implements Runnable {
	OutputStream os;

	public ThreadOut(OutputStream os) {
		this.os = os;
	}

	public void run() {
		Scanner sc = new Scanner(System.in);
		while (true) {
			// String words = sc.nextLine();
			// SensorUtil.hexStringToByte(words);
			try {

				os.write(SensorUtil.hexStringToByte("5501120000000169"));
				// os.write(SensorUtil.hexStringToByte("5501110000000168"));
				os.flush();
				try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				// os.write(SensorUtil.hexStringToByte(words));
				// os.flush();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

	}

}
