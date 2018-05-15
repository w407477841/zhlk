package com.zyiot.entity;

import java.util.HashMap;
import com.zyiot.annotation.BatchSaveColumns;
import com.zyiot.annotation.TableSeg;
import com.zyiot.util.FormMap;
@TableSeg(tableName="t_user",id="id",version="version")
@BatchSaveColumns(columns={"userName","password","id"})
public class UserFormMap extends FormMap<String, Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

}
