package com.zyiot.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.entity.UserFormMap;
import com.zyiot.entity.WarehouseFormMap;
import com.zyiot.entity.WarehouseInfoFormMap;
import com.zyiot.entity.WarehouseLocationFormMap;
import com.zyiot.entity.shouchu.InstorageQualityFormMap;
import com.zyiot.entity.shouchu.StorageFormMap;
import com.zyiot.entity.shouchu.WeightingFormMap;
import com.zyiot.server.StorageServerI;
import com.zyiot.server.WarehouseInfoServerI;
import com.zyiot.server.WarehouseLocationServerI;
import com.zyiot.server.WarehouseServerI;
import com.zyiot.server.dataDocking.DataDockingServerI;
import com.zyiot.server.weight.ReportHarborServerI;
import com.zyiot.util.ClientSocketUtil;
import com.zyiot.util.JasperHelper;
import com.zyiot.util.MapUtil;

@Controller
@RequestMapping("ei")
public class ExternalInterfaceController extends BaseController {

	@Autowired
	WarehouseLocationServerI warehouseLocationServer;
	@Autowired
	WarehouseServerI warehouseServer;

	@Autowired
	WarehouseInfoServerI warehouseInfoServer;
	@Autowired
	StorageServerI storageServer;
	@Autowired
	private DataDockingServerI dockingServer;

	@Autowired
	private ReportHarborServerI reportHarborServer;

	@RequestMapping("test")
	@ResponseBody
	public HashMap test(String data) {

		JSONArray json = JSONArray.fromObject(data);
		List<UserFormMap> persons = (List<UserFormMap>) JSONArray.toCollection(
				json, UserFormMap.class);

		for (UserFormMap u : persons) {
			MapUtil.sysoMapKeyAndVal(u);
		}

		return null;
	}

	/**
	 * 查询粮库主键
	 * 
	 * @param wNo
	 * @return
	 */
	@RequestMapping("findLocationByNo")
	@ResponseBody
	public HashMap findLocationByNo(String wNo) {
		HashMap ret = new HashMap();
		WarehouseLocationFormMap wl = new WarehouseLocationFormMap();
		if (wNo == null || wNo.equals("")) {
			ret.put("message", "需要提供 参数 wNo且不能为空 ");
			return ret;
		}
		wl.put("wNo", wNo);
		List<WarehouseLocationFormMap> ls = null;
		try {
			ls = warehouseLocationServer.findAllWarehouseLocation(wl);
		} catch (Exception e) {
			ret.put("message", "异常，请联系接口提供商");
		}
		if (ls != null && ls.size() > 0)
			wl = ls.get(0);
		else {
			ret.put("message", "未查询到 ");
		}
		ret.put("id", wl.get("id"));
		ret.put("message", "成功");
		return ret;
	}

