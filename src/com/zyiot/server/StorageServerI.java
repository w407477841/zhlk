package com.zyiot.server;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zyiot.entity.StorageDetailFormMap;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.StoreInfoFormMap;
import com.zyiot.entity.qualityChain.BuyMsgFormMap;
import com.zyiot.entity.qualityChain.InstanceMsgFormMap;
import com.zyiot.entity.qualityChain.SellMsgFormMap;
import com.zyiot.entity.qualityChain.StoreMsgFormMap;
import com.zyiot.entity.shouchu.AvailableCarsFormMap;
import com.zyiot.entity.shouchu.InstorageQualityFormMap;
import com.zyiot.entity.shouchu.PriceMessage;
import com.zyiot.entity.shouchu.RelationsFormMap;
import com.zyiot.entity.shouchu.StandardFormMap;
import com.zyiot.entity.shouchu.StorageFormMap;
import com.zyiot.entity.shouchu.TransportCarFormMap;
import com.zyiot.entity.shouchu.WeightingFormMap;

public interface StorageServerI {
	/**
	 * 查询列表
	 * */
	public List<StorageFormMap> findStorage(int page, int row,
			StorageFormMap formMap) throws Exception;

	public List<InstorageQualityFormMap> findQuality(
			InstorageQualityFormMap formMap);

	public List<WeightingFormMap> findWeighting_g_lasttime(
			WeightingFormMap formMap);

	public Map instancWeight(Map map) throws Exception;

	/**
	 * 查询最大值
	 * */
	public StorageFormMap findMaxBasicid(StorageFormMap formMap);

	public List<StorageFormMap> findStorage(StorageFormMap formMap)
			throws Exception;

	public void batchSaveStorages(List<StorageFormMap> l) throws Exception;

	public void batchSaveQuality(List<InstorageQualityFormMap> l,
			String location) throws Exception;

	public void batchSaveWeighting(List<WeightingFormMap> l, String location)
			throws Exception;

	public void batchSaveStock(List<StorageInfoFormMap> list) throws Exception;

	public void batchSaveStore(List<StoreInfoFormMap> list) throws Exception;

	public void batchSaveStoreDetail(List<StorageDetailFormMap> list)
			throws Exception;

	public void batchSaveTongcang(List<InstanceMsgFormMap> list)
			throws Exception;

	public void addTimeStamp(StorageFormMap s) throws Exception;

	public Map singleInstorage(Map map) throws Exception;

	/**
	 * 查询可用的车辆
	 * */
	public List<TransportCarFormMap> availableCars() throws Exception;

	/**
	 * 查询质检信息
	 * */
	public List<StandardFormMap> foodStandard(String code) throws Exception;

	/**
	 * 查询粮食价格
	 * */
	public PriceMessage priceMessage(String code) throws Exception;

	public int forid(String id) throws Exception;

	/**
	 * 插入报港信息
	 * */
	public void addStorage(StorageFormMap formMap) throws Exception;

	public int updateInstorage(Map<String, String> formMap) throws Exception;

	public int updateInstorage(StorageFormMap formMap) throws Exception;

	public int removeInstorage(String id) throws Exception;

	public int removeWeight(String id) throws Exception;

	public int removeQuality(String id) throws Exception;

	public int addQuailty(InstorageQualityFormMap formMap) throws Exception;

	public int editQuailty(InstorageQualityFormMap formMap) throws Exception;

	/**
	 * 查询车辆可用的
	 * */
	public List<AvailableCarsFormMap> queryCars(String all) throws Exception;

	public int addOneCar(AvailableCarsFormMap formMap) throws Exception;

	public int deleteOneCar(String value) throws Exception;

	public int updateCar(AvailableCarsFormMap formMap) throws Exception;

	/**
	 * 打印车辆报港单
	 * */

	public List<HashMap> printCars(String id) throws Exception;

	public int addRelation(RelationsFormMap formMap) throws Exception;

	public List<Map<String, String>> singleBill(Map<String, String> map)
			throws Exception;

	public List<Map<String, String>> billList_Page(int page, int row,
			Map<String, String> map) throws Exception;

	public List<Map> totalBill() throws Exception;

	public List<Map<String, Object>> showInstorages(Map<String, String> map)
			throws Exception;

	public Map weightingcount(Map<String, String> map) throws Exception;

	public int validation(Map<String, String> map) throws Exception;

	public List<Map> applySettings(Map<String, String> map) throws Exception;

	public List<Map> allSettings(Map<String, String> map) throws Exception;

	public int saveDiBangData(Map<String, String> map) throws Exception;

	public int updateDiBangData(Map<String, String> map) throws Exception;

	public List<WeightingFormMap> weightingList(String id) throws Exception;

	public int insertWeight(WeightingFormMap bo) throws Exception;

	public int updateWeight(WeightingFormMap bo) throws Exception;

	public int updateQuality(InstorageQualityFormMap bo) throws Exception;

	public Map carcount(String id);

	public int resetCarStatus(Map<String, String> map);

	public List<Map> queryPayInstorages(int page, int row,
			Map<String, String> formMap) throws Exception;

	public int addPayWay(Map params);

	public List<Map> instanceAmount(Map<String, String> map) throws Exception;

	public List<Map> instanceHouseAmount(Map<String, String> map)
			throws Exception;

	public List<Map> splineData(Map<String, String> map) throws Exception;

	public List<Map> totalDetail(Map<String, String> map) throws Exception;

	public WeightingFormMap findWeightBySid(Map<String, String> map)
			throws Exception;

	public List<Map> quailtyDetail(int page, int row, Map<String, String> map)
			throws Exception;

	public List<Map> queryMonthlyStorage(int page, int row,
			Map<String, Object> map) throws Exception;

	public List<Map> queryFendianStorage(int page, int row,
			Map<String, Object> map) throws Exception;

	public List<BuyMsgFormMap> msgLists(int page, int row,
			Map<String, Object> map) throws Exception;

	public BuyMsgFormMap singleBuyMsg(String id) throws Exception;

	public int addBuyMsg(BuyMsgFormMap formMap) throws Exception;

	public int editBuyMsg(BuyMsgFormMap formMap) throws Exception;

	public int deleteBuyMsg(String formMap) throws Exception;

	public List<SellMsgFormMap> sellMsgLists(int page, int row,
			Map<String, Object> map) throws Exception;

	public SellMsgFormMap singleSellMsg(String id) throws Exception;

	public int addSellMsg(SellMsgFormMap formMap) throws Exception;

	public int editSellMsg(SellMsgFormMap formMap) throws Exception;

	public int deleteSellMsg(String formMap) throws Exception;

	public List<StoreMsgFormMap> storeMsgLists(int page, int row,
			Map<String, Object> map) throws Exception;

	public StoreMsgFormMap singleStoreMsg(String id) throws Exception;

	public int addStoreMsg(StoreMsgFormMap formMap) throws Exception;

	public int editStoreMsg(StoreMsgFormMap formMap) throws Exception;

	public int deleteStoreMsg(String formMap) throws Exception;

	public List<Map> instanceMsgLists(int page, int row, Map<String, Object> map)
			throws Exception;

	public Map singleInstanceMsg(String id) throws Exception;

	public int addInstanceMsg(InstanceMsgFormMap formMap) throws Exception;

	public int editInstanceMsg(InstanceMsgFormMap formMap) throws Exception;

	public int deleteInstanceMsg(String formMap) throws Exception;

	public List<Map> tweenInstorage(int page, int row, Map<String, String> map)
			throws Exception;

	public int dataTransfer() throws Exception;

	public int dataInstanceTransfer() throws Exception;
}
