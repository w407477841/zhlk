package com.zyiot.mapper.dataDocking;

import com.zyiot.entity.dataDocking.ContrastLocationFormMap;
import com.zyiot.mapper.BaseMapper;

public interface ContrastLocationMapper extends BaseMapper {
	/**
	 * 根据粮库地点no获取数据
	 * @param wlno 粮库地点no
	 * @return
	 */
	public ContrastLocationFormMap findContrastLocationByWLNO(String wlno);
	
}
