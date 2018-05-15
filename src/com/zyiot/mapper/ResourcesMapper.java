package com.zyiot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zyiot.entity.ResFormMap;

public interface ResourcesMapper extends BaseMapper {
	public List<ResFormMap> findUserResourcess(String userId);

	public List<ResFormMap> findRes(ResFormMap res);

	public List<ResFormMap> findFirstRes(ResFormMap res);

	public List<ResFormMap> findResByPage(ResFormMap res);

	public List<ResFormMap> findAllParent();

	public List<ResFormMap> findRes_RoleIdORUserId(ResFormMap res);

	int deleteResByRoleId(@Param("roleId") String roleId);

	int addResUser(@Param("userId") String userId,
			@Param("roleId") String roleId);
}
