package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.LogFormMap;

public interface LogMapper extends BaseMapper {
	List<LogFormMap> findByPage(LogFormMap logFormMap);
}
