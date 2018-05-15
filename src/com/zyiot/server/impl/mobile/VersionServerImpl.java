package com.zyiot.server.impl.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.entity.mobile.VersionFormMap;
import com.zyiot.mapper.mobile.VersionMapper;
import com.zyiot.server.mobile.VersionServerI;

@Service
public class VersionServerImpl implements VersionServerI {
	@Autowired
	private VersionMapper versionMapper;
	
	@Override
	public void addVersionMap(VersionFormMap versionFormMap) throws Exception {
		versionMapper.addEntity(versionFormMap);
	}

	@Override
	public void editVersionMap(VersionFormMap versionFormMap) throws Exception {
		versionMapper.updateEntity(versionFormMap);
	}

	@Override
	public void dropVersionMap(String id) throws Exception {
		versionMapper.deleteEntityByKey("id", id, VersionFormMap.class);
	}

	@Override
	public List<VersionFormMap> findByPage(VersionFormMap versionMap,
			int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return versionMapper.findByPage(versionMap);
	}

	@Override
	public VersionFormMap findLast(String type) {
		return versionMapper.findLast(type);
	}

	@Override
	public VersionFormMap findById(int id) {
		return versionMapper.findVersionById(id);
	}

}
