package com.zyiot.mapper.mobile;

import java.util.List;

import com.zyiot.entity.UserFormMap;
import com.zyiot.mapper.BaseMapper;

public interface MobileUserMapper extends BaseMapper {
	public List<UserFormMap> findByPage(UserFormMap userFormMap);
	/**
	 * 添加用户角色
	 * @param userFormMap
	 */
	public void addUserRole(UserFormMap userFormMap);
	/**
	 * 修改用户角色
	 * @param userFormMap
	 */
	public void editUserRole(UserFormMap userFormMap);
	/**
	 * 根据用户id获取是否已经分配角色
	 * @param userId
	 * @return
	 */
	public UserFormMap findByUserId(String userId);
}