	/**
	 * 添加仓库 参数
	 * [{"wNo":"05","wName":"仓库5","wHeight":"4","wColumn":"7","wRow":"5",
	 * "wLocation":"1","wStatus":"1","wDisable":"1"},
	 * {"wNo":"06","wName":"仓库6","wHeight"
	 * :"4","wColumn":"7","wRow":"5","wLocation"
	 * :"1","wStatus":"1","wDisable":"1"} ]
	 * 
	 * @param data
	 * @return
	 */
	@RequestMapping("addWareHouse")
	@ResponseBody
	public HashMap addWareHouse(String data) {
		HashMap ret = new HashMap();
		JSONArray json = JSONArray.fromObject(data);
		List<WarehouseFormMap> warehouses = (List<WarehouseFormMap>) JSONArray
				.toCollection(json, WarehouseFormMap.class);
		List<WarehouseFormMap> newWarehouses = new ArrayList<WarehouseFormMap>();
		for (WarehouseFormMap u : warehouses) {
			// MapUtil.sysoMapKeyAndVal(u);
			WarehouseFormMap ws = new WarehouseFormMap();
			for (Map.Entry<String, Object> m : u.entrySet())
				try {
					String val = (String) m.getValue();
					ws.put(m.getKey(), new String(val.getBytes("iso-8859-1"),
							"utf-8"));
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			newWarehouses.add(ws);
		}

		try {
			warehouseServer.batchSave(newWarehouses);
		} catch (Exception e) {
			ret.put("message", "添加失败");
			return ret;
		}

		ret.put("message", "添加成功");
		return ret;
	}

	/**
	 * 查询仓库主键
	 * 
	 * @param wNo
	 * @return
	 */
	@RequestMapping("findWareHouseByNo")
	@ResponseBody
	public HashMap findWareHouseByNo(String wNo) {
		HashMap ret = new HashMap();
		if (wNo == null || wNo.equals("")) {
			ret.put("message", "需要提供 参数 wNo且不能为空 ");
			return ret;
		}
		WarehouseFormMap ws = new WarehouseFormMap();
		ws.put("wNo", wNo);
		List<WarehouseFormMap> warehouses = null;
		List<WarehouseFormMap> newwarehouses = new ArrayList();
		try {
			warehouses = warehouseServer.findAllWarehouseByLocationId(ws);
			if (warehouses == null || warehouses.size() == 0) {
				ret.put("message", "无数据");
			} else {
				for (WarehouseFormMap w : warehouses) {
					WarehouseFormMap newW = new WarehouseFormMap();
					newW.put("id", w.get("id"));
					newW.put("wName", w.get("wName"));
					newwarehouses.add(newW);
				}
				ret.put("data", newwarehouses);
			}
		} catch (Exception e) {
			ret.put("message", "异常");
			return ret;
		}
		ret.put("message", "成功");
		return ret;
	}

	@RequestMapping("addData")
	@ResponseBody
	public HashMap addData(String data) {
		HashMap ret = new HashMap();
		JSONArray json = JSONArray.fromObject(data);
		List<WarehouseInfoFormMap> warehouseinfos = (List<WarehouseInfoFormMap>) JSONArray
				.toCollection(json, WarehouseInfoFormMap.class);
		try {
			warehouseInfoServer.batchSave(warehouseinfos);
		} catch (Exception e) {
			ret.put("message", "添加失败");
			return ret;
		}
		ret.put("message", "添加成功");
		return ret;
	}

	@RequestMapping("test1")
	@ResponseBody
	public String test1() {
		try {
			reportHarborServer.shijiduijie();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "success";
	}

	private void sendStorage(String location, ClientSocketUtil util)
			throws Exception {
		util.send(location);
		BufferedReader br = util.recieve();
		String lasttime = "";
		lasttime = br.readLine();
		System.out.println("从服务器获取到了时间为" + lasttime);

		StorageFormMap formmap = new StorageFormMap();
		formmap.put("lasttime", lasttime);
		formmap.put("location", location);
		List<StorageFormMap> storages = storageServer.findStorage(formmap);
		if (storages == null || storages.size() == 0) {
			util.send("null");
			br.readLine();
		} else {
			JSONArray json = JSONArray.fromObject(storages);
			System.out.println("客户端发送的数据：" + json.toString());
			util.send(json.toString());
			String s = "";
			s = br.readLine();
			if (s.equals("error")) {
				throw new Exception("意外1");
			}
		}
	}

	private void sendQuality(String location, ClientSocketUtil util)
			throws Exception {
		util.send(location);
		BufferedReader br = util.recieve();
		String lasttime = "";
		lasttime = br.readLine();
		System.out.println("从服务器获取到了时间为" + lasttime);

		InstorageQualityFormMap formmap = new InstorageQualityFormMap();
		formmap.put("lasttime", lasttime);
		// formmap.put("location", location);
		List<InstorageQualityFormMap> storages = storageServer
				.findQuality(formmap);
		if (storages == null || storages.size() == 0) {
			util.send("null");
			br.readLine();
		} else {
			JSONArray json = JSONArray.fromObject(storages);
			System.out.println("客户端发送的数据：" + json.toString());
			util.send(json.toString());
			String s = "";
			s = br.readLine();
			if (s.equals("error")) {
				throw new Exception("意外2");
			}
		}
	}

	private void sendWeighting(String location, ClientSocketUtil util)
			throws Exception {
		util.send(location);
		BufferedReader br = util.recieve();
		String lasttime = "";
		lasttime = br.readLine();
		System.out.println("从服务器获取到了时间为" + lasttime);

		WeightingFormMap formmap = new WeightingFormMap();
		formmap.put("lasttime", lasttime);
		// formmap.put("location", location);
		List<WeightingFormMap> storages = storageServer
				.findWeighting_g_lasttime(formmap);
		if (storages == null || storages.size() == 0) {
			util.send("null");
			br.readLine();
		} else {
			JSONArray json = JSONArray.fromObject(storages);
			System.out.println("客户端发送的数据：" + json.toString());
			util.send(json.toString());
			String s = "";
			s = br.readLine();
			if (s.equals("error")) {
				throw new Exception("意外3");
			}
		}
	}

	@RequestMapping("weixin")
	@ResponseBody
	public long weixin() {
		String signature = getPara("signature");
		String timestamp = getPara("timestamp");
		String nonce = getPara("nonce");
		String echostr = getPara("echostr");

		ArrayList<String> list = new ArrayList<String>();
		list.add(nonce);
		list.add(timestamp);
		list.add("zyiot");

		Collections.sort(list);
		System.out.println(echostr);
		System.out.println(signature);
		System.out.println(getSha1(list.get(0) + list.get(1) + list.get(2)));

		return Long.parseLong(echostr);

	}

	@RequestMapping("xiaoxi")
	@ResponseBody
	public String xiaoxi(HttpServletRequest r) {
		Enumeration<String> e = r.getParameterNames();

		while (e.hasMoreElements()) {
			System.out.println(e.nextElement());
		}
		e = r.getAttributeNames();
		while (e.hasMoreElements()) {
			System.out.println(e.nextElement());
		}
		return "";
	}

	public static String getSha1(String str) {
		if (str == null || str.length() == 0) {
			return null;
		}
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f' };
		try {
			MessageDigest mdTemp = MessageDigest.getInstance("SHA1");
			mdTemp.update(str.getBytes("UTF-8"));

			byte[] md = mdTemp.digest();
			int j = md.length;
			char buf[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				buf[k++] = hexDigits[byte0 >>> 4 & 0xf];
				buf[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(buf);
		} catch (Exception e) {
			return null;
		}
	}

	@Autowired
	private DataSource dataSource;

	@RequestMapping("createhtml")
	public void createhtml(HttpServletRequest request,
			HttpServletResponse response) {
		UserFormMap u = new UserFormMap();
		u.put("location", "");
		u.put("ck", "");
		u.put("cjsj", "");
		JasperHelper.export("html", "仓内传感器", "cangneichuanganqi.jasper", u,
				dataSource, request, response);

	}
}

class ClientSocketThread extends Thread {
	private String data;
	private int port;

	public ClientSocketThread(String data, int port) {
		this.data = data;
		this.port = port;
	}

	public void run() {
		ClientSocketUtil util = new ClientSocketUtil(port);
		util.send(data);
		BufferedReader br = util.recieve();
		String s = "";
		try {
			while ((s = br.readLine()) != null)
				System.out.println(s);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		util.close();
	}

}