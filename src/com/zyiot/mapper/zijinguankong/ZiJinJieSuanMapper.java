package com.zyiot.mapper.zijinguankong;

import java.util.List;

import com.zyiot.entity.zijinguankong.ZiJinJieSuanFormMap;
import com.zyiot.mapper.BaseMapper;

public interface ZiJinJieSuanMapper extends BaseMapper {
	List<ZiJinJieSuanFormMap> findByPage(ZiJinJieSuanFormMap ziJinJieSuanFormMap);
	ZiJinJieSuanFormMap findZiJinJieSuanById(int id);
}
