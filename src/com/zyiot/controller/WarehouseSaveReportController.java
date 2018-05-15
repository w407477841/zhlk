package com.zyiot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.entity.WarehouseSaveReportFormMap;
import com.zyiot.server.WarehouseSaveReportI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;

@RequestMapping("warehouseSaveReport")
@Controller
public class WarehouseSaveReportController extends BaseController {
	@Autowired
	WarehouseSaveReportI warehouseSaveReport;

	@RequestMapping("addUI")
	public String addUI() {

		return Common.BACKGROUND_PATH + "/report/add";
	}

	@RequestMapping("add")
	@ResponseBody
	public String add() {

		WarehouseSaveReportFormMap w = getFormMap(WarehouseSaveReportFormMap.class);
		try {
			FormMapUtil.toADDFormMap(w);
		} catch (Exception e) {
			return ERROR;
		}

		try {
			warehouseSaveReport.add(w);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

}
