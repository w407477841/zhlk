package com.zyiot.server.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.FoodStorageAirColdFormMap;
import com.zyiot.entity.FoodStorageColdFormMap;
import com.zyiot.entity.FoodStoragePlanFormMap;
import com.zyiot.entity.FoodStorageProjectFormMap;
import com.zyiot.entity.FoodStorageSteamFormMap;
import com.zyiot.entity.FoodStorageSteamPlanFormMap;
import com.zyiot.entity.FoodStorageWindFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.mapper.FoodStorageMapper;
import com.zyiot.mapper.yaojiguanli.YaoJiKuCunMapper;
import com.zyiot.server.FoodStorageServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;

@Service("foodStorageService")
public class FoodStorageServerImpl implements FoodStorageServerI{
	@Autowired
	private FoodStorageMapper  fmapper;
	@Autowired
	private YaoJiKuCunMapper yaoJiKuCunMapper;

	@Override
	public FoodStorageProjectFormMap getDetail(String wId) {
		return fmapper.getDetail(wId);
	}

	@Override
	@SystemLog(module="作业方案编制",methods="添加",description="成功")
	public int addProject(FoodStorageProjectFormMap formMap) throws Exception{
			return fmapper.addEntity(formMap);
	}

	@Override
	@SystemLog(module="作业方案编制",methods="修改",description="成功")
	@Transactional(readOnly = false)
	public int updateProject(FoodStorageProjectFormMap formMap) throws Exception {
		FoodStorageProjectFormMap foodStorageProjectFormMap = fmapper.findSingleProject(Integer.parseInt(formMap.getStr("id")));
		if(foodStorageProjectFormMap.getInt(Constant.VERSION) == Integer.parseInt(formMap.getStr(Constant.VERSION))){
			formMap.set(Constant.VERSION, foodStorageProjectFormMap.getInt(Constant.VERSION)+1);
			int result =  fmapper.updateEntity(formMap);
			addOperatorLog(foodStorageProjectFormMap, "update");
			return result;
		}else{
			throw new Exception("[数据已被修改！]");
		}
	}

	@Override
	@SystemLog(module="作业方案编制",methods="删除",description="成功")
	@Transactional(readOnly = false)
	public int deleteProject(String id) throws Exception{
		FoodStorageProjectFormMap foodStorageProjectFormMap = fmapper.findSingleProject(Integer.parseInt(id));
		int result =  fmapper.deleteEntityByKey("id", id, FoodStorageProjectFormMap.class);
		addOperatorLog(foodStorageProjectFormMap, "delete");
		return result;
	}

	@Override
	public List<FoodStorageProjectFormMap> findProjects(FoodStorageProjectFormMap formMap,int page,int rows){
		PageHelper.startPage(page, rows);
		return fmapper.findProjects(formMap);
	
	}
	@Override
	public List<FoodStorageProjectFormMap> findTotleProjects(FoodStorageProjectFormMap formMap) throws Exception{
		return fmapper.findProjects(formMap);
	}

	@Override
	public FoodStorageProjectFormMap findSingleProject(String id) throws Exception{
		return fmapper.findSingleProject(Integer.parseInt(id));
	}

	@Override
	@SystemLog(module="作业计划",methods="添加",description="成功")
	public int addPLan(FoodStoragePlanFormMap formMap) throws Exception {
		return fmapper.addEntity(formMap);
	}

	@Override
	@SystemLog(module="作业计划",methods="修改",description="成功")
	public int updatePLan(FoodStoragePlanFormMap formMap) throws Exception {
		return fmapper.updateEntity(formMap);
	}

	@Override
	@SystemLog(module="作业计划",methods="删除",description="成功")
	public int deletePLan(String id) throws Exception {
		return fmapper.deleteEntityByKey("id", id, FoodStoragePlanFormMap.class);
	}

	@Override
	public List<FoodStoragePlanFormMap> findPLan(FoodStoragePlanFormMap formMap, int page, int rows) throws Exception {
		if (page >= 0 && rows >= 0) {
			System.out.println(PageHelper.startPage(page, rows));
		}
		return fmapper.findPLan(formMap);
	
	}

	@Override
	public FoodStoragePlanFormMap findSinglePLan(String id) throws Exception {
		return fmapper.findById(id, FoodStoragePlanFormMap.class);
	}

