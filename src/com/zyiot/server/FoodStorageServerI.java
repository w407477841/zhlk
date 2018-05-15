/**
 * 
 */
package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.FoodStorageAirColdFormMap;
import com.zyiot.entity.FoodStorageColdFormMap;
import com.zyiot.entity.FoodStoragePlanFormMap;
import com.zyiot.entity.FoodStorageProjectFormMap;
import com.zyiot.entity.FoodStorageSteamFormMap;
import com.zyiot.entity.FoodStorageSteamPlanFormMap;
import com.zyiot.entity.FoodStorageWindFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.util.FormMap;

/**
 * 储量管理
 *
 */

public interface FoodStorageServerI {
	/**
	 * 根据仓号--计划编制自动填充
	 * @param wId
	 * @return
	 */
	public FoodStorageProjectFormMap getDetail(String wId);
	
	
	/**
	 * 作业方案编制新增
	 * */
	public int addProject(FoodStorageProjectFormMap formMap)throws Exception;
	/**
	 * 作业方案编制修改
	 * */
	public int updateProject(FoodStorageProjectFormMap formMap)throws Exception;
	/**
	 * 作业方案编制删除
	 * */
	public int deleteProject(String id)throws Exception;
	/**
	 * 作业方案编制查询
	 * */
	public List<FoodStorageProjectFormMap> findProjects(FoodStorageProjectFormMap formMap,int page,int row);
	public List<FoodStorageProjectFormMap> findTotleProjects(FoodStorageProjectFormMap formMap)throws Exception;
	/**
	 * 作业方案编制查询
	 * */
	public FoodStorageProjectFormMap findSingleProject(String id)throws Exception;
	
	/**
	 * 作业方案计划 增删改查===========================================================================================================
	 * */

	public int addPLan(FoodStoragePlanFormMap formMap)throws Exception;
	
	public int updatePLan(FoodStoragePlanFormMap formMap)throws Exception;
	
	public int deletePLan(String id)throws Exception;
	
	public List<FoodStoragePlanFormMap> findPLan(FoodStoragePlanFormMap formMap,int page,int row)throws Exception;
	
	public FoodStoragePlanFormMap findSinglePLan(String id)throws Exception;
	
	/**
	 * 通风记录增删改查===========================================================================================================
	 * */
	public int addWind(FoodStorageWindFormMap formMap)throws Exception;
	
	public int updateWind(FoodStorageWindFormMap formMap)throws Exception;
	
	public int deleteWind(String id)throws Exception;
	
	public List<FoodStorageWindFormMap> findWind(FoodStorageWindFormMap formMap,int page,int row)throws Exception;
	
	public FoodStorageWindFormMap findSingleWind(String id)throws Exception;
	
	/**
	 * 熏蒸记录增删改查===========================================================================================================
	 * */
	public int addSteam(FoodStorageSteamFormMap formMap)throws Exception;
	
	public int updateSteam(FoodStorageSteamFormMap formMap)throws Exception;
	
	public int deleteSteam(String id)throws Exception;
	
	public List<FoodStorageSteamFormMap> findSteam(FoodStorageSteamFormMap formMap,int page,int row)throws Exception;
	
	public FoodStorageSteamFormMap findSingleSteam(String id)throws Exception;
	/**
	 * 冷却记录增删改查===========================================================================================================
	 * */
	public int addCold(FoodStorageColdFormMap formMap)throws Exception;
	
	public int updateCold(FoodStorageColdFormMap formMap)throws Exception;
	
	public int deleteCold(String id)throws Exception;
	
	public List<FoodStorageColdFormMap> findCold(FoodStorageColdFormMap formMap,int page,int row)throws Exception;
	
	public FoodStorageColdFormMap findSingleCold(String id)throws Exception;
	/**
	 * 空调降温记录增删改查===========================================================================================================
	 * */
	public int addAirCold(FoodStorageAirColdFormMap formMap)throws Exception;
	
	public int updateAirCold(FoodStorageAirColdFormMap formMap)throws Exception;
	
	public int deleteAirCold(String id)throws Exception;
	
	public List<FoodStorageAirColdFormMap> findAirCold(FoodStorageAirColdFormMap formMap,int page,int row)throws Exception;
	
	public FoodStorageAirColdFormMap findSingleAirCold(String id)throws Exception;
	
	/**
	 * 熏蒸备案增删改查===========================================================================================================
	 * */
	public int addSteamPlan(FoodStorageSteamPlanFormMap formMap)throws Exception;
	
	public int updateSteamPlan(FoodStorageSteamPlanFormMap formMap)throws Exception;
	
	public int deleteSteamPlan(String id)throws Exception;
	
	public List<FoodStorageSteamPlanFormMap> findSteamPlan(FoodStorageSteamPlanFormMap formMap,int page,int row)throws Exception;
	
	public FoodStorageSteamPlanFormMap findSingleSteamPlan(String id)throws Exception;
	
	
	/**
	 * ==========================
	 * */
	
	public List<YaoJiKuCunFormMap> findMedicines(YaoJiKuCunFormMap formMap)throws Exception;
	
	/**
	 * 根据id查找熏蒸计划--进行打印操作
	 * @param id
	 * @return
	 */
	public FormMap<String, Object> findPrintById(int id);
}