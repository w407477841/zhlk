package com.zyiot.controller.weight;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

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
import com.zyiot.entity.UserFormMap;
import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.entity.weight.WeighingFormMap;
import com.zyiot.entity.weight.WeighingSpeckConfigFormMap;
import com.zyiot.entity.weight.WeighingVideoConfigFormMap;
import com.zyiot.server.weight.ReportHarborServerI;
import com.zyiot.server.weight.WeighingServerI;
import com.zyiot.server.weight.WeighingSpeckConfigServerI;
import com.zyiot.server.weight.WeighingVideoConfigServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.JsonUtils;
import com.zyiot.util.MyPage;
import com.zyiot.util.PropertiesUtils;
import com.zyiot.util.ValidateUtil;

/**
 * 称重信息
 * 
 * @author Lip
 * @date 2017年5月5日 下午4:12:06
 */
@Controller
@RequestMapping("weighing")
public class WeighingController extends BaseController {
	Logger log = Logger.getLogger(WeighingController.class);

	@Autowired
	private WeighingVideoConfigServerI weighingVideoConfigServer;
	@Autowired
	private WeighingServerI weighingServer;
	@Autowired
	public ReportHarborServerI reportHarborServer;
	@Autowired
	public WeighingSpeckConfigServerI weighingSpeckConfigServer;

	private String basePath;

	private ServerSocket server;

	@RequestMapping("list")
	public String weighingUI(Model model, HttpServletRequest request) {
		socket();
		basePath = request.getServletContext().getRealPath("/")
				+ "screenshot\\";
		Session session = SecurityUtils.getSubject().getSession();
		String mac = (String) session.getAttribute(Constant.MAC_ADDr);
		// 称重视频配置
		List<WeighingVideoConfigFormMap> weighingVideoConfigList = weighingVideoConfigServer
				.findWeighingVideoConfigByMAC(mac);
		if (weighingVideoConfigList == null
				|| weighingVideoConfigList.size() == 0) {
			// 轮询称重 -- 默认轮询称重
			model.addAttribute("turnWeighing", "1");
			// 凭据打印 -- 默认不逐条打印
			model.addAttribute("printType", "2");
			model.addAttribute("jsonData", "");
		} else {

			model.addAttribute("turnWeighing", weighingVideoConfigList.get(0)
					.getStr("turnWeighing"));

			model.addAttribute("printType", weighingVideoConfigList.get(0)
					.getStr("printType"));
			String jsonData = JsonUtils.listToJson(weighingVideoConfigList);
			model.addAttribute("jsonData", jsonData);
		}
		// 称重语音配置
		WeighingSpeckConfigFormMap weighingSpeckConfig = weighingSpeckConfigServer
				.findWeighingSpeckConfigByMac(mac);
		if (weighingSpeckConfig == null) {
			weighingSpeckConfig = new WeighingSpeckConfigFormMap();
			weighingSpeckConfig.set("isOpen", "2");
		}
		model.addAttribute("weighingSpeckConfig", weighingSpeckConfig);

		return Constant.BACKGROUND_PATH + "/weight/weighing/weighing";
	}

	@RequestMapping("showVideoIFrame")
	public String showVideoIFrame() {
		return Constant.BACKGROUND_PATH + "/weight/weighing/videoshow";
	}

