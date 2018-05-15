package com.zyiot.controller.cangkuzhinenghuaxitong;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterConfigFormMap;
import com.zyiot.server.WarehouseLocationServerI;
import com.zyiot.server.cangkuzhinenghuaxitong.AmmeterConfigServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.SensorUtil;

@Controller
@RequestMapping("cangkuzhinenghuaxitong/ammeterConfig")
public class AmmeterConfigController extends BaseController {
	@Autowired
	AmmeterConfigServerI ammeterConfigServer;
	@Autowired
	private WarehouseLocationServerI warehouseLocationServer;

	Logger logger = Logger.getLogger(AmmeterConfigController.class);

	@RequestMapping(value = "listUI", method = RequestMethod.POST)
	public String ammeterConfigListUI() {
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterconfig/list";
	}

	@RequestMapping(value = "findByPage")
	@ResponseBody
	public MyPage<AmmeterConfigFormMap> findByPage(int page, int rows) {
		AmmeterConfigFormMap ammeterConfigFormMap = getFormMap(AmmeterConfigFormMap.class);
		return toMyPage(ammeterConfigServer.findAmmeterConfigByPage(
				ammeterConfigFormMap, rows, page));
	}

	@RequestMapping(value = "addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterconfig/add";
	}

	@RequestMapping(value = "editUI")
	public String editUI(Model model) {
		AmmeterConfigFormMap u = new AmmeterConfigFormMap();
		u.put("id", getPara("id"));
		List<AmmeterConfigFormMap> list = ammeterConfigServer
				.findAmmeterConfigByPage(u, 1, 1);
		if (list != null && list.size() > 0) {
			model.addAttribute("ammeterConfigFormMap", list.get(0));
		}
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterconfig/edit";
	}

	@RequestMapping(value = "add")
	@ResponseBody
	public String add() {
		AmmeterConfigFormMap ammeterConfigFormMap = getFormMap(AmmeterConfigFormMap.class);
		try {
			FormMapUtil.toADDFormMap(ammeterConfigFormMap);
			ammeterConfigServer.add(ammeterConfigFormMap);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping(value = "edit")
	@ResponseBody
	public String edit() {
		AmmeterConfigFormMap ammeterConfigFormMap = getFormMap(AmmeterConfigFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(ammeterConfigFormMap);
			ammeterConfigServer.edit(ammeterConfigFormMap);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping(value = "deleteOne")
	@ResponseBody
	public String deleteOne() {
		try {
			ammeterConfigServer.delete(getPara("id"));
		} catch (Exception e) {
			logger.error(e.getMessage());
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping(value = "ammetersUI")
	public String ammetersUI(Model model) {
		model.addAttribute("list", ammeterConfigServer
				.findCangKuDianWei(new AmmeterConfigFormMap()));
		
		String name = getPara("name");
		String imagePath = warehouseLocationServer.getImagePath(name);
		model.addAttribute("imgPath", imagePath);
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterconfig/ammeters";
	}

	@RequestMapping(value = "findAmmetersDatas")
	@ResponseBody
	public List<AmmeterConfigFormMap> findAmmetersDatas() {
		AmmeterConfigFormMap u = new AmmeterConfigFormMap();
		u.put("cangkudianwei", getPara("cangkudianwei"));
		List<AmmeterConfigFormMap> ammeters = ammeterConfigServer
				.findAmmeterConfigByPage(u, -1, -1);
		List<AmmeterConfigFormMap> retList = new ArrayList<>();
		for (AmmeterConfigFormMap ammeter : ammeters) {
			AmmeterConfigFormMap temp = new AmmeterConfigFormMap();
			temp.put("name", ammeter.getStr("name"));
			temp.put("data", readAmmeterTcp(ammeter));
			retList.add(temp);
		}

		return retList;
	}

	public String readAmmeterTcp(AmmeterConfigFormMap ammeter) {
		Socket socket = new Socket();
		InputStream is = null;
		OutputStream os = null;
		try {
			InetSocketAddress add = new InetSocketAddress(ammeter.getStr("ip"),
					Integer.parseInt(ammeter.getStr("port")));
			String retString;
			int length;
			byte[] receive;

			socket.connect(add, 1000);
			is = socket.getInputStream();
			os = socket.getOutputStream();

			os.write(SensorUtil.hexStringToByte(ammeter.getStr("instructions")));
			os.flush();
			retString = "";
			int i = 0;
			length = 0;
			receive = new byte[100];
			while (true) {
				if (i < 0 || i == 22)
					break;
				i = is.read();
				receive[length] = (byte) i;
				length++;
			}

			byte[] byteRet = new byte[length];
			System.arraycopy(receive, 0, byteRet, 0, length);

			retString = SensorUtil.bytesToHexString(byteRet);
			retString = retString.substring(retString.indexOf("68"));
			String hex1 = retString.substring(30, 32);
			String hex2 = retString.substring(28, 30);
			String hex3 = retString.substring(26, 28);
			String hex4 = retString.substring(24, 26);
			String hexDel = "33";// 需要减去的16进制数；

			String ret = Integer
					.toHexString((Integer.parseInt(hex1, 16) - Integer
							.parseInt(hexDel, 16)))
					+ Integer.toHexString((Integer.parseInt(hex2, 16) - Integer
							.parseInt(hexDel, 16)))

					+ Integer.toHexString((Integer.parseInt(hex3, 16) - Integer
							.parseInt(hexDel, 16)))
					+ "."
					+ Integer.toHexString((Integer.parseInt(hex4, 16) - Integer
							.parseInt(hexDel, 16)));
			return ret;
		} catch (IOException e) {
			logger.error(e.getMessage());
			return "error";
		} finally {
			if (is != null)
				try {
					is.close();
				} catch (IOException e) {
					logger.error(e.getMessage());
				}
			if (os != null)
				try {
					os.close();
				} catch (IOException e) {
					logger.error(e.getMessage());
				}
			if (socket != null)
				try {
					socket.close();
				} catch (IOException e) {
					logger.error(e.getMessage());
				}
		}

	}

//	public static void main(String[] args) throws Exception {
//
//		AmmeterConfigFormMap a = new AmmeterConfigFormMap();
//		a.put("ip", "218.91.235.70");
//		a.put("port", "50002");
//		a.put("instructions", "6833920741010268010243C3E916");
//
//		String retString = AmmeterConfigController.readAmmeterTcp(a);
//
//		System.out.println(retString);
//
//	}
}
