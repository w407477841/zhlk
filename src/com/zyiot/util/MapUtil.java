package com.zyiot.util;

import java.util.Map;
/**
 * 
 * @author Administrator
 *
 */
public class MapUtil {
	/**
	 * 
	 * @param map 需要打印输出的map
	 */
	public static void sysoMapKeyAndVal(FormMap<String,Object> map ){
		
		for(Map.Entry<String, Object> m:map.entrySet()){
			System.out.println(m.getKey()+"  "+m.getValue());
		}
		
	}
	/**
	 * 
	 * @param oldMap
	 * @param oldColumn 原map需要转换的字段。
	 * @param newMap 
	 * @return newColumn 新map转换后的字段名
	 */
	public static FormMap<String,Object> map2Map(FormMap<String,Object> oldMap,
					String oldColumn[],FormMap<String,Object> newMap,String newColumn[]){
		
		if(oldColumn==null||oldColumn.length==0) return oldMap;
		int i=0;
		for(String colunm:oldColumn){
			String newColumnName=newColumn[i];
			if("".equals(newColumnName)||newColumnName!=null){
				newMap.put(newColumnName,oldMap.get(colunm) );
			}
			else{
				newMap.put(colunm,oldMap.get(colunm) );
			}
			
			
		i++;
		}
		
		return newMap;
	}
	
	
}
