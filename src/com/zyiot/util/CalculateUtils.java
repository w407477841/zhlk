package com.zyiot.util;

import java.math.BigDecimal;

public class CalculateUtils {
	/**
	 * 加法
	 * 
	 * @param var1
	 * @param var2
	 * @return
	 */
	public static double add(String var1, String var2) {
		BigDecimal b1 = new BigDecimal(var1);
		BigDecimal b2 = new BigDecimal(var2);
		return b1.add(b2).doubleValue();

	}

	/**
	 * 减法
	 * 
	 * @param var1
	 * @param var2
	 * @return
	 */

	public static double sub(String var1, String var2) {
		BigDecimal b1 = new BigDecimal(var1);
		BigDecimal b2 = new BigDecimal(var2);
		return b1.subtract(b2).doubleValue();
	}

	/**
	 * 乘法
	 * 
	 * @param var1
	 * @param var2
	 * @return
	 */
	public static double mul(String var1, String var2) {
		BigDecimal b1 = new BigDecimal(var1);
		BigDecimal b2 = new BigDecimal(var2);
		return b1.multiply(b2).doubleValue();
	}

	/**
	 * 除法
	 * 
	 * @param v1
	 * @param v2
	 * @param scale 精度，到小数点后几位
	 * @return
	 */

	public static double div(String v1, String v2, int scale) {
		if (scale < 0) {
			throw new IllegalArgumentException(
					"The scale must be a positive integer or ");
		}
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();

	}

	/**
	 * 四舍五入
	 * 
	 * @param v
	 * @param scale 精确位数
	 * @return
	 */
	public static double round(String v, int scale) {
		if (scale < 0) {
			throw new IllegalArgumentException(
					"The scale must be a positive integer or zero");
		}
		BigDecimal b = new BigDecimal(v);
		BigDecimal one = new BigDecimal("1");
		return b.divide(one, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
	
	public static void main(String[] args){
		
		float price = 188;
		int weight = 789087;
		
		double p = div(price+"", 100+"", 3);
		
		double m = mul(806365+"", p+"");
		
		System.out.println(p);
		System.out.println(m);
		System.out.println(round(m+"", 0));
		System.out.println(round(m+"", 1));
	}
}
