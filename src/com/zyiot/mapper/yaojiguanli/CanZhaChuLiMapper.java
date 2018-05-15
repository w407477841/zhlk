package com.zyiot.mapper.yaojiguanli;

import java.util.List;

import com.zyiot.entity.yaojiguanli.CanZhaChuLiFormMap;
import com.zyiot.mapper.BaseMapper;

public interface CanZhaChuLiMapper extends BaseMapper {
	List<CanZhaChuLiFormMap> findByPage(CanZhaChuLiFormMap canZhaChuLiFormMap);
	CanZhaChuLiFormMap findCanZhaChuLiById(int id);
}
