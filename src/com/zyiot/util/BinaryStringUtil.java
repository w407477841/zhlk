package com.zyiot.util;

public class BinaryStringUtil {
	/**
	 * 将 32位二进制转换成double数
	 * 
	 * @return
	 * @throws Exception
	 */
	public static double binaryString32ToFloat(String bs) throws Exception {
		int len = bs.length();
		if (len > 32)
			throw new Exception("超过32位");
		else if (len < 32)
			throw new Exception("小于32位");
		int symbol = Integer.parseInt(bs.substring(0, 1));
		if (symbol == 1)
			System.out.println("负数");
		else
			System.out.println("正数");

		String offsetBinary = bs.substring(1, 9);
		int offset = Integer.valueOf(offsetBinary, 2) - 127;
		String valueBinary = "1" + bs.substring(9, 32);
		String positiveBinary = valueBinary.substring(0, offset + 1);
		String decimalBinary = valueBinary.substring(offset + 1);
		double f = 0f;
		for (int i = 0; i < positiveBinary.length(); i++) {
			f = f
					+ (Integer.parseInt(positiveBinary.substring(i, i + 1)) << (offset - i));
		}
		for (int i = 0; i < decimalBinary.length(); i++) {
			double temp = Math.pow(2, -(i + 1))
					* Integer.parseInt(decimalBinary.substring(i, i + 1));
			f = f + temp;
		}

		return Math.round(f * 100) / 100.0;
	}

	public static String hexString2binaryString(String hexString) {
		if (hexString == null || hexString.length() % 2 != 0)
			return null;
		String bString = "", tmp;
		for (int i = 0; i < hexString.length(); i++) {
			tmp = "0000"
					+ Integer.toBinaryString(Integer.parseInt(
							hexString.substring(i, i + 1), 16));
			bString += tmp.substring(tmp.length() - 4);
		}
		return bString;
	}

	public static void main(String[] args) {
		System.out.println(BinaryStringUtil.hexString2binaryString("00000001"));
		try {
			System.out.println(BinaryStringUtil
					.binaryString32ToFloat("00000000000000000000000000000001"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}