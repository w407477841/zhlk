package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.RuKuFangAnFormMap;
import com.zyiot.mapper.BaseMapper;

public interface RuKuFangAnMapper extends BaseMapper {
	public List<RuKuFangAnFormMap> findByPage(RuKuFangAnFormMap ruKuFangAnFormMap);
	
	public RuKuFangAnFormMap findRuKuFangAnById(int id);
	
	public RuKuFangAnFormMap lookRuKuFangAnById(int id);
}
