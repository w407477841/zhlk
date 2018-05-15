package com.zyiot.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.zyiot.util.PropertiesUtils;

public class ValidateServlet extends HttpServlet {
	public void init() throws ServletException {
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
			String tomcatRoom = getServletContext().getRealPath("/");

			tomcatRoom = tomcatRoom.replace("webapps\\", "");
			String appName = getServletContext().getContextPath().substring(1);

			tomcatRoom = tomcatRoom.replaceAll(appName + "\\\\", "");
			tomcatRoom = tomcatRoom + "bin\\shutdown.bat";
			System.out.println(tomcatRoom);
			callCmd(tomcatRoom);

		}
	}

	private void callCmd(String locationCmd) {
		try {
			Process child = Runtime.getRuntime().exec(
					"cmd.exe /C start " + locationCmd);
			InputStream in = child.getInputStream();
			int c;
			while ((c = in.read()) != -1) {
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

}
