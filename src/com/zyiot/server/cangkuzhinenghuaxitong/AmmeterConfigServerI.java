package com.zyiot.server.cangkuzhinenghuaxitong;

import java.util.List;

import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterConfigFormMap;

public interface AmmeterConfigServerI {
	public List<AmmeterConfigFormMap> findAmmeterConfigByPage(
			AmmeterConfigFormMap u, int pageSize, int pageNum);

	public void add(AmmeterConfigFormMap u) throws Exception;

	public void edit(AmmeterConfigFormMap u) throws Exception;

	public void delete(String id) throws Exception;

	public List<AmmeterConfigFormMap> findCangKuDianWei(AmmeterConfigFormMap u);
}
