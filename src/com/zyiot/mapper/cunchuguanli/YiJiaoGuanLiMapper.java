package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.YiJiaoGuanLiFormMap;
import com.zyiot.mapper.BaseMapper;

public interface YiJiaoGuanLiMapper extends BaseMapper {
	public List<YiJiaoGuanLiFormMap> findByPage(YiJiaoGuanLiFormMap yiJiaoGuanLiFormMap);
	
	public YiJiaoGuanLiFormMap findYiJiaoGuanLiById(int id);
}
