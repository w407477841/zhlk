package com.zyiot.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zyiot.annotation.TableSeg;

public class BatchInsertParameter<T> {
	private static final int DEFAULT_BATCH_SIZE = 100;
    private final T t;
	private final List<T> data;
	private final int batchSize;
	private final String tableName;
	private final String fields;
	private final String values;
	private final HashMap<String,Integer> paramSort;


	public String getTableName() {
		return tableName;
	}

	private BatchInsertParameter(List<T> data, int batchSize) {
		this.data = data;
		this.batchSize = batchSize;
		this.t=(T)data.get(0);
		this.tableName=t.getClass().getAnnotation(TableSeg.class).tableName();
		FormMap<String,Object> formMap=(FormMap<String, Object>) t;
		HashMap<String,Integer> paramSortTemp=new HashMap<String, Integer>();
		String fs=" (";
		String vs=" (";
		int i=0;
		for(Map.Entry<String,Object> m:formMap.entrySet()){
			i+=1;
			fs+=m.getKey()+",";
			vs+="?,";
			paramSortTemp.put(m.getKey(), i);
		}
		fs=fs.substring(0,fs.length()-1);
		vs=vs.substring(0,vs.length()-1);
		
		fs+=") ";
		vs+=") ";
		this.fields=fs;
		this.values=vs;
		this.paramSort=paramSortTemp;
	}

	public HashMap<String, Integer> getParamSort() {
		return paramSort;
	}

	public String getValues() {
		return values;
	}

	public String getFields() {
		return fields;
	}

	public List<T> getData() {
		return data;
	}

	public int getBatchSize() {
		return batchSize;
	}

	public static <T> BatchInsertParameter<T> wrap(List<T> data) {
		return wrap(data, DEFAULT_BATCH_SIZE);
	}

	/**
	 * 
	 * @param data
	 *            不能是空
	 * @param batchSize
	 *            不能小于 10
	 * @return
	 */
	public static <T> BatchInsertParameter<T> wrap(List<T> data, int batchSize) {
		if (data == null || data.isEmpty()) {
			throw new IllegalArgumentException("data must not be empty");
		}

		if (batchSize < 10) {
			throw new IllegalArgumentException("batchSize < 10");
		}

		return new BatchInsertParameter<T>(data, batchSize);
}

	
}
