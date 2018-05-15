package com.zyiot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.server.ShiPinDianWeiServerI;
import com.zyiot.server.StorageServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("kcxx")
public class StorageInfoController extends BaseController {
	@Autowired
	private StorageServiceI storageService;
	@Autowired
	ShiPinDianWeiServerI shiPinDianWeiServer;

	@RequestMapping("kcxx")
	public String kcxx() {
		return Common.BACKGROUND_PATH + "/liangku/storageInfo";
	}

	@RequestMapping("detail")
	public String detail() {
		try {
			return Common.BACKGROUND_PATH + "/liangku/detail";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping(value = "queryData", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<StorageInfoFormMap> queryData(int page, int rows, HttpServletRequest request) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("source", getPara("source"));
		List<StorageInfoFormMap> list = storageService.classifyByNo(params,
				rows, page);
		return toMyPage(list);

	}

	@RequestMapping(value = "queryDetail", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<?> queryDetail(int page, int rows) {
		// Map<String,Object> result=new HashMap<String, Object>();
		Map<String, String> params = new HashMap<String, String>();
		params.put("timestart", getPara("timestart"));
		params.put("timeend", getPara("timeend"));
		params.put("library_sel", getPara("library_sel"));
		try {
			List<?> ls = storageService.queryLibraryInfo(params, page, rows);
			return toMyPage(ls);
		} catch (Exception e) {
			// result.put("success", false);
			e.printStackTrace();
			return null;
		}

	}

	@RequestMapping(value = "queryChart", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> queryChart() {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> params = new HashMap<String, String>();
		try {
			params.put("source", getPara("source"));
			List<StorageInfoFormMap> _map0 = storageService
					.classifyBykudian(params);
			List<StorageInfoFormMap> _map1 = storageService
					.classifyByquan(params);
			result.put("map0", _map0);
			result.put("map1", _map1);
			result.put("success", true);
			return result;
		} catch (Exception e) {
			// result.put("success", false);
			//e.printStackTrace();
			return null;
		}

	}

	@RequestMapping(value = "locations", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map findLocation() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<StorageInfoFormMap> locations = storageService.findLocation();
			result.put("list", locations);
			result.put("success", true);
			return result;
		} catch (Exception e) {
			result.put("success", false);
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(value = "contrastStation", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map findContrastStation() {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			params.put("location", getPara("location"));
			List<Map> locations = storageService.findContrastStation(params);
			result.put("list", locations);
			result.put("success", true);
			return result;
		} catch (Exception e) {
			result.put("success", false);
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(value = "contrastLocation", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map findContrastLocation() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<Map> locations = storageService.findContrastLocation();
			result.put("list", locations);
			result.put("success", true);
			return result;
		} catch (Exception e) {
			result.put("success", false);
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(value = "breeds", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map findBreeds() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<StorageInfoFormMap> locations = storageService.findBreeds();
			result.put("list", locations);
			result.put("success", true);
			return result;
		} catch (Exception e) {
			result.put("success", false);
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(value = "properties", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map findProperties() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<StorageInfoFormMap> locations = storageService.findProperties();
			result.put("list", locations);
			result.put("success", true);
			return result;
		} catch (Exception e) {
			result.put("success", false);
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(value = "weights", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map findWeights() {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			params.put("location", getPara("location"));
			params.put("houseid", getPara("houseid").split(",")[0]);
			
			Map locations = storageService.instancWeight(params);
			result.put("reslut", locations);
			result.put("success", true);
			return result;
		} catch (Exception e) {
			result.put("success", false);
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 根据仓号获取粮食品种、性质、包装方式、收获年度
	 * @author Lip
	 * @return
	 */
	
	@RequestMapping(value = "findVAndPByWId", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public StorageInfoFormMap findVarietyAndPropertyByWarehouseId(){
		String id = getPara("id");
		StorageInfoFormMap storage = storageService.findVarietyAndPropertyByWarehouseId(Integer.parseInt(id));
		if(storage ==  null){
			storage = new StorageInfoFormMap();
		}
		return storage;
	}
}
