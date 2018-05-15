package com.zyiot.server.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.ictehi.grainplat.service.GrainplatService;
import com.ictehi.grainplat.service.GrainplatServicePortType;
import com.zyiot.annotation.SystemLog;
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
import com.zyiot.mapper.StorageMapper;
import com.zyiot.server.StorageServerI;
import com.zyiot.util.FormMapUtil;

@Service("sService")
public class StorageServerImpl implements StorageServerI {
	@Autowired
	private StorageMapper mapper;

	@Override
	public List<StorageFormMap> findStorage(int page, int rows,
			StorageFormMap formMap) throws Exception {

		if (page >= 0 && rows >= 0) {
			System.out.println(PageHelper.startPage(page, rows));
		}
		return mapper.findInstorages(formMap);
	}

	@Override
	public List<TransportCarFormMap> availableCars() throws Exception {
		return mapper.availableCars();
	}

	@Override
	public List<StandardFormMap> foodStandard(String code) throws Exception {
		return mapper.findStandard(code);
	}

	@Override
	public PriceMessage priceMessage(String code) throws Exception {
		return mapper.priceMessage(code);
	}

	@Override
	public void addStorage(StorageFormMap formMap) throws Exception {
		mapper.addEntity(formMap);
	}

	@Override
	public int addQuailty(InstorageQualityFormMap formMap) throws Exception {
		return mapper.addEntity(formMap);
	}

	@Override
	public int editQuailty(InstorageQualityFormMap formMap) throws Exception {
		return mapper.updateEntity(formMap);
	}

	@Override
	public List<AvailableCarsFormMap> queryCars(String all) throws Exception {
		return mapper.queryCars(all);
	}

	@Override
	public int updateCar(AvailableCarsFormMap formMap) throws Exception {
		return mapper.updateEntity(formMap);
	}

	@Override
	public int addOneCar(AvailableCarsFormMap formMap) throws Exception {
		return mapper.addEntity(formMap);
	}

	@Override
	public int deleteOneCar(String value) throws Exception {
		return mapper.deleteEntityByKey("CaNum", value,
				AvailableCarsFormMap.class);
	}

	@Override
	public int addRelation(RelationsFormMap formMap) throws Exception {
		return mapper.addEntity(formMap);
	}

	@Override
	public List<HashMap> printCars(String id) throws Exception {
		return mapper.printCars(id);
	}

	@Override
	public List<Map<String, String>> singleBill(Map<String, String> map) {
		return mapper.singleBill(map);
	}

	@Override
	public List<Map<String, Object>> showInstorages(Map<String, String> map) {
		return mapper.showInstorages(map);
	}

	@Override
	public Map weightingcount(Map<String, String> map) {
		return mapper.weightingcount(map);
	}

	@Override
	public int validation(Map<String, String> map) {

		List list = mapper.validation(map);
		if (list.isEmpty()) {
			return 0;
		} else {
			return 1;
		}

	}

	@Override
	public List<Map> applySettings(Map<String, String> map) throws Exception {
		return mapper.applySettings(map);
	}

	@Override
	public List<WeightingFormMap> weightingList(String id) throws Exception {
		return mapper.weightingList(id);
	}

	@Override
	public int insertWeight(WeightingFormMap bo) throws Exception {
		return mapper.addEntity(bo);
	}

	@Override
	public int updateWeight(WeightingFormMap bo) throws Exception {
		return mapper.updateEntity(bo);
	}

	@Override
	public Map carcount(String id) {
		return mapper.carcount(id);
	}

	@Override
	public int updateInstorage(Map<String, String> formMap) throws Exception {
		return mapper.updateInstorage(formMap);
	}

	@Override
	public int resetCarStatus(Map<String, String> map) {
		return mapper.resetCarStatus(map);
	}

	@Override
	public List<Map> totalBill() throws Exception {
		return mapper.totalBill();
	}

	@Override
	public List<Map> queryPayInstorages(int page, int rows,
			Map<String, String> formMap) throws Exception {

		if (page >= 0 && rows >= 0) {
			System.out.println(PageHelper.startPage(page, rows));
		}
		return mapper.queryPayInstorages(formMap);
	}

