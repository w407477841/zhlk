package com.zyiot.mapper.yaojiguanli;

import java.util.List;

import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.mapper.BaseMapper;

public interface YaoJiKuCunMapper extends BaseMapper {
	List<YaoJiKuCunFormMap> findByPage(YaoJiKuCunFormMap yaoJiKuCunFormMap);
	YaoJiKuCunFormMap findYaoJiKuCunById(int id);
	YaoJiKuCunFormMap lookYaoJiKuCunById(int id);
	List<YaoJiKuCunFormMap> findAll();
	
	List<YaoJiKuCunFormMap> findDataDocking(String beginDate);
}
