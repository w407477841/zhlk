package com.zyiot.server.mobile;

import java.util.List;

import com.zyiot.entity.mobile.VersionFormMap;

/**
 * 版本控制
 * @author Admin
 * @date 2017年11月7日 下午1:38:23
 */
public interface VersionServerI {
	
	public void addVersionMap(VersionFormMap versionFormMap)throws Exception;
	public void editVersionMap(VersionFormMap versionFormMap)throws Exception;
	public void dropVersionMap(String id)throws Exception;
	
	public List<VersionFormMap> findByPage(VersionFormMap versionMap,int pageNum,int pageSize);
	/**
	 * 获取最新的一条数据
	 * @param type 类型
	 * @return
	 */
	public VersionFormMap findLast(String type);
	
	public VersionFormMap findById(int id);
	
}
