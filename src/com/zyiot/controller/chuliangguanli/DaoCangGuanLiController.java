package com.zyiot.controller.chuliangguanli;

import java.sql.Timestamp;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.cunchuguanli.DaoCangGuanLiFormMap;
import com.zyiot.server.cunchuguanli.DaoCangGuanLiServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("daocangguanli")
public class DaoCangGuanLiController extends BaseController {
	Logger log = Logger.getLogger(DaoCangGuanLiController.class);
	@Autowired
	private DaoCangGuanLiServerI daoCangGuanLiServer;

	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/cangkuguanli/daocangguanlilist";
	}
 
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<DaoCangGuanLiFormMap> findByPage(int page, int rows) {
		DaoCangGuanLiFormMap daoCangGuanLiFormMap = getFormMap(DaoCangGuanLiFormMap.class);
		List<DaoCangGuanLiFormMap> list = daoCangGuanLiServer.findByPage(
				daoCangGuanLiFormMap, page, rows);
		if (list != null && list.size() > 0) {
			for (DaoCangGuanLiFormMap cf : list) {
				cf.set("wgtTransferDate", DateUtils.dateFormatToShort(cf
						.getDate("wgtTransferDate")));
			}
		}
		return toMyPage(list);
	}

	@RequestMapping("addUI")
	@Token(save = true)
	public String addUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/cangkuguanli/daocangguanliadd";
	}

	@RequestMapping("add")
	@ResponseBody
	@Token(remove = true)
	public String add() {
		DaoCangGuanLiFormMap daoCangGuanLiFormMap = getFormMap(DaoCangGuanLiFormMap.class);
		if (!validData(daoCangGuanLiFormMap)) {
			return ERROR;
		}

		try {
			FormMapUtil.toADDFormMap(daoCangGuanLiFormMap);
		} catch (Exception e) {
			log.error("===Class:DaoCangGuanLiController===Method:toADDFormMap==="
					+ e);
			return ERROR;
		}

		try {

			Session session = SecurityUtils.getSubject().getSession();
			daoCangGuanLiFormMap.set("wgtDataOperator",
					session.getAttribute("userSessionId"));
			daoCangGuanLiFormMap.set("wgtAddDate",
					new Timestamp(System.currentTimeMillis()));
			daoCangGuanLiServer.addDaoCangGuanLi(daoCangGuanLiFormMap);
		} catch (Exception e) {
			log.error("===Class:DaoCangGuanLiController===Method:addDaoCangGuanLi==="
					+ e);
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("lookUI")
	public String lookUI(Model model) {

		try {
			DaoCangGuanLiFormMap daoCangGuanLiFormMap = daoCangGuanLiServer
					.findDaoCangGuanLiById(Integer.parseInt(getPara("id")));
			daoCangGuanLiFormMap.set("wgtTransferDate", DateUtils
					.dateFormatToShort(daoCangGuanLiFormMap
							.getDate("wgtTransferDate")));
			daoCangGuanLiFormMap.set("wgtAddDate", DateUtils
					.dateFormatToShort(daoCangGuanLiFormMap
							.getDate("wgtAddDate")));
			model.addAttribute("daoCangGuanLiFormMap", daoCangGuanLiFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:DaoCangGuanLiController===Method:Integer.parseInt==="
					+ e);
		} catch (Exception e) {
			log.error("===Class:DaoCangGuanLiController===Method:findDaoCangGuanLiById==="
					+ e);
		}

		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/cangkuguanli/daocangguanlilook";
	}

	@RequestMapping("shibiemaUI")
	public String shibiemaUI(Model model) {

		try {
			DaoCangGuanLiFormMap daoCangGuanLiFormMap = daoCangGuanLiServer
					.findDaoCangGuanLiById(Integer.parseInt(getPara("id")));
			daoCangGuanLiFormMap.set("wgtTransferDate", DateUtils
					.dateFormatToShort(daoCangGuanLiFormMap
							.getDate("wgtTransferDate")));
			daoCangGuanLiFormMap.set("wgtAddDate", DateUtils
					.dateFormatToShort(daoCangGuanLiFormMap
							.getDate("wgtAddDate")));
			model.addAttribute("daoCangGuanLiFormMap", daoCangGuanLiFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:DaoCangGuanLiController===Method:Integer.parseInt==="
					+ e);
		} catch (Exception e) {
			log.error("===Class:DaoCangGuanLiController===Method:findDaoCangGuanLiById==="
					+ e);
		}

		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/shibiedaima/daocangxinxidengjishibiema";
	}

	@RequestMapping(value = "findByWarehouseId", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public DaoCangGuanLiFormMap findDaoCangGuanLiByWarehouseId() {
		try {
			return daoCangGuanLiServer.findDaoCangGuanLiByWarehouseId(Integer
					.parseInt(getPara("id")));
		} catch (NumberFormatException e) {
			log.error("===Class:DaoCangGuanLiController===Method:Integer.parseInt==="
					+ e);
		} catch (Exception e) {
			log.error("===Class:DaoCangGuanLiController===Method:findDaoCangGuanLiByWarehouseId==="
					+ e);
		}

		return null;
	}

	/**
	 * 数据验证，确保数据符合要求
	 * 
	 * @param formMap
	 *            要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap) {
		String wgtOriginalVariety = formMap.getStr("wgtOriginalVariety");
		String wgtTargetVariety = formMap.getStr("wgtTargetVariety");
		String wgtOriginalCategory = formMap.getStr("wgtOriginalCategory");
		String wgtTargetCategory = formMap.getStr("wgtTargetCategory");
		String wgtBill = formMap.getStr("wgtBill");
		String wgtTransferDate = formMap.getStr("wgtTransferDate");
		String wgtCause = formMap.getStr("wgtCause");
		String wgtNumber = formMap.getStr("wgtNumber");

		if (ValidateUtil.isEmpty(wgtOriginalVariety)
				|| !ValidateUtil.isLength(wgtOriginalVariety, Constant.INT_32)) {
			return false;
		}
		if (ValidateUtil.isEmpty(wgtTargetVariety)
				|| !ValidateUtil.isLength(wgtTargetVariety, Constant.INT_32)) {
			return false;
		}
		if (ValidateUtil.isEmpty(wgtOriginalCategory)
				|| !ValidateUtil.isLength(wgtOriginalCategory, Constant.INT_32)) {
			return false;
		}
		if (ValidateUtil.isEmpty(wgtTargetCategory)
				|| !ValidateUtil.isLength(wgtTargetCategory, Constant.INT_32)) {
			return false;
		}
		if (!wgtOriginalVariety.equals(wgtTargetVariety)) {
			return false;
		}
		if (!wgtOriginalCategory.equals(wgtTargetCategory)) {
			return false;
		}
		if (ValidateUtil.isEmpty(wgtBill)
				|| !ValidateUtil.isLength(wgtBill, Constant.INT_64)) {
			return false;
		}
		if (!ValidateUtil.isShortDate(wgtTransferDate)) {
			return false;
		}
		if (!ValidateUtil.isLength(wgtCause, Constant.INT_32)) {
			return false;
		}
		if (!ValidateUtil.isFloat(wgtNumber)) {
			return false;
		}

		return true;
	}
}
