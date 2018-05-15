package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.UserFormMap;

public interface UserMapper extends BaseMapper {

	UserFormMap findUserById(int id);

	List<UserFormMap> findUserByPage(UserFormMap user);

	List<UserFormMap> findUserByRoleId(UserFormMap user);
	/**
	 * 根据用户进行帐号锁定
	 * @param accountName
	 */
	public void lockUserByAccountName(String accountName);
	/**
	 * 根据帐号获取用户信息
	 * @param accountName
	 * @return
	 */
	UserFormMap findUserFormByAccountName(String accountName);
}
