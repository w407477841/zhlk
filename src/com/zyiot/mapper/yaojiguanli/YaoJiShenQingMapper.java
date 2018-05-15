package com.zyiot.mapper.yaojiguanli;

import java.util.List;

import com.zyiot.entity.yaojiguanli.YaoJiShenQingFormMap;
import com.zyiot.mapper.BaseMapper;

public interface YaoJiShenQingMapper extends BaseMapper {
	List<YaoJiShenQingFormMap> findByPage(YaoJiShenQingFormMap yaoJiShenQingFormMap);
	List<YaoJiShenQingFormMap> findShenPiByPage(YaoJiShenQingFormMap yaoJiShenQingFormMap);
	YaoJiShenQingFormMap findYaoJiShenQingById(int id);
}
