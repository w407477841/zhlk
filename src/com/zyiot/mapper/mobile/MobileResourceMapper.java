package com.zyiot.mapper.mobile;

import java.util.List;

import com.zyiot.entity.mobile.MobileResourceFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 移动端--菜单管理
 * @author Admin
 * @date 2017年11月17日 下午3:18:18
 */
public interface MobileResourceMapper extends BaseMapper {
	public MobileResourceFormMap findResourceById(int id);
	/**
	 * 删除菜单，同样删除权限数据
	 * @param ids
	 */
	public void dropResourceAndPrmession(List<String> ids);
	/**
	 * 删除菜单，删除上级菜单同样把下级菜单删除
	 * @param ids
	 */
	public void dropResource(List<String> ids);
	/**
	 * 查询授权菜单
	 * @param mobileResourceFormMap
	 * @return
	 */
	public List<MobileResourceFormMap> findByPermission(MobileResourceFormMap mobileResourceFormMap);
	/**
	 * 查询所有菜单信息
	 * @param mobileResourceFormMap
	 * @return
	 */
	public List<MobileResourceFormMap> findAllResource(MobileResourceFormMap mobileResourceFormMap);
	
	
	
	
}
