package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.Module;
import com.zyiot.entity.YingPanLuXiangJiFormMap;
import com.zyiot.mapper.YingPanLuXiangJiMapper;
import com.zyiot.server.YingPanLuXiangJiServerI;

@Module(module = "硬盘录像机管理")
@Service("yingPanLuXiangJiServer")
public class YingPanLuXiangJiServerImpl extends
		BaseServerImpl<YingPanLuXiangJiFormMap, YingPanLuXiangJiMapper>
		implements YingPanLuXiangJiServerI {
	@Autowired
	YingPanLuXiangJiMapper yingPanLuXiangJiMapper;

	@Override
	public List<YingPanLuXiangJiFormMap> findByPage(
			YingPanLuXiangJiFormMap yingPanLuXIangjiFormMap, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);

		return yingPanLuXiangJiMapper.findByPage(yingPanLuXIangjiFormMap);
	}

	@Override
	public List<YingPanLuXiangJiFormMap> findByAttr(
			YingPanLuXiangJiFormMap yingPanLuXIangjiFormMap) {
		return yingPanLuXiangJiMapper.findByAttr(yingPanLuXIangjiFormMap);
	}
}
