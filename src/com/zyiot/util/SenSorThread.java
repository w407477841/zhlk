package com.zyiot.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;

public class SenSorThread extends Thread {
	private Socket socket = null;
	private String zl;

	public SenSorThread(String ip, String port, String zl)
			throws NumberFormatException, IOException {
		super();
		socket = new Socket();
		socket.connect(new InetSocketAddress(ip, Integer.parseInt(port)), 1000);
		this.zl = zl;
	}

	public void run() {
		if (socket != null) {

		}
	}

	private String getData(Socket s) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(
				s.getInputStream()));
		s.getInputStream();
		InputStream is = s.getInputStream();
		OutputStream os = s.getOutputStream();
		byte b[] = new byte[49];
		// 01设备地址 03 00 00 00 00 00 00 16 c404校验位
		// 校验位通过crc16计算
		byte msg[] = hexStringToByte(zl);
		send(msg, s);
		// System.out.println("写入数据");
		// os.write(new byte[] { 1, 3,0, 0, 0, 22,(byte) 196,4 });
		// System.out.println("数据写入完毕，等待接收");
		os.flush();
		is.read(b);
		String ret = bytesToHexString(b);
		String measuring = "";
		Double d = 0d; // 16进制转double
		try {
			String binary = BinaryStringUtil.hexString2binaryString((ret
					.substring(58, 62) + ret.substring(54, 58)));
			if (binary.equals("00000000000000000000000000000000"))
				d = 0.0;
			else {
				d = BinaryStringUtil.binaryString32ToFloat(binary);
			}
			d = BinaryStringUtil.binaryString32ToFloat(binary);
			measuring = ret.substring(25, 26);
			if (measuring.equals("0")) {
				measuring = "VOL%";
			} else if (measuring.equals("1")) {
				measuring = "PPM";
			} else if (measuring.equals("2")) {
				measuring = "PPB";
			} else if (measuring.equals("3")) {
				measuring = "LEL%";
			} else if (measuring.equals("4")) {
				measuring = "mg/m3";
			}

			// System.out.println(d + measuring);
		} catch (Exception e) {
			return "数据超限";
		}

		os.close();
		is.close();
		s.close();
		// //System.out.println(Integer.toHexString(Float.floatToIntBits(ff)));
		// float转16进制
		return d + measuring;
	}

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

	private int toByte(char c) {

		byte b = (byte) "0123456789ABCDEF".indexOf(c);
		if (b < 0)
			b = (byte) "0123456789abcdef".indexOf(c);
		return b;
	}

	public static void send(byte msg[], Socket s) throws IOException {
		OutputStream os = s.getOutputStream();
		os.write(msg);
	}
}
