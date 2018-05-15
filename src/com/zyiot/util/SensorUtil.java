package com.zyiot.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;

public class SensorUtil {

	public static String getData(String ip, String port, String zl)
			throws UnknownHostException, IOException, SocketTimeoutException {
		Socket s = new Socket();
		s.setSoTimeout(1000);
		s.connect(new InetSocketAddress(ip, Integer.parseInt(port)), 1000);
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
		System.out.println("写入数据");
		// os.write(new byte[] { 1, 3,0, 0, 0, 22,(byte) 196,4 });

		os.flush();
		System.out.println("数据写入完毕，等待接收");
		is.read(b);
		System.out.println("开始读取");
		String ret = bytesToHexString(b);
		// System.out.println(ret);
		String measuring = "";
		Double d = 0d; // 16进制转double
		try {
			String binary = BinaryStringUtil.hexString2binaryString((ret
					.substring(58, 62) + ret.substring(54, 58)));
			// System.out.println(binary);
			if (binary.equals("00000000000000000000000000000000"))
				d = 0.0;
			else {
				d = BinaryStringUtil.binaryString32ToFloat(binary);
			}
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

			System.out.println(d + measuring);
		} catch (Exception e) {
			return "0.0";
		}

		os.close();
		is.close();
		s.close();
		// //System.out.println(Integer.toHexString(Float.floatToIntBits(ff)));
		// float转16进制
		// System.out.println(d + measuring);
		return d + measuring;
	}

	public static String bytesToHexString(byte[] src) {
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

	public static byte[] hexStringToByte(String hex) {
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

	public static void send(byte msg[], Socket s) throws IOException {
		OutputStream os = s.getOutputStream();
		os.write(msg);
	}

	public static void main(String[] args) {
		//
		// try {
		// SenSorThread s1 = new SenSorThread("218.91.235.70", "50005",
		// "020300000016c437");
		// s1.run();
		// } catch (NumberFormatException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// } catch (IOException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }

		try {

			SensorUtil.getData("183.207.189.200", "40001", "150300000016c710");
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// String l =
		// "03032c00000000001600000001000000004248000041f0000041700000000000000000a6f04415000041c0e968448fe706";
		// String xsnd = l.substring(58, 62) + l.substring(54, 58);
		// System.out.println(xsnd);
		// System.out.println(BinaryStringUtil.hexString2binaryString(xsnd));
		// try {
		// BinaryStringUtil.binaryString32ToFloat(BinaryStringUtil
		// .hexString2binaryString(xsnd));
		// } catch (Exception e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// String dbnd = l.substring(50, 54) + l.substring(46, 50);
		//
		// System.out.println(dbnd);
		// System.out.println(BinaryStringUtil.hexString2binaryString(dbnd));
		// try {
		// BinaryStringUtil.binaryString32ToFloat(BinaryStringUtil
		// .hexString2binaryString(dbnd));
		// } catch (Exception e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// String gbnd = l.substring(42, 46) + l.substring(38, 42);
		//
		// System.out.println(gbnd);
		// System.out.println(BinaryStringUtil.hexString2binaryString(gbnd));
		// try {
		// BinaryStringUtil.binaryString32ToFloat(BinaryStringUtil
		// .hexString2binaryString(gbnd));
		// } catch (Exception e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
	}
}
