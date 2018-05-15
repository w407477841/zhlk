package com.zyiot.util;

import java.lang.annotation.Annotation;
import java.util.ArrayList;
import java.util.List;

import com.zyiot.annotation.TableSeg;

/**
 * 
 * 用于操作formMap
 *
 */
public class FormMapUtil {
/**
 * 将数据转换成用于add的形式
 * @param formMap
 * @return
 * @throws Exception
 */
	public static FormMap<String ,Object> toADDFormMap(FormMap<String,Object> formMap) throws Exception{
		Class clazz=formMap.getClass();
		
		boolean flag = clazz.isAnnotationPresent(TableSeg.class);
		if(flag){
			TableSeg a= (TableSeg) clazz.getAnnotation(TableSeg.class);
			formMap.put(Constant.ENTITY_TABLE,a.tableName());
		}
		else throw new Exception("["+clazz.getName()+"]未设置注解@TableSeg");
		return formMap;
	}
	/**
	 * 将数据转换成用于update的形式
	 * @param formMap
	 * @return
	 * @throws Exception
	 */
	public static FormMap<String ,Object> toUPDATEFormMap(FormMap<String,Object> formMap) throws Exception{
		Class clazz=formMap.getClass();
		
		boolean flag = clazz.isAnnotationPresent(TableSeg.class);
		if(flag){
			TableSeg a= (TableSeg) clazz.getAnnotation(TableSeg.class);
			formMap.put(Constant.ENTITY_TABLE,a.tableName());
			formMap.put(Constant.PRIMARY_KEY,a.id() );
			formMap.put(Constant.UPDATE_VERSION,a.version() );
		}
		else throw new Exception("["+clazz.getName()+"]未设置注解@TableSeg");
		return formMap;
	}
	
	/**
	 * 将数据转换成用于delete的形式
	 * @param formMap
	 * @return
	 * @throws Exception
	 */
		public static FormMap<String ,Object> toDELETEFormMap(FormMap<String,Object> formMap) throws Exception{
			return toADDFormMap(formMap);
		}
		
		/**
		 * 获取数据表名
		 * @param formMap
		 * @return
		 * @throws Exception
		 */
		public static String getTableName(FormMap<String,Object> formMap) throws Exception{
	        Class clazz=formMap.getClass();
		
			boolean flag = clazz.isAnnotationPresent(TableSeg.class);
			if(flag){
				TableSeg a= (TableSeg) clazz.getAnnotation(TableSeg.class);
				return a.tableName();
			}
			else{
				throw new Exception("["+clazz.getName()+"]未设置注解@TableSeg");
			}
		}
		
	
	public static  <T> List<T> changeFormMapKey(String oldKey,String newKey,List<T> mps){
		List<T> ret=new ArrayList<T>();
		for(FormMap<String,Object> formMap:(List<FormMap<String,Object>>)mps){
		
		formMap.put(newKey,formMap.get(oldKey));
		formMap.remove(oldKey);
		ret.add((T) formMap);
		}
		return ret;
	};
	
	
}
