package com.zyiot.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.Socket;

public class ClientSocketUtil {

	protected static Socket server;
	// private String url="";
	// private int port=9766;
	private boolean isConnected = true;

	public ClientSocketUtil(int port) {// 链接自己，本机上测试的时候用
		try {
			server = new Socket(InetAddress.getLocalHost(), port);
		} catch (Exception e) {
			isConnected = false;
		}
	}

	public ClientSocketUtil(String url, int port) {
		try {
			server = new Socket(url, port);
		} catch (Exception e) {
			isConnected = false;
		}
	}

	// 向服务端程序发送数据
	public void send(String data) {
		try {

			OutputStreamWriter osw = new OutputStreamWriter(
					server.getOutputStream(), "UTF-8");
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
	 * 从服务端程序接收数据,返回一个BufferedReader
	 * 
	 * @return
	 */
	public BufferedReader recieve() {
		InputStreamReader isr = null;
		BufferedReader br = null;
		try {
			isr = new InputStreamReader(server.getInputStream(), "utf-8");
			br = new BufferedReader(isr);
		} catch (IOException e) {
		}
		return br;
	}

	public void close() {
		try {
			if (server != null || server.isConnected()) {
				server.close();
			}
		} catch (IOException e) {
		}
	}

	public boolean isConnected() {
		return isConnected;
	}

	public void setConnected(boolean isConnected) {
		this.isConnected = isConnected;
	}

	public static void main(String[] args) {

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
