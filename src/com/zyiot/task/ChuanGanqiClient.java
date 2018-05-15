package com.zyiot.task;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;

import org.apache.log4j.Logger;

import com.zyiot.util.BinaryStringUtil;

public class ChuanGanqiClient {
	Logger log = Logger.getLogger(ChuanGanqiClient.class);
	private Socket client;
	private InputStream is;
	private BufferedReader br;
	private OutputStream os;
	private byte[] b = new byte[80];

	public ChuanGanqiClient(String ip, int port) {

		try {
			client = new Socket();
			client.setSoTimeout(2000);// 设置接受超时
			client.connect(new InetSocketAddress(ip, port), 1500);
			is = client.getInputStream();
			br = new BufferedReader(new InputStreamReader(is));
			os = client.getOutputStream();
		} catch (UnknownHostException e) {
			log.error("==Class:ChuanGanqiClient==ip:"+ip+"==port:"+port+"==exception:未知主机"+e);
		} catch (SocketTimeoutException e) {
			if (!client.isClosed() && client.isConnected()){
				log.error("==Class:ChuanGanqiClient==ip:"+ip+"==port:"+port+"==exception:读取数据超时!"+e);
			}
			else{
				log.error("==Class:ChuanGanqiClient==ip:"+ip+"==port:"+port+"==exception:连接超时"+e);
			}
		} catch (IOException e) {
			log.error("==Class:ChuanGanqiClient==ip:"+ip+"==port:"+port+"==exception:连接出错"+e);
		}
	}

	public void send(byte msg[]) throws IOException {
		os.write(msg);
	}

	public String receive() throws IOException {

		return br.readLine();

	}

	public void close() {
		if (client != null) {
			try {
				client.close();
			} catch (IOException e) {
			}
		}
	}

	public String getStr(String zl) {

		String sl = "00000000000000000000000000000000";
		Double ret = 0.0;
		if (client == null)
			return "0.0";
		try {
			send(hexStringToByte(zl));
			is.read(b);
			sl = bytesToHexString(b);
			String binary = BinaryStringUtil.hexString2binaryString((sl
					.substring(58, 62) + sl.substring(54, 58)));
			System.out.println(binary);
			if (binary.equals(sl)) {
				return ret + "";
			}
			try {
				ret = BinaryStringUtil.binaryString32ToFloat(binary);
			} catch (Exception e) {
				return "0.0";
			}
		} catch (IOException e) {
			return "0.0";
		} catch (Exception e) {
			return "0.0";
		}

		return ret + "";
	}

	/**
	 * 16进制字符串转byte
	 */
	private byte[] hexStringToByte(String hex) {
		int len = (hex.length() / 2);
		byte[] result = new byte[len];
		char[] achar = hex.toCharArray();
		for (int i = 0; i < len; i++) {
			int pos = i * 2;
			result[i] = (byte) (toByte(achar[pos]) << 4 | toByte(achar[pos + 1]));
		}
		return result;
	}

	private static int toByte(char c) {

		byte b = (byte) "0123456789ABCDEF".indexOf(c);
		if (b < 0)
			b = (byte) "0123456789abcdef".indexOf(c);
		return b;
	}

	/**
	 * 将Byte数组转成16进制字符串
	 * 
	 */
	private String bytesToHexString(byte[] src) {
		StringBuilder stringBuilder = new StringBuilder("");
		if (src == null || src.length <= 0) {
			return null;
		}
		for (int i = 0; i < src.length; i++) {
			int v = src[i] & 0xFF;
			String hv = Integer.toHexString(v);
			if (hv.length() < 2) {
				stringBuilder.append(0);
			}
			stringBuilder.append(hv);
		}
		return stringBuilder.toString();
	}

	public static void main(String[] args) {
		ChuanGanqiClient c = new ChuanGanqiClient("183.207.189.200", 40001);
		System.out.println(c.getStr("150300000016c710"));
	}
}