	@Override
	public int updateInstorage(StorageFormMap formMap) throws Exception {
		return mapper.updateEntity(formMap);
	}

	@Override
	public int addPayWay(Map params) {
		return mapper.addPayWay(params);
	}

	@Override
	public int saveDiBangData(Map<String, String> map) throws Exception {
		return mapper.saveDiBangData(map);
	}

	@Override
	public int updateDiBangData(Map<String, String> map) throws Exception {
		return mapper.updateDiBangData(map);
	}

	@Override
	public int removeInstorage(String id) throws Exception {
		return mapper.deleteEntityByKey("basicid", id, StorageFormMap.class);
	}

	@Override
	public int removeWeight(String id) throws Exception {
		return mapper.deleteEntityByKey("id", id, WeightingFormMap.class);
	}

	@Override
	public int removeQuality(String id) throws Exception {
		return mapper
				.deleteEntityByKey("ID", id, InstorageQualityFormMap.class);
	}

	@Override
	public List<Map> allSettings(Map<String, String> map) throws Exception {
		return mapper.allSettings(map);
	}

	@Override
	public List<Map> instanceAmount(Map<String, String> map) throws Exception {
		return mapper.instanceAmount(map);
	}

	@Override
	public List<Map> instanceHouseAmount(Map<String, String> map)
			throws Exception {
		return mapper.instanceHouseAmount(map);
	}

	@SystemLog(methods = "数据对接", module = "出入库记录", description = "成功")
	@Transactional(readOnly = false)
	public void batchSaveStorages(List<StorageFormMap> l) throws Exception {

		int size = l.size();
		StorageFormMap timestamp = null;
		for (int i = 0; i < size; i++) {

			StorageFormMap s = l.get(i);
			String location = s.getStr("location");
			location = location.substring(0, 1)
					+ location.substring(location.length() - 3);
			s.put("basicid", location + s.get("basicid"));
			if (i == 0) {
				timestamp = new StorageFormMap();
				timestamp.put("lasttime", s.getStr("update_time"));
				timestamp.put("location", s.getStr("location"));
				timestamp.put("tableName", "w_instorage");
			}

			FormMapUtil.toADDFormMap(s);
			mapper.addEntity(s);
		}
		if (timestamp != null) {
			mapper.updateTimeStamp(timestamp);

		}

	}

	@SystemLog(methods = "数据对接", module = "质量记录", description = "成功")
	@Transactional(readOnly = false)
	public void batchSaveQuality(List<InstorageQualityFormMap> l,
			String location) throws Exception {
		int size = l.size();
		StorageFormMap timestamp = null;
		for (int i = 0; i < size; i++) {

			InstorageQualityFormMap s = l.get(i);
			// String location = s.getStr("location");
			String lt = location.substring(0, 1)
					+ location.substring(location.length() - 3);
			s.put("basicid", lt + s.get("basicid"));
			if (i == 0) {
				timestamp = new StorageFormMap();
				timestamp.put("lasttime", s.getStr("update_time"));
				timestamp.put("location", location);
				timestamp.put("tableName", "w_quality");
			}

			FormMapUtil.toADDFormMap(s);
			mapper.addEntity(s);
		}
		if (timestamp != null) {
			mapper.updateTimeStamp(timestamp);

		}

	}

	@SystemLog(methods = "数据对接", module = "称重记录", description = "成功")
	@Transactional(readOnly = false)
	public void batchSaveWeighting(List<WeightingFormMap> l, String location)
			throws Exception {
		int size = l.size();
		StorageFormMap timestamp = null;
		for (int i = 0; i < size; i++) {

			WeightingFormMap s = l.get(i);
			// String location = s.getStr("location");
			String lt = location.substring(0, 1)
					+ location.substring(location.length() - 3);
			s.put("basicid", lt + s.get("basicid"));
			if (i == 0) {
				timestamp = new StorageFormMap();
				timestamp.put("lasttime", s.getStr("update_time"));
				timestamp.put("location", location);
				timestamp.put("tableName", "w_weighting");
			}
			WeightingFormMap query = new WeightingFormMap();
			query.put("basicid", s.get("basicid"));
			List<WeightingFormMap> has = mapper.findByAttr(query);
			if (has != null && has.size() > 0) {// 已存在
				FormMapUtil.toUPDATEFormMap(s);
				mapper.updateEntity(s);
			} else {
				FormMapUtil.toADDFormMap(s);
				mapper.addEntity(s);
			}
		}
		if (timestamp != null) {
			mapper.updateTimeStamp(timestamp);

		}

	}

