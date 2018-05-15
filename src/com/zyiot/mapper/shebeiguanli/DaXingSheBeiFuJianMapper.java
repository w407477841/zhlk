package com.zyiot.mapper.shebeiguanli;

import java.util.List;

import com.zyiot.entity.shebeiguanli.DaXingSheBeiFuJianFormMap;
import com.zyiot.mapper.BaseMapper;

public interface DaXingSheBeiFuJianMapper extends BaseMapper {
	List<DaXingSheBeiFuJianFormMap> findByPage(DaXingSheBeiFuJianFormMap daXingSheBeiFuJianFormMap);
	void updateVersion(int id);
	
	void clearNotUsedData(int dataOperator);
	
	List<DaXingSheBeiFuJianFormMap> findByleId(List<Integer> ids);
}
