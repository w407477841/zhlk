package com.zyiot.mapper.fuwupingtai;

import java.util.List;

import com.zyiot.entity.fuwupingtai.ZhengCeChaXunFormMap;
import com.zyiot.mapper.BaseMapper;
import com.zyiot.util.FormMap;

public interface ZhengCeChaXunMapper extends BaseMapper {
List<ZhengCeChaXunFormMap> findByPage(ZhengCeChaXunFormMap zhengCeChaXunFormMap);
	
	ZhengCeChaXunFormMap findZhengCeChaXunById(int id);
	
	ZhengCeChaXunFormMap lookZhengCeChaXunById(int id);
	/**
	 * 查找政策查询类型
	 * @return
	 */
	List<FormMap<String,Object>> findZhengCeType();
}
