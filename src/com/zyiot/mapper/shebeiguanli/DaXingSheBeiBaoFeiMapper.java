package com.zyiot.mapper.shebeiguanli;

import java.util.List;

import com.zyiot.entity.shebeiguanli.DaXingSheBeiBaoFeiFormMap;
import com.zyiot.mapper.BaseMapper;

public interface DaXingSheBeiBaoFeiMapper extends BaseMapper {
	List<DaXingSheBeiBaoFeiFormMap> findByPage(DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap);
	DaXingSheBeiBaoFeiFormMap findDaXingSheBeiBaoFeiById(int id);
}
