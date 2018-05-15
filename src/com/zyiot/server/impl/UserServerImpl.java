package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.UserFormMap;
import com.zyiot.entity.UserResFormMap;
import com.zyiot.entity.UserRoleFormMap;
import com.zyiot.mapper.ResourcesMapper;
import com.zyiot.mapper.UserMapper;
import com.zyiot.server.UserServerI;
import com.zyiot.util.BatchInsertParameter;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.PasswordHelper;

@Service("userServer")
public class UserServerImpl implements UserServerI {
	@Autowired
	UserMapper userMapper;
	@Autowired
	ResourcesMapper resourcesMapper;

	public UserFormMap findUserById(int id) {
		return userMapper.findUserById(id);
	}

	@SystemLog(module = "用户管理", methods = "添加用户", description = "成功")
	@Transactional(readOnly = false)
	public int insertUser(UserFormMap u) throws Exception {
		String roleId = u.getStr("roleId");
		u.remove("roleId");
		int ret = userMapper.addEntity(u);
		if (roleId != null && !"".equals(roleId)) {
			UserRoleFormMap userRole = new UserRoleFormMap();
			userRole.put("userId", u.get("id"));
			userRole.put("roleId", roleId);
			FormMapUtil.toADDFormMap(userRole);
			userMapper.addEntity(userRole);
			resourcesMapper.addResUser(u.get("id") + "", roleId);
		}
		return ret;
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "用户管理", methods = "初始密码", description = "成功")
	public void editPassword(UserFormMap userFormMap) throws Exception {
		PasswordHelper passwordHelper = new PasswordHelper();
		passwordHelper.encryptPassword(userFormMap);
		FormMapUtil.toUPDATEFormMap(userFormMap);
		userMapper.updateEntity(userFormMap);
	}

	@SystemLog(module = "用户管理", methods = "修改用户", description = "成功")
	@Transactional(readOnly = false)
	public int updateUser(UserFormMap u) throws Exception {
		String roleId = u.getStr("roleId");
		String userId = u.getStr("id");
		u.remove("roleId");

		int updateLine = userMapper.updateEntity(u);
		if (updateLine < 1)
			throw new Exception("[已被修改]");

		// 删除用户下的res
		// 删除用户下的role
		userMapper.deleteEntityByKey("userId", userId, UserResFormMap.class);
		userMapper.deleteEntityByKey("userId", userId, UserRoleFormMap.class);
		// 添加用户角色
		if (roleId != null && !"".equals(roleId)) {
			UserRoleFormMap userRole = new UserRoleFormMap();
			userRole.put("userId", userId);
			userRole.put("roleId", roleId);
			FormMapUtil.toADDFormMap(userRole);
			userMapper.addEntity(userRole);
			// 添加用户权限
			resourcesMapper.addResUser(userId, roleId);
		}
		return 0;
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "用户管理", methods = "用户删除", description = "成功")
	public int deleteUser(String key, String val) throws Exception {
		userMapper.deleteEntityByKey("userId", val, UserRoleFormMap.class);
		userMapper.deleteEntityByKey("userId", val, UserResFormMap.class);
		return userMapper.deleteEntityByKey(key, val, UserFormMap.class);
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "用户管理", methods = "用户删除", description = "成功")
	public int deleteUserByNames(UserFormMap u) throws Exception {
		return userMapper.deleteEntityByNames(u);
	}

	@Transactional(readOnly = false, noRollbackFor = { org.springframework.dao.DuplicateKeyException.class })
	@Override
	public int batchSaveUsers(List<UserFormMap> l) throws Exception {
		return userMapper.batchSave(BatchInsertParameter.wrap(l, 1000));
	}

	@Override
	public List<UserFormMap> findUserByAttr(UserFormMap u) {
		return userMapper.findByAttr(u);
	}

	@Override
	public List<UserFormMap> findUserByPage(UserFormMap u, int pageSize,
			int pageNum) {
		if (pageSize >= 0 && pageNum >= 0) {
			PageHelper.startPage(pageNum, pageSize);
		}
		return userMapper.findUserByPage(u);
	}

	@Override
	@SystemLog(module = "用户管理", methods = "锁定用户", description = "成功")
	public void lockUserByAccountName(String accountName) {
		userMapper.lockUserByAccountName(accountName);
	}

}
