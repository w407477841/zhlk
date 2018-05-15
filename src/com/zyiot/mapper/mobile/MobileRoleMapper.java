package com.zyiot.mapper.mobile;

import java.util.List;

import com.zyiot.entity.mobile.MobileRoleFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 移动端--角色
 * @author Admin
 * @date 2017年11月20日 上午9:45:47
 */
public interface MobileRoleMapper extends BaseMapper {
	
	public List<MobileRoleFormMap> findByPage(MobileRoleFormMap mobileRoleFormMap);
	
	public MobileRoleFormMap findMobileRoleById(int id);
	/**
	 * 删除角色并删除角色授权
	 * @param id
	 */
	public void deleteRolePermission(String id);
	/**
	 * 添加角色权限
	 * @param mobileRoleFormMap
	 */
	public void addRolePermission(MobileRoleFormMap mobileRoleFormMap);
	
}
