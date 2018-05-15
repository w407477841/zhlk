package com.zyiot.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.util.List;

import javax.servlet.ServletContext;

import net.sf.json.JSONArray;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zyiot.entity.StorageDetailFormMap;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.StoreInfoFormMap;
import com.zyiot.entity.qualityChain.InstanceMsgFormMap;
import com.zyiot.entity.shouchu.InstorageQualityFormMap;
import com.zyiot.entity.shouchu.StorageFormMap;
import com.zyiot.entity.shouchu.WeightingFormMap;
import com.zyiot.server.StorageServerI;

public class ServerSocketConnection extends Thread {
	private Socket client;
	private StorageServerI storageServer;

	public ServerSocketConnection(Socket client, ServletContext sc) {
		WebApplicationContext wc = WebApplicationContextUtils
				.getWebApplicationContext(sc);
		this.client = client;
		this.storageServer = (StorageServerI) wc.getBean("sService");
	}

	public void run() {
		try {

			BufferedReader in = recieve();

			String location = "";
			// StringBuffer sb = new StringBuffer();
			location = in.readLine();

			bisInstorage(location, in);

			location = in.readLine();
			bisQuality(location, in);

			location = in.readLine();
			bisWeighting(location, in);

			bisStock(location, in);
			bisStore(location, in);
			bisDetail(location, in);
			bisTongcang(location, in);
			// sb.append(location);
			// System.out.println(sb.toString());

		} catch (Exception ex) {
			ex.printStackTrace();
			send("error");
		} finally {
			try {
				if (client != null)
					client.close();
			} catch (IOException e) {
			}

		}
	}

	private void bisQuality(String location, BufferedReader in)
			throws Exception {
		// 获取最大时间
		String lasttime = findOrAddLasttime("w_quality", location);
		send(lasttime);
		// System.out.println("服务器接受到的数据为：" + sb.toString());
		String datas = "";
		// StringBuffer sb = new StringBuffer();
		datas = in.readLine();
		// sb.append(location);
		// System.out.println(sb.toString());

		// 批量
		if (datas == null || datas.equals("null")) {
		} else {
			addObject(new InstorageQualityFormMap(), datas, 2, location);

		}
		send("success");// 向客户端发送

		System.out.println("---------send success-----------");
		// if (str.equals("end"))
		// break;
		// }
	}

	private void bisWeighting(String location, BufferedReader in)
			throws Exception {
		// 获取最大时间
		String lasttime = findOrAddLasttime("w_weighting", location);
		send(lasttime);
		// System.out.println("服务器接受到的数据为：" + sb.toString());
		String datas = "";
		// StringBuffer sb = new StringBuffer();
		datas = in.readLine();
		// sb.append(location);
		// System.out.println(sb.toString());

		// 批量
		if (datas == null || datas.equals("null")) {
		} else {
			addObject(new WeightingFormMap(), datas, 3, location);

		}
		send("success");// 向客户端发送

		System.out.println("---------send success-----------");
		// if (str.equals("end"))
		// break;
		// }
	}

	private String findOrAddLasttime(String tableName, String location)
			throws Exception {
		StorageFormMap s = new StorageFormMap();
		s.put("location", location);
		s.put("tableName", tableName);
		s = storageServer.findMaxBasicid(s);
		String lasttime = null;
		if (s != null) {
			lasttime = s.get("lasttime") + "";
		}
		if (lasttime == null || lasttime.equals("")) {
			lasttime = "2016-01-01 00:00:00";
			s = new StorageFormMap();
			s.put("location", location);
			s.put("tableName", tableName);
			storageServer.addTimeStamp(s);

		}
		return lasttime;
	}

	private void bisInstorage(String location, BufferedReader in)
			throws Exception {
		String lasttime = findOrAddLasttime("w_instorage", location);

		send(lasttime);
		// System.out.println("服务器接受到的数据为：" + sb.toString());
		String datas = "";
		// StringBuffer sb = new StringBuffer();
		datas = in.readLine();
		// sb.append(location);
		// System.out.println(sb.toString());

		// 批量
		if (datas == null || datas.equals("null")) {

		} else {
			addObject(new StorageFormMap(), datas, 1, location);

		}
		send("success");// 向客户端发送

		System.out.println("---------send success-----------");
		// if (str.equals("end"))
		// break;
		// }
	}

	private void bisStock(String location, BufferedReader in) throws Exception {

		// System.out.println("服务器接受到的数据为：" + sb.toString());
		String datas = "";
		// StringBuffer sb = new StringBuffer();
		datas = in.readLine();
		// sb.append(location);
		// System.out.println(sb.toString());

		// 批量
		if (datas == null || datas.equals("null")) {

		} else {
			addObject(new StorageInfoFormMap(), datas, 4, location);

		}
		send("success");// 向客户端发送

		System.out.println("---------send success-----------");
		// if (str.equals("end"))
		// break;
		// }
	}

