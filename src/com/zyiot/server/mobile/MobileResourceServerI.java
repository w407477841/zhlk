package com.zyiot.server.mobile;

import java.util.List;

import com.zyiot.entity.mobile.MobileResourceFormMap;

/**
 * 移动端--菜单管理
 * @author Admin
 * @date 2017年11月17日 下午3:19:12
 */
public interface MobileResourceServerI {
	public void addMobileResource(MobileResourceFormMap mobileResourceFormMap)throws Exception;
	public void editMobileResource(MobileResourceFormMap mobileResourceFormMap)throws Exception;
	public void dropMobileResource(List<String> ids)throws Exception;
	
	public List<MobileResourceFormMap> findByAttr(MobileResourceFormMap mobileResourceFormMap);
	
	public MobileResourceFormMap findById(int id);
	
	/**
	 * 查询授权菜单
	 * @param mobileResourceFormMap
	 * @return
	 */
	public List<MobileResourceFormMap> findByPermission(MobileResourceFormMap mobileResourceFormMap);
	
}
