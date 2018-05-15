package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.CangFangWeiXiuFormMap;
import com.zyiot.mapper.BaseMapper;

public interface CangFangWeiXiuMapper extends BaseMapper {
	public List<CangFangWeiXiuFormMap> findByPage(CangFangWeiXiuFormMap CangFangWeiXiuFormMap);
	
	public CangFangWeiXiuFormMap findCangFangWeiXiuById(int id);
}
