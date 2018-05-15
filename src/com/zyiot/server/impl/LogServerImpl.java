package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.entity.LogFormMap;
import com.zyiot.mapper.LogMapper;
import com.zyiot.server.LogServerI;

@Service("logServer")
public class LogServerImpl implements LogServerI {
	@Autowired
	LogMapper logMapper;

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public int addLog(LogFormMap logFormMap) throws Exception {
		return logMapper.addEntity(logFormMap);
	}

	@Override
	public List<LogFormMap> findByPage(LogFormMap logFormMap, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return logMapper.findByPage(logFormMap);
	}

}
