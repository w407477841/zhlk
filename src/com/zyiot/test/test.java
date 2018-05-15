package com.zyiot.test;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Enumeration;
import java.util.Random;

public class test {
	public static void main(String[] args) {
		for(int i=0;i<20;i++){
			random(20,2,1);
		}
	}
	
	private static void random(int baseline,int errorValue,int decimal){
		StringBuffer result = new StringBuffer();
		Random random = new Random();
		int s = random.nextInt(errorValue*2+1) - errorValue;
		result.append(baseline+s);
		if(decimal>0){
			result.append(".");
			for(int i=0;i<decimal;i++){
				result.append(random.nextInt(10));
			}
		}
		System.out.println(result.toString());
	}
	
	
	private static void test1() {
		System.out.println("==========test1方法中运行start......");
		try {
			InetAddress ipInfo = InetAddress.getLocalHost();
			// 输出IP地址内容
			System.out.println(ipInfo.getHostAddress());
			// 获得网卡内容字节数组
			byte[] byAddress = NetworkInterface.getByInetAddress(ipInfo)
					.getHardwareAddress();
			// 输出数组长度
			System.out.println(byAddress.length);
			// 地址字符串容器
			StringBuffer stringBuffer = new StringBuffer();
			// 单个数组值进行转换
			for (int i = 0; i < byAddress.length; i++) {
				// 单个数组值 就是一个地址位数添加分隔符
				if (i != 0) {
					stringBuffer.append("-");
				}
				// 字节转换为16进制数
				int number = byAddress[i] & 0xff;
				String strAddr = Integer.toHexString(number);
				System.out
						.println("转换后：======================================="
								+ strAddr);

				// 当转换的值是 个位数时，在前面补0
				if (strAddr.length() == 1) {
					stringBuffer.append("0" + strAddr);
				} else {
					stringBuffer.append(strAddr);
				}
			}
			// 输出转换后的mac地址
			System.out.println("转换后的MacAddress为:"
					+ stringBuffer.toString().toUpperCase());

		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (SocketException e) {
			e.printStackTrace();
		}
		System.out.println("==========test1方法中运行over......");
	}

	private static void test() {
		System.out.println("==========test方法中运行start......");

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
					System.out.println(stringBuffer.toString().toUpperCase());
				}
			}
		} catch (SocketException e) {
			e.printStackTrace();
		}
		System.out.println("==========test方法中运行 over......");
	}

	public static String numberConvertUp(String money){

		String Number[] = { "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖" };
		String Post[] = { "拾", "佰", "仟", "万", "拾", "佰", "仟", "亿", "拾","佰", "仟" };
	    String Moneys[] = new String[30];// je[]数组用于存放数字金额被转换后的数字
		
	    //存取小数部分
	    String dec = null;
		int index = money.indexOf(".");
		if(index>0){
			dec = money.substring(index+1);
			money = money.substring(0, index);
		}
		//存取整数部分
		long full = 0;
		
		full = Long.parseLong(money);
		// bitt用于存放第几个需转换的金额数字，
		int bitt = 0, j, k = -1, i = 0;
		
		StringBuffer temps = new StringBuffer();
		// 转换过程
		while (full != 0) {
			bitt = (int) (full % 10L);
			// 计算出每个数字对应的大写值
			for (j = 0; j < Number.length; j++) {
				if (j == bitt)
					break;
			}
			
			if (k != -1) {
				Moneys[i] = Post[k];
				i++;
			}
			
			Moneys[i] = Number[j];
			i++;
			
			full = full / 10;
			k++;
			
			if (full == 0) {
				i--;
				for (; i >= 0; i--){
					temps.append(Moneys[i]);
				}
			}
		}
		
		System.out.println("原始:"+temps.toString());
		
		String result = temps.toString().replace("零仟", "零").replace("零佰", "零").replace("零拾", "零");
		System.out.println("第一:"+result);
		
		StringBuffer sb = new StringBuffer();
		boolean flag = false;
		for(int n = 0;n<result.length();n++){
			String t = result.substring(n,n+1);
			if(t.equals("零")){
				if(!flag){
					sb.append(t);
					flag = true;
				}
			}else{
				sb.append(t);
				flag = false;
			}
		}
		result = sb.toString();
		System.out.println("第一:"+result);
		
		
		result = result.replace("零亿", "亿").replace("零万", "万");
		System.out.println("第二:"+result);
		
		while(result.substring(result.length()-1).equals("零")){
			result = result.substring(0, result.length()-1);
		}
		System.out.println("第三:"+result);
		
		String[] aa = {"角","分"};
		temps = new StringBuffer();
		if(index>0 && dec != null){
			for(int m = 0;m<dec.length();m++){
				String t = dec.substring(m, m+1);
				if(!t.equals("0")){
					temps.append(Number[Integer.parseInt(t)]);
					temps.append(aa[m]);
				}
			}
		}
		if(temps.length()>0){
			result+="元";
			result+=temps.toString();
		}else{
			result+="元整";
		}
		System.out.println("第四:"+result);
		
		//result = sb.toString().replace("零亿", "亿").replace("零万", "万").replace("零仟", "零").replace("零佰", "零").replace("零拾", "零");
		
		return result;
	}
	
}
