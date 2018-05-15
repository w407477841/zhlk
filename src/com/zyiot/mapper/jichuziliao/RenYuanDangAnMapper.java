package com.zyiot.mapper.jichuziliao;

import java.util.List;

import com.zyiot.entity.jichuziliao.RenYuanDangAnFormMap;
import com.zyiot.mapper.BaseMapper;

public interface RenYuanDangAnMapper extends BaseMapper {
	List<RenYuanDangAnFormMap> findByPage(RenYuanDangAnFormMap renYuanDangAnFormMap);
	RenYuanDangAnFormMap findRenYuanDangAnById(int id);
}
