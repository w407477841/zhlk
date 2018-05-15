package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.RoleFormMap;

public interface RoleMapper extends BaseMapper {
	List<RoleFormMap> findRoleByPage(RoleFormMap roleFormMap);
}
