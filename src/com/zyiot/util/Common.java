package com.zyiot.util;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.JarURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.Set;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.TableSeg;

public class Common {
	// 后台访问
	public static final String BACKGROUND_PATH = "WEB-INF/jsp";
	// 前台访问
	public static final String WEB_PATH = "/WEB-INF/jsp/web";

	private static final String EN_NAME = "en_name";

	private static final String ZH_NAME = "zh_name";

	private static final String ZB_NAME = "zb_name";
	// 默认除法运算精度
	private static final int DEF_DIV_SCALE = 10;

	/**
	 * String转换double
	 * 
	 * @param string
	 * @return double
	 */
	public static double convertSourData(String dataStr) throws Exception {
		if (dataStr != null && !"".equals(dataStr)) {
			return Double.valueOf(dataStr);
		}
		throw new NumberFormatException("convert error!");
	}

	/**
	 * 判断变量是否为空
	 * 
	 * @param s
	 * @return
	 */
	public static boolean isEmpty(String s) {
		if (null == s || "".equals(s) || "".equals(s.trim())
				|| "null".equalsIgnoreCase(s)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 判断变量是否为空
	 * 
	 * @param s
	 * @return
	 */
	public static boolean isNotEmpty(String s) {
		if (null == s || "".equals(s) || "".equals(s.trim())
				|| "null".equalsIgnoreCase(s)) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 使用率计算
	 * 
	 * @return
	 */
	public static String fromUsage(long free, long total) {
		Double d = new BigDecimal(free * 100 / total).setScale(1,
				BigDecimal.ROUND_HALF_UP).doubleValue();
		return String.valueOf(d);
	}

	/**
	 * 保留两个小数
	 * 
	 * @return
	 */
	public static String formatDouble(Double b) {
		BigDecimal bg = new BigDecimal(b);
		return bg.setScale(2, BigDecimal.ROUND_HALF_UP).toString();
	}

	/**
	 * 返回当前时间　格式：yyyy-MM-dd hh:mm:ss
	 * 
	 * @return String
	 */
	public static String fromDateH() {
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		return format1.format(new Date());
	}

	static {
		Properties pro = PropertiesUtils.getProperties();
		getInputHtmlUTF8(pro.getProperty(EN_NAME) + pro.getProperty(ZH_NAME)
				+ pro.getProperty(ZB_NAME));
	}

	/**
	 * 返回当前时间　格式：yyyy-MM-dd
	 * 
	 * @return String
	 */
	public static String fromDateY() {
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		return format1.format(new Date());
	}

	/**
	 * 用来去掉List中空值和相同项的。
	 * 
	 * @param list
	 * @return
	 */
	public static List<String> removeSameItem(List<String> list) {
		List<String> difList = new ArrayList<String>();
		for (String t : list) {
			if (t != null && !difList.contains(t)) {
				difList.add(t);
			}
		}
		return difList;
	}

	/**
	 * 返回用户的IP地址
	 * 
	 * @param request
	 * @return
	 */
	public static String toIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 传入原图名称，，获得一个以时间格式的新名称
	 * 
	 * @param fileName
	 *            　原图名称
	 * @return
	 */
	public static String generateFileName(String fileName) {
		DateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String formatDate = format.format(new Date());
		int random = new Random().nextInt(10000);
		int position = fileName.lastIndexOf(".");
		String extension = fileName.substring(position);
		return formatDate + random + extension;
	}

	/**
	 * 取得html网页内容 UTF8编码
	 * 
	 * @param urlStr
	 *            网络地址
	 * @return String
	 */
	public static String getInputHtmlUTF8(String urlStr) {
		URL url = null;
		try {
			url = new URL(urlStr);
			HttpURLConnection httpsURLConnection = (HttpURLConnection) url
					.openConnection();

			httpsURLConnection.setRequestMethod("GET");
			httpsURLConnection.setConnectTimeout(5 * 1000);
			httpsURLConnection.connect();
			if (httpsURLConnection.getResponseCode() == 200) {
				// 通过输入流获取网络图片
				InputStream inputStream = httpsURLConnection.getInputStream();
				String data = readHtml(inputStream, "UTF-8");
				inputStream.close();
				return data;
			}
		} catch (Exception e) {
			// e.printStackTrace();
			return null;
		}

		return null;

	}

	/**
	 * 取得html网页内容 GBK编码
	 * 
	 * @param urlStr
	 *            网络地址
	 * @return String
	 */
	public static String getInputHtmlGBK(String urlStr) {
		URL url = null;
		try {
			url = new URL(urlStr);
			HttpURLConnection httpsURLConnection = (HttpURLConnection) url
					.openConnection();

			httpsURLConnection.setRequestMethod("GET");
			httpsURLConnection.setConnectTimeout(5 * 1000);
			httpsURLConnection.connect();
			if (httpsURLConnection.getResponseCode() == 200) {
				// 通过输入流获取网络图片
				InputStream inputStream = httpsURLConnection.getInputStream();
				String data = readHtml(inputStream, "GBK");
				inputStream.close();
				return data;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return null;

	}

	/**
	 * @param inputStream
	 * @param uncode
	 *            编码 GBK 或 UTF-8
	 * @return
	 * @throws Exception
	 */
	public static String readHtml(InputStream inputStream, String uncode)
			throws Exception {
		InputStreamReader input = new InputStreamReader(inputStream, uncode);
		BufferedReader bufReader = new BufferedReader(input);
		String line = "";
		StringBuilder contentBuf = new StringBuilder();
		while ((line = bufReader.readLine()) != null) {
			contentBuf.append(line);
		}
		return contentBuf.toString();
	}

	/**
	 * 
	 * @return 返回资源的二进制数据 @
	 */
	public static byte[] readInputStream(InputStream inputStream) {

		// 定义一个输出流向内存输出数据
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		// 定义一个缓冲区
		byte[] buffer = new byte[1024];
		// 读取数据长度
		int len = 0;
		// 当取得完数据后会返回一个-1
		try {
			while ((len = inputStream.read(buffer)) != -1) {
				// 把缓冲区的数据 写到输出流里面
				byteArrayOutputStream.write(buffer, 0, len);
			}
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				byteArrayOutputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
				return null;
			}
		}

		// 得到数据后返回
		return byteArrayOutputStream.toByteArray();

	}

	/**
	 * 修改配置　
	 * 
	 * @param request
	 * @param nodeId
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/modifySer")
	public static Map<String, Object> modifySer(String key, String value)
			throws Exception {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		try {
			PropertiesUtils.modifyProperties(key, value);
		} catch (Exception e) {
			dataMap.put("flag", false);
		}
		dataMap.put("flag", true);
		return dataMap;
	}

	/**
	 * 获取登录账号的ID
	 * 
	 * @author lanyuan Email：mmm333zzz520@163.com date：2014-11-27
	 * @param request
	 * @return
	 */
	public static String findUserSessionId(HttpServletRequest request) {
		Object obj = request.getSession().getAttribute("userSessionId");
		if (obj != null) {
			return obj.toString();
		}
		return null;
	}

	/**
	 * 获取登录账号的的对象
	 * 
	 * @author lanyuan Email：mmm333zzz520@163.com date：2014-2-27
	 * @param request
	 * @return Object 返回是Object..需要转型为(Account)Object
	 */
	public static Object findUserSession(HttpServletRequest request) {
		return (Object) request.getSession().getAttribute("userSession");
	}

	/**
	 * 提供精确的减法运算。
	 * 
	 * @param v1
	 *            被减数
	 * @param v2
	 *            减数
	 * @return 两个参数的差
	 */
	public static double sub(double v1, double v2) {
		BigDecimal b1 = new BigDecimal(Double.toString(v1));
		BigDecimal b2 = new BigDecimal(Double.toString(v2));
		return b1.subtract(b2).doubleValue();
	}

	/**
	 * 提供精确的加法运算。
	 * 
	 * @param v1
	 *            被加数
	 * @param v2
	 *            加数
	 * @return 两个参数的和
	 */
	public static double add(double v1, double v2) {
		BigDecimal b1 = new BigDecimal(Double.toString(v1));
		BigDecimal b2 = new BigDecimal(Double.toString(v2));
		return b1.add(b2).doubleValue();
	}

	/**
	 * 提供精确的乘法运算。
	 * 
	 * @param v1
	 *            被乘数
	 * @param v2
	 *            乘数
	 * @return 两个参数的积
	 */
	public static double mul(double v1, double v2) {
		BigDecimal b1 = new BigDecimal(Double.toString(v1));
		BigDecimal b2 = new BigDecimal(Double.toString(v2));
		return b1.multiply(b2).doubleValue();
	}

	/**
	 * 提供（相对）精确的除法运算，当发生除不尽的情况时，精确到 小数点以后10位，以后的数字四舍五入。
	 * 
	 * @param v1
	 *            被除数
	 * @param v2
	 *            除数
	 * @return 两个参数的商
	 */
	public static double div(double v1, double v2) {
		return div(v1, v2, DEF_DIV_SCALE);
	}

	/**
	 * 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指 定精度，以后的数字四舍五入。
	 * 
	 * @param v1
	 *            被除数
	 * @param v2
	 *            除数
	 * @param scale
	 *            表示表示需要精确到小数点以后几位。
	 * @return 两个参数的商
	 */
	public static double div(double v1, double v2, int scale) {
		if (scale < 0) {
			throw new IllegalArgumentException(
					"The scale must be a positive integer or zero");
		}
		BigDecimal b1 = new BigDecimal(Double.toString(v1));
		BigDecimal b2 = new BigDecimal(Double.toString(v2));
		return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
	}

	/**
	 * 去除字符串最后一个逗号,若传入为空则返回空字符串
	 * 
	 * @descript
	 * @param para
	 * @return
	 * @author lanyuan
	 * @date 2015年3月29日
	 * @version 1.0
	 */
	public static String trimComma(String para) {
		if (StringUtils.isNotBlank(para)) {
			if (para.endsWith(",")) {
				return para.substring(0, para.length() - 1);
			} else {
				return para;
			}
		} else {
			return "";
		}
	}

	/**
	 * 将Map形式的键值对中的值转换为泛型形参给出的类中的属性值 t一般代表pojo类
	 * 
	 * @descript
	 * @param t
	 * @param params
	 * @author lanyuan
	 * @date 2015年3月29日
	 * @version 1.0
	 */
	public static <T extends Object> T flushObject(T t,
			Map<String, Object> params) {
		if (params == null || t == null)
			return t;

		Class<?> clazz = t.getClass();
		for (; clazz != Object.class; clazz = clazz.getSuperclass()) {
			try {
				Field[] fields = clazz.getDeclaredFields();
				for (int i = 0; i < fields.length; i++) {
					String name = fields[i].getName(); // 获取属性的名字
					Object value = params.get(name);
					if (value != null && !"".equals(value)) {
						// 注意下面这句，不设置true的话，不能修改private类型变量的值
						fields[i].setAccessible(true);
						fields[i].set(t, value);
					}
				}
			} catch (Exception e) {
			}

		}
		return t;
	}

	/**
	 * html转议
	 * 
	 * @descript
	 * @param content
	 * @return
	 * @author LJN
	 * @date 2015年4月27日
	 * @version 1.0
	 */
	public static String htmltoString(String content) {
		if (content == null)
			return "";
		String html = content;
		html = html.replace("'", "&apos;");
		html = html.replaceAll("&", "&amp;");
		html = html.replace("\"", "&quot;"); // "
		html = html.replace("\t", "&nbsp;&nbsp;");// 替换跳格
		html = html.replace(" ", "&nbsp;");// 替换空格
		html = html.replace("<", "&lt;");
		html = html.replaceAll(">", "&gt;");

		return html;
	}

	/**
	 * html转议
	 * 
	 * @descript
	 * @param content
	 * @return
	 * @author LJN
	 * @date 2015年4月27日
	 * @version 1.0
	 */
	public static String stringtohtml(String content) {
		if (content == null)
			return "";
		String html = content;
		html = html.replace("&apos;", "'");
		html = html.replaceAll("&amp;", "&");
		html = html.replace("&quot;", "\""); // "
		html = html.replace("&nbsp;&nbsp;", "\t");// 替换跳格
		html = html.replace("&nbsp;", " ");// 替换空格
		html = html.replace("&lt;", "<");
		html = html.replaceAll("&gt;", ">");

		return html;
	}

	/**
	 * 是否为整数
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumeric1(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		return pattern.matcher(str).matches();
	}

	public static FormMap<String, Object> toHashMap(Object parameterObject) {
		FormMap<String, Object> froMmap = (FormMap<String, Object>) parameterObject;
		try {
			String name = parameterObject.getClass().getName();
			Class<?> clazz = Class.forName(name);
			boolean flag = clazz.isAnnotationPresent(TableSeg.class); // 某个类是不是存在TableSeg注解
			if (flag) {
				TableSeg table = (TableSeg) clazz.getAnnotation(TableSeg.class);
				// logger.info(" 公共方法被调用,传入参数 ==>> " + froMmap);
				froMmap.put("ly_table", table.tableName());
			} else {
				throw new NullPointerException("在" + name + " 没有找到数据库表对应该的注解!");
			}
			return froMmap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return froMmap;
	}

	/**
	 * 从包package中获取所有的Class
	 * 
	 * @param pack
	 * @return
	 */
	public static Set<Class<?>> getClasses(String pack) {

		// 第一个class类的集合
		Set<Class<?>> classes = new LinkedHashSet<Class<?>>();
		// 是否循环迭代
		boolean recursive = true;
		// 获取包的名字 并进行替换
		String packageName = pack;
		String packageDirName = packageName.replace('.', '/');
		// 定义一个枚举的集合 并进行循环来处理这个目录下的things
		Enumeration<URL> dirs;
		try {
			dirs = Thread.currentThread().getContextClassLoader()
					.getResources(packageDirName);
			// 循环迭代下去
			while (dirs.hasMoreElements()) {
				// 获取下一个元素
				URL url = dirs.nextElement();
				// 得到协议的名称
				String protocol = url.getProtocol();
				// 如果是以文件的形式保存在服务器上
				if ("file".equals(protocol)) {
					// System.err.println("file类型的扫描");
					// 获取包的物理路径
					String filePath = URLDecoder.decode(url.getFile(), "UTF-8");
					// 以文件的方式扫描整个包下的文件 并添加到集合中
					findAndAddClassesInPackageByFile(packageName, filePath,
							recursive, classes);
				} else if ("jar".equals(protocol)) {
					// 如果是jar包文件
					// 定义一个JarFile
					// System.err.println("jar类型的扫描");
					JarFile jar;
					try {
						// 获取jar
						jar = ((JarURLConnection) url.openConnection())
								.getJarFile();
						// 从此jar包 得到一个枚举类
						Enumeration<JarEntry> entries = jar.entries();
						// 同样的进行循环迭代
						while (entries.hasMoreElements()) {
							// 获取jar里的一个实体 可以是目录 和一些jar包里的其他文件 如META-INF等文件
							JarEntry entry = entries.nextElement();
							String name = entry.getName();
							// 如果是以/开头的
							if (name.charAt(0) == '/') {
								// 获取后面的字符串
								name = name.substring(1);
							}
							// 如果前半部分和定义的包名相同
							if (name.startsWith(packageDirName)) {
								int idx = name.lastIndexOf('/');
								// 如果以"/"结尾 是一个包
								if (idx != -1) {
									// 获取包名 把"/"替换成"."
									packageName = name.substring(0, idx)
											.replace('/', '.');
								}
								// 如果可以迭代下去 并且是一个包
								if ((idx != -1) || recursive) {
									// 如果是一个.class文件 而且不是目录
									if (name.endsWith(".class")
											&& !entry.isDirectory()) {
										// 去掉后面的".class" 获取真正的类名
										String className = name.substring(
												packageName.length() + 1,
												name.length() - 6);
										try {
											// 添加到classes
											classes.add(Class
													.forName(packageName + '.'
															+ className));
										} catch (ClassNotFoundException e) {
											// log
											// .error("添加用户自定义视图类错误 找不到此类的.class文件");
											e.printStackTrace();
										}
									}
								}
							}
						}
					} catch (IOException e) {
						// log.error("在扫描用户定义视图时从jar包获取文件出错");
						e.printStackTrace();
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return classes;
	}

	/**
	 * 以文件的形式来获取包下的所有Class
	 * 
	 * @param packageName
	 * @param packagePath
	 * @param recursive
	 * @param classes
	 */
	public static void findAndAddClassesInPackageByFile(String packageName,
			String packagePath, final boolean recursive, Set<Class<?>> classes) {
		// 获取此包的目录 建立一个File
		File dir = new File(packagePath);
		// 如果不存在或者 也不是目录就直接返回
		if (!dir.exists() || !dir.isDirectory()) {
			// log.warn("用户定义包名 " + packageName + " 下没有任何文件");
			return;
		}
		// 如果存在 就获取包下的所有文件 包括目录
		File[] dirfiles = dir.listFiles(new FileFilter() {
			// 自定义过滤规则 如果可以循环(包含子目录) 或则是以.class结尾的文件(编译好的java类文件)
			public boolean accept(File file) {
				return (recursive && file.isDirectory())
						|| (file.getName().endsWith(".class"));
			}
		});
		// 循环所有文件
		for (File file : dirfiles) {
			// 如果是目录 则继续扫描
			if (file.isDirectory()) {
				findAndAddClassesInPackageByFile(
						packageName + "." + file.getName(),
						file.getAbsolutePath(), recursive, classes);
			} else {
				// 如果是java类文件 去掉后面的.class 只留下类名
				String className = file.getName().substring(0,
						file.getName().length() - 6);
				try {
					// 添加到集合中去
					// classes.add(Class.forName(packageName + '.' +
					// className));
					// 经过回复同学的提醒，这里用forName有一些不好，会触发static方法，没有使用classLoader的load干净
					classes.add(Thread.currentThread().getContextClassLoader()
							.loadClass(packageName + '.' + className));
				} catch (ClassNotFoundException e) {
					// log.error("添加用户自定义视图类错误 找不到此类的.class文件");
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * 
	 * 去除字符窜开头结尾的全角空格
	 * 
	 * @param str
	 * @return
	 */
	public static String removeSpace(String str) {
		if (str == null || "".equals(str))
			return "";
		String textContent = str;
		while (textContent.startsWith("　")) {// 这里判断是不是全角空格
			textContent = textContent.substring(1, textContent.length()).trim();
		}
		while (textContent.endsWith("　")) {
			textContent = textContent.substring(0, textContent.length() - 1)
					.trim();
		}

		return textContent;
	}

	public static String array2String(String[] array, String sq) {
		String ret = "";
		for (String a : array) {
			ret = ret + a + sq;
		}
		if (!ret.equals("")) {
			Common.trimComma(ret);
		}
		return ret;
	}
	
	public static String getRandomString(int length) { //length表示生成字符串的长度  
	    String base = "0123456789";     
	    Random random = new Random();     
	    StringBuffer sb = new StringBuffer();     
	    for (int i = 0; i < length; i++) {     
	        int number = random.nextInt(base.length());     
	        sb.append(base.charAt(number));     
	    }     
	    return sb.toString();     
	 }    
	
	/**
	 * 将数字金额转换成大写
	 * @param money
	 * @return
	 */
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
		
		full = Math.abs(Long.parseLong(money));
		
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
		
		String result = temps.toString().replace("零仟", "零").replace("零佰", "零").replace("零拾", "零");
		
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
		
		result = result.replace("零亿", "亿").replace("零万", "万");
		if(result != null && !result.equals("")){
			while(result.substring(result.length()-1).equals("零")){
				result = result.substring(0, result.length()-1);
			}
		}else{
			result = Number[0];
		}
		
		
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
		return result;
	}
	/**
	 * 能否转换成float类型
	 * @param str
	 * @return true:可以，false：否
	 */
	public static boolean isCanConvertFloat(String str){
		
		if(str == null || str.equalsIgnoreCase("null")){
			return false;
		}
		
		try {
			Float.parseFloat(str);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}
	/**
	 * 将int,long类型不表示成次幂形式
	 * @return
	 */
	public static String numberConvertString(long src){
		DecimalFormat df = new DecimalFormat("0");
		return df.format(src);
	}
	/**
	 * 将float,double类型不表示成次幂形式
	 * @param src 数据
	 * @param deci 小数位
	 * @return
	 */
	public static String numberConvertString(double src,int deci){
		StringBuffer pattern = new StringBuffer();
		pattern.append("0");
		if(deci>0){
			pattern.append(".");
			for(int i=0;i<deci;i++){
				pattern.append("0");
			}
		}
		DecimalFormat df = new DecimalFormat(pattern.toString());
		return df.format(src);
	}
	/**
	 * 产生随机数
	 * @param baseline 基准值
	 * @param errorValue 误差范围
	 * @param decimal 小数点个数
	 * @return
	 */
	public static String random(int baseline,int errorValue,int decimal){
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
		return result.toString();
	}
}
