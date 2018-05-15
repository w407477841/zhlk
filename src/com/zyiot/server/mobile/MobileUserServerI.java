package com.zyiot.server.mobile;

import java.util.List;

import com.zyiot.entity.UserFormMap;

/**
 * 移动端--用户管理
 * @author Admin
 * @date 2017年11月20日 下午2:12:06
 */
public interface MobileUserServerI {
	
	public List<UserFormMap> findByPage(UserFormMap userFormMap,int pageSize,int pageNum);
	/**
	 * 修改或添加用户角色
	 * @param userFormMap
	 */
	public void addOrEditUserRole(UserFormMap userFormMap)throws Exception;
	
}
