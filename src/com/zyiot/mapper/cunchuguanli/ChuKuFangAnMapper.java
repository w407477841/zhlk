package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.ChuKuFangAnFormMap;
import com.zyiot.mapper.BaseMapper;

public interface ChuKuFangAnMapper extends BaseMapper {
	
	public List<ChuKuFangAnFormMap> findByPage(ChuKuFangAnFormMap chuKuFangAnFormMap);
	
	public ChuKuFangAnFormMap findChuKuFangAnById(int id);
	
	public ChuKuFangAnFormMap lookChuKuFangAnById(int id);
	
	
}
