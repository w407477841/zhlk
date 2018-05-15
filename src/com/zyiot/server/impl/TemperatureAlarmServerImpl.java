package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.entity.TemperatureAlarmFormMap;
import com.zyiot.mapper.TemperatureAlarmMapper;
import com.zyiot.server.TemperatureAlarmServerI;
@Service("temperatureAlarmServer")
public class TemperatureAlarmServerImpl implements TemperatureAlarmServerI {
	@Autowired
	private TemperatureAlarmMapper temperatureAlarmMapper;
	@Override
	public void addTemperatureAlarm(
			TemperatureAlarmFormMap temperatureAlarmFormMap) throws Exception {
		temperatureAlarmMapper.addEntity(temperatureAlarmFormMap);
	}

	@Override
	public TemperatureAlarmFormMap findTemperatureAlarmById(String id) {
		return temperatureAlarmMapper.findTemperatureAlarmById(Integer.parseInt(id));
	}

	@Override
	public List<TemperatureAlarmFormMap> findByPage(
			TemperatureAlarmFormMap temperatureAlarmFormMap, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return temperatureAlarmMapper.findByPage(temperatureAlarmFormMap);
	}

}
