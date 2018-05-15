package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.TemperatureAlarmFormMap;

public interface TemperatureAlarmMapper extends BaseMapper {
	public List<TemperatureAlarmFormMap> findByPage(TemperatureAlarmFormMap temperatureAlarmFormMap);
	
	public TemperatureAlarmFormMap findTemperatureAlarmById(int id);
}
