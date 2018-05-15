package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.ShouKuanTongZhiDanFormMap;
import com.zyiot.mapper.BaseMapper;

public interface ShouKuanTongZhiDanMapper extends BaseMapper {
	List<ShouKuanTongZhiDanFormMap> findByPage(ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap);
	
	ShouKuanTongZhiDanFormMap findShouKuanTongZhiDanById(int id);
	
	ShouKuanTongZhiDanFormMap lookShouKuanTongZhiDanById(int id);
}
