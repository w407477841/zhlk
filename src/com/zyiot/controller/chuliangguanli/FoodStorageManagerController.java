package com.zyiot.controller.chuliangguanli;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.FoodStorageAirColdFormMap;
import com.zyiot.entity.FoodStorageColdFormMap;
import com.zyiot.entity.FoodStoragePlanFormMap;
import com.zyiot.entity.FoodStorageProjectFormMap;
import com.zyiot.entity.FoodStorageSteamFormMap;
import com.zyiot.entity.FoodStorageSteamPlanFormMap;
import com.zyiot.entity.FoodStorageWindFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.server.CommonsFileServerI;
import com.zyiot.server.FoodStorageServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FileManager;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.JsonUtils;
import com.zyiot.util.MyPage;
/**
 * 储量作业管理
 * @author Admin
 * @date 2017年10月17日 下午2:48:28
 */
@Controller
@RequestMapping("foodStorageManager")
public class FoodStorageManagerController extends BaseController {

	Logger log = Logger.getLogger(FoodStorageManagerController.class);

	@Autowired
	private FoodStorageServerI foodStorageService;
	@Autowired
	private CommonsFileServerI fileManager;
	
	@RequestMapping("getDetail")
	@ResponseBody
	public FoodStorageProjectFormMap getDetail(){
		String wId = getPara("wId");
		return foodStorageService.getDetail(wId);
	}
	
	
	/**
	 * 跳转作业方案编制
	 * */
	@RequestMapping("/project/listUI")
	public String project() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/project";
	}

	/**
	 * 跳转作业方案编制--新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/project/addPage")
	public String addPage() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/project/add";
	}

	/**
	 * 跳转作业方案编制--编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/project/editPage")
	public String editPage(Model model) {
		try {
			model.addAttribute("FoodStorageProjectFormMap",
					foodStorageService.findSingleProject(getPara("id")));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:editPage===Exception:findSingleProject=="+e);
		}
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/project/edit";
	}

	/**
	 * 跳转作业计划
	 * */
	@RequestMapping("/plan/listUI")
	public String plan() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/plan";
	}

	/**
	 * 跳转作业计划--新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/plan/addPage")
	public String planAddPage() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/plan/add";
	}

	/**
	 * 跳转作业计划--编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/plan/editPage")
	public String planEditPage(Model model) {
		try {
			model.addAttribute("FoodStoragePlanFormMap",
					foodStorageService.findSinglePLan(getPara("id")));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:planEditPage===Exception:findSinglePLan=="+e);
		}
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/plan/edit";
	}

	/**
	 * 跳转作业审批
	 * */
	@RequestMapping("/approve/listUI")
	public String approve() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/approve";
	}

	/**
	 * 跳转作业审批--审批页面
	 * */
	@Token(save = true)
	@RequestMapping("/approve/approvePage")
	public String approvePage(Model model) {
		try {
			model.addAttribute("FoodStorageProjectFormMap",
					foodStorageService.findSingleProject(getPara("id")));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:approvePage===Exception:findSingleProject=="+e);
		}
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/approve/confirm";
	}

	/**
	 * 跳转作业记录---通风记录
	 * */
	@RequestMapping("/wind/listUI")
	public String wind() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/wind";
	}

	/**
	 * 跳转作业计划---通风记录--新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/wind/addPage")
	public String windAddPage() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/wind/add";
	}

	/**
	 * 跳转作业计划---通风记录--编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/wind/editPage")
	public String windEditPage(Model model) {
		try {
			model.addAttribute("FoodStorageWindFormMap",
					foodStorageService.findSingleWind(getPara("id")));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:windEditPage===Exception:findSingleWind=="+e);
		}
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/wind/edit";
	}

	/**
	 * 跳转作业记录---熏蒸记录
	 * */
	@RequestMapping("/steamRecord/listUI")
	public String steamRecord() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/steamRecord";
	}

	/**
	 * 跳转作业计划---熏蒸记录--常规熏蒸新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/steam/addPage")
	public String steamAddPage() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/steam/add";
	}

	/**
	 * 跳转作业计划---熏蒸记录--环流熏蒸新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/circleSteam/addPage")
	public String circleSteamAddPage() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/steam/addCircle";
	}

	/**
	 * 跳转作业计划---熏蒸记录--编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/steam/editPage")
	public String steamEditPage(Model model) {
		try {
			model.addAttribute("FoodStorageSteamFormMap",
					foodStorageService.findSingleSteam(getPara("id")));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:steamEditPage===Exception:findSingleSteam=="+e);
		}
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/steam/edit";
	}

	/**
	 * 跳转作业计划---熏蒸记录--编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/circleSteam/editPage")
	public String circleSteamEditPage(Model model) {
		try {
			model.addAttribute("FoodStorageSteamFormMap",
					foodStorageService.findSingleSteam(getPara("id")));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:circleSteamEditPage===Exception:findSingleSteam=="+e);
		}
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/steam/editCircle";
	}

	/**
	 * 跳转作业记录---冷却记录
	 * */
	@RequestMapping("/cold/listUI")
	public String cold() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/cold";
	}

	/**
	 * 跳转作业计划---冷却记录--新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/cold/addPage")
	public String coldAddPage() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/cold/add";
	}

	/**
	 * 跳转作业计划---冷却记录--编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/cold/editPage")
	public String coldEditPage(Model model) {
		try {
			model.addAttribute("FoodStorageColdFormMap",
					foodStorageService.findSingleCold(getPara("id")));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:coldEditPage===Exception:findSingleCold=="+e);
		}
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/cold/edit";
	}

	/**
	 * 跳转作业记录---空调降温记录
	 * */
	@RequestMapping("/airCold/listUI")
	public String airCold() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/airCold";
	}

	/**
	 * 跳转作业计划---冷却记录--新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/airCold/addPage")
	public String airColdAddPage() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/aircold/add";
	}

	/**
	 * 跳转作业计划---冷却记录--编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/airCold/editPage")
	public String airColdEditPage(Model model) {
		try {
			model.addAttribute("FoodStorageAirColdFormMap",
					foodStorageService.findSingleAirCold(getPara("id")));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:airColdEditPage===Exception:findSingleAirCold=="+e);
		}
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/aircold/edit";
	}

	/**
	 * 跳转作业备案---熏蒸备案
	 * */
	@RequestMapping("/steamPlan/listUI")
	public String steamPlan() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyebeian/steamPlan";
	}

	/**
	 * 跳转作业备案---熏蒸备案--新增页面
	 * */
	@Token(save = true)
	@RequestMapping("/steamPlan/addPage")
	public String steamPlanAddPage() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyebeian/add";
	}

	/**
	 * 跳转作业备案---熏蒸备案--编辑页面
	 * */
	@Token(save = true)
	@RequestMapping("/steamPlan/editPage")
	public String steamPlanEditPage(Model model) {
		try {
			model.addAttribute("FoodStorageSteamPlanFormMap",
					foodStorageService.findSingleSteamPlan(getPara("id")));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:steamPlanEditPage===Exception:findSingleSteamPlan=="+e);
		}
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyebeian/edit";
	}

	/**
	 * 跳转文件上传页面
	 * */
	@Token(save = true)
	@RequestMapping("/uploadFiles")
	public String uploadFiles(Model model) {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyebeian/upload";
	}

	@RequestMapping(value = "queryProjects", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<FoodStorageProjectFormMap> queryProjects(int page, int rows,
			HttpServletRequest request) {
		FoodStorageProjectFormMap formMap = getFormMap(FoodStorageProjectFormMap.class);
		try {

			List<FoodStorageProjectFormMap> ls = foodStorageService
					.findProjects(formMap, page, rows);
			return toMyPage(ls);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:queryProjects===Exception:findProjects=="+e);
			return null;
		}

	}

	@RequestMapping(value = "queryTotalProjects", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> queryProjects() {
		Map<String, Object> rs = new HashMap<>();
		try {
			FoodStorageProjectFormMap formMap = new FoodStorageProjectFormMap();
			formMap.put("status", "1");
			List<FoodStorageProjectFormMap> ls = foodStorageService
					.findTotleProjects(formMap);
			rs.put("rs", ls);
			rs.put("success", true);
			return rs;
		} catch (Exception e) {
			rs.put("success", false);
			log.error("===Class:FoodStorageManagerController===Method:queryProjects===Exception:findTotleProjects=="+e);
			return null;
		}
	}

	@RequestMapping(value = "queryPlans", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<FoodStoragePlanFormMap> queryPlans(int page, int rows,
			HttpServletRequest request) {
		FoodStoragePlanFormMap formMap = getFormMap(FoodStoragePlanFormMap.class);
		try {
			List<FoodStoragePlanFormMap> ls = foodStorageService.findPLan(
					formMap, page, rows);
			return toMyPage(ls);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:queryPlans===Exception:findPLan=="+e);
			return null;
		}

	}

	@RequestMapping(value = "queryWinds", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<FoodStorageWindFormMap> queryWinds(int page, int rows,
			HttpServletRequest request) {
		FoodStorageWindFormMap formMap = getFormMap(FoodStorageWindFormMap.class);
		try {
			String amounts = formMap.getStr("amounts");
			String amounte = formMap.getStr("amounte");

			formMap.put("amounts", (amounts == null || amounts.equals("")) ? 0
					: Integer.parseInt(amounts));
			formMap.put("amounte", (amounte == null || amounte.equals("")) ? 0
					: Integer.parseInt(amounte));
			List<FoodStorageWindFormMap> ls = foodStorageService.findWind(
					formMap, page, rows);
			return toMyPage(ls);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:queryWinds===Exception:findWind=="+e);
			return null;
		}

	}

	@RequestMapping(value = "queryCold", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<FoodStorageColdFormMap> queryCold(int page, int rows,
			HttpServletRequest request) {
		try {
			FoodStorageColdFormMap formMap = getFormMap(FoodStorageColdFormMap.class);
			List<FoodStorageColdFormMap> ls = foodStorageService.findCold(
					formMap, page, rows);
			return toMyPage(ls);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:queryCold===Exception:findCold=="+e);
			return null;
		}

	}

	@RequestMapping(value = "queryAirCold", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<FoodStorageAirColdFormMap> queryAirCold(int page, int rows,
			HttpServletRequest request) {
		FoodStorageAirColdFormMap formMap = getFormMap(FoodStorageAirColdFormMap.class);
		try {
			formMap.put(
					"amounts",
					(formMap.getStr("amounts") == null || formMap.getStr(
							"amounts").equals("")) ? "" : Integer
							.parseInt(formMap.getStr("amounts")));
			formMap.put(
					"amounte",
					(formMap.getStr("amounte") == null || formMap.getStr(
							"amounte").equals("")) ? "" : Integer
							.parseInt(formMap.getStr("amounte")));
			List<FoodStorageAirColdFormMap> ls = foodStorageService
					.findAirCold(formMap, page, rows);
			return toMyPage(ls);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:queryAirCold===Exception:findAirCold=="+e);
			return null;
		}

	}

	@RequestMapping(value = "querySteam", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<FoodStorageSteamFormMap> querySteam(int page, int rows,
			HttpServletRequest request) {
		FoodStorageSteamFormMap formMap = getFormMap(FoodStorageSteamFormMap.class);
		try {
			String amounts = formMap.getStr("amounts");
			String amounte = formMap.getStr("amounte");

			formMap.put("amounts", (amounts == null || amounts.equals("")) ? 0
					: Integer.parseInt(amounts));
			formMap.put("amounte", (amounte == null || amounte.equals("")) ? 0
					: Integer.parseInt(amounte));
			List<FoodStorageSteamFormMap> ls = foodStorageService.findSteam(
					formMap, page, rows);
			return toMyPage(ls);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:querySteam===Exception:findSteam=="+e);
			return null;
		}

	}

	@RequestMapping(value = "querySteamPlan", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MyPage<FoodStorageSteamPlanFormMap> querySteamPlan(int page,
			int rows, HttpServletRequest request) {
		try {
			FoodStorageSteamPlanFormMap formMap = new FoodStorageSteamPlanFormMap();
			formMap.put("mName", getPara("mName"));
			List<FoodStorageSteamPlanFormMap> ls = foodStorageService
					.findSteamPlan(formMap, page, rows);
			return toMyPage(ls);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:querySteamPlan===Exception:findSteamPlan=="+e);
			return null;
		}
	}

	@RequestMapping(value = "queryMedicines", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<YaoJiKuCunFormMap> queryMedicines() {
		try {
			YaoJiKuCunFormMap formMap = new YaoJiKuCunFormMap();
			List<YaoJiKuCunFormMap> ls = foodStorageService
					.findMedicines(formMap);
			return ls;
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:queryMedicines===Exception:findMedicines=="+e);
			return null;
		}

	}

	@Token(remove = true)
	@RequestMapping(value = "addProject")
	@ResponseBody
	public String addProject(HttpServletRequest request) {
		try {
			FoodStorageProjectFormMap formMap = getFormMap(FoodStorageProjectFormMap.class);
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time = format.format(Calendar.getInstance().getTime());
			formMap.put("ctime", time);
			FormMapUtil.toADDFormMap(formMap);
			foodStorageService.addProject(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController==Method:addProject==Exception:addProject=="
					+ e);
			return ERROR;
		}
		return SUCCESS;

	}

	@Token(remove = true)
	@RequestMapping(value = "addPlan")
	@ResponseBody
	public String addPlan(HttpServletRequest request) {
		FoodStoragePlanFormMap formMap = getFormMap(FoodStoragePlanFormMap.class);
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String time = format.format(Calendar.getInstance().getTime());
		formMap.put("ctime", time);
		try {
			FormMapUtil.toADDFormMap(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController==Method:addPlan==Exception:toADDFormMap=="
					+ e);
			return ERROR;
		}
		try {
			foodStorageService.addPLan(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController==Method:addPlan==Exception:addPLan=="
					+ e);
			return ERROR;
		}
		return SUCCESS;

	}

	@Token(remove = true)
	@RequestMapping(value = "addWind")
	@ResponseBody
	public String addWind() {
		FoodStorageWindFormMap formMap = getFormMap(FoodStorageWindFormMap.class);
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String time = format.format(Calendar.getInstance().getTime());
		formMap.put("timecreate", time);
		try {
			FormMapUtil.toADDFormMap(formMap);
			foodStorageService.addWind(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController==Method:addWind==Exception:addWind=="
					+ e);
			return ERROR;
		}
		return SUCCESS;

	}

	@Token(remove = true)
	@RequestMapping(value = "addCold")
	@ResponseBody
	public String addCold() {
		try {
			FoodStorageColdFormMap formMap = getFormMap(FoodStorageColdFormMap.class);
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String time = format.format(Calendar.getInstance().getTime());
			formMap.put("timecreate", time);
			FormMapUtil.toADDFormMap(formMap);
			foodStorageService.addCold(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:addCold===Exception:addCold=="+e);
			return ERROR;
		}
		return SUCCESS;

	}

	@Token(remove = true)
	@RequestMapping(value = "addAirCold")
	@ResponseBody
	public String addAirCold() {
		try {
			FoodStorageAirColdFormMap formMap = getFormMap(FoodStorageAirColdFormMap.class);
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String time = format.format(Calendar.getInstance().getTime());
			formMap.put("timecreate", time);
			FormMapUtil.toADDFormMap(formMap);
			foodStorageService.addAirCold(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:addAirCold===Exception:addAirCold=="+e);
			return ERROR;
		}
		return SUCCESS;

	}

	@Token(remove = true)
	@RequestMapping(value = "addSteam")
	@ResponseBody
	public String addSteam() {
		try {
			FoodStorageSteamFormMap formMap = getFormMap(FoodStorageSteamFormMap.class);
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String time = format.format(Calendar.getInstance().getTime());
			formMap.put("timecreate", time);
			FormMapUtil.toADDFormMap(formMap);
			foodStorageService.addSteam(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController==Method:addSteam==Exception:addSteam=="
					+ e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 熏蒸备案添加
	 * @return
	 */
	@Token(remove = true)
	@RequestMapping(value = "addSteamPlan")
	@ResponseBody
	public String addSteamPlan() {
		try {
			FoodStorageSteamPlanFormMap formMap = getFormMap(FoodStorageSteamPlanFormMap.class);
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String time = format.format(Calendar.getInstance().getTime());
			formMap.put("timeCreate", time);
			FormMapUtil.toADDFormMap(formMap);
			foodStorageService.addSteamPlan(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:addSteamPlan==Exception:addSteamPlan=="+e);
			return ERROR;
		}
		return SUCCESS;

	}

	@Token(remove = true)
	@RequestMapping("editProject")
	@ResponseBody
	public String editProject() {
		FoodStorageProjectFormMap formMap = getFormMap(FoodStorageProjectFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
		} catch (Exception e1) {
			log.error("===Class:FoodStorageManagerController==Method:editProject==Exception:toUPDATEFormMap=="
					+ e1);
			return ERROR;
		}

		try {
			foodStorageService.updateProject(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController==Method:editProject==Exception:updateProject=="
					+ e);
			return ERROR;
		}

		return SUCCESS;
	}

	@Token(remove = true)
	@RequestMapping("editPlan")
	@ResponseBody
	public String editPlan() {
		FoodStoragePlanFormMap formMap = getFormMap(FoodStoragePlanFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController==Method:editPlan==Exception:toUPDATEFormMap=="
					+ e);
			return ERROR;
		}
		try {
			foodStorageService.updatePLan(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController==Method:editPlan==Exception:updatePLan=="
					+ e);
			return ERROR;
		}

		return SUCCESS;
	}

	@Token(remove = true)
	@RequestMapping("editWind")
	@ResponseBody
	public String editWind() {
		FoodStorageWindFormMap formMap = getFormMap(FoodStorageWindFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
			foodStorageService.updateWind(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController==Method:editWind==Exception:editWind=="
					+ e);
			return ERROR;
		}

		return SUCCESS;
	}

	@Token(remove = true)
	@RequestMapping("editCold")
	@ResponseBody
	public String editCold() {
		FoodStorageColdFormMap formMap = getFormMap(FoodStorageColdFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
			foodStorageService.updateCold(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:editCold===Exception:updateCold=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@Token(remove = true)
	@RequestMapping("editAirCold")
	@ResponseBody
	public String editAirCold() {
		FoodStorageAirColdFormMap formMap = getFormMap(FoodStorageAirColdFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
			foodStorageService.updateAirCold(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:editAirCold===Exception:updateAirCold=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@Token(remove = true)
	@RequestMapping("editSteam")
	@ResponseBody
	public String editSteam() {
		FoodStorageSteamFormMap formMap = getFormMap(FoodStorageSteamFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
			foodStorageService.updateSteam(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:editSteam===Exception:updateSteam=="+e);
			return ERROR;
		}

		return SUCCESS;
	}
	/**
	 * 熏蒸备案修改
	 * @return
	 */
	@Token(remove = true)
	@RequestMapping("editSteamPlan")
	@ResponseBody
	public String editSteamPlan() {
		FoodStorageSteamPlanFormMap formMap = getFormMap(FoodStorageSteamPlanFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(formMap);
			foodStorageService.updateSteamPlan(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:editSteamPlan===Exception:updateSteamPlan=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("updateProject")
	@ResponseBody
	public String updateProject() {
		FoodStorageProjectFormMap formMap = getFormMap(FoodStorageProjectFormMap.class);

		try {
			FormMapUtil.toUPDATEFormMap(formMap);
			foodStorageService.updateProject(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:updateProject===Exception:updateProject=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteProject")
	@ResponseBody
	public String deleteProject() {

		try {
			foodStorageService.deleteProject(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:deleteProject===Exception:deleteProject=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deletePlan")
	@ResponseBody
	public String deletePlan() {

		try {
			foodStorageService.deletePLan(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:deletePlan===Exception:deletePLan=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteWind")
	@ResponseBody
	public String deleteWind() {

		try {
			foodStorageService.deleteWind(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:deleteWind===Exception:deleteWind=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteCold")
	@ResponseBody
	public String deleteCold() {

		try {
			foodStorageService.deleteCold(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:deleteCold===Exception:deleteCold=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteAirCold")
	@ResponseBody
	public String deleteAirCold() {

		try {
			foodStorageService.deleteAirCold(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:deleteAirCold===Exception:deleteAirCold=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteSteam")
	@ResponseBody
	public String deleteSteam() {

		try {
			foodStorageService.deleteSteam(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:deleteSteam===Exception:deleteSteam=="+e);
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteSteamPlan")
	@ResponseBody
	public String deleteSteamPlan() {

		try {
			foodStorageService.deleteSteamPlan(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:deleteSteamPlan===Exception:deleteSteamPlan=="+e);
			return ERROR;
		}

		return SUCCESS;
	}
	/**
	 * 熏蒸申请--打印
	 * @return
	 */
	@RequestMapping("findProjrctPrintById")
	@ResponseBody
	public FormMap<String, Object> findProjrctPrintById(){
		String id = getPara("id");
		FormMap<String,Object> formMap = foodStorageService.findPrintById(Integer.parseInt(id));
		String person = formMap.getStr("peopleMsg");
		formMap.remove("peopleMsg");
		if(person != null){
			person = person.replace("||", ",");
			person = "["+person+"]";
			List<Map<String,Object>> objectList = JsonUtils.parseJSONList(person);
			if(objectList != null && objectList.size()>0){
				formMap.set("personNumber", objectList.size());
				StringBuffer persons = new StringBuffer();
				for(Map<String,Object> map:objectList){
					persons.append(map.get("name"));
					persons.append(",");
				}
				formMap.set("persons", persons.substring(0, persons.length()-1));
			}
		}
		
		//熏蒸日期
		String steamDate = formMap.getStr("times");
		//申请日期
		String applyDate = formMap.getStr("ctime");
		if(applyDate != null){
			String[] applyArr;
			if(applyDate.length()>10){
				applyArr = applyDate.substring(0, 10).split("-");
			}else{
				applyArr = applyDate.split("-");
			}
			formMap.set("applyDate", applyArr);
		}else{
			formMap.set("applyDate", new String[3]);
		}
		if(steamDate != null){
			String[] steamArr;
			if(steamDate.length()>10){
				steamArr = steamDate.substring(0, 10).split("-");
			}else{
				steamArr = steamDate.split("-");
			}
			formMap.set("steamDate", steamArr);
		}else{
			formMap.set("steamDate", new String[3]);
		}
		return formMap;
	}

	@RequestMapping("download")
	@ResponseBody
	public void download(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String fileName = getPara("id");
			String path = request.getServletContext().getRealPath("/upload/files/steamPlan");
			File file = new File(path + "\\" + fileName);

			String lastName = new String(fileName.getBytes("utf-8"),
					"ISO-8859-1");
			// IE
			if (request.getHeader("User-Agent").toUpperCase()
					.indexOf("TRIDENT") > 0) {
				lastName = URLEncoder.encode(fileName, "UTF-8");
			}
			OutputStream os = response.getOutputStream();
			response.reset();
			response.setHeader("Content-Disposition", "attachment; filename="
					+ lastName);
			response.setContentType("application/octet-stream; charset=utf-8");
			os.write(FileUtils.readFileToByteArray(file));
			os.flush();

		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:download===Exception:download=="+e);
		}

	}

	@RequestMapping("uploadFile")
	@ResponseBody
	public String uploadCodeItem(
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, String dataid) {
		try {
			String savePath = request.getServletContext().getRealPath("/upload/files/steamPlan");
			//获取扩展名
			String oFileName = file.getOriginalFilename();
			String ext = oFileName.substring(oFileName.lastIndexOf("."));
			String fileName = UUID.randomUUID().toString().replace("-", "");
			fileName+=ext;
			// 上传文件
			FileManager.upFile(file, savePath,fileName);
			// 更新表数据
			FoodStorageSteamPlanFormMap formMap = getFormMap(FoodStorageSteamPlanFormMap.class);
			formMap.put("status", 1);
			formMap.put("id", dataid);
			formMap.put("files", fileName);
			FormMapUtil.toUPDATEFormMap(formMap);
			foodStorageService.updateSteamPlan(formMap);
		} catch (Exception e) {
			log.error("===Class:FoodStorageManagerController===Method:uploadCodeItem===Exception:updateSteamPlan=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
}
