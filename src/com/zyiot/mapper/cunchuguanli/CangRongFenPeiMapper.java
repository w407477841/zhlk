package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.CangRongFenPeiFormMap;
import com.zyiot.mapper.BaseMapper;

public interface CangRongFenPeiMapper extends BaseMapper {
	
	public List<CangRongFenPeiFormMap> findByPage(CangRongFenPeiFormMap cangRongFenPeiFormMap);
	
	public CangRongFenPeiFormMap findCangRongFenPeiById(int id);
}
