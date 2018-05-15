package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.WindowConfigFormMap;
import com.zyiot.mapper.WindowConfigMapper;
import com.zyiot.server.WindowConfigServerI;

@Service("windowConfigServer")
public class WindowConfigServerImpl implements WindowConfigServerI {
	@Autowired
	WindowConfigMapper windowConfigMapper;

	public List<WindowConfigFormMap> findWindowConfigByPage(
			WindowConfigFormMap u, int pageSize, int pageNum) {
		if (pageSize < 0 && pageNum < 0)
			return windowConfigMapper.findWindowConfigByPage(u);
		PageHelper.startPage(pageNum, pageSize);
		return windowConfigMapper.findWindowConfigByPage(u);
	}

	@SystemLog(module = "智能窗户", methods = "新增", description = "成功")
	@Transactional(readOnly = false)
	public void add(WindowConfigFormMap u) throws Exception {
		windowConfigMapper.addEntity(u);
	}

	@SystemLog(module = "智能窗户", methods = "修改", description = "成功")
	@Transactional(readOnly = false)
	public void edit(WindowConfigFormMap u) throws Exception {
		windowConfigMapper.updateEntity(u);
	}

	@SystemLog(module = "智能窗户", methods = "删除", description = "成功")
	@Transactional(readOnly = false)
	public void delete(String id) throws Exception {
		windowConfigMapper.deleteEntityByKey("id", id,
				WindowConfigFormMap.class);
	}

	@Override
	public List<WindowConfigFormMap> findCangKuDianWei(
			WindowConfigFormMap windowConfigFormMap) {
		return windowConfigMapper.findCangKuDianWei(windowConfigFormMap);
	}

	@Override
	public List<WindowConfigFormMap> findShipin(
			WindowConfigFormMap windowConfigFormMap) {
		return windowConfigMapper.findShipin(windowConfigFormMap);
	}

}