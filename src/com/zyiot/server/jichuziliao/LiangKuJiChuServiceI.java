package com.zyiot.server.jichuziliao;

import java.util.List;

import com.zyiot.entity.jichuziliao.LiangKuJiChuFormMap;

public interface LiangKuJiChuServiceI {
	void addLiangKuJiChu(LiangKuJiChuFormMap liangKuJiChuFormMap)throws Exception;
	void editLiangKuJiChu(LiangKuJiChuFormMap liangKuJiChuFormMap)throws Exception;
	void dropLiangKuJiChu(String id)throws Exception;
	
	List<LiangKuJiChuFormMap> findByPage(LiangKuJiChuFormMap liangKuJiChuFormMap,int pageSize,int pageNum);
	LiangKuJiChuFormMap findLiangKuJiChuById(int id);
}
