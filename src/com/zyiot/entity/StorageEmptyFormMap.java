package com.zyiot.entity;

import com.zyiot.annotation.TableSeg;
import com.zyiot.util.FormMap;
/**
 * 仓库被清空时，进行清空数据记载
 * @author Admin
 * @date 2017年7月27日 下午2:01:52
 */
@TableSeg(tableName="t_storage_empty_info",id="id")
public class StorageEmptyFormMap extends FormMap<String,Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

}
