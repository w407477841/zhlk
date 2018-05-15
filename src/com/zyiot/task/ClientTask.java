package com.zyiot.task;

import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.zyiot.entity.StorageDetailFormMap;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.StoreInfoFormMap;
import com.zyiot.entity.qualityChain.InstanceMsgFormMap;
import com.zyiot.entity.shouchu.InstorageQualityFormMap;
import com.zyiot.entity.shouchu.StorageFormMap;
import com.zyiot.entity.shouchu.WeightingFormMap;
import com.zyiot.server.StorageServerI;
import com.zyiot.server.StorageServiceI;
import com.zyiot.server.StoreInfoServerI;
import com.zyiot.util.ClientSocketUtil;
import com.zyiot.util.PropertiesUtils;

@Component
@Lazy(false)
public class ClientTask {
	@Autowired
	StorageServerI storageServer;
	@Autowired
	StorageServiceI storageService;
	@Autowired
	StoreInfoServerI storeInfoServer;

	@Scheduled(cron = "0 30 *  * * ? ")
	// @Scheduled(cron = "0 1 0/1  * * ? ") 每个小时第一分钟
	public void upload() throws Exception {
		ClientSocketUtil util = null;
		String open = PropertiesUtils.getPropertyByName("socket.properties")
				.getProperty("open_client");
		if (open == null || open.equals("") || !open.equals("1")) {
			System.out.println("县级平台对接接口未打开");
			return;
		}
		String port = PropertiesUtils.getPropertyByName("socket.properties")
				.getProperty("client_port");
		String ip = PropertiesUtils.getPropertyByName("socket.properties")
				.getProperty("client_ip");

		// 获取location
		String location = PropertiesUtils
				.getPropertyByName("socket.properties").getProperty("location");
		String locations[] = location.split(",");
		for (int i = 0; i < locations.length; i++) {
			try {
				util = new ClientSocketUtil(ip, Integer.parseInt(port));
				sendStorage(locations[i], util);
				sendQuality(locations[i], util, i == 0);
				sendWeighting(locations[i], util, i == 0);
				sendStock(locations[i], util);
				sendStore(locations[i], util);
				sendDetail(locations[i], util);
				sendTongcang(locations[i], util);

			} catch (Exception e) {
				e.printStackTrace();
				// return
			} finally {
				if (util != null)
					util.close();
			}
		}

		return;

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

	private void sendQuality(String location, ClientSocketUtil util,
			boolean isSend) throws Exception {
		util.send(location);
		BufferedReader br = util.recieve();
		String lasttime = "";
		lasttime = br.readLine();
		System.out.println("从服务器获取到了时间为" + lasttime);

		InstorageQualityFormMap formmap = new InstorageQualityFormMap();
		formmap.put("lasttime", lasttime);
		// formmap.put("location", location);
		List<InstorageQualityFormMap> storages = null;
		if (isSend)
			storages = storageServer.findQuality(formmap);
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

	private void sendWeighting(String location, ClientSocketUtil util,
			boolean isSend) throws Exception {
		util.send(location);
		BufferedReader br = util.recieve();
		String lasttime = "";
		lasttime = br.readLine();
		System.out.println("从服务器获取到了时间为" + lasttime);

		WeightingFormMap formmap = new WeightingFormMap();
		formmap.put("lasttime", lasttime);
		// formmap.put("location", location);
		List<WeightingFormMap> storages = null;
		if (isSend)
			storages = storageServer.findWeighting_g_lasttime(formmap);
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

	/**
	 * 
	 * @param location
	 * @param util
	 * @throws Exception
	 * 
	 *             库存
	 * 
	 */
	private void sendStock(String location, ClientSocketUtil util)
			throws Exception {
		BufferedReader br = util.recieve();
		List<StorageInfoFormMap> storages = storageService.findAll();

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
				throw new Exception("意外4");
			}
		}
	}

	private void sendStore(String location, ClientSocketUtil util)
			throws Exception {
		BufferedReader br = util.recieve();
		List<StoreInfoFormMap> storages = storeInfoServer.findAll();
		List<StoreInfoFormMap> newstorages = new ArrayList();

		if (storages == null || storages.size() == 0) {
			util.send("null");
			br.readLine();
		} else {
			for (int i = 0; i < storages.size(); i++) {
				StoreInfoFormMap m = storages.get(i);
				Date d = m.getDate("siPutin");
				m.put("siPutin", d != null ? d.toString() : "");
				d = m.getDate("siUpdatetime");
				m.put("siUpdatetime", d != null ? d.toString() : "");
				newstorages.add(m);
			}
			JSONArray json = JSONArray.fromObject(newstorages);
			System.out.println("客户端发送的数据：" + json.toString());
			util.send(json.toString());
			String s = "";
			s = br.readLine();
			if (s.equals("error")) {
				throw new Exception("意外5");
			}
		}
	}

	private void sendTongcang(String location, ClientSocketUtil util)
			throws Exception {
		BufferedReader br = util.recieve();
		List<InstanceMsgFormMap> storages = storeInfoServer.findAllTongcang();
		List<InstanceMsgFormMap> newstorages = new ArrayList();
		if (storages == null || storages.size() == 0) {
			util.send("null");
			br.readLine();
		} else {
			for (int i = 0; i < storages.size(); i++) {
				InstanceMsgFormMap m = storages.get(i);
				Date d = m.getDate("dates");
				m.put("dates", d != null ? d.toString() : "");
				newstorages.add(m);
			}
			JSONArray json = JSONArray.fromObject(newstorages);
			System.out.println("客户端发送的数据：" + json.toString());
			util.send(json.toString());
			String s = "";
			s = br.readLine();
			if (s.equals("error")) {
				throw new Exception("意外7");
			}
		}
	}

	private void sendDetail(String location, ClientSocketUtil util)
			throws Exception {
		BufferedReader br = util.recieve();
		List<StorageDetailFormMap> storages = storeInfoServer.findAllDetail();
		List<StorageDetailFormMap> newstorages = new ArrayList();
		String prelocation = location.substring(0, 1)
				+ location.substring(location.length() - 3);
		if (storages == null || storages.size() == 0) {
			util.send("null");
			br.readLine();
		} else {
			for (int i = 0; i < storages.size(); i++) {
				StorageDetailFormMap s = storages.get(i);
				s.put("id", prelocation + s.get("id"));
				s.put("storage_id", prelocation + s.get("storage_id"));
				newstorages.add(s);
			}

			JSONArray json = JSONArray.fromObject(newstorages);
			System.out.println("客户端发送的数据：" + json.toString());
			util.send(json.toString());
			String s = "";
			s = br.readLine();
			if (s.equals("error")) {
				throw new Exception("意外6");
			}
		}
	}
}
