package com.zyiot.mapper.zijinguankong;

import java.util.List;

import com.zyiot.entity.zijinguankong.ZiJinJiHuaFormMap;
import com.zyiot.mapper.BaseMapper;

public interface ZiJinJiHuaMapper extends BaseMapper {
	List<ZiJinJiHuaFormMap> findByPage(ZiJinJiHuaFormMap ziJinJiHuaFormMap);
	ZiJinJiHuaFormMap findZiJinJiHuaById(int id);
}
