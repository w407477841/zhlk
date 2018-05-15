package com.zyiot.controller.shouchu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.shouchu.AvailableCarsFormMap;
import com.zyiot.entity.shouchu.InstorageQualityFormMap;
import com.zyiot.entity.shouchu.PriceMessage;
import com.zyiot.entity.shouchu.RelationsFormMap;
import com.zyiot.entity.shouchu.StandardFormMap;
import com.zyiot.entity.shouchu.StorageFormMap;
import com.zyiot.entity.shouchu.WeightingFormMap;
import com.zyiot.server.StorageServerI;
import com.zyiot.server.StorageServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.TimeGenerate;

@Controller
@RequestMapping("/storage")
public class StorageController extends BaseController {
	@Autowired
	private StorageServerI sService;
	@Autowired
	StorageServiceI storageService;

	@RequestMapping("/register/listUI")
	public String register(Model model) {
		return Common.BACKGROUND_PATH + "/storage/register";
	}

	@RequestMapping("/weighting/listUI")
	public String weighting(Model model) {
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Common.BACKGROUND_PATH + "/storage/weighting";
	}

	@RequestMapping("/weight/listUI")
	public String weight(Model model) {
		model.addAttribute("code", getPara("code"));
		return Common.BACKGROUND_PATH + "/storage/weight";
	}

	@RequestMapping("/fiancePayment/listUI")
	public String fiancePayment(Model model) {
		return Common.BACKGROUND_PATH + "/storage/fiancePayment";
	}

	@RequestMapping("/paramConfig/listUI")
	public String paramConfig(Model model) {
		model.addAttribute("disable", getPara("disable"));
		return Common.BACKGROUND_PATH + "/storage/paramConfig";
	}

	@Token(save = true)
	@RequestMapping("/paramConfig/addPage")
	public String addParamConfigPage(Model model) {
		model.addAttribute("id", getPara("id"));
		return Common.BACKGROUND_PATH + "/storage/paramConfig/add";
	}

	@Token(save = true)
	@RequestMapping("/paramConfig/editPage")
	public String editParamConfigPage(Model model) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("sid", getPara("sid"));

		try {
			model.addAttribute("WeightingFormMap",
					sService.findWeightBySid(param));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return Common.BACKGROUND_PATH + "/storage/paramConfig/edit";
	}

	@RequestMapping("/reports/listUI")
	public String reports(Model model) {
		return Common.BACKGROUND_PATH + "/storage/reports";
	}

	@Token(save = true)
	@RequestMapping("/register/add")
	public String registerAdd(Model model) {
		model.addAttribute("inorout", getPara("inorout"));
		return Common.BACKGROUND_PATH + "/storage/register/add";
	}

	@RequestMapping("/car/listUI")
	public String carList(Model model) {
		return Common.BACKGROUND_PATH + "/storage/register/carList";
	}

	@RequestMapping("/carPrint/listUI")
	public String carPrint(Model model) {
		return Common.BACKGROUND_PATH + "/storage/register/carPrint";
	}

	@RequestMapping("/toPrint/listUI")
	public String toPrint(Model model) {
		model.addAttribute("id", getPara("id"));
		return Common.BACKGROUND_PATH + "/gridReport/shouchuxitong/mm";
	}