	@SystemLog(methods = "数据对接", module = "实时库存", description = "成功")
	@Transactional(readOnly = false)
	public void batchSaveStock(List<StorageInfoFormMap> l) throws Exception {
		int size = l.size();
		for (int i = 0; i < size; i++) {
			StorageInfoFormMap s = l.get(i);
			String location = s.getStr("source");
			String lt = location.substring(0, 1)
					+ location.substring(location.length() - 3);
			s.put("id", lt + s.get("id"));

			try {
				FormMapUtil.toADDFormMap(s);
				mapper.addEntity(s);
			} catch (Exception e) {
				FormMapUtil.toUPDATEFormMap(s);
				mapper.updateEntity(s);
			}

		}
	}

	public List<StorageFormMap> findStorage(StorageFormMap formMap)
			throws Exception {
		return mapper.findStorages_g_basicid(formMap);
	}

	public List<InstorageQualityFormMap> findQuality(
			InstorageQualityFormMap formMap) {
		return mapper.findQualist_g_lasttime(formMap);
	}

	public List<WeightingFormMap> findWeighting_g_lasttime(
			WeightingFormMap formMap) {
		return mapper.findWeighting_g_lasttime(formMap);
	}

	@Override
	public StorageFormMap findMaxBasicid(StorageFormMap formMap) {
		return mapper.findMaxBasicidInStorage(formMap);
	}

	@SystemLog(module = "对接数据", methods = "添加时间戳", description = "成功")
	@Transactional(readOnly = false)
	public void addTimeStamp(StorageFormMap s) throws Exception {
		//
		mapper.addTimeStamp(s);

	}

