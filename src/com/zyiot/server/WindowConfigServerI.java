package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.WindowConfigFormMap;

public interface WindowConfigServerI {
	public List<WindowConfigFormMap> findWindowConfigByPage(
			WindowConfigFormMap u, int pageSize, int pageNum);

	List<WindowConfigFormMap> findCangKuDianWei(
			WindowConfigFormMap windowConfigFormMap);

	List<WindowConfigFormMap> findShipin(WindowConfigFormMap windowConfigFormMap);

	public void add(WindowConfigFormMap u) throws Exception;

	public void edit(WindowConfigFormMap u) throws Exception;

	public void delete(String id) throws Exception;
}