	@Override
	@SystemLog(module="通风记录",methods="添加",description="成功")
	public int addWind(FoodStorageWindFormMap formMap) throws Exception {
		return fmapper.addEntity(formMap);
	}

	@Override
	@SystemLog(module="通风记录",methods="修改",description="成功")
	public int updateWind(FoodStorageWindFormMap formMap) throws Exception {
		return fmapper.updateEntity(formMap);
	}

	@Override
	@SystemLog(module="通风记录",methods="删除",description="成功")
	public int deleteWind(String id) throws Exception {
		return fmapper.deleteEntityByKey("id", id, FoodStorageWindFormMap.class);
	}

	@Override
	public List<FoodStorageWindFormMap> findWind(FoodStorageWindFormMap formMap, int page, int rows) throws Exception {
		PageHelper.startPage(page, rows);
		return fmapper.findWind(formMap);
	
	}

	@Override
	public FoodStorageWindFormMap findSingleWind(String id) throws Exception {
		return fmapper.findSingleWind(Integer.parseInt(id));
	}

	@Override
	@SystemLog(module="熏蒸记录",methods="增加",description="成功")
	public int addSteam(FoodStorageSteamFormMap formMap) throws Exception {
		return fmapper.addEntity(formMap);
	}

	@Override
	@SystemLog(module="熏蒸记录",methods="修改",description="成功")
	public int updateSteam(FoodStorageSteamFormMap formMap) throws Exception {
		return fmapper.updateEntity(formMap);
	}

	@Override
	@SystemLog(module="熏蒸记录",methods="删除",description="成功")
	public int deleteSteam(String id) throws Exception {
		return fmapper.deleteEntityByKey("id", id, FoodStorageSteamFormMap.class);
	}

	@Override
	public List<FoodStorageSteamFormMap> findSteam(FoodStorageSteamFormMap formMap, int page, int rows)throws Exception {
		PageHelper.startPage(page, rows);
		return fmapper.findSteam(formMap);
	}

	@Override
	public FoodStorageSteamFormMap findSingleSteam(String id) throws Exception {
		return fmapper.findSingleSteam(Integer.parseInt(id));
	}

	@Override
	@SystemLog(module="冷却记录",methods="添加",description="成功")
	public int addCold(FoodStorageColdFormMap formMap) throws Exception {
		return fmapper.addEntity(formMap);
	}

	@Override
	@SystemLog(module="冷却记录",methods="修改",description="成功")
	public int updateCold(FoodStorageColdFormMap formMap) throws Exception {
		return fmapper.updateEntity(formMap);
	}

	@Override
	@SystemLog(module="冷却记录",methods="删除",description="成功")
	public int deleteCold(String id) throws Exception {
		return fmapper.deleteEntityByKey("id", id, FoodStorageColdFormMap.class);
	}

	@Override
	public List<FoodStorageColdFormMap> findCold(FoodStorageColdFormMap formMap, int page, int rows) throws Exception {
		PageHelper.startPage(page, rows);
		return fmapper.findCold(formMap);
	}

	@Override
	public FoodStorageColdFormMap findSingleCold(String id) throws Exception {
		return fmapper.findSingleCold(Integer.parseInt(id));
	}

	@Override
	@SystemLog(module="空调降温记录",methods="添加",description="成功")
	public int addAirCold(FoodStorageAirColdFormMap formMap) throws Exception {
		return fmapper.addEntity(formMap);
	}

	@Override
	@SystemLog(module="空调降温记录",methods="修改",description="成功")
	public int updateAirCold(FoodStorageAirColdFormMap formMap)
			throws Exception {
		return fmapper.updateEntity(formMap);
	}

	@Override
	@SystemLog(module="空调降温记录",methods="删除",description="成功")
	public int deleteAirCold(String id) throws Exception {
		return fmapper.deleteEntityByKey("id", id, FoodStorageAirColdFormMap.class);
	}

	@Override
	public List<FoodStorageAirColdFormMap> findAirCold(FoodStorageAirColdFormMap formMap, int page, int rows)throws Exception {
		if (page >= 0 && rows >= 0) {
			System.out.println(PageHelper.startPage(page, rows));
		}
		return fmapper.findAirCold(formMap);
	}

	@Override
	public FoodStorageAirColdFormMap findSingleAirCold(String id)
			throws Exception {
		return fmapper.findSingleAirCold(Integer.parseInt(id));
	}

