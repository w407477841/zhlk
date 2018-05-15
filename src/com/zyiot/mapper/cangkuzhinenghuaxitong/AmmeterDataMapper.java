package com.zyiot.mapper.cangkuzhinenghuaxitong;

import java.util.List;

import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterConfigFormMap;
import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterDataFormMap;
import com.zyiot.mapper.BaseMapper;

public interface AmmeterDataMapper extends BaseMapper {
	List<AmmeterDataFormMap> findAmmeterDataByPage(AmmeterDataFormMap FormMap);

	List<AmmeterConfigFormMap> findAmmeters();

	List<AmmeterDataFormMap> findCurrentReading(AmmeterDataFormMap FormMap);

	List<AmmeterDataFormMap> findEnergy(AmmeterDataFormMap FormMap);

	List<AmmeterDataFormMap> findEnergyMon(AmmeterDataFormMap FormMap);

	List<AmmeterDataFormMap> findEnergyQua(AmmeterDataFormMap FormMap);

	public List<AmmeterDataFormMap> findEnergyDayList(AmmeterDataFormMap u);

	public List<AmmeterDataFormMap> findEnergyMonList(AmmeterDataFormMap u);

	public List<AmmeterDataFormMap> findEnergyQuaList(AmmeterDataFormMap u);

	public AmmeterDataFormMap sumEnergy(AmmeterDataFormMap u);
}