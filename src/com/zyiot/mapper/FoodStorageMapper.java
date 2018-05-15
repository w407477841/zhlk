package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.FoodStorageAirColdFormMap;
import com.zyiot.entity.FoodStorageColdFormMap;
import com.zyiot.entity.FoodStoragePlanFormMap;
import com.zyiot.entity.FoodStorageProjectFormMap;
import com.zyiot.entity.FoodStorageSteamFormMap;
import com.zyiot.entity.FoodStorageSteamPlanFormMap;
import com.zyiot.entity.FoodStorageWindFormMap;
import com.zyiot.util.FormMap;


public interface FoodStorageMapper extends BaseMapper{
	public List<FoodStorageProjectFormMap> findProjects(FoodStorageProjectFormMap formMap);
	
	public FoodStorageProjectFormMap findSingleProject(int id);
	/**
	 * 获取通风
	 * @param id
	 * @return
	 */
	public FoodStorageWindFormMap findSingleWind(int id);
	/**
	 * 获取熏蒸
	 * @param id
	 * @return
	 */
	public FoodStorageSteamFormMap findSingleSteam(int id);
	/**
	 * 获取冷却
	 * @param id
	 * @return
	 */
	public FoodStorageColdFormMap findSingleCold(int id);
	/**
	 * 空调降温
	 * @param id
	 * @return
	 */
	public FoodStorageAirColdFormMap findSingleAirCold(int id);
	
	public List<FoodStoragePlanFormMap> findPLan(FoodStoragePlanFormMap formMap)throws Exception;
	
	public List<FoodStorageWindFormMap> findWind(FoodStorageWindFormMap formMap)throws Exception;
	
	public List<FoodStorageSteamFormMap> findSteam(FoodStorageSteamFormMap formMap)throws Exception;
	
	public List<FoodStorageColdFormMap> findCold(FoodStorageColdFormMap formMap)throws Exception;
	
	public List<FoodStorageAirColdFormMap> findAirCold(FoodStorageAirColdFormMap formMap)throws Exception;
	
	public List<FoodStorageSteamPlanFormMap> findSteamPlan(FoodStorageSteamPlanFormMap formMap)throws Exception;
	
	/**
	 * 根据仓号--计划编制自动填充
	 * @param wId
	 * @return
	 */
	public FoodStorageProjectFormMap getDetail(String wId);
	/**
	 * 根据日期获取最大的编号--熏蒸备案
	 * @param date
	 * @return
	 */
	public String getMaxBId(String date);
	
	/**
	 * 根据id查找熏蒸计划--进行打印操作
	 * @param id
	 * @return
	 */
	public FormMap<String, Object> findPrintById(int id);
}
