package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.UserFormMap;

public interface UserServerI {
	public UserFormMap findUserById(int id) throws Exception;

	public int insertUser(UserFormMap u) throws Exception;

	public int updateUser(UserFormMap u) throws Exception;

	public int deleteUser(String key, String val) throws Exception;

	public int deleteUserByNames(UserFormMap u) throws Exception;

	public int batchSaveUsers(List<UserFormMap> l) throws Exception;

	public List<UserFormMap> findUserByAttr(UserFormMap u) throws Exception;

	public void editPassword(UserFormMap userFormMap) throws Exception;

	public List<UserFormMap> findUserByPage(UserFormMap u, int pageSize,
			int pageNum);
	/**
	 * 根据用户进行帐号锁定
	 * @param accountName
	 */
	public void lockUserByAccountName(String accountName);
}
