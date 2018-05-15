package com.zyiot.server.mobile;

import java.util.List;

import com.zyiot.entity.mobile.MobileRoleFormMap;
/**
 * 移动端--角色管理
 * @author Admin
 * @date 2017年11月20日 上午9:48:48
 */
public interface MobileRoleServerI {
	
	public void addMobileRole(MobileRoleFormMap mobileRoleFormMap)throws Exception;
	public void editMobileRole(MobileRoleFormMap mobileRoleFormMap)throws Exception;
	public void dropMobileRole(String id)throws Exception;
	
	public List<MobileRoleFormMap> findByPage(MobileRoleFormMap mobileRoleFormMap,int pageSize,int pageNum);
	
	public List<MobileRoleFormMap> findBySelected(MobileRoleFormMap mobileRoleFormMap);
	
	public MobileRoleFormMap findByRoleId(int id);
	/**
	 * 角色权限分配
	 * @param mobileRoleFormMap
	 * @throws Exception
	 */
	public void editPermission(MobileRoleFormMap mobileRoleFormMap)throws Exception;
}
