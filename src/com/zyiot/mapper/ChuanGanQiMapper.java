package com.zyiot.mapper;

import java.util.List;
import java.util.Map;

import com.zyiot.entity.ChuanGanQiFormMap;

public interface ChuanGanQiMapper extends BaseMapper{
	public int addSensor(ChuanGanQiFormMap map);
	public int updateSensor(ChuanGanQiFormMap map);
	public List<ChuanGanQiFormMap> querySensorList();
	public ChuanGanQiFormMap querySensorList(Map<String,String>map);
	public List<ChuanGanQiFormMap> queryHouse(Map<String,String>map);
}
