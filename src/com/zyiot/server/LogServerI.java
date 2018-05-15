package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.LogFormMap;

public interface LogServerI {

	public int addLog(LogFormMap logFormMap) throws Exception;

	public List<LogFormMap> findByPage(LogFormMap logFormMap, int pageSize,
			int pageNum);

}
