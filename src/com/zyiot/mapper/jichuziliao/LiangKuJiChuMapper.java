package com.zyiot.mapper.jichuziliao;

import java.util.List;

import com.zyiot.entity.jichuziliao.LiangKuJiChuFormMap;
import com.zyiot.mapper.BaseMapper;

public interface LiangKuJiChuMapper extends BaseMapper {
	List<LiangKuJiChuFormMap> findByPage(LiangKuJiChuFormMap liangKuJiChuFormMap);
	LiangKuJiChuFormMap findLiangKuJiChuById(int id);
}
