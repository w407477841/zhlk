package com.zyiot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.entity.ChuanGanQiBaoJingFormMap;
import com.zyiot.entity.ChuanGanQiDataFormMap;
import com.zyiot.entity.ChuanGanQiFormMap;
import com.zyiot.server.ChuanGanQiDataServerI;
import com.zyiot.server.ChuanGanQiServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMap;
import com.zyiot.util.MyPage;
import com.zyiot.util.PropertiesUtils;

@Controller
@RequestMapping("sensorManager")
public class ChuanGanQiController extends BaseController {
	Logger log = Logger.getLogger(ChuanGanQiController.class);
	@Autowired
	private ChuanGanQiServerI sensorServer;
	@Autowired
	private ChuanGanQiDataServerI chuanGanQiDataServer;

	@RequestMapping("listUI")
	public String sensorManagerHome() {
		return Common.BACKGROUND_PATH + "/system/sensor/list";
	}

	@Token(save = true)
	@RequestMapping("add")
	public String addPage() {
		return Common.BACKGROUND_PATH + "/system/sensor/add";
	}

	@Token(save = true)
	@RequestMapping("editUI")
	public String edit(Model model) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", getPara("id"));
		model.addAttribute("ChuanGanQiFormMap",
				sensorServer.querySensorByID(param));

		return Common.BACKGROUND_PATH + "/system/sensor/edit";
	}

	@RequestMapping(value = "querySensorList", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<ChuanGanQiFormMap> querySensorList(int page, int rows, HttpServletRequest request) {
		List<ChuanGanQiFormMap> list = sensorServer.querySensorList(rows,
				page);
		return toMyPage(list);
	}

	@Token(remove = true)
	@RequestMapping(value = "addSensor")
	@ResponseBody
	public String addSensor() {
		try {
			ChuanGanQiFormMap formMap = getFormMap(ChuanGanQiFormMap.class);
			sensorServer.addSensor(formMap);
		} catch (Exception e) {
			log.error("===Class:ChuanGanQiController==Method:addSensor==Exception"+e);
			return ERROR;
		}
		return SUCCESS;
	}

	@Token(remove = true)
	@RequestMapping("edit")
	@ResponseBody
	public String updateSensor() {
		try {
			ChuanGanQiFormMap formMap = getFormMap(ChuanGanQiFormMap.class);
			sensorServer.updateSensor(formMap);
		} catch (Exception e) {
			log.error("===Class:ChuanGanQiController==Method:updateSensor==Exception"+e);
			return ERROR;
		}
		return SUCCESS;

	}

	@RequestMapping("deleteOne")
	@ResponseBody
	public String deleteOne() {

		try {
			sensorServer.deleteOne(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:ChuanGanQiController==Method:deleteOne==Exception"+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("queryHouse")
	@ResponseBody
	public Map<String, Object> queryHouse() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Map<String, String> params = new HashMap<String, String>();
			params.put("location", getPara("location"));
			List<ChuanGanQiFormMap> ls = sensorServer.queryHouse(params);
			result.put("rs", ls);
			result.put("success", true);
		} catch (Exception e) {
			log.error("===Class:ChuanGanQiController==Method:queryHouse==Exception"+e);
			result.put("success", false);
		}
		return result;
	}
	@RequestMapping("findByHouseSelect")
	@ResponseBody
	public List<ChuanGanQiFormMap> findByHouseSelect() {
		Map<String, String> params = new HashMap<String, String>();
		params.put("location", getPara("location"));
		List<ChuanGanQiFormMap> ls = sensorServer.queryHouse(params);
		return ls;
	}

	@RequestMapping(value = "getCurrentDatas", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<ChuanGanQiDataFormMap> getCurrentDatas(int page, int rows) {
		ChuanGanQiFormMap chuanGanQiFormMap = new ChuanGanQiFormMap();
		String cjsj = chuanGanQiDataServer.getMaxCjsj();
		chuanGanQiFormMap.put("cjsj", cjsj);
		List<ChuanGanQiDataFormMap> list = chuanGanQiDataServer.getDatas(chuanGanQiFormMap,page, rows);
		return toMyPage(list);
	}

	@RequestMapping(value = "getCurrentBaoJing", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<ChuanGanQiBaoJingFormMap> getCurrentBaoJing(int page, int rows) {
		List<ChuanGanQiBaoJingFormMap> list = chuanGanQiDataServer
				.getBaojing(page, rows);
		return toMyPage(list);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("updLiuhuaqing")
	@ResponseBody
	public String updLiuhuaqing(HttpServletRequest request) {

		String lhq = getPara("lhq");

		PropertiesUtils.modifyByName("qitibaojing", "cwlhq", lhq);
		ServletContext sc = request.getServletContext();
		FormMap<String, Object> f = (FormMap<String, Object>) sc
				.getAttribute("prop");
		f.put("cwlhq", lhq);
		sc.setAttribute("prop", f);

		return SUCCESS;
	}

	@RequestMapping("updqiti")
	@ResponseBody
	public String updqiti(HttpServletRequest request) {

		String lhq = getPara("lhq");
		String yq = getPara("yq");
		String eyht = getPara("eyht");
		PropertiesUtils.modifyByName("qitibaojing", "lhq", lhq);
		PropertiesUtils.modifyByName("qitibaojing", "yq", yq);
		PropertiesUtils.modifyByName("qitibaojing", "eyht", eyht);
		return SUCCESS;
	}
	@RequestMapping("updateExec")
	@ResponseBody
	public String updateExec(HttpServletRequest request) {
		String execSpace = getPara("execSpace");
		PropertiesUtils.modifyByName("qitibaojing", "execSpace", execSpace);
		return SUCCESS;
	}
}