	/**
	 * 随机称重
	 * 
	 * @return
	 */
	@RequestMapping("addWeightingweight")
	@ResponseBody
	public String addWeightingweight() {
		String bill = getPara("bill");
		String carId = getPara("usedCarText");
		String weight = getPara("weight");
		String type = getPara("type");
		String pictureNames = getPara("pictureNames");
		// 是否驳车
		String usedCarOrNot = getPara("usedCarOrNot");
		// 是否逐条打印,1，逐条打印，2：不逐条打印
		String printType = getPara("printType");
		if (usedCarOrNot.equals("1")) {// 驳车---每次称重产生一条记录
			WeighingFormMap weighingFormMap = new WeighingFormMap();

			weighingFormMap.set("bId", bill);
			weighingFormMap.set("carId", carId);
			if (type.equals("1")) { // 称毛
				weighingFormMap.set("grossWeight", weight);
				weighingFormMap.set("grossWeightDate",
						DateUtils.dateFormatToLong(new Date()));
				weighingFormMap.set("grossWeightPhoto", pictureNames);
			} else if (type.equals("2")) { // 称皮
				weighingFormMap.set("tare", weight);
				weighingFormMap.set("tarDate",
						DateUtils.dateFormatToLong(new Date()));
				weighingFormMap.set("tarPhoto", pictureNames);
			}

			Session session = SecurityUtils.getSubject().getSession();
			weighingFormMap.set("weightPerson", ((UserFormMap) session
					.getAttribute("userSession")).getStr("userName"));

			try {
				FormMapUtil.toADDFormMap(weighingFormMap);
				weighingServer.addWeighing(weighingFormMap);
			} catch (Exception e) {
				log.error("===Class:WeighingController==Method:addWeightingGrossweight===Exception:addWeighing=="
						+ e);
				return ERROR;
			}
			// 根据产生的称重信息去获取数据库中的整条信息
			// 其主要是获id
			weighingFormMap = weighingServer
					.findWeighingByWeighing(weighingFormMap);
			if (printType.equals("1")) { // 逐条打印
				return "print:" + weighingFormMap.getInt("id");
			}
		} else {// 不驳车 -- 一共产生一条数据
				// 根据单据号获取称重信息
			List<WeighingFormMap> weighingList = weighingServer
					.findWeighingByBId(bill);
			if (weighingList == null || weighingList.size() == 0) { // 未产生称重信息
				WeighingFormMap weighingFormMap = new WeighingFormMap();

				weighingFormMap.set("bId", bill);
				weighingFormMap.set("carId", carId);
				if (type.equals("1")) { // 称毛
					weighingFormMap.set("grossWeight", weight);
					weighingFormMap.set("grossWeightDate",
							DateUtils.dateFormatToLong(new Date()));
					weighingFormMap.set("grossWeightPhoto", pictureNames);
				} else if (type.equals("2")) { // 称皮
					weighingFormMap.set("tare", weight);
					weighingFormMap.set("tarDate",
							DateUtils.dateFormatToLong(new Date()));
					weighingFormMap.set("tarPhoto", pictureNames);
				}

				Session session = SecurityUtils.getSubject().getSession();
				weighingFormMap.set("weightPerson", ((UserFormMap) session
						.getAttribute("userSession")).getStr("userName"));

				try {
					FormMapUtil.toADDFormMap(weighingFormMap);
					weighingServer.addWeighing(weighingFormMap);
				} catch (Exception e) {
					log.error("===Class:WeighingController==Method:addWeightingGrossweight===Exception:addWeighing=="
							+ e);
					return ERROR;
				}
			} else {// 已产生称重信息
				WeighingFormMap weighingFormMap = weighingList.get(0);
				// int id = weighingFormMap.getInt("id");
				if (type.equals("1")) { // 称毛
					weighingFormMap
							.set("grossWeight", Float.parseFloat(weight));
					weighingFormMap.set("grossWeightDate",
							DateUtils.dateFormatToLong(new Date()));
					weighingFormMap.set("grossWeightPhoto", pictureNames);
				} else if (type.equals("2")) { // 称皮
					weighingFormMap.set("tare", Float.parseFloat(weight));
					weighingFormMap.set("tarDate",
							DateUtils.dateFormatToLong(new Date()));
					weighingFormMap.set("tarPhoto", pictureNames);
				}

				try {
					FormMapUtil.toUPDATEFormMap(weighingFormMap);
					// 未使用驳车，则表示称重完成，进行报港信息和称重信息汇总
					weighingServer.retailWeighingEnd(weighingFormMap);
				} catch (Exception e) {
					log.error("===Class:WeighingController==Method:addWeightingGrossweight===Exception:editWeighing=="
							+ e);
					return ERROR;
				}

				return "print:" + bill;
			}
		}
		return SUCCESS;
	}

