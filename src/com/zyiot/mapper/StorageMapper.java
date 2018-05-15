package com.zyiot.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.qualityChain.BuyMsgFormMap;
import com.zyiot.entity.qualityChain.InstanceMsgFormMap;
import com.zyiot.entity.qualityChain.SellMsgFormMap;
import com.zyiot.entity.qualityChain.StoreMsgFormMap;
import com.zyiot.entity.shouchu.AvailableCarsFormMap;
import com.zyiot.entity.shouchu.InstorageQualityFormMap;
import com.zyiot.entity.shouchu.PriceMessage;
import com.zyiot.entity.shouchu.StandardFormMap;
import com.zyiot.entity.shouchu.StorageFormMap;
import com.zyiot.entity.shouchu.TransportCarFormMap;
import com.zyiot.entity.shouchu.WeightingFormMap;

public interface StorageMapper extends BaseMapper {

	public List<StorageFormMap> findInstorages(StorageFormMap formMap);
	
	public Map  instancWeight(Map map) throws Exception;
	
	public int forid(String id)throws Exception;

	public List<StorageFormMap> findStorages_g_basicid(StorageFormMap formMap);

	public List<WeightingFormMap> findWeighting_g_lasttime(
			WeightingFormMap formMap);
	
	public Map singleInstorage(Map map)throws Exception;

	public StorageFormMap findMaxBasicidInStorage(StorageFormMap formMap);

	public void updateTimeStamp(StorageFormMap formMap) throws Exception;

	public List<InstorageQualityFormMap> findQualist_g_lasttime(
			InstorageQualityFormMap formMap);

	public void addTimeStamp(StorageFormMap formMap) throws Exception;

	public List<TransportCarFormMap> availableCars();

	public List<StandardFormMap> findStandard(String code);

	public PriceMessage priceMessage(String code);

	public List<AvailableCarsFormMap> queryCars(String all) throws Exception;

	public List<HashMap> printCars(String id) throws Exception;

	public List<Map<String, String>> singleBill(Map<String, String> map);

	public List<Map<String, Object>> showInstorages(Map<String, String> map);

	public Map weightingcount(Map<String, String> map);

	public List validation(Map<String, String> map);

	public List<Map> applySettings(Map<String, String> map) throws Exception;
	
	public List<Map> findStorageByPage(Map map) throws Exception;

	public List<WeightingFormMap> weightingList(String id) throws Exception;

	public Map carcount(String id);

	public int updateInstorage(Map<String, String> formMap) throws Exception;

	public int resetCarStatus(Map<String, String> map);

	public List<Map> totalBill() throws Exception;

	public List<Map> queryPayInstorages(Map<String, String> formMap)
			throws Exception;

	public int addPayWay(Map params);

	public int saveDiBangData(Map<String, String> map) throws Exception;

	public int updateDiBangData(Map<String, String> map) throws Exception;

	public List<Map> allSettings(Map<String, String> map) throws Exception;

	public List<Map> splineData(Map<String, String> map) throws Exception;

	public List<Map> instanceAmount(Map<String, String> map) throws Exception;
	
	public List<Map> instanceHouseAmount(Map<String, String> map)
			throws Exception;

	public List<Map> totalDetail(Map<String, String> map) throws Exception;

	public WeightingFormMap findWeightBySid(Map<String, String> map)
			throws Exception;
	
	
	public List<Map> quailtyDetail(Map<String, String> map) throws Exception;
	
	public List<Map> queryFendianStorage( Map<String, Object> map) throws Exception;
	
	public List<Map> queryMonthlyStorage( Map<String, Object> map) throws Exception;
	
	public List<BuyMsgFormMap> msgLists(Map<String, Object> map) throws Exception;
	
	public List<SellMsgFormMap> sellMsgLists( Map<String, Object> map) throws Exception;
	
	public List<StoreMsgFormMap> storeMsgLists(Map<String, Object> map) throws Exception;
	
	public List<Map> instancMsgLists( Map<String, Object> map) throws Exception;
	
	public Map singleInstancMsgLists(Map<String, Object> map)throws Exception;
	
	public List<Map> tweenInstorage(Map<String ,String> map)throws Exception;
	
	public List <Map> instorageTransfer(Map<String ,String> map)throws Exception;
	
	public List <Map> storeInstanceTransfer(Map<String ,String> map)throws Exception;
	
	public  int updateWeights(Map map)throws Exception;
	
}
