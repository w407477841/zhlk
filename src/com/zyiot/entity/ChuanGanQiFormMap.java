package com.zyiot.entity;

import java.io.Serializable;

import com.zyiot.annotation.TableSeg;
import com.zyiot.util.FormMap;

@TableSeg(id = "id", tableName = "t_chuanganqi")
public class ChuanGanQiFormMap extends FormMap<String, Object> implements
		Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

}
