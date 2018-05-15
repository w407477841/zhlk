package com.zyiot.server;

import java.util.List;
import java.util.Map;

import com.zyiot.entity.StorageDetailFormMap;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.StoreInfoFormMap;
import com.zyiot.entity.qualityChain.InstanceMsgFormMap;
import com.zyiot.mapper.BaseMapper;

public interface StoreInfoServerI extends
		BaseServerI<StoreInfoFormMap, BaseMapper> {

	/**
	 * 识别代码
	 * @param s
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	public List<StorageInfoFormMap> findCurrentStorageByPage(StorageInfoFormMap s, int pageSize, int pageNum);
	/**
	 * 首页显示实时库存
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	public List<StorageInfoFormMap> findByPage(int pageSize, int pageNum);

	public List<Map> findCurrentStorageByPage(Map s, int pageSize, int pageNum);

	StorageInfoFormMap findStorageByStorageID(StorageInfoFormMap s);

	public StorageInfoFormMap findCurrentStorageOne(StorageInfoFormMap s);

	/**
	 * 根据粮食品种，汇总其库存总量 首页图表显示
	 * 
	 * @author lip
	 * @return
	 */
	public List<StorageInfoFormMap> findCurrentStorageByCategory();

	public void batchSaveStorageInfo(List<StorageInfoFormMap> l)
			throws Exception;

	public List<StoreInfoFormMap> findAll();

	public List<StorageDetailFormMap> findAllDetail();

	public List<InstanceMsgFormMap> findAllTongcang();
	/**
	 * 仓库定性/品种分页显示
	 * @param s
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	public List<StorageInfoFormMap> findStorageByPage(StorageInfoFormMap s, int pageSize, int pageNum);
	
	public void addStorageInfo(StorageInfoFormMap storageInfoFormMap)throws Exception;
	public void editStorageInfo(StorageInfoFormMap storageInfoFormMap)throws Exception;
	public void dropStorageInfo(String id)throws Exception;
	/**
	 * 根据仓号查找数据
	 * @param id
	 * @return
	 */
	public StorageInfoFormMap findStorageByWarehouseId(int warehouseId);
	/**
	 * 识别代码--生成二维码
	 * @param id
	 * @return
	 */
	public StorageInfoFormMap findStorageById(int id);
}
