package com.zyiot.controller.cangkuzhinenghuaxitong;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterConfigFormMap;
import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterDataFormMap;
import com.zyiot.server.cangkuzhinenghuaxitong.AmmeterDataServerI;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("cangkuzhinenghuaxitong/ammeterData")
public class AmmeterDataController extends BaseController {
	@Autowired
	AmmeterDataServerI ammeterDataServer;
	Logger logger = Logger.getLogger(AmmeterDataController.class);

	@RequestMapping(value = "listUI", method = RequestMethod.POST)
	public String ammeterDataListUI() {
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterdata/list";
	}

	@RequestMapping(value = "findByPage")
	@ResponseBody
	public MyPage<?> findByPage(int page, int rows) {
		AmmeterDataFormMap ammeterDataFormMap = getFormMap(AmmeterDataFormMap.class);
		return toMyPage(ammeterDataServer.findAmmeterDataByPage(
				ammeterDataFormMap, rows, page));
	}

	@RequestMapping(value = "addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterdata/add";
	}

	@RequestMapping(value = "editUI")
	public String editUI(Model model) {
		AmmeterDataFormMap u = new AmmeterDataFormMap();
		u.put("id", getPara("id"));
		List<AmmeterDataFormMap> list = ammeterDataServer
				.findAmmeterDataByPage(u, 1, 1);
		if (list != null && list.size() > 0) {
			model.addAttribute("ammeterDataFormMap", list.get(0));
		}
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterdata/edit";
	}

