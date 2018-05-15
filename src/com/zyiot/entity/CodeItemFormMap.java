package com.zyiot.entity;

import com.zyiot.annotation.BatchSaveColumns;
import com.zyiot.annotation.TableSeg;
import com.zyiot.util.FormMap;
@TableSeg(id="value",tableName="t_codeitem")
@BatchSaveColumns(columns={"id","parentId","text","codeid"})
public class CodeItemFormMap extends FormMap<String,Object> {
	private static final long serialVersionUID = 1L;
}
