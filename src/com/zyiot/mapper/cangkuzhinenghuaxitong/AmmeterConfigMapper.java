package com.zyiot.mapper.cangkuzhinenghuaxitong;

import java.util.List;

import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterConfigFormMap;
import com.zyiot.mapper.BaseMapper;

public interface AmmeterConfigMapper extends BaseMapper {
	List<AmmeterConfigFormMap> findAmmeterConfigByPage(
			AmmeterConfigFormMap FormMap);

	List<AmmeterConfigFormMap> findCangKuDianWei(AmmeterConfigFormMap FormMap);
}