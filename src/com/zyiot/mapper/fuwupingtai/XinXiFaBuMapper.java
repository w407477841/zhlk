package com.zyiot.mapper.fuwupingtai;

import java.util.List;

import com.zyiot.entity.fuwupingtai.XinXiFaBuFormMap;
import com.zyiot.mapper.BaseMapper;
import com.zyiot.util.FormMap;

public interface XinXiFaBuMapper extends BaseMapper {
	List<XinXiFaBuFormMap> findByPage(XinXiFaBuFormMap faBuXinXiFormMap);
	
	XinXiFaBuFormMap findXinXiFaBuById(int id);
	
	XinXiFaBuFormMap lookXinXiFaBuById(int id);
	/**
	 * 查找信息发布类型
	 * @return
	 */
	List<FormMap<String,Object>> findXinXiType();
	
	
}
