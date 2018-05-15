package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.RoleFormMap;
import com.zyiot.entity.UserRoleFormMap;
import com.zyiot.mapper.RoleMapper;
import com.zyiot.server.RoleServerI;
@Service("roleServer")
public class RoleServerImpl implements RoleServerI {
	@Autowired
	RoleMapper roleMapper; 
	
	@Override
	public List<RoleFormMap> findRoleByPage(RoleFormMap roleFormMap,int pageSize,int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return roleMapper.findRoleByPage(roleFormMap);
	}

	@Transactional(readOnly=false)
	@SystemLog(module="角色管理",methods="角色修改",description="成功")
	public int edit(RoleFormMap roleFormMap) throws Exception {
		return roleMapper.updateEntity(roleFormMap);
	}

	@Transactional(readOnly=false)
	@SystemLog(module="角色管理",methods="角色删除",description="成功")
	public int delete(String key, String val) throws Exception {
		/*
		 * 此处删除 中间表
		 */
		roleMapper.deleteEntityByKey("roleId",val,UserRoleFormMap.class);
		return roleMapper.deleteEntityByKey(key, val, RoleFormMap.class);
	}

	@Transactional(readOnly=false)
	@SystemLog(module="角色管理",methods="角色添加",description="成功")
	public int add(RoleFormMap roleFormMap) throws Exception {
		return roleMapper.addEntity(roleFormMap);
	}

	@Override
	public List<RoleFormMap> findRoleByAttr(RoleFormMap roleFormMap) {
		
		return roleMapper.findByAttr(roleFormMap);
	}

}
