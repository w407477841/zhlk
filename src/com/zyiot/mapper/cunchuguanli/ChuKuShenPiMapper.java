package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.ChuKuShenPiFormMap;
import com.zyiot.mapper.BaseMapper;

public interface ChuKuShenPiMapper extends BaseMapper {
	public List<ChuKuShenPiFormMap> findByPage(ChuKuShenPiFormMap chuKuShenPiFormMap);
	
}
