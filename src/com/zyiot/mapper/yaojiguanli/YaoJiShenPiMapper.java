package com.zyiot.mapper.yaojiguanli;

import java.util.List;

import com.zyiot.entity.yaojiguanli.YaoJiShenPiFormMap;
import com.zyiot.mapper.BaseMapper;

public interface YaoJiShenPiMapper extends BaseMapper {
	List<YaoJiShenPiFormMap> findByPage(YaoJiShenPiFormMap yaoJiShenPiFormMap);
	YaoJiShenPiFormMap findYaoJiShenPiById(int id);
}
