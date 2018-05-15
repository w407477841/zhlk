package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.YingPanLuXiangJiFormMap;
import com.zyiot.mapper.YingPanLuXiangJiMapper;

public interface YingPanLuXiangJiServerI extends
		BaseServerI<YingPanLuXiangJiFormMap, YingPanLuXiangJiMapper> {

	public List<YingPanLuXiangJiFormMap> findByPage(
			YingPanLuXiangJiFormMap yingPanLuXIangjiFormMap, int pageSize,
			int pageNum);

	public List<YingPanLuXiangJiFormMap> findByAttr(
			YingPanLuXiangJiFormMap yingPanLuXIangjiFormMap);
}
