package com.zyiot.mapper.yaojiguanli;

import java.util.List;

import com.zyiot.entity.yaojiguanli.YaoJiLingYongFormMap;
import com.zyiot.mapper.BaseMapper;

public interface YaoJiLingYongMapper extends BaseMapper {
	List<YaoJiLingYongFormMap> findByPage(YaoJiLingYongFormMap yaoJiLingYongFormMap);
	YaoJiLingYongFormMap findYaoJiLingYongById(int id);
}