	/**
	 * 轮询称重
	 * 
	 * @return
	 */
	@RequestMapping("addWeighingTurnWeight")
	@ResponseBody
	public String addWeighingTurnWeight() {
		String bill = getPara("bill");
		String carId = getPara("usedCarText");
		String weight = getPara("weight");
		String pictureNames = getPara("pictureNames");

		// 是否逐条打印,1，逐条打印，2：不逐条打印
		String printType = getPara("printType");
		if (Common.isEmpty(bill)) {
			return ERROR;
		} else {
			// 根据单据号获取报港信息
			ReportHarborFormMap reportHarborFormMap = reportHarborServer
					.findReportHarborByBId(bill);
			if (reportHarborFormMap == null) {// 报港信息为null ，直接返回操作失败
				return ERROR;
			} else {
				// 出库还是入库，1:出库，2:入库
				String inOrOut = reportHarborFormMap.getStr("inOrOut");
				// 是否驳车
				String usedCarOrNot = reportHarborFormMap.getStr("usedCar");
				// 根据单据号和车牌号获取最后一条称重信息
				WeighingFormMap weighingFormMap = weighingServer
						.findLastWeighingByBIdAndCarId(bill, carId);
				if (weighingFormMap == null) { // 无称重信息，插入称重信息
					weighingFormMap = new WeighingFormMap();
					if (inOrOut.equals("1")) { // 出库，先称皮重，后称毛重
						weighingFormMap.set("tare", weight);
						weighingFormMap.set("tarDate",
								DateUtils.dateFormatToLong(new Date()));
						weighingFormMap.set("tarPhoto", pictureNames);
					} else if (inOrOut.equals("2")) { // 入库，先称毛重，后称皮重
						weighingFormMap.set("grossWeight", weight);
						weighingFormMap.set("grossWeightDate",
								DateUtils.dateFormatToLong(new Date()));
						weighingFormMap.set("grossWeightPhoto", pictureNames);
					}
					weighingFormMap.set("bId", bill);
					weighingFormMap.set("carId", carId);
					Session session = SecurityUtils.getSubject().getSession();
					weighingFormMap.set("weightPerson", ((UserFormMap) session
							.getAttribute("userSession")).getStr("userName"));

					try {
						FormMapUtil.toADDFormMap(weighingFormMap);
						weighingServer.addWeighing(weighingFormMap);
					} catch (Exception e) {
						log.error("===Class:WeighingController==Method:addWeighingTurnWeight===Exception:addWeighing=="
								+ e);
						return ERROR;
					}

					return SUCCESS;

				} else { // 有称重信息
							// 一条称重信息不完整，进行称重信息修改
					if (weighingFormMap.getFloat("grossWeight") == null
							|| weighingFormMap.getFloat("tare") == null) {
						int id = weighingFormMap.getInt("id");

						if (weighingFormMap.getFloat("grossWeight") == null) {
							weighingFormMap.set("grossWeight",
									Float.parseFloat(weight));
							weighingFormMap.set("grossWeightDate",
									DateUtils.dateFormatToLong(new Date()));
							weighingFormMap.set("grossWeightPhoto",
									pictureNames);
						} else if (weighingFormMap.getFloat("tare") == null) {
							weighingFormMap.set("tare",
									Float.parseFloat(weight));
							weighingFormMap.set("tarDate",
									DateUtils.dateFormatToLong(new Date()));
							weighingFormMap.set("tarPhoto", pictureNames);
						}

						try {
							FormMapUtil.toUPDATEFormMap(weighingFormMap);
							if (usedCarOrNot.equals("1")) { // 使用驳车
								weighingServer.editWeighing(weighingFormMap);
							} else { // 未使用驳车，则表示称重完成，进行报港信息和称重信息汇总
								weighingServer
										.retailWeighingEnd(weighingFormMap);
								// 完成一条称重，必须进行打印操作
								return "print:" + bill;
							}

						} catch (Exception e) {
							log.error("===Class:WeighingController==Method:addWeighingTurnWeight===Exception:editWeighing=="
									+ e);
							return ERROR;
						}

						if (usedCarOrNot.equals("1")) { // 驳车
							if (printType.equals("1")) { // 逐条打印
								return "print:" + id;
							} else {
								return SUCCESS;
							}
						} else {
							// 完成一条称重，必须进行打印操作
							return "print:" + id;
						}

					} else { // 完整的一条称重信息，如果是散户，则不操作，若驳载，则插入新的数据
						if (usedCarOrNot.equals("1")) { // 使用驳车
							weighingFormMap = new WeighingFormMap();
							if (inOrOut.equals("1")) { // 出库，先称皮重，后称毛重
								weighingFormMap.set("tare", weight);
								weighingFormMap.set("tarDate",
										DateUtils.dateFormatToLong(new Date()));
								weighingFormMap.set("tarPhoto", pictureNames);
							} else if (inOrOut.equals("2")) { // 入库，先称毛重，后称皮重
								weighingFormMap.set("grossWeight", weight);
								weighingFormMap.set("grossWeightDate",
										DateUtils.dateFormatToLong(new Date()));
								weighingFormMap.set("grossWeightPhoto",
										pictureNames);
							}
							weighingFormMap.set("bId", bill);
							weighingFormMap.set("carId", carId);
							Session session = SecurityUtils.getSubject()
									.getSession();
							weighingFormMap.set("weightPerson",
									((UserFormMap) session
											.getAttribute("userSession"))
											.getStr("userName"));

							try {
								FormMapUtil.toADDFormMap(weighingFormMap);
								weighingServer.addWeighing(weighingFormMap);
							} catch (Exception e) {
								log.error("===Class:WeighingController==Method:addWeighingTurnWeight===Exception:addWeighing=="
										+ e);
								return ERROR;
							}
							return SUCCESS;
						}
					}
				}
			}
		}

		return SUCCESS;
	}

