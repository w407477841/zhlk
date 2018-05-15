package com.zyiot.mapper.mobile;

import java.util.List;

import com.zyiot.entity.mobile.VersionFormMap;
import com.zyiot.mapper.BaseMapper;

/**
 * 版本控制
 * @author Admin
 * @date 2017年11月7日 下午1:35:03
 */
public interface VersionMapper extends BaseMapper {
	
	public List<VersionFormMap> findByPage(VersionFormMap versionMap);
	/**
	 * 获取最新的一条数据
	 * @return
	 */
	public VersionFormMap findLast(String type);
	
	public VersionFormMap findVersionById(int id);
}
