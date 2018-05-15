package com.zyiot.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.zyiot.annotation.TableSeg;
import com.zyiot.mapper.BaseMapper;

public class ConfigUtils {
	private final Logger logger = Logger.getLogger(ConfigUtils.class);
	/**
	 * 初始化数据库表字段到缓存
	 */
	public void initTableField(BaseMapper baseMapper) throws Exception {
		StackTraceElement[] s = new Exception().getStackTrace();
		System.out.println(s[1].getClassName() + s[1].getMethodName());
		
		// 记录总记录数
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> mapVal = null;
		try {
			Properties pro = PropertiesUtils.getjdbcProperties();
			Class.forName(pro.getProperty("jdbc.driverClass")); // 1、使用CLASS
		//	Class.forName("com.mysql.jdbc.Driver");
			
			String url = pro.getProperty("jdbc.url");
			//String url="jdbc:mysql://192.168.0.166:3306/wzglxt?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true"; 
			String db = url.substring(url.lastIndexOf("/")+1);
			if(db.indexOf("?")>-1){
				db=db.substring(0, db.indexOf("?"));
			}
			String packageName = PropertiesUtils.findPropertiesKey("entityPackageName");
			// List<String> classNames = getClassName(packageName);
			List<String> classNames = ClassUtil.getClassName(packageName, true);//true包含子目录
			//List<String> classNames = ClassUtil.getClassName("com.zyiot.entity", true);//true包含子目录
			String tabs = "";
			if (classNames != null) {
				for (String className : classNames) {
					System.out.println(className);
					Class<?> clazz = Class.forName(className);
					boolean flag = clazz.isAnnotationPresent(TableSeg.class); // 某个类是不是存在TableSeg注解
					if (flag) {
						TableSeg table = (TableSeg) clazz.getAnnotation(TableSeg.class);
						tabs+="'"+table.tableName()+"',";
						mapVal=new HashMap<String, Object>();
						mapVal.put("id", table.id());
						mapVal.put("version",table.version());
						
						map.put(table.tableName(), mapVal);
					} 
				}
			}
			tabs=Common.trimComma(tabs);
			//tabs="'t_log','t_resources','t_user'";
			//尽量减少对数据库/IO流操作一次查询出所有表的的字段
			HashMap<String, Object> tm = new HashMap<String, Object>();
			tm.put("table_name", tabs);
			tm.put("database_name","'"+db+"'");
			logger.debug(tabs+"  "+db);
			 List<HashMap<String, Object>> lh = baseMapper.initTableField(tm);
			 for (HashMap<String, Object> hashMap : lh) {
				 Map<String, Object> m = new HashMap<String, Object>();
					m.put("field", hashMap.get("COLUMN_NAME"));
					logger.debug("field="+hashMap.get("COLUMN_NAME"));
					String ble =hashMap.get("TABLE_NAME").toString();//表名
					mapVal=(Map<String, Object>) map.get(ble);
					m.put("column_key",mapVal.get("id"));//获取表的主键
					m.put("column_version",mapVal.get("version"));//获取表的版本字段
					EhcacheUtils.put(ble, m);//某表对应的主键和字段放到缓存
			}
		} catch (ClassNotFoundException e) {
			logger.error(" 初始化数据失败，没法加载表字段到缓存 -->> "+e.fillInStackTrace());
			e.printStackTrace();
		} catch (Exception e){
			logger.error(" 初始化数据失败，没法加载表字段到缓存 -->> "+e.fillInStackTrace());
			e.printStackTrace();
		}
	}

	
	
}
