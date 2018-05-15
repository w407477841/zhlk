package com.zyiot.mapper.jichuziliao;

import java.util.List;

import com.zyiot.entity.jichuziliao.CangFangXinXiFormMap;
import com.zyiot.mapper.BaseMapper;

public interface CangFangXinXiMapper extends BaseMapper {
	List<CangFangXinXiFormMap> findByPage(CangFangXinXiFormMap cangFangXinXiFormMap);
	/**
	 * 根据Id获取信息
	 * @param id  编号(自增列)
	 * @return
	 */
	CangFangXinXiFormMap findCangFangXinXiById(int id);
	/**
	 * 根据Id获取保管人员信息
	 * @param id  编号(自增列)
	 * @return
	 */
	CangFangXinXiFormMap findStroremanById(int id);
	/**
	 * 根据仓号获取信息
	 * @param wId 仓库表中的自增列
	 * @return
	 */
	CangFangXinXiFormMap findBywId(int wId);
}