	@RequestMapping(value = "add")
	@ResponseBody
	public String add() {

		AmmeterDataFormMap ammeterDataFormMap = getFormMap(AmmeterDataFormMap.class);
		UUID id = UUID.randomUUID();
		ammeterDataFormMap.put("id", id.toString().replace("-", ""));
		try {
			FormMapUtil.toADDFormMap(ammeterDataFormMap);
			ammeterDataServer.add(ammeterDataFormMap);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping(value = "edit")
	@ResponseBody
	public String edit() {
		AmmeterDataFormMap ammeterDataFormMap = getFormMap(AmmeterDataFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(ammeterDataFormMap);
			ammeterDataServer.edit(ammeterDataFormMap);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return ERROR;
		}
		return SUCCESS;
	}

	@RequestMapping(value = "deleteOne")
	@ResponseBody
	public String deleteOne() {
		try {
			ammeterDataServer.delete(getPara("id"));
		} catch (Exception e) {
			logger.error(e.getMessage());
			return ERROR;
		}
		return SUCCESS;
	}

	/*
	 * 手动抄表
	 */
	@RequestMapping(value = "manualOperation")
	@ResponseBody
	public String manualOperation() {

		String time = DateUtils.dateFormatToLong(new Date());
		List<AmmeterConfigFormMap> ammeters = ammeterDataServer.findAmmeters();

		List<AmmeterDataFormMap> datas = new ArrayList<>();
		for (AmmeterConfigFormMap ammeter : ammeters) {
			String reading = new AmmeterConfigController().readAmmeterTcp(ammeter);
			AmmeterDataFormMap data = new AmmeterDataFormMap();
			data.put("id", UUID.randomUUID().toString().replace("-", ""));
			data.put("ammeter", ammeter.get("id") + "");
			data.put("reading",
					reading.equals("error") ? ammeter.get("reading") : reading);
			data.put("isError", reading.equals("error") ? 1 : 0);
			data.put("type", 1);
			data.put("acquisitionTime", time);

			datas.add(data);
		}

		try {
			ammeterDataServer.batchSave(datas);
		} catch (Exception e) {
			logger.error("批量保存失败");

		}

		return "success";
	}

	@RequestMapping(value = "manualOperationUI")
	public String manualOperationUI() {
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterdata/manualOperation";
	}

	@RequestMapping(value = "energyTendencyUI")
	public String energyTendencyUI() {
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterdata/energyTendency";
	}

	@RequestMapping(value = "findEnergy")
	@ResponseBody
	public AmmeterDataFormMap findEnergy() {
		AmmeterDataFormMap u = new AmmeterDataFormMap();
		String time1 = getPara("time1");
		String time2 = getPara("time2");
		Date now = new Date();
		if (time2 == null || time2.equals("")) {
			time2 = DateUtils.dateFormatToShort(now);
			System.out.println(time2);
		}
		if (time1 == null || time1.equals("")) {
			Date nowBefore30 = DateUtils.dateBefore(DateUtils.parseDate(time2),
					30, Calendar.DATE);
			time1 = DateUtils.dateFormatToShort(nowBefore30);
			System.out.println(time1);
		}
		u.put("time1", time1);
		u.put("time2", time2);

		return ammeterDataServer.findEnergy(u, 0);
	}

	@RequestMapping(value = "findEnergyMon")
	@ResponseBody
	public AmmeterDataFormMap findEnergyMon() {
		AmmeterDataFormMap u = new AmmeterDataFormMap();
		String time1 = getPara("time1");
		String time2 = getPara("time2");
		Date now = new Date();
		if (time2 == null || time2.equals("")) {
			time2 = DateUtils.dateFormatToShort(now);
			System.out.println(time2);
		}
		if (time1 == null || time1.equals("")) {
			Date nowBefore30 = DateUtils.date(DateUtils.getYear(new Date()), 1,
					1); // 今年 1月1号
			time1 = DateUtils.dateFormatToShort(nowBefore30);
		}
		u.put("time1", time1);
		u.put("time2", time2);

		return ammeterDataServer.findEnergy(u, 1);
	}

	@RequestMapping(value = "findEnergyQua")
	@ResponseBody
	public AmmeterDataFormMap findEnergyQua() {
		AmmeterDataFormMap u = new AmmeterDataFormMap();
		String time1 = getPara("time1");
		String time2 = getPara("time2");
		Date now = new Date();
		if (time2 == null || time2.equals("")) {
			time2 = DateUtils.dateFormatToShort(now);
			System.out.println(time2);
		}
		if (time1 == null || time1.equals("")) {
			Date nowBefore30 = DateUtils.date(DateUtils.getYear(new Date()), 1,
					1); // 今年 1月1号
			time1 = DateUtils.dateFormatToShort(nowBefore30);
		}
		u.put("time1", time1);
		u.put("time2", time2);

		return ammeterDataServer.findEnergy(u, 2);
	}

	@RequestMapping(value = "findDayList")
	@ResponseBody
	public List<AmmeterDataFormMap> findDayList() {
		AmmeterDataFormMap u = new AmmeterDataFormMap();
		String time1 = getPara("time1");
		String time2 = getPara("time2");
		Date now = new Date();
		if (time2 == null || time2.equals("")) {
			time2 = DateUtils.dateFormatToShort(now);
			System.out.println(time2);
		}
		if (time1 == null || time1.equals("")) {
			Date nowBefore30 = DateUtils.dateBefore(DateUtils.parseDate(time2),
					30, Calendar.DATE);
			time1 = DateUtils.dateFormatToShort(nowBefore30);
			System.out.println(time1);
		}
		u.put("time1", time1);
		u.put("time2", time2);

		return ammeterDataServer.findEnergyList(u, 0);
	}

	@RequestMapping(value = "findMonList")
	@ResponseBody
	public List<AmmeterDataFormMap> findMonList() {
		AmmeterDataFormMap u = new AmmeterDataFormMap();
		String time1 = getPara("time1");
		String time2 = getPara("time2");
		Date now = new Date();
		if (time2 == null || time2.equals("")) {
			time2 = DateUtils.dateFormatToShort(now);
			System.out.println(time2);
		}
		if (time1 == null || time1.equals("")) {
			Date nowBefore30 = DateUtils.date(DateUtils.getYear(new Date()), 1,
					1); // 今年 1月1号
			time1 = DateUtils.dateFormatToShort(nowBefore30);
		}
		u.put("time1", time1);
		u.put("time2", time2);

		return ammeterDataServer.findEnergyList(u, 1);
	}

	@RequestMapping(value = "findCurrentReading")
	@ResponseBody
	public List<AmmeterDataFormMap> findCurrentReading() {
		AmmeterDataFormMap u = new AmmeterDataFormMap();

		return ammeterDataServer.findCurrentReading(u);
	}

	@RequestMapping(value = "findQuaList")
	@ResponseBody
	public List<AmmeterDataFormMap> findQuaList() {
		AmmeterDataFormMap u = new AmmeterDataFormMap();
		String time1 = getPara("time1");
		String time2 = getPara("time2");
		Date now = new Date();
		if (time2 == null || time2.equals("")) {
			time2 = DateUtils.dateFormatToShort(now);
			// System.out.println(time2);
		}
		if (time1 == null || time1.equals("")) {

			Date nowBefore30 = DateUtils.date(DateUtils.getYear(new Date()), 1,
					1); // 今年 1月1号
			time1 = DateUtils.dateFormatToShort(nowBefore30);
			// System.out.println(time1);
		}
		u.put("time1", time1);
		u.put("time2", time2);

		return ammeterDataServer.findEnergyList(u, 2);
	}

	@RequestMapping(value = "findDayListUI")
	public String findDayListUI() {

		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterdata/findDayList";
	}

	@RequestMapping(value = "findMonListUI")
	public String findMonListUI() {

		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterdata/findMonList";
	}

	@RequestMapping(value = "findQuaListUI")
	public String findQuaListUI() {

		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/ammeterdata/findQuaList";
	}

}
