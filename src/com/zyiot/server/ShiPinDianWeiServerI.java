package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.ShiPinDianWeiFormMap;

public interface ShiPinDianWeiServerI {
	public List<ShiPinDianWeiFormMap> findShiPinDianWeiByPage(ShiPinDianWeiFormMap shiPinDianWeiFormMap, 
			int pageSize,int pageNum);
	public ShiPinDianWeiFormMap findShiPinDianWeiById(String id);
	public List<ShiPinDianWeiFormMap> findShiPinDianWeiByAttr(ShiPinDianWeiFormMap shiPinDianWeiFormMap);
 int addShiPinDianWei(ShiPinDianWeiFormMap shiPinDianWeiFormMap)throws Exception;

 public void editShiPinDianWei(ShiPinDianWeiFormMap formMap)throws Exception;
public void deleteShiPinDianWei(String id)throws Exception;
}
