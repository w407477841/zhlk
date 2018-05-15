package com.zyiot.server.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.ChuanGanQiFormMap;
import com.zyiot.mapper.ChuanGanQiMapper;
import com.zyiot.server.ChuanGanQiServerI;

@Service("sensorServer")
public class ChuanGanQiServerImpl implements ChuanGanQiServerI {
	@Autowired
	private ChuanGanQiMapper sensorMapper;

	@Transactional(readOnly = false)
	@SystemLog(module = "系统基础管理/传感器管理", methods = "添加", description = "成功")
	public int addSensor(ChuanGanQiFormMap map) {
		return sensorMapper.addSensor(map);
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "系统基础管理/传感器管理", methods = "修改", description = "成功")
	public int updateSensor(ChuanGanQiFormMap map) {
		return sensorMapper.updateSensor(map);
	}

	@Override
	public List<ChuanGanQiFormMap> querySensorList(int page, int row) {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(row, page));
		}
		return sensorMapper.querySensorList();
	}

	@Override
	public ChuanGanQiFormMap querySensorByID(Map<String, String> map) {
		return sensorMapper.querySensorList(map);
	}

	@Override
	public List<ChuanGanQiFormMap> queryHouse(Map<String, String> map) {
		return sensorMapper.queryHouse(map);
	}

	@Override
	@Transactional(readOnly = false)
	@SystemLog(module = "系统管理/传感器", methods = "删除", description = "成功")
	public void deleteOne(String id) throws Exception {
		sensorMapper.deleteEntityByKey("id", id, ChuanGanQiFormMap.class);
	}

}
