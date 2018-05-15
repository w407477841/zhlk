package com.zyiot.server.impl.cangkuzhinenghuaxitong;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterConfigFormMap;
import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterDataFormMap;
import com.zyiot.mapper.cangkuzhinenghuaxitong.AmmeterDataMapper;
import com.zyiot.server.cangkuzhinenghuaxitong.AmmeterDataServerI;
import com.zyiot.util.BatchInsertParameter;

@Service("ammeterDataServer")
public class AmmeterDataServerImpl implements AmmeterDataServerI {
	@Autowired
	AmmeterDataMapper ammeterDataMapper;

	public List<AmmeterDataFormMap> findAmmeterDataByPage(AmmeterDataFormMap u,
			int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return ammeterDataMapper.findAmmeterDataByPage(u);
	}

	@SystemLog(module = "智能电表数据", methods = "新增", description = "成功")
	public void add(AmmeterDataFormMap u) throws Exception {
		ammeterDataMapper.addEntity(u);
	}

	@SystemLog(module = "智能电表数据", methods = "修改", description = "成功")
	public void edit(AmmeterDataFormMap u) throws Exception {
		ammeterDataMapper.updateEntity(u);
	}

	@SystemLog(module = "智能电表数据", methods = "删除", description = "成功")
	public void delete(String id) throws Exception {
		ammeterDataMapper.deleteEntityByKey(id, id, AmmeterDataFormMap.class);
	}

	@Override
	public List<AmmeterConfigFormMap> findAmmeters() {
		return ammeterDataMapper.findAmmeters();
	}

	@SystemLog(module = "智能电表数据", methods = "批量新增", description = "成功")
	@Transactional(readOnly = false)
	public void batchSave(List<AmmeterDataFormMap> list) throws Exception {
		ammeterDataMapper.batchSave(BatchInsertParameter.wrap(list));
	}

	@Override
	public AmmeterDataFormMap findEnergy(AmmeterDataFormMap u, int type) {
		List<AmmeterDataFormMap> list = null;
		if (type == 0) {
			list = ammeterDataMapper.findEnergy(u);
		} else if (type == 1) {
			list = ammeterDataMapper.findEnergyMon(u);
		} else if (type == 2) {
			list = ammeterDataMapper.findEnergyQua(u);
		}
		if (list == null || list.size() == 0)
			return null;

		int size = list.size();
		// 迭代出所有仓库，所有时间段
		List<String> name = new ArrayList<String>();// 存放所有仓库名称
		List<String> xAxis = new ArrayList<String>();// 存放所有时间，x轴数据
		List<AmmeterDataFormMap> series = new ArrayList<>();// 存放所有数据
		HashMap<String, HashMap<String, String>> name_data = new HashMap<>();
		for (int i = 0; i < size; i++) {
			HashMap<String, String> time_data;
			AmmeterDataFormMap data = list.get(i);
			String ckName = data.getStr("wName");
			String time = data.getStr("time");

			if (name.indexOf(ckName) == -1) {// 不存在
				name.add(ckName);
				time_data = new HashMap<>();

				// name_data.put(ckName, time_data);
			} else {
				time_data = name_data.get(ckName);
			}
			if (xAxis.indexOf(time) == -1) {// 不存在
				xAxis.add(time);

			}
			time_data.put(time, data.get("energy").toString());
			name_data.put(ckName, time_data);

		}
		Collections.sort(xAxis);
		int nSize = name.size();
		int aSize = xAxis.size();
		// 封装数据
		for (int i = 0; i < nSize; i++) {
			AmmeterDataFormMap serie = new AmmeterDataFormMap();
			serie.put("name", name.get(i));
			serie.put("type", "line");
			HashMap<String, String> time_data = name_data.get(name.get(i));
			List<String> ldata = new ArrayList<>();
			for (int j = 0; j < aSize; j++) {
				String nd = time_data.get(xAxis.get(j));
				if (nd == null) {
					ldata.add("0.0");
				} else {
					ldata.add(nd);
				}

			}
			serie.put("data", ldata);
			series.add(serie);
		}

		AmmeterDataFormMap retMap = new AmmeterDataFormMap();
		retMap.put("xAxis", xAxis);
		retMap.put("name", name);
		retMap.put("series", series);
		return retMap;
	}

	@Override
	public AmmeterDataFormMap sumEnergy(AmmeterDataFormMap u) {
		return ammeterDataMapper.sumEnergy(u);
	}

	/**
	 * 0 日期 1 月份 02季度 按日期/月份 /季度 数据展示 能耗/读数
	 */
	public List<AmmeterDataFormMap> findEnergyList(AmmeterDataFormMap u,
			int type) {

		List<AmmeterDataFormMap> list = null;
		if (type == 0) {

			list = ammeterDataMapper.findEnergyDayList(u);
		} else if (type == 1) {
			list = ammeterDataMapper.findEnergyMonList(u);
		} else if (type == 2) {
			list = ammeterDataMapper.findEnergyQuaList(u);
		}
		List<AmmeterDataFormMap> retList = new ArrayList<>();

		int size = 0;
		if (list != null && (size = list.size()) > 0) {

			for (int i = 0; i < size; i++) {
				AmmeterDataFormMap data = list.get(i);

				// String ckName = data.getStr("wName"); // 仓库名称
				String energys[] = data.getStr("energys").split(",");// 能耗
				String reading[] = data.getStr("readings").split(",");// 读数
				// String time = data.getStr("time");// 时间
				// String sum = data.get("energysum").toString();
				for (int j = 0, _size = energys.length; j < _size; j++) {
					data.put("energy" + j, energys[j]);

					data.put("reading" + j, reading[j]);
				}

				data.remove("energys");
				data.remove("readings");
				retList.add(data);
			}

		}

		return retList;
	}

	@Override
	public List<AmmeterDataFormMap> findCurrentReading(AmmeterDataFormMap u) {
		List<AmmeterDataFormMap> list = ammeterDataMapper.findCurrentReading(u);
		List<AmmeterDataFormMap> retList = new ArrayList<>();

		int size = 0;
		if (list != null && (size = list.size()) > 0) {

			for (int i = 0; i < size; i++) {
				AmmeterDataFormMap data = list.get(i);
				String reading[] = data.getStr("readings").split(",");// 读数
				for (int j = 0, _size = reading.length; j < _size; j++) {

					data.put("reading" + j, reading[j]);
				}
				data.remove("readings");
				retList.add(data);
			}

		}

		return retList;
	}
}
