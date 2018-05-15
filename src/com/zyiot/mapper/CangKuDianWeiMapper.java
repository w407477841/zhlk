package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.CangKuDianWeiFormMap;

public interface CangKuDianWeiMapper extends BaseMapper {
	List<CangKuDianWeiFormMap> findDianWeiByPage(
			CangKuDianWeiFormMap cangKuDianWeiFormMap);
	
	/**
	 * 根据仓库点位id 获取传感器数据
	 * @param id
	 * @return
	 */
	public List<CangKuDianWeiFormMap> findDataById(String id);
}
