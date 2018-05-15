package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.ChuKuShenQingFormMap;
import com.zyiot.mapper.BaseMapper;

public interface ChuKuShenQingMapper extends BaseMapper {
	public List<ChuKuShenQingFormMap> findByPage(ChuKuShenQingFormMap chuKuShenQingFormMap);
	
	public List<ChuKuShenQingFormMap> findShenPiByPage(ChuKuShenQingFormMap chuKuShenQingFormMap);
	
	public ChuKuShenQingFormMap findChuKuShenQingById(int id);
	
	public ChuKuShenQingFormMap lookChuKuShenQingById(int id);
}