	/**
	 * 根据单据号查找称重信息
	 * 
	 * @return
	 */
	@RequestMapping("findWeighingByBId")
	@ResponseBody
	public List<WeighingFormMap> findWeighingByBId() {
		String bId = getPara("bId");
		if (Common.isEmpty(bId)) {
			return null;
		}
		return weighingServer.findWeighingByBId(bId);
	}

	/**
	 * 根据单据号和车号获取最后一条称重信息，判断是该称皮重还是毛重
	 * 
	 * @return
	 */
	@RequestMapping("findWeighingByBidAndCarId")
	@ResponseBody
	public String findWeighingByBidAndCarId() {
		String bId = getPara("bId");
		String carId = getPara("carId");

		String gross = "毛重";
		String tare = "皮重";
		ReportHarborFormMap reportHarborFormMap = reportHarborServer
				.findReportHarborByBId(bId);
		if (reportHarborFormMap != null) {
			// 出库还是入库，1:出库，2:入库
			String inOrOut = reportHarborFormMap.getStr("inOrOut");
			// 根据单据号和车牌号获取最后一条称重信息
			WeighingFormMap weighingFormMap = weighingServer
					.findLastWeighingByBIdAndCarId(bId, carId);
			if (weighingFormMap == null) {
				if (inOrOut.equals("1")) {
					return tare;
				} else {
					return gross;
				}
			} else {
				if (weighingFormMap.getFloat("grossWeight") != null
						&& weighingFormMap.getFloat("tare") != null) {
					if (inOrOut.equals("1")) {
						return tare;
					} else {
						return gross;
					}
				} else if (weighingFormMap.getFloat("grossWeight") == null) {
					return gross;
				} else if (weighingFormMap.getFloat("tare") == null) {
					return tare;
				}
			}
		}

		return "";
	}