	private void bisStore(String location, BufferedReader in) throws Exception {

		// System.out.println("服务器接受到的数据为：" + sb.toString());
		String datas = "";
		// StringBuffer sb = new StringBuffer();
		datas = in.readLine();
		// sb.append(location);
		// System.out.println(sb.toString());

		// 批量
		if (datas == null || datas.equals("null")) {

		} else {
			addObject(new StoreInfoFormMap(), datas, 5, location);

		}
		send("success");// 向客户端发送

		System.out.println("---------send success-----------");
		// if (str.equals("end"))
		// break;
		// }
	}

	private void bisDetail(String location, BufferedReader in) throws Exception {

		// System.out.println("服务器接受到的数据为：" + sb.toString());
		String datas = "";
		// StringBuffer sb = new StringBuffer();
		datas = in.readLine();
		// sb.append(location);
		// System.out.println(sb.toString());

		// 批量
		if (datas == null || datas.equals("null")) {

		} else {
			addObject(new StorageDetailFormMap(), datas, 7, location);

		}
		send("success");// 向客户端发送

		System.out.println("---------send success-----------");
		// if (str.equals("end"))
		// break;
		// }
	}

	private void bisTongcang(String location, BufferedReader in)
			throws Exception {

		// System.out.println("服务器接受到的数据为：" + sb.toString());
		String datas = "";
		// StringBuffer sb = new StringBuffer();
		datas = in.readLine();
		// sb.append(location);
		// System.out.println(sb.toString());

		// 批量
		if (datas == null || datas.equals("null")) {

		} else {
			addObject(new InstanceMsgFormMap(), datas, 6, location);

		}
		send("success");// 向客户端发送

		System.out.println("---------send success-----------");
		// if (str.equals("end"))
		// break;
		// }
	}

	// 向客户端程序发送数据
	public void send(String data) {
		try {
			OutputStreamWriter osw = new OutputStreamWriter(
					client.getOutputStream(), "UTF-8");
			BufferedWriter bw = new BufferedWriter(osw);
			bw.write(data + "\r\n");
			bw.flush();
			// DataOutputStream dos=new
			// DataOutputStream(server.getOutputStream());
			// dos.write(data.getBytes());
			// dos.flush();
		} catch (IOException e) {
		}
	}

	/**
	 * 从客户端程序接收数据,返回一个BufferedReader
	 * 
	 * @return
	 */
	public BufferedReader recieve() {
		InputStreamReader isr = null;
		BufferedReader br = null;
		try {
			isr = new InputStreamReader(client.getInputStream(), "utf-8");
			br = new BufferedReader(isr);
		} catch (IOException e) {
		}
		return br;
	}

	/**
	 * 添加对象，并将id前面添加
	 * 
	 * @param t
	 * @param data
	 * @param id
	 * @throws Exception
	 */

	public <T> void addObject(T t, String data, int type, String location)
			throws Exception {

		JSONArray json = JSONArray.fromObject(data);
		List<T> list = (List<T>) JSONArray.toCollection(json, t.getClass());
		if (type == 1) {
			storageServer.batchSaveStorages((List<StorageFormMap>) list);
		} else if (type == 2) {
			storageServer.batchSaveQuality(
					(List<InstorageQualityFormMap>) list, location);
		} else if (type == 3) {
			storageServer.batchSaveWeighting((List<WeightingFormMap>) list,
					location);
		} else if (type == 4) {
			storageServer.batchSaveStock((List<StorageInfoFormMap>) list);
		} else if (type == 5) {
			storageServer.batchSaveStore((List<StoreInfoFormMap>) list);
		} else if (type == 6) {
			storageServer.batchSaveTongcang((List<InstanceMsgFormMap>) list);
		} else if (type == 7) {
			storageServer
					.batchSaveStoreDetail((List<StorageDetailFormMap>) list);
		}
	}

	public static void main(String[] args) throws IOException {
		// 这个程序的主要目的在于服务器不断接收客户机所写入的信息只到。客户机发送"End"字符串就退出程序。
		// 并且服务器也会做出"Receive"为回应。告知客户机已接收到消息。多线程
		// ServerSocket server = new ServerSocket(10001);
		// while (true) {
		// ServerSocketConnection ssc = new ServerSocketConnection(
		// server.accept(), null);
		// ssc.start();
		// }

	}

}
