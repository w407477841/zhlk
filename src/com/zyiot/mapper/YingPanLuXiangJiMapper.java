package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.YingPanLuXiangJiFormMap;

public interface YingPanLuXiangJiMapper extends BaseMapper {
	public List<YingPanLuXiangJiFormMap> findByPage(
			YingPanLuXiangJiFormMap yingPanLuXIangjiFormMap);
}