	/**
	 * 打开脚粮页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("addFootGrainUI")
	@Token(save = true)
	public String addFootGrainUI(Model model) {
		String bId = getPara("bId");
		model.addAttribute("bId", bId);
		return Constant.BACKGROUND_PATH + "/weight/weighing/footgrain";
	}

	/**
	 * 添加脚粮，并汇总称重信息提交
	 * 
	 * @return
	 */
	@RequestMapping("addFootGrain")
	@ResponseBody
	@Token(remove = true)
	public String addFootGrain() {
		WeighingFormMap weighingFormMap = getFormMap(WeighingFormMap.class);
		if (!validData(weighingFormMap)) {
			return ERROR;
		}

		String bId = weighingFormMap.getStr("bId");
		Session session = SecurityUtils.getSubject().getSession();
		weighingFormMap.set("weightPerson", ((UserFormMap) session
				.getAttribute("userSession")).getStr("userName"));
		weighingFormMap.set("carId", "脚粮");

		try {
			FormMapUtil.toADDFormMap(weighingFormMap);
			weighingServer.addFootGrainWeighing(weighingFormMap);
		} catch (Exception e) {
			log.error("===Class:WeighingController==Method:addFootGrain===Exception:addWeighing=="
					+ e);
			return ERROR;
		}

		return "print:" + bId;
	}

	/**
	 * 分页显示散户称重信息--称重页面
	 * 
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findRetailWeightByPage")
	@ResponseBody
	public MyPage<WeighingFormMap> findRetailWeightByPage(int rows, int page) {
		List<WeighingFormMap> list = weighingServer.findRetailWeightByPage(
				rows, page);
		return toMyPage(list);
	}

	/**
	 * 分页显示驳车称重信息--称重页面
	 * 
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findUsedCarWeightByPage")
	@ResponseBody
	public MyPage<WeighingFormMap> findUsedCarWeightByPage(int rows, int page) {
		List<WeighingFormMap> list = weighingServer.findUsedCarWeightByPage(
				rows, page);
		return toMyPage(list);
	}

	/**
	 * 打开驳车称重详细称重页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("weighingDetailUI")
	public String weighingDetail(Model model) {
		String bId = getPara("bId");
		String carId = getPara("carId");

		model.addAttribute("bId", bId);
		model.addAttribute("carId", carId);
		return Constant.BACKGROUND_PATH + "/weight/weighing/detailweighing";
	}

	/**
	 * 根据单据号和车号，获取单据号下某辆车的称重信息
	 * 
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findAllWeighingByBIdAndCarId")
	@ResponseBody
	public MyPage<WeighingFormMap> findAllWeighingByBIdAndCarId(int rows,
			int page) {
		String bId = getPara("bId");
		String carId = getPara("carId");
		List<WeighingFormMap> list = weighingServer
				.findAllWeighingByBIdAndCarId(rows, page, bId, carId);
		return toMyPage(list);
	}

	/**
	 * 根据单据号，获取单据号下的称重信息
	 * 
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findAllWeighingByBId")
	@ResponseBody
	public MyPage<WeighingFormMap> findAllWeighingByBId(int rows, int page) {
		String bId = getPara("bId");
		List<WeighingFormMap> list = weighingServer.findAllWeighingByBId(rows,
				page, bId);
		return toMyPage(list);
	}

	/**
	 * 根据单据号和车号获取最后一条称重信息，判断是清除皮重还是毛重
	 * 
	 * @return
	 */
	@RequestMapping("resetLastWeighingByBidAndCarId")
	@ResponseBody
	public String resetLastWeighingByBidAndCarId() {
		String bId = getPara("bId");
		String carId = getPara("carId");

		String gross = "毛重";
		String tare = "皮重";
		ReportHarborFormMap reportHarborFormMap = reportHarborServer
				.findReportHarborByBId(bId);
		if (reportHarborFormMap != null) {
			// 出库还是入库，1:出库，2:入库
			String inOrOut = reportHarborFormMap.getStr("inOrOut");
			// 根据单据号和车牌号获取最后一条称重信息
			WeighingFormMap weighingFormMap = weighingServer
					.findLastWeighingByBIdAndCarId(bId, carId);
			// 无称重信息或称重完成---不允许进行复位称重
			if (weighingFormMap == null
					|| reportHarborFormMap.getFloat("totalWeight") != null) {
				return ERROR;
			} else {
				if (weighingFormMap.getFloat("grossWeight") != null
						&& weighingFormMap.getFloat("tare") != null) {
					if (inOrOut.equals("1")) { // 出库--清除毛重
						return gross;
					} else {// 入库 -- 清除皮重
						return tare;
					}
				} else if (weighingFormMap.getFloat("grossWeight") == null) {
					return tare;
				} else if (weighingFormMap.getFloat("tare") == null) {
					return gross;
				}
			}
		}
		return ERROR;
	}