	@Override
	@SystemLog(module="熏蒸备案",methods="添加",description="添加成功")
	@Transactional(readOnly = false)
	public int addSteamPlan(FoodStorageSteamPlanFormMap formMap)
			throws Exception {
		String Bid =fmapper.getMaxBId(DateUtils.dateToShortString(new Date()));
		if(Bid == null){//如果当前日期是第一个
			Bid = DateUtils.dateToShortString(new Date())+"1001";
		}else{
			String head = Bid.substring(0,8);
			String tial = Bid.substring(8);
			Bid = head+ (Integer.parseInt(tial)+1);
		}
		formMap.set("bill", Bid);
		return fmapper.addEntity(formMap);
	}

	@Override
	@SystemLog(module="熏蒸备案",methods="修改",description="修改成功")
	@Transactional(readOnly = false)
	public int updateSteamPlan(FoodStorageSteamPlanFormMap formMap)
			throws Exception {
		String id = formMap.getStr("id");
		FoodStorageSteamPlanFormMap foodStorageSteamPlanFormMap = fmapper.findById(id, FoodStorageSteamPlanFormMap.class);
		if(foodStorageSteamPlanFormMap.getInt(Constant.VERSION) == Integer.parseInt(formMap.getStr(Constant.VERSION))){
			formMap.set(Constant.VERSION,foodStorageSteamPlanFormMap.getInt(Constant.VERSION)+1);
			int result = fmapper.updateEntity(formMap);
			addOperatorLog(foodStorageSteamPlanFormMap, "update");
			return result;
		}else{
			throw new Exception("[数据已被修改！]");
		}
	}

	@Override
	@SystemLog(module="熏蒸备案",methods="删除",description="删除成功")
	@Transactional(readOnly = false)
	public int deleteSteamPlan(String id) throws Exception {
		FoodStorageSteamPlanFormMap foodStorageSteamPlanFormMap = fmapper.findById(id, FoodStorageSteamPlanFormMap.class);
		int result =  fmapper.deleteEntityByKey("id", id, FoodStorageSteamPlanFormMap.class);
		addOperatorLog(foodStorageSteamPlanFormMap, "delete");
		return result;
	}

	@Override
	public List<FoodStorageSteamPlanFormMap> findSteamPlan(
			FoodStorageSteamPlanFormMap formMap, int page, int rows)
			throws Exception {
		if (page >= 0 && rows >= 0) {
			System.out.println(PageHelper.startPage(page, rows));
		}
		return fmapper.findSteamPlan(formMap);
	}

	@Override
	public FoodStorageSteamPlanFormMap findSingleSteamPlan(String id)
			throws Exception {
		return fmapper.findById(id, FoodStorageSteamPlanFormMap.class);
	}

	@Override
	public List<YaoJiKuCunFormMap> findMedicines(YaoJiKuCunFormMap formMap)
			throws Exception {
		return yaoJiKuCunMapper.findByPage(formMap);
	}
	
	@Override
	public FormMap<String, Object> findPrintById(int id) {
		return fmapper.findPrintById(id);
	}

	private void addOperatorLog(FoodStorageSteamPlanFormMap foodStorageSteamPlanFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		foodStorageSteamPlanFormMap.set(Constant.ENTITY_TABLE, "t_storage_steam_present_his");
		foodStorageSteamPlanFormMap.set("execSQL", sql);
		foodStorageSteamPlanFormMap.set("execUser", session.getAttribute("userSessionId"));
		foodStorageSteamPlanFormMap.set("execType", type);
		foodStorageSteamPlanFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		fmapper.addEntity(foodStorageSteamPlanFormMap);
	}
	private void addOperatorLog(FoodStorageProjectFormMap foodStorageProjectFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		foodStorageProjectFormMap.set(Constant.ENTITY_TABLE, "t_storage_work_project_his");
		foodStorageProjectFormMap.remove("wlName");
		foodStorageProjectFormMap.remove("wName");
		foodStorageProjectFormMap.remove("text");
		foodStorageProjectFormMap.set("execSQL", sql);
		foodStorageProjectFormMap.set("execUser", session.getAttribute("userSessionId"));
		foodStorageProjectFormMap.set("execType", type);
		foodStorageProjectFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		fmapper.addEntity(foodStorageProjectFormMap);
	}
}
