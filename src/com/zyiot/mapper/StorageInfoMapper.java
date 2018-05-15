package com.zyiot.mapper;

import java.util.List;
import java.util.Map;

import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.util.FormMap;

public interface StorageInfoMapper extends BaseMapper {
	public List<StorageInfoFormMap> classifybykudian(Map<String, String> map);

	public List<StorageInfoFormMap> classifybyquan(Map<String, String> map);

	public List<StorageInfoFormMap> classifyByNo(Map<String, String> formmap);

	public List<StorageInfoFormMap> findLocation();

	public List<StorageInfoFormMap> queryLibraryInfo(Map<String, String> map);

	int updateStorageByStorageID(StorageInfoFormMap map);

	int updateStorageBybasicid(StorageInfoFormMap map);

	int updateStorageByLiushui(StorageInfoFormMap map);

	public List<Map> findContrastLocation();

	public List<Map> findContrastStation(Map param);

	public List<StorageInfoFormMap> findBreeds();

	public List<StorageInfoFormMap> findProperties();

	public Map instancWeight(Map map) throws Exception;
	
	/**
	 * 根据仓号获取粮食性质和品种
	 * @param warehouseId 仓号
	 * @return
	 */
	public StorageInfoFormMap findVarietyAndPropertyByWarehouseId(int warehouseId);
	
	/**
	 * 实时库存报表
	 * @param storageInfoFormMap
	 * @return
	 */
	public List<StorageInfoFormMap> findCurrentStorageByPage(StorageInfoFormMap storageInfoFormMap);
	/**
	 * 分点明细报表
	 * @param storageInfoFormMap
	 * @param pageSize
	 * @param pageNum
	 * @return
	 */
	public List<StorageInfoFormMap> findDetailStorageByPage(StorageInfoFormMap storageInfoFormMap);
	
	/**
	 * 根据粮食属性进行汇总--用于实时库存报表
	 * @param propertyList
	 * @return
	 */
	public List<StorageInfoFormMap> findCurrentTotalWeight(FormMap<String,Object> base);
	
	/**
	 * 获取所有实时库存中粮库地点
	 * @return
	 */
	public List<StorageInfoFormMap> findAllWarehouseLocation();
	/**
	 * 获取所有实时库存中粮食性质
	 * @return
	 */
	public List<StorageInfoFormMap> findAllGrainProperty();
	/**
	 * 获取所有实时库存中粮食品种
	 * @return
	 */
	public List<StorageInfoFormMap> findAllGrainVariety();
	/**
	 * 分点报表--汇总
	 * @return
	 */
	public List<StorageInfoFormMap> findSumStorage(FormMap<String,Object> base);
	/**
	 * 根据仓号获取库存信息
	 * @param wId
	 * @return
	 */
	public StorageInfoFormMap findByWarehouseId(String wId);
}