	@Override
	public List<Map<String, String>> billList_Page(int page, int row,
			Map<String, String> map) throws Exception {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(page, row));
		}
		return mapper.singleBill(map);
	}

	@Override
	public List<Map> splineData(Map<String, String> map) throws Exception {
		return mapper.splineData(map);
	}

	@Override
	public List<Map> totalDetail(Map<String, String> map) throws Exception {
		return mapper.totalDetail(map);
	}

	@Override
	public WeightingFormMap findWeightBySid(Map<String, String> map)
			throws Exception {
		return mapper.findWeightBySid(map);
	}

	@Override
	public List<Map> quailtyDetail(int page, int row, Map<String, String> map)
			throws Exception {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(page, row));
		}
		return mapper.quailtyDetail(map);
	}

	@Override
	public List<Map> queryMonthlyStorage(int page, int row,
			Map<String, Object> map) throws Exception {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(page, row));
		}
		return mapper.queryMonthlyStorage(map);
	}

	@Override
	public List<Map> queryFendianStorage(int page, int row,
			Map<String, Object> map) throws Exception {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(page, row));
		}
		return mapper.queryFendianStorage(map);
	}

	@Override
	public List<BuyMsgFormMap> msgLists(int page, int row,
			Map<String, Object> map) throws Exception {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(page, row));
		}
		return mapper.msgLists(map);
	}

	@Override
	public int addBuyMsg(BuyMsgFormMap formMap) throws Exception {
		return mapper.addEntity(formMap);
	}

	@Override
	public int editBuyMsg(BuyMsgFormMap formMap) throws Exception {
		return mapper.updateEntity(formMap);
	}

	@Override
	public int deleteBuyMsg(String val) throws Exception {
		return mapper.deleteEntityByKey("id", val, BuyMsgFormMap.class);
	}

	@Override
	public BuyMsgFormMap singleBuyMsg(String id) throws Exception {
		return mapper.findById(id, BuyMsgFormMap.class);
	}

	@Override
	public List<SellMsgFormMap> sellMsgLists(int page, int row,
			Map<String, Object> map) throws Exception {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(page, row));
		}
		return mapper.sellMsgLists(map);
	}

	@Override
	public SellMsgFormMap singleSellMsg(String id) throws Exception {
		return mapper.findById(id, SellMsgFormMap.class);
	}

	@Override
	public int addSellMsg(SellMsgFormMap formMap) throws Exception {
		return mapper.addEntity(formMap);
	}

	@Override
	public int editSellMsg(SellMsgFormMap formMap) throws Exception {
		return mapper.updateEntity(formMap);
	}

	@Override
	public int deleteSellMsg(String id) throws Exception {
		return mapper.deleteEntityByKey("id", id, SellMsgFormMap.class);
	}

	@Override
	public List<StoreMsgFormMap> storeMsgLists(int page, int row,
			Map<String, Object> map) throws Exception {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(page, row));
		}
		return mapper.storeMsgLists(map);
	}

	@Override
	public StoreMsgFormMap singleStoreMsg(String id) throws Exception {
		return mapper.findById(id, StoreMsgFormMap.class);
	}

	@Override
	public int addStoreMsg(StoreMsgFormMap formMap) throws Exception {
		return mapper.addEntity(formMap);
	}

	@Override
	public int editStoreMsg(StoreMsgFormMap formMap) throws Exception {
		return mapper.updateEntity(formMap);
	}

	@Override
	public int deleteStoreMsg(String id) throws Exception {
		return mapper.deleteEntityByKey("id", id, StoreMsgFormMap.class);
	}

	@Override
	public List<Map> instanceMsgLists(int page, int row, Map<String, Object> map)
			throws Exception {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(page, row));
		}
		return mapper.instancMsgLists(map);
	}

	@Override
	public Map singleInstanceMsg(String id) throws Exception {
		Map param = new HashMap<>();
		param.put("id", id);
		return mapper.singleInstancMsgLists(param);
	}

	@Override
	public int addInstanceMsg(InstanceMsgFormMap formMap) throws Exception {
		return mapper.addEntity(formMap);
	}

	@Override
	public int editInstanceMsg(InstanceMsgFormMap formMap) throws Exception {
		return mapper.updateEntity(formMap);
	}

	@Override
	public int deleteInstanceMsg(String id) throws Exception {
		return mapper.deleteEntityByKey("id", id, InstanceMsgFormMap.class);
	}

	@Override
	public Map instancWeight(Map map) throws Exception {
		return mapper.instancWeight(map);
	}

	@Override
	public List<Map> tweenInstorage(int page, int row, Map<String, String> map)
			throws Exception {
		if (page >= 0 && row >= 0) {
			System.out.println(PageHelper.startPage(page, row));
		}
		return mapper.tweenInstorage(map);
	}

	@Override
	public Map singleInstorage(Map map) throws Exception {
		return mapper.singleInstorage(map);
	}

	@Override
	public int updateQuality(InstorageQualityFormMap bo) throws Exception {
		return mapper.updateEntity(bo);
	}

	@Override
	@SystemLog(module = "出入库对接", methods = "数据对接", description = "对接成功")
	@Transactional(readOnly = false)
	public int dataTransfer() throws Exception {

		List<Map> map = mapper.instorageTransfer(null);

		int rs = _bulidJSON(map, 3);

		return rs;

	}

	@Override
	@SystemLog(module = "实时库存对接", methods = "数据对接", description = "对接成功")
	@Transactional(readOnly = false)
	public int dataInstanceTransfer() throws Exception {

		List<Map> map = mapper.storeInstanceTransfer(null);
		return _bulidSHISHIJSON(map, 2);

	}

	@SuppressWarnings("unused")
	private int _bulidJSON(List<Map> map, int type) {
		int rs = 100;
		try {
			com.ictehi.grainplat.service.GrainplatService s = new GrainplatService();
			GrainplatServicePortType context = s
					.getGrainplatServiceHttpSoap11Endpoint();

			for (Map obj : map) {
				Iterator its = JSONObject.fromObject(obj).keys();
				StringBuffer strs = new StringBuffer();
				strs.append("{");
				while (its.hasNext()) {
					String key = (String) its.next();
					if (key != null && key.equals("param3")
							|| key.equals("param4") || key.equals("param1")) {
						continue;
					}
					strs.append(key + ":'" + obj.get(key) + "',");
				}
				strs.deleteCharAt(strs.length() - 1);
				strs.append("}");
				rs = context.saveOrUpdateGrainDepotInfo(strs.toString(),
						strs.length() + "", type, obj.get("param3").toString(),
						obj.get("param4").toString());
				if (rs == 0) {
					StorageFormMap param1 = new StorageFormMap();
					param1.put("basicid", obj.get("param1"));
					param1.put("late", 0);
					FormMapUtil.toUPDATEFormMap(param1);
					mapper.updateEntity(param1);

					WeightingFormMap param2 = new WeightingFormMap();
					param2.put("id", obj.get("inOutID"));
					param2.put("late", 0);
					mapper.updateWeights(param2);
				}

				System.out.println(rs);
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@SuppressWarnings("unused")
	private int _bulidSHISHIJSON(List<Map> map, int type) {
		int rs = 100;
		try {
			com.ictehi.grainplat.service.GrainplatService s = new GrainplatService();
			GrainplatServicePortType context = s
					.getGrainplatServiceHttpSoap11Endpoint();

			for (Map obj : map) {
				Iterator its = JSONObject.fromObject(obj).keys();
				StringBuffer strs = new StringBuffer();
				strs.append("{");
				while (its.hasNext()) {
					String key = (String) its.next();
					if (key != null && key.equals("param3")
							|| key.equals("param4")) {
						continue;
					}
					strs.append(key + ":'" + obj.get(key) + "',");
				}
				strs.deleteCharAt(strs.length() - 1);
				strs.append("}");
				rs = context.saveOrUpdateGrainDepotInfo(strs.toString(),
						strs.length() + "", type, obj.get("param3").toString(),
						obj.get("param4").toString());
				System.out.println(rs);
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int forid(String id) throws Exception {
		return mapper.forid(id);
	}

	@SystemLog(methods = "数据对接", module = "初始存量记录", description = "成功")
	@Transactional(readOnly = false)
	public void batchSaveStore(List<StoreInfoFormMap> l) throws Exception {
		int size = l.size();
		for (int i = 0; i < size; i++) {
			StoreInfoFormMap s = l.get(i);
			String location = s.get("location_id") + "";
			String lt = location.substring(0, 1)
					+ location.substring(location.length() - 3);
			s.put("id", lt + s.get("id"));

			try {
				FormMapUtil.toADDFormMap(s);
				mapper.addEntity(s);
			} catch (Exception e) {
				FormMapUtil.toUPDATEFormMap(s);
				mapper.updateEntity(s);
			}

		}

	}

	@SystemLog(methods = "数据对接", module = "初始质量信息", description = "成功")
	@Transactional(readOnly = false)
	public void batchSaveStoreDetail(List<StorageDetailFormMap> l)
			throws Exception {

		int size = l.size();
		for (int i = 0; i < size; i++) {
			StorageDetailFormMap s = l.get(i);

			try {
				FormMapUtil.toADDFormMap(s);
				mapper.addEntity(s);
			} catch (Exception e) {
				FormMapUtil.toUPDATEFormMap(s);
				mapper.updateEntity(s);
			}

		}

	}

	@Override
	public void batchSaveTongcang(List<InstanceMsgFormMap> l) throws Exception {
		int size = l.size();
		for (int i = 0; i < size; i++) {
			InstanceMsgFormMap s = l.get(i);
			String location = s.getStr("location");
			String lt = location.substring(0, 1)
					+ location.substring(location.length() - 3);
			s.put("id", lt + s.get("id"));

			try {
				FormMapUtil.toADDFormMap(s);
				mapper.addEntity(s);
			} catch (Exception e) {
				FormMapUtil.toUPDATEFormMap(s);
				mapper.updateEntity(s);
			}

		}

	}
}
