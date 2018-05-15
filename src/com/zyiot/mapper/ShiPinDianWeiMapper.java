package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.ShiPinDianWeiFormMap;

public interface ShiPinDianWeiMapper extends BaseMapper {

	List<ShiPinDianWeiFormMap> findShiPinDianWeiByPage(ShiPinDianWeiFormMap shiPinDianWeiFormMap);
	
}
