package com.zyiot.server;

import java.util.List;
import java.util.Map;

import com.zyiot.entity.ChuanGanQiFormMap;

public interface ChuanGanQiServerI {
	public int addSensor(ChuanGanQiFormMap map);
	public int updateSensor(ChuanGanQiFormMap map);
	public List<ChuanGanQiFormMap> querySensorList(int page,int rows);
	public ChuanGanQiFormMap querySensorByID(Map<String,String>map);
	public List<ChuanGanQiFormMap> queryHouse(Map<String,String>map);
	public void deleteOne(String id) throws Exception;
}
