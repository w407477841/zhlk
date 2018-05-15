package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.TemperatureAlarmFormMap;

public interface TemperatureAlarmServerI {
	public void addTemperatureAlarm(TemperatureAlarmFormMap temperatureAlarmFormMap) throws Exception;
	
	public TemperatureAlarmFormMap findTemperatureAlarmById(String id);
	
	public List<TemperatureAlarmFormMap> findByPage(TemperatureAlarmFormMap temperatureAlarmFormMap,int pageSize,int pageNum);
}