	@RequestMapping(value = "queryInstorages", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<StorageFormMap> queryInstorages(int page, int rows) {
		try {
			StorageFormMap m = new StorageFormMap();
			m.put("id", getPara("id"));
			m.put("createTime", getPara("createTime"));
			m.put("inorout", getPara("inorout"));
			List<StorageFormMap> ls = sService.findStorage(page, rows, m);
			return toMyPage(ls);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	@RequestMapping(value = "queryPayInstorages", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<Map> queryPayInstorages(int page, int rows) {
		try {
			Map<String, String> param = new HashMap<String, String>();
			param.put("id", getPara("id"));
			param.put("starttime", getPara("starttime"));
			param.put("endtime", getPara("endtime"));
			param.put("owner", getPara("owner"));
			param.put("state", getPara("state"));
			param.put("type", getPara("type"));
			List<Map> ls = sService.queryPayInstorages(page, rows, param);
			return toMyPage(ls);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	@RequestMapping(value = "quailtyDetail", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<Map> quailtyDetail(int page, int rows) {
		try {
			Map<String, String> param = new HashMap<String, String>();
			param.put("inorout", getPara("inorout"));
			List<Map> ls = sService.quailtyDetail(page, rows, param);
			return toMyPage(ls);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	@RequestMapping(value = "queryStandards", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> queryStandards() {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			String code = getPara("code");
			List<StandardFormMap> standard = sService.foodStandard(code);
			PriceMessage message = sService.priceMessage(code);
			rs.put("success", true);
			rs.put("list", standard);
			rs.put("price", message);
		} catch (Exception e) {
			rs.put("success", false);
			e.printStackTrace();
		}
		return rs;
	}

	@RequestMapping(value = "queryCars", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> queryCars() {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			String all = getPara("all");
			List<AvailableCarsFormMap> cars = sService.queryCars(all);
			List<HashMap> pLists = sService.printCars(getPara("id"));
			rs.put("success", true);
			rs.put("cars", cars);
			rs.put("pList", pLists);
		} catch (Exception e) {
			rs.put("success", false);
			e.printStackTrace();
		}
		return rs;
	}

	@Token(remove = true)
	@RequestMapping(value = "addInstorage")
	@ResponseBody
	public Map<String, Object> addInstorage(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String uuid = "";
			int count = 1;
			while (count != 0) {
				uuid = TimeGenerate.generator1();
				count = sService.forid(uuid);
			}

			// 插入报港信息
			StorageFormMap formMap = getFormMap(StorageFormMap.class);
			formMap.put("id", uuid);
			formMap.put("createTime", TimeGenerate.generator2());
			FormMapUtil.toADDFormMap(formMap);
			sService.addStorage(formMap);
			// 插入质检信息
			InstorageQualityFormMap formMap1 = getFormMap(InstorageQualityFormMap.class);
			formMap1.put("id", uuid);
			FormMapUtil.toADDFormMap(formMap1);
			sService.addQuailty(formMap1);

			// 启用驳车
			String cars = getPara("cars");
			if (cars != null && !cars.equals("")) {
				for (String obj : cars.split(",")) {
					// 更改车辆状态
					AvailableCarsFormMap carFormMap = new AvailableCarsFormMap();
					carFormMap.put("ID", Integer.parseInt(obj));
					carFormMap.put("Inuse", uuid + TimeGenerate.randomNum());
					FormMapUtil.toUPDATEFormMap(carFormMap);
					sService.updateCar(carFormMap);

					// 插入车辆对照关系
					RelationsFormMap relationFormMap = new RelationsFormMap();
					relationFormMap.put("carid", obj);
					relationFormMap.put("instorageid", carFormMap.get("Inuse"));
					FormMapUtil.toADDFormMap(relationFormMap);
					sService.addRelation(relationFormMap);

				}
			} else {
				// 插入车辆对照关系
				RelationsFormMap relationFormMap = new RelationsFormMap();
				relationFormMap.put("carid", formMap.get("CarID"));
				relationFormMap.put("instorageid", uuid);
				FormMapUtil.toADDFormMap(relationFormMap);
				sService.addRelation(relationFormMap);
			}

			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			e.printStackTrace();
		}
		return result;

	}

	@RequestMapping(value = "addInstorage_tween")
	@ResponseBody
	public Map<String, Object> addInstorage_tween(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			// 插入报港信息
			StorageFormMap formMap = getFormMap(StorageFormMap.class);
			String uuid = TimeGenerate.generator1();
			formMap.put("id", uuid);
			formMap.put("createTime", TimeGenerate.generator2());
			formMap.put("payTime", TimeGenerate.generator2());
			FormMapUtil.toADDFormMap(formMap);
			sService.addStorage(formMap);
			// 插入质检信息
			InstorageQualityFormMap formMap1 = getFormMap(InstorageQualityFormMap.class);
			formMap1.put("id", uuid);
			FormMapUtil.toADDFormMap(formMap1);
			sService.addQuailty(formMap1);

			// 插入车辆对照关系
			RelationsFormMap relationFormMap = new RelationsFormMap();
			relationFormMap.put("carid", formMap.get("CarID"));
			relationFormMap.put("instorageid", uuid);
			FormMapUtil.toADDFormMap(relationFormMap);
			sService.addRelation(relationFormMap);

			// 插入质量
			WeightingFormMap bo = new WeightingFormMap();
			bo.put("id", uuid);
			bo.put("CarID", formMap.get("CarID"));

			Float weight_t = Float.parseFloat(getPara("weight_tween_t"));
			Float weight_c = Float.parseFloat(getPara("weight_tween_c"));

			if (formMap.get("inorout").equals("0")) {
				weight_t = weight_t * -1;
				weight_c = weight_c * -1;
			}

			bo.put("TotalWeight", weight_t);
			bo.put("TotalWeightingTime", TimeGenerate.generator2());
			bo.put("CarWeight", weight_c);
			bo.put("CarWeightingTime", TimeGenerate.generator2());
			bo.put("Flag", 1);
			bo.put("lastweight", 1);
			bo.put("Sid", UUID.randomUUID().toString());
			FormMapUtil.toADDFormMap(bo);
			sService.insertWeight(bo);

			// 插入storage或修改 t_storag_info

			StorageInfoFormMap storageinfo = new StorageInfoFormMap();
			storageinfo.put("source", formMap.get("location"));
			storageinfo.put("storageID",
					formMap.getStr("StorageID").split(",")[0]);
			storageinfo.put("cangKu", (weight_t - weight_c));
			// storageinfo.put("quanZhong", formMap.get("Breed"));
			// storageinfo.put("name", formMap.get("Property"));
			storageService.editOrAddStorage(storageinfo);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			e.printStackTrace();
		}
		return result;

	}

	@RequestMapping(value = "singleBill", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> singleBill() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String id = getPara("id");
			String id1 = getPara("id1");
			String weightComplete = "";
			Map<String, String> params = new HashMap<String, String>();
			params.put("id", id);
			params.put("id1", id1);
			params.put("flag", "1");// 查询14位流水号
			List<Map<String, String>> map = sService.singleBill(params);
			List<Map<String, Object>> list = sService.showInstorages(params);

			Map rs = sService.weightingcount(params);
			if (rs == null || rs.get("COUNT") == null
					|| (int) Float.parseFloat(rs.get("COUNT").toString()) == 0) {
				weightComplete = "1";
			} else if ((int) Float.parseFloat(rs.get("COUNT").toString()) == 1) {
				weightComplete = "2";
			}
			int validate = sService.validation(params);

			result.put("success", false);
			result.put("map", map);
			result.put("list", list);
			if (validate == 1 && weightComplete.equals("1")) {// 存在该流水单号
																// 并且称重流程未结束
				result.put("success", true);
			} else if (validate == 1 && weightComplete.equals("2")) {// 已结束
				result.put("complete", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return result;
	}

	@RequestMapping(value = "totalBill", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> totalBill() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<Map> list = sService.totalBill();
			result.put("list", list);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return result;

	}

	@RequestMapping(value = "billList", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> billList() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String id1 = getPara("id1");
			Map<String, String> params = new HashMap<String, String>();
			params.put("id1", id1);
			List<Map<String, String>> map = sService.singleBill(params);
			result.put("map", map);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return result;

	}

	@RequestMapping(value = "billList_Page", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<Map<String, String>> billList_Page(int page, int rows) {
		List<Map<String, String>> map = new ArrayList<Map<String, String>>();
		try {
			String id1 = getPara("id1");
			Map<String, String> params = new HashMap<String, String>();
			params.put("id1", id1);
			map = sService.billList_Page(page, rows, params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return toMyPage(map);

	}

	@RequestMapping(value = "setPayWay", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> setPayWay() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			String payway = getPara("wayid");
			map.put("payway", payway);
			map.put("basicid", getPara("id"));
			// map.put("jsy",
			// ServletActionContext.getRequest().getSession().getAttribute("username").toString());

			StorageFormMap formMap = new StorageFormMap();
			formMap.putAll(map);
			formMap.put("State", 3);
			formMap.put("PayTime", TimeGenerate.generator2());
			FormMapUtil.toUPDATEFormMap(formMap);
			int rs = sService.updateInstorage(formMap);
			if (payway != null && payway.equals("2")) {
				map.put("bankName", getPara("bankName"));
				map.put("carid", getPara("bankid"));
				map.put("id", getPara("order"));
				int rs1 = sService.addPayWay(map);
			}
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return result;

	}

	@RequestMapping(value = "saveDiBangData")
	@ResponseBody
	public String saveDiBangData() {
		try {
			Map<String, String> params = new HashMap<String, String>();
			params.put("location", getPara("location"));
			params.put("number", new String(getPara("num")
					.getBytes("ISO8859-1"), "UTF-8"));

			params.put("_value", getPara("para"));

			List<Map> map = sService.applySettings(params);
			if (map == null || map.isEmpty()) {
				sService.saveDiBangData(params);
			} else {
				sService.updateDiBangData(params);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@RequestMapping(value = "applySettings", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> applySettings() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Map<String, String> param = new HashMap<String, String>();
			param.put("code", getPara("code"));
			// param.put("number",new String(
			// getPara("num").getBytes("ISO8859-1"),"UTF-8"));
			List<Map> rs = sService.applySettings(param);
			result.put("rs", rs);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "allSettings", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> allSettings() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<Map> rs = sService.allSettings(null);
			result.put("rs", rs);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "instanceAmount", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> instanceAmount() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<Map> rs = sService.instanceAmount(null);
			List<Map> rs1 = sService.splineData(null);
			result.put("rs", rs);
			result.put("rs1", rs1);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "instanceHouseAmount", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> instanceHouseAmount() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Map<String, String> param = new HashMap<String, String>();
			param.put("location", getPara("location"));
			List<Map> rs = sService.instanceHouseAmount(param);
			result.put("rs", rs);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "totalDetail", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> totalDetail() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Map<String, String> param = new HashMap<String, String>();
			param.put("id", getPara("id"));

			List<Map> rs = sService.totalDetail(param);

			List<Map<String, String>> rs1 = sService.singleBill(param);

			result.put("msg", rs);
			result.put("msg1", rs1);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "splineData", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> splineData() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<Map> rs = sService.splineData(null);
			result.put("rs1", rs);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "insertCars")
	@ResponseBody
	public String insertCars() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			AvailableCarsFormMap formMap = getFormMap(AvailableCarsFormMap.class);
			FormMapUtil.toADDFormMap(formMap);
			int rs = sService.addOneCar(formMap);
			result.put("success", true);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return SUCCESS;
	}

	@RequestMapping(value = "deleteCars")
	@ResponseBody
	public String deleteCars() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			int rs = sService.deleteOneCar(getPara("id"));
			result.put("success", true);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return SUCCESS;
	}

	@RequestMapping(value = "removeInstorage")
	@ResponseBody
	public String removeInstorage() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			int rs = sService.removeInstorage(getPara("id"));
			result.put("success", true);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return SUCCESS;
	}

	@RequestMapping(value = "weighting", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> weighting() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String id = getPara("id");// 流水号
			String weight = getPara("weight"); // 重量
			String carid = getPara("carid");//
			String ifchecked = getPara("ifchecked");//
			String way = "", order = "", allow = "", inorout = "1";
			Map<String, String> param = new HashMap<String, String>();
			param.put("flag", "1");
			param.put("_key", "2");
			param.put("id", id);
			List<Map> rs = sService.applySettings(param);
			List<Map<String, Object>> ins = sService.showInstorages(param);

			if (ins != null && !ins.isEmpty()) {
				inorout = ins.get(0).get("inorout").toString();
			}
			if (inorout.equals("0")) {
				weight = "-" + weight;
			}
			if (rs != null && !rs.isEmpty()) {
				JSONObject js = JSONObject.fromObject((String) rs.get(0).get(
						"parameterValue"));
				way = (String) js.get("way");
				order = (String) js.get("order");
				allow = (String) js.get("allow");
			}
			if (/* way != null */true) { // 按流程称重
				if (/* order.equals("2") */true) { // 先皮后毛
					List<WeightingFormMap> ls = sService.weightingList(id);
					if (ls.isEmpty()) {
						WeightingFormMap bo = new WeightingFormMap();
						bo.put("Sid", UUID.randomUUID().toString());
						bo.put("CarID", carid);
						bo.put("id", id);
						bo.put("Flag", 0);
						bo.put("CarWeight", weight);
						bo.put("CarWeightingTime", TimeGenerate.generator2());
						FormMapUtil.toADDFormMap(bo);
						sService.insertWeight(bo);
					} else {
						WeightingFormMap bo = ls.get(0);
						bo.put("id", id);
						bo.put("flag", 1);
						bo.put("TotalWeight", weight);
						bo.put("TotalWeightingTime", TimeGenerate.generator2());
						// 最后一次称重
						if (ifchecked != null && ifchecked.equals("true")) {
							Map<String, String> params = new HashMap<String, String>();
							params.put("id", id);
							params.put("inuse", id);
							bo.put("lastweight", 1);
							FormMapUtil.toUPDATEFormMap(bo);
							sService.updateWeight(bo);
							Map para = new HashMap<String, String>();
							para.put("id", id);
							Map rs1 = sService.carcount(id);
							Map rs2 = sService.weightingcount(para);
							if (Integer.parseInt(rs1.get("COUNT").toString()) == (int) Float
									.parseFloat(rs2.get("COUNT").toString())) {
								// 所有车辆最后一次称重,流水单进入结算业务
								sService.updateInstorage(params);
								sService.resetCarStatus(params);
								result.put("last", true);
							}

						} else {
							FormMapUtil.toUPDATEFormMap(bo);
							sService.updateWeight(bo);
						}
					}

				}

			}/*
			 * else if(way!=null&&way.equals("1")){//只称重一次
			 * 
			 * }
			 */

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Token(remove = true)
	@RequestMapping(value = "addWeight")
	@ResponseBody
	public String addWeight() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			WeightingFormMap formMap = getFormMap(WeightingFormMap.class);
			StorageInfoFormMap storageinfo = new StorageInfoFormMap();
			storageinfo.put("id", formMap.get("id"));
			storageinfo.put("cangKu",
					Double.parseDouble(formMap.getStr("TotalWeight")));
			storageService.editOrAddStorageByliushui(storageinfo);

			formMap.put("CarID", "");
			formMap.put("CarWeight", "0.00");
			formMap.put("TotalWeightingTime", TimeGenerate.generator2());
			formMap.put("CarWeightingTime", TimeGenerate.generator2());
			formMap.put("lastweight", 0);
			formMap.put("Sid", UUID.randomUUID().toString());
			formMap.put("SBY", 1);

			FormMapUtil.toADDFormMap(formMap);
			int rs = sService.insertWeight(formMap);

			result.put("success", true);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return SUCCESS;
	}

	@Token(remove = true)
	@RequestMapping(value = "editWeight")
	@ResponseBody
	public String editWeight() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			WeightingFormMap formMap = getFormMap(WeightingFormMap.class);

			// if (formMap.get("in") != null && formMap.get("in").equals("0")) {
			// formMap.put("TotalWeight",
			// Float.parseFloat(formMap.get("TotalWeight").toString())
			// * -1);
			//
			// formMap.put("CarWeight",
			// Float.parseFloat(formMap.get("CarWeight").toString())
			// * -1);
			//
			// }
			StorageInfoFormMap storageinfo = new StorageInfoFormMap();
			storageinfo
					.put("cangKu",
							(Float.parseFloat(formMap.get("TotalWeight")
									.toString()) - Float.parseFloat(formMap
									.get("CarWeight").toString()))
									- (Float.parseFloat(formMap.get(
											"wTotalWeight").toString()) - Float
											.parseFloat(formMap.get(
													"wCarWeight").toString())));
			storageinfo.put("basicid", formMap.get("basicid"));
			storageService.editOrAddStorageByBasicid(storageinfo);
			formMap.remove("wTotalWeight");
			formMap.remove("wCarWeight");
			formMap.remove("in");
			formMap.put("late", 1);
			FormMapUtil.toUPDATEFormMap(formMap);
			int rs = sService.updateWeight(formMap);
			result.put("success", true);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return SUCCESS;
	}
}
