package com.zyiot.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.regex.Pattern;

/**
 * 
 * @author Lip
 * 
 *         对数据进行校验，确保数据符合要求
 * 
 */
public class ValidateUtil {

	/**
	 * 判断是否为空
	 * 
	 * @param s
	 *            需校验的字符串
	 * @return true:为空,false:不为空
	 */
	public static Boolean isEmpty(String str) {
		if (null == str || "".equals(str) || "".equals(str.trim())
				|| "null".equalsIgnoreCase(str)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 验证是否为整形,范围-2147483648~2147483647
	 * 
	 * @param str
	 *            需验证的字符串
	 * @return true:整形,false:不为整形
	 */
	public static Boolean isInt(String str) {
		if (isEmpty(str)) {
			return true;
		}
		Pattern pattern = Pattern.compile("[0-9]*");
		if (pattern.matcher(str).matches()) {
			try {
				if (Integer.parseInt(str) <= 2147483647) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				return false;
			}
		} else {
			return false;
		}
	}

	/**
	 * 判断是否是浮点数
	 * 
	 * @param s
	 *            需校验的字符串
	 * @return true:浮点数，false:非浮点数
	 */
	public static Boolean isFloat(String str) {
		if (isEmpty(str)) {
			return true;
		}
		if (!str.contains(".")) {
			Pattern pattern = Pattern.compile("[0-9]*");
			return pattern.matcher(str).matches();
		} else {
			String[] temp = str.split("\\.");
			if (temp.length == 2) {
				if (isInt(temp[0]) && isInt(temp[1])) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		}
	}

	/**
	 * 判断是否为长日期格式：yyyy-MM-dd HH:mm:ss
	 * 
	 * @param str
	 *            需验证的字符串
	 * @return true:长日期，false:不是长日期
	 */
	public static Boolean isLongDate(String str) {
		if (isEmpty(str)) {
			return true;
		}
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			df.parse(str);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 判断是否为短日期格式：yyyy-MM-dd
	 * 
	 * @param str
	 *            需验证的字符串
	 * @return true:短日期,false:不是短日期
	 */
	public static Boolean isShortDate(String str) {
		if (isEmpty(str)) {
			return true;
		}
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			df.parse(str);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	/**
	 * 字符串是否超过指定长度
	 * @param str 字符串
	 * @param length 最大长度
	 * @return true:未超出,false:超出指定长度
	 */
	public static Boolean isLength(String str,int length) {
		if (isEmpty(str)) {
			return true;
		} else {
			if (str.length() <= length) {
				return true;
			} else {
				return false;
			}
		}
	}
}
