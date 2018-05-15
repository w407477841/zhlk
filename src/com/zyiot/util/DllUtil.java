package com.zyiot.util;

import com.sun.jna.Native;
import com.sun.jna.WString;
import com.sun.jna.win32.StdCallLibrary;

public class DllUtil {
	public interface COMM232 extends StdCallLibrary {
		/**
		 * 
		 * 当前路径是在项目下，而不是bin输出目录下。
		 * 
		 */
		COMM232 INSTANCE = (COMM232) Native.loadLibrary("COMM232", COMM232.class);

		public void say(WString value);
		public void StopComm();
		
		public int OpenComm(int num);
		
		public int GetMacNo(int MacNo);
		
		public int SetAutoRead(int MacNo,int SetValue);
		
		public int ReadVersion(int MacNo,char[] Version);
		
		public int ReadUID(int MacNo,byte[] UID);
	}
	
	public static void main(String[] args) {
		int a = COMM232.INSTANCE.OpenComm(1001);
		System.out.println("a:"+a);
		byte[] c = new byte[5];
		int e = COMM232.INSTANCE.ReadUID(0,c);
		if(e == 0){
			for(byte b:c){
				System.out.println(b);
				System.out.println(convertEightBinary(b));
				System.out.println(Integer.toBinaryString(b));
			}
		}
		COMM232.INSTANCE.StopComm();
	}
	
	public String getUID(){
		StringBuffer result = new StringBuffer();
		int a = COMM232.INSTANCE.OpenComm(1001);
		if(a == 0){
			byte[] c = new byte[5];
			int e = COMM232.INSTANCE.ReadUID(0,c);
			if(e == 0){
				for(byte b:c){
					result.append(convertEightBinary(b));
				}
			}else{
				result.append("读卡失败");
			}
		}else{
			result.append("未找到读卡器");
		}
		COMM232.INSTANCE.StopComm();
		return result.toString();
	}
	
	/**
	 * 转换称八位二进制
	 * 最高位为符号位，0整数，1负数
	 * @param num
	 * @return
	 */
	public static String convertEightBinary(int num){
		StringBuffer result = new StringBuffer();
		if(num>=0){
			result.append("0");
		}else{
			result.append("1");
		}
		
		num = Math.abs(num);
		String tem = Integer.toBinaryString(num);
		for(int i=0;i<7-tem.length();i++){
			result.append("0");
		}
		result.append(tem);
		return result.toString();
	}
}
