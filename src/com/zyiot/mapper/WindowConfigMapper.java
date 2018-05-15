package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.WindowConfigFormMap;

public interface WindowConfigMapper extends BaseMapper {
	List<WindowConfigFormMap> findWindowConfigByPage(
			WindowConfigFormMap windowConfigFormMap);

	List<WindowConfigFormMap> findCangKuDianWei(
			WindowConfigFormMap windowConfigFormMap);

	List<WindowConfigFormMap> findShipin(WindowConfigFormMap windowConfigFormMap);
}
