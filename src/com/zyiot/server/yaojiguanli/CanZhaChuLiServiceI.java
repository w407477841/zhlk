package com.zyiot.server.yaojiguanli;

import java.util.List;

import com.zyiot.entity.yaojiguanli.CanZhaChuLiFormMap;

public interface CanZhaChuLiServiceI {
	void addCanZhaChuLi(CanZhaChuLiFormMap canZhaChuLiFormMap)throws Exception;
	void editCanZhaChuLi(CanZhaChuLiFormMap canZhaChuLiFormMap)throws Exception;
	void dropCanZhaChuLi(String id)throws Exception;
	
	List<CanZhaChuLiFormMap> findByPage(CanZhaChuLiFormMap canZhaChuLiFormMap,int pageSize,int pageNum);
	List<CanZhaChuLiFormMap> findByAttr(CanZhaChuLiFormMap canZhaChuLiFormMap);
	
	CanZhaChuLiFormMap findById(int id) throws Exception;
}
