package com.zyiot.mapper.shebeiguanli;

import java.util.List;

import com.zyiot.entity.shebeiguanli.DaXingSheBeiWeiXiuFormMap;
import com.zyiot.mapper.BaseMapper;

public interface DaXingSheBeiWeiXiuMapper extends BaseMapper {
	List<DaXingSheBeiWeiXiuFormMap> findByPage(DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap);
	DaXingSheBeiWeiXiuFormMap findDaXingSheBeiWeiXiuById(int id);
	List<DaXingSheBeiWeiXiuFormMap> findByLeId(int leId);
}
