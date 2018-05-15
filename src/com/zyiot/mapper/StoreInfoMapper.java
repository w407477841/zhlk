package com.zyiot.mapper;

import java.util.List;
import java.util.Map;

import com.zyiot.entity.StorageInfoFormMap;

public interface StoreInfoMapper extends BaseMapper {
	List<StorageInfoFormMap> findStorageByPage(StorageInfoFormMap s);
	
	/**
	 * 识代码
	 * @param s
	 * @return
	 */
	List<StorageInfoFormMap> findCurrentStorageByPage(StorageInfoFormMap s);
	/**
	 * 识别代码--生成二维码
	 * @param id
	 * @return
	 */
	public StorageInfoFormMap findStorageById(int id);
	
	/**
	 * 首页显示
	 * @param s
	 * @return
	 */
	List<StorageInfoFormMap> findByPage();

	List<Map> findStorageByPage1(Map s);

	StorageInfoFormMap findStorageByStorageID(StorageInfoFormMap s);

	List<StorageInfoFormMap> findStorageByCategory();

	/**
	 * 根据仓库Id进行数据筛选
	 * 
	 * @author lip
	 * @param id
	 * @return
	 */
	StorageInfoFormMap findByWarehouseId(int id);
	/**
	 * 根据Id进行数据筛选
	 * 
	 * @author lip
	 * @param id
	 * @return
	 */
	StorageInfoFormMap findStorageInfoById(int id);

	int updateStorage(StorageInfoFormMap s);
	/**
	 * 仓库定性/品种分页显示
	 * @param s
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	 List<StorageInfoFormMap> findStoreByPage(StorageInfoFormMap s);
	 /**
	  * 根据仓库和仓号进行查询
	  * @param wlId 仓库
	  * @param wId 仓号
	  * @return
	  */
	 StorageInfoFormMap findStorageByWarehouse(String wlId,String wId);
}