	/**
	 * 复位称重 只对最后一次称重进行复位
	 * 
	 * @return
	 */
	@RequestMapping("resetWeighing")
	@ResponseBody
	public String resetWeighing() {
		String bId = getPara("bill");
		String car = getPara("usedCarText");
		if (Common.isEmpty(bId)) {
			return ERROR;
		}
		// 获取报港信息
		ReportHarborFormMap reportHarborFormMap = reportHarborServer
				.findReportHarborByBId(bId);

		// 根据单据号和车牌号获取最后一条称重信息
		WeighingFormMap weighingFormMap = weighingServer
				.findLastWeighingByBIdAndCarId(bId, car);
		if (reportHarborFormMap == null || weighingFormMap == null) {
			return ERROR;
		}
		// 称重已经完成---不能进行复位操作
		if (reportHarborFormMap.getFloat("totalWeight") != null) {
			return ERROR;
		}

		String inOrOut = reportHarborFormMap.getStr("inOrOut");

		String resetType = "";

		if (weighingFormMap.getFloat("grossWeight") != null
				&& weighingFormMap.getFloat("tare") != null) { // 一条有皮重和毛重的记录
			if (inOrOut.equals("1")) { // 出库--清除毛重
				weighingFormMap.set("grossWeight", null);
				weighingFormMap.set("grossWeightDate", null);
				weighingFormMap.set("grossWeightPhoto", null);
				resetType = "毛重";
			} else {// 入库 -- 清除皮重
				weighingFormMap.set("tare", null);
				weighingFormMap.set("tarDate", null);
				weighingFormMap.set("tarPhoto", null);
				resetType = "皮重";
			}

			try {
				FormMapUtil.toUPDATEFormMap(weighingFormMap);
				weighingServer.editWeighing(weighingFormMap);

				return resetType;
			} catch (Exception e) {
				log.error("===Class:WeighingController==Method:resetWeighing===Exception:editWeighing=="
						+ e);
				return ERROR;
			}
		} else { // 只有皮重/毛重的记录
			if (weighingFormMap.getFloat("grossWeight") != null) {
				resetType = "毛重";
			} else {
				resetType = "皮重";
			}

			try {
				weighingServer.dropWeighing(weighingFormMap.getInt("id") + "");

				return resetType;
			} catch (Exception e) {
				log.error("===Class:WeighingController==Method:resetWeighing===Exception:dropWeighing=="
						+ e);
				return ERROR;
			}
		}
	}

	@RequestMapping("editlistUI")
	public String editListUI() {
		return Constant.BACKGROUND_PATH + "/weight/weighing/editlist";
	}

