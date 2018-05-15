package com.zyiot.mapper.fuwupingtai;

import java.util.List;

import com.zyiot.entity.fuwupingtai.YuYueJiaoLiangFormMap;
import com.zyiot.mapper.BaseMapper;

public interface YuYueJiaoLiangMapper extends BaseMapper {
	List<YuYueJiaoLiangFormMap> findByPage(YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap);
	
	YuYueJiaoLiangFormMap findYuYueJiaoLiangById(int id);
}
