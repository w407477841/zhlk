package com.zyiot.server.cangkuzhinenghuaxitong;

import java.util.List;

import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterConfigFormMap;
import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterDataFormMap;

public interface AmmeterDataServerI {
	public List<AmmeterDataFormMap> findAmmeterDataByPage(AmmeterDataFormMap u,
			int pageSize, int pageNum);

	public void add(AmmeterDataFormMap u) throws Exception;

	public void batchSave(List<AmmeterDataFormMap> list) throws Exception;

	public void edit(AmmeterDataFormMap u) throws Exception;

	public AmmeterDataFormMap findEnergy(AmmeterDataFormMap u, int type);

	public List<AmmeterDataFormMap> findCurrentReading(AmmeterDataFormMap u);

	public List<AmmeterDataFormMap> findEnergyList(AmmeterDataFormMap u,
			int type);

	public AmmeterDataFormMap sumEnergy(AmmeterDataFormMap u);

	public void delete(String id) throws Exception;

	public List<AmmeterConfigFormMap> findAmmeters();
}