	/**
	 * 查找可修改的称重信息 -- 结算之前
	 * 
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findCanUpdateByPage")
	@ResponseBody
	public MyPage<WeighingFormMap> findCanUpdateByPage(int rows, int page) {
		WeighingFormMap weighingFormMap = getFormMap(WeighingFormMap.class);
		List<WeighingFormMap> list = weighingServer.findCanUpdateByPage(
				weighingFormMap, rows, page);
		return toMyPage(list);
	}

	@RequestMapping("editUI")
	@Token(save = true)
	public String editUI(Model model) {
		String id = getPara("id");
		WeighingFormMap weighingFormMap = weighingServer
				.findWeighingById(Integer.parseInt(id));
		model.addAttribute("weighingFormMap", weighingFormMap);
		return Constant.BACKGROUND_PATH + "/weight/weighing/edit";
	}

	@RequestMapping("edit")
	@ResponseBody
	@Token(remove = true)
	public String edit() {
		WeighingFormMap weighingFormMap = getFormMap(WeighingFormMap.class);

		try {
			FormMapUtil.toUPDATEFormMap(weighingFormMap);
		} catch (Exception e) {
			log.error("===Class:WeighingController==Method:edit===Exception:toUPDATEFormMap=="
					+ e);
			return ERROR;
		}

		try {
			weighingServer.setWeighing(weighingFormMap);
		} catch (Exception e) {
			log.error("===Class:WeighingController==Method:edit===Exception:setWeighing=="
					+ e);
			return ERROR;
		}
		return SUCCESS;
	}

	public boolean validData(WeighingFormMap weighingFormMap) {
		String bId = weighingFormMap.getStr("bId");
		String grossWeight = weighingFormMap.getStr("grossWeight");
		String tare = weighingFormMap.getStr("tare");

		if (ValidateUtil.isEmpty(bId) || bId.length() != 12) {
			return false;
		}
		if (!ValidateUtil.isFloat(tare)) {
			return false;
		}
		if (!ValidateUtil.isFloat(grossWeight)) {
			return false;
		}

		return true;
	}

	/**
	 * 称重抓图接受socket
	 */
	private void socket() {
		Properties properties = PropertiesUtils
				.getPropertyByName("socket.properties");
		try {
			String port = properties.getProperty("capture_server_port");
			if (server == null) {
				server = new ServerSocket(Integer.parseInt(port));
			}
			Thread th = new Thread(new Runnable() {
				public void run() {
					while (true) {
						try {
							Socket socket = server.accept();
							receiveFile(socket);
						} catch (Exception e) {
						}
					}
				}
			});
			th.start();
		} catch (IOException e) {

		}
	}

	/**
	 * 文件接受并保存
	 * 
	 * @param socket
	 * @param request
	 */
	private void receiveFile(Socket socket) {
		byte[] inputByte = null;
		int length = 0;
		DataInputStream dis = null;
		FileOutputStream fos = null;
		try {
			try {
				dis = new DataInputStream(socket.getInputStream());
				String fileName = dis.readUTF();
				String filePath = basePath + fileName;
				markdirOrNot(filePath);

				fos = new FileOutputStream(new File(filePath));
				inputByte = new byte[1024];
				while ((length = dis.read(inputByte, 0, inputByte.length)) > 0) {
					fos.write(inputByte, 0, length);
					fos.flush();
				}
			} finally {
				if (fos != null)
					fos.close();
				if (dis != null)
					dis.close();
				if (socket != null)
					socket.close();
			}
		} catch (Exception e) {
		}
	}

	/**
	 * 判断其文件夹是否存在，若不存在创建文件夹
	 * 
	 * @param filepath
	 */
	private void markdirOrNot(String filepath) {
		File file = new File(filepath);

		if (!file.exists()) {// 判断文件目录不存在
			File file2 = new File(file.getParent());
			file2.mkdirs();
		}
	}
}
