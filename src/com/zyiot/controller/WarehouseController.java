package com.zyiot.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.entity.WarehouseFormMap;
import com.zyiot.entity.WarehouseInfoFormMap;
import com.zyiot.entity.WarehouseLocationFormMap;
import com.zyiot.server.WarehouseInfoServerI;
import com.zyiot.server.WarehouseLocationServerI;
import com.zyiot.server.WarehouseServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.JasperHelper;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("warehouse")
public class WarehouseController extends BaseController {
	Logger log = Logger.getLogger(WarehouseController.class);
	@Autowired
	private WarehouseServerI warehouseServer;
	@Autowired
	private WarehouseInfoServerI warehouseInfoServer;
	@Autowired
	private WarehouseLocationServerI warehouseLocationServer;
	@Autowired
	private DataSource dataSource;
	
	@RequestMapping("list")
	public String listUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/cangfanglist";
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/cangfangadd";
	}
	
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		String id = getPara("id");
		WarehouseFormMap warehouseFormMap = warehouseServer.findById(id);
		model.addAttribute("warehouseFormMap", warehouseFormMap);
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/jichuziliao/cangfangedit";
	}
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<WarehouseFormMap> findByPage(int rows,int page){
		WarehouseFormMap warehouseFormMap =  getFormMap(WarehouseFormMap.class);
		
		List<WarehouseFormMap> list = warehouseServer.findByPage(warehouseFormMap, rows, page);
		
		return toMyPage(list);
	}
	@RequestMapping("findWarehouseInfoByPage")
	@ResponseBody
	public MyPage<WarehouseFormMap> findWarehouseInfoByPage(int rows,int page){
		WarehouseFormMap warehouseFormMap =  getFormMap(WarehouseFormMap.class);
		
		List<WarehouseFormMap> list = warehouseServer.findWarehouseInfoByPage(warehouseFormMap, rows, page);
		for(WarehouseFormMap w:list){
			w.set("cjsj", DateUtils.dateFormatToLong(w.getDate("cjsj")));
		}
		return toMyPage(list);
	}
	
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		WarehouseFormMap warehouse = getFormMap(WarehouseFormMap.class);
		String wNo = warehouse.getStr("wNo");
		if(Common.isEmpty(wNo)){
			warehouse.set("wNo", warehouse.getStr("id"));
		}
		try {
			FormMapUtil.toADDFormMap(warehouse);
		} catch (Exception e) {
			log.error("===Class:WarehouseController===Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			warehouseServer.addWarehouse(warehouse);
		} catch (Exception e) {
			log.error("===Class:WarehouseController===Method:add==Exception:addWarehouse=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		WarehouseFormMap warehouse = getFormMap(WarehouseFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(warehouse);
		} catch (Exception e) {
			log.error("===Class:WarehouseController===Method:edit==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			warehouseServer.editWarehouse(warehouse);
		} catch (Exception e) {
			log.error("===Class:WarehouseController===Method:edit==Exception:editWarehouse=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		try {
			warehouseServer.dropWarehouse(id);
		} catch (Exception e) {
			log.error("===Class:WarehouseController===Method:delete==Exception:dropWarehouse=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	/**
	 * 判断是否存在
	 * @return
	 */
	@RequestMapping("isExist")
	@ResponseBody
	public String isExist(){
		String id = getPara("id");
		
		WarehouseFormMap warehouse = warehouseServer.findById(id);
		if(warehouse == null){
			return ERROR;
		}
		return SUCCESS;
	}
	
	
	
	@RequestMapping(value = "findAllWarehouse", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<WarehouseFormMap> findAllByLocation() {
		try {
			return warehouseServer.findAllByLocation();
		} catch (Exception e) {
			log.error("===Calss:WarehouseController===Method:findAllByLocation==="
					+ e);
		}
		return null;
	}

	/**
	 * wangyf
	 * 
	 * 根据locationid获取warehouse
	 * 
	 * @return
	 */
	@RequestMapping("findWareHouseByLocation")
	@ResponseBody
	public List<WarehouseFormMap> findWareHouseByLocation() {
		WarehouseFormMap w = new WarehouseFormMap();
		List<WarehouseFormMap> ret = null;
		w.put("wLocation", getPara("location_id"));
		try {
			ret = warehouseServer.findWareHouseByLocation(w);
		} catch (Exception e) {

			return ret;
		}

		return ret;
	}

	@RequestMapping("findWareHouseByLocation2")
	@ResponseBody
	public List<WarehouseFormMap> findWareHouseByLocation2() {
		WarehouseFormMap w = new WarehouseFormMap();
		w.put("wLocation", getPara("location_id"));
		
		return warehouseServer.findWareHouseByLocation2(w);
	}
	@RequestMapping("findWareHouseByLocationAndVariety")
	@ResponseBody
	public List<WarehouseFormMap> findWareHouseByLocationAndVariety() {
		WarehouseFormMap w = new WarehouseFormMap();
		w.put("wLocation", getPara("location_id"));
		if(Common.isEmpty(getPara("name"))){
			w.put("name", "-1");
		}else{
			w.put("name", getPara("name"));
		}
		
		
		return warehouseServer.findWareHouseByLocationAndVariety(w);
	}

	@Autowired
	public void setWarehouseLocationServer(
			WarehouseLocationServerI warehouseLocationServer) {
		this.warehouseLocationServer = warehouseLocationServer;
	}

	@RequestMapping("view")
	public String view() {
		return Common.BACKGROUND_PATH + "/warehouse/view";
	}
	@RequestMapping("look")
	public String lookUI(Model model){
		String id = getPara("id");
		WarehouseFormMap warehouseFormMap = warehouseServer.findWarehouseInfoById(id);
		if(warehouseFormMap != null){
			String result = convertWarehouseInfo(warehouseFormMap.getStr("wCoordinate"),warehouseFormMap.getInt("wHeight"),warehouseFormMap.getInt("wColumn"),warehouseFormMap.getInt("wRow"));			
			warehouseFormMap.set("wCoordinate", result);
			model.addAttribute("warehouseFormMap", warehouseFormMap);
		}
		return Constant.BACKGROUND_PATH+"/warehouse/look";
	}
	@RequestMapping("mobile")
	public String mobileUI(Model model){
		String id = getPara("id");
		WarehouseFormMap warehouseFormMap = warehouseServer.findWarehouseInfoById(id);
		if(warehouseFormMap != null){
			String result = convertWarehouseInfo(warehouseFormMap.getStr("wCoordinate"),warehouseFormMap.getInt("wHeight"),warehouseFormMap.getInt("wColumn"),warehouseFormMap.getInt("wRow"));			
			warehouseFormMap.set("wCoordinate", result);
			model.addAttribute("warehouseFormMap", warehouseFormMap);
		}
		return Constant.BACKGROUND_PATH+"/warehouse/mobile";
	}
	@RequestMapping("show")
	public String show() {
		return Common.BACKGROUND_PATH + "/warehouse/show";
	}
	@RequestMapping("warehouseList")
	public String warehouseistUI(Model model) {
		String wId = getPara("kd");
		model.addAttribute("wId", wId);
		return Common.BACKGROUND_PATH + "/warehouse/list";
	}
	
	@RequestMapping("getSVG")
	public void getSVG(HttpServletRequest request,HttpServletResponse response){
		    //response.setContentType("text/svg+xml");
	        ServletOutputStream out;
			try {
				out = response.getOutputStream();
				out.println("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>");
				out.println("<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.0//EN\" \"http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd\">");
				out.println("<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" onload=\"OnLoadEvent(evt)\" style=\"width:100%;height:100%;\"> ");
				out.println("<g id=\"Scene\"></g>");
				out.println("<script type=\"text/ecmascript\"><![CDATA[");
				out.println("function OnLoadEvent(evt)");
				out.println("{ parent.AddSVGObject(evt.target.ownerDocument);}]]></script></svg>");
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
	}
	
	
	@RequestMapping(value = "find", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String findAllInfo(HttpServletRequest request) {
		String action = request.getParameter("action");
		String ckdm = request.getParameter("f_kdbm"); // 仓库编号

		if (action != null && !action.equals("")) {
			if (action.equals("ckda")) {
				return findWarehouse(ckdm);
			} else if (action.equals("date")) {
				String ck = request.getParameter("f_ckbm");
				String res = findDate(ck);
				return res;
			} else if (action.equals("time")) {
				String ck = request.getParameter("f_ckbm");
				String rq = request.getParameter("f_rq");
				return findTime(ck, rq);
			} else if (action.equals("info")) {
				String ck = request.getParameter("f_ckbm");
				String rq = request.getParameter("f_rq");
				String sj = request.getParameter("f_sj");
				return findWarehouseInfo(ck, rq, sj);
			}
		}

		return Common.BACKGROUND_PATH + "/warehouse/view";
	}

	@RequestMapping(value = "findMap", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<WarehouseLocationFormMap> findMapInfo() {
		List<WarehouseLocationFormMap> warehouseLocationList = warehouseLocationServer.findBySelect();
		return warehouseLocationList;
	}
	@RequestMapping(value = "findAllMap", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<WarehouseLocationFormMap> findAllMapInfo() {
		List<WarehouseLocationFormMap> warehouseLocationList = warehouseLocationServer.findAllWarehouseLocation(new WarehouseLocationFormMap());
		return warehouseLocationList;
	}

	@RequestMapping(value = "jkInfo", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public WarehouseLocationFormMap findJianKongInfo(HttpServletRequest request) {
		String no = request.getParameter("wno");
		WarehouseLocationFormMap warehouseLocation = new WarehouseLocationFormMap();
		warehouseLocation.set("wDisable", "1");
		warehouseLocation.set("wNo", no);

		try {
			List<WarehouseLocationFormMap> warehouseLocationList = warehouseLocationServer
					.findAllWarehouseLocation(warehouseLocation);
			if (warehouseLocationList != null
					&& warehouseLocationList.size() > 0) {
				return warehouseLocationList.get(0);
			}
		} catch (Exception e) {
			log.error("===Calss:WarehouseController===Method:findJianKongInfo==="
					+ e);
		}
		return null;
	}

	/**
	 * 根据仓库地点获取仓库信息
	 * 
	 * @param wlId
	 *            仓库地点编号
	 * @return
	 */
	public String findWarehouse(String wlId) {
		WarehouseFormMap warehouse = new WarehouseFormMap();
		warehouse.set("wLocation", wlId);
		warehouse.set("wDisable", "1");

		try {
			List<WarehouseFormMap> warehouseList = warehouseServer
					.findAllWarehouseByLocationId(warehouse);
			return warehouseListToString(warehouseList);
		} catch (Exception e) {
			log.error("===Class:WarehouseController===Method:findWarehouse==="
					+ e);
		}
		return "";
	}

	/**
	 * 把仓库信息对象转换成字符串
	 * 
	 * @param warehouseList
	 * @return
	 */
	public String warehouseListToString(List<WarehouseFormMap> warehouseList) {
		if (warehouseList != null && warehouseList.size() > 0) {
			StringBuffer result = new StringBuffer();
			for (WarehouseFormMap warehouse : warehouseList) {
				result.append(warehouse.getInt("id"));
				result.append(" ");
				result.append(warehouse.getStr("wName"));
				result.append(" ");
				result.append(warehouse.getInt("wHeight"));
				result.append(" ");
				result.append(warehouse.getInt("wColumn"));
				result.append(" ");
				result.append(warehouse.getInt("wRow"));
				result.append(";");
			}
			String dd = result.substring(0, result.length() - 1);
			return dd;
		}

		return "";
	}

	/**
	 * 查询时间
	 * 
	 * @param wlId
	 *            仓库地点编号
	 * @param wId
	 *            仓库编号
	 * @return
	 */
	public String findTime(String wId, String date) {
		WarehouseInfoFormMap warehouseInfo = new WarehouseInfoFormMap();
		warehouseInfo.set("wWarehouse", wId);
		warehouseInfo.set("wDisable", "1");
		warehouseInfo.set(Constant.ORDER_BY, "wDate desc");
		warehouseInfo.set("wDate", date);
		// if (date != null && !date.equals("")) {
		// }
		StringBuffer results = new StringBuffer();
		try {
			List<WarehouseInfoFormMap> warehouseInfoList = warehouseInfoServer
					.findAllByWarehouseId(warehouseInfo);
			for (WarehouseInfoFormMap wif : warehouseInfoList) {
				results.append(wif.getStr("wTime"));
				results.append(";");
			}
			return results.length()>0?results.substring(0, results.length() - 1):results.toString();
		} catch (Exception e) {
			log.error("===Class:WarehouseController===Method:findWarehouseDate==="
					+ e);
		}

		return "";
	}

	/**
	 * 查询日期
	 * 
	 * @param wlNo
	 * @param wNo
	 * @return
	 */
	private String findDate(String wNo) {
		StringBuffer results = new StringBuffer();
		try {
			List<WarehouseInfoFormMap> warehouseInfoList = warehouseInfoServer
					.findDate(wNo);
			for (WarehouseInfoFormMap wif : warehouseInfoList) {
				results.append(wif.getStr("wDate"));
				results.append(";");
			}
			return results.length()>0?results.substring(0, results.length() - 1):results.toString();
		} catch (Exception e) {
			log.error("===Class:WarehouseController===Method:findDate===" + e);
		}

		return "";
	}

	/**
	 * 获取仓库各个点的温度
	 * 
	 * @param wlId
	 *            仓库地点编号
	 * @param wId
	 *            仓库编号
	 * @param date
	 *            日期
	 * @param time
	 *            时间
	 * @return
	 */
	public String findWarehouseInfo(String wId, String date,
			String time) {
		WarehouseInfoFormMap warehouseInfo = new WarehouseInfoFormMap();
		warehouseInfo.set("wWarehouse", wId);
		warehouseInfo.set("wDate", date);
		warehouseInfo.set("wTime", time);
		warehouseInfo.set("wDisable", "1");
		try {
			List<WarehouseInfoFormMap> warehouseInfoList = warehouseInfoServer
					.findAllByWarehouseId(warehouseInfo);
			if (warehouseInfoList != null && warehouseInfoList.size() > 0) {
				warehouseInfo = warehouseInfoList.get(0);
				StringBuffer result = new StringBuffer();
				result.append("cnwd=");
				result.append(warehouseInfo.getFloat("wTemperature"));
				result.append(";");
				result.append("cwwd=");
				result.append(warehouseInfo.getFloat("gTemperature"));
				result.append(";");
				result.append("cnsd=");
				result.append(warehouseInfo.getFloat("wHumidity"));
				result.append(";");
				result.append("cwsd=");
				result.append(warehouseInfo.getFloat("gHumidity"));
				result.append(";");
				result.append("p_id=");
				result.append(warehouseInfo.getInt("id"));
				result.append(";");
				result.append("f_cwz=");
				result.append(warehouseInfo.getStr("wCoordinate"));
				
				return result.toString();
			}
		} catch (Exception e) {
			log.error("===Class:WarehouseController===Method:findWarehouseDate==="
					+ e);
		}

		return "";
	}
	/**
	 * 报表导出
	 * @param request
	 * @param response
	 */
	@RequestMapping("report")
	public void report(HttpServletRequest request,HttpServletResponse response){
		String id = request.getParameter("pId");
		
		WarehouseInfoFormMap warehouseInfo = warehouseInfoServer.findSideAndDataById(Integer.parseInt(id));
		
		int layer = warehouseInfo.getInt("wHeight");
		int column = warehouseInfo.getInt("wColumn");
		int row = warehouseInfo.getInt("wRow");		
		String data = warehouseInfo.getStr("wCoordinate");
		String begindata = DateUtils.dateFormatToLong(warehouseInfo.getDate("cjsj"));
		
		String[] arr = data.split(" ");
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		Map<String,Object> temp;
		int totalCount = 0;//记录总的有效数据个数
		float totalSum = 0f; //记录总的数据和
		if(arr.length == layer*column*row){
			for(int l=layer-1;l>=0;l--){
				float max = 0f , min=0f;
				float sum = 0f;
				int count = 0;//记录每层有效数据个数
				for(int k = 0;k<column*row;k++){
					int index = l*column*row + k;
					float value = 300;
					if(arr[index].equalsIgnoreCase("null")){
						
					}else{
						value = Float.parseFloat(arr[index]);
					}
					
					if(value < 100f && value >-100f){ //数据在-100~100中间才为有效数据
						if(count==0){ //为第一个有效数据
							max = value;
							min = value;
						}else{
							if(value>max){
								max = value;
							}else if(value<min){
								min = value;
							}
						}
						
						sum +=value;
						count ++;
						
						totalCount++;
						totalSum += value;
					}
				}
				
				temp = new HashMap<String,Object>();
				temp.put("max", max);
				temp.put("min", min);
				
				float avg = sum/count;
				BigDecimal bd = new BigDecimal(avg);
				avg = bd.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
				
				temp.put("avg", avg);
				
				result.add(temp);
			}
		}
		
		FormMap<String,Object> param = new FormMap<String,Object>();
		param.put("tempList", result);
		param.put("pid", Integer.parseInt(id));
		
		float avg = totalSum/totalCount;
		BigDecimal bd = new BigDecimal(avg);
		avg = bd.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
		
		param.put("avage_temp", avg);
		param.put("begin_date", begindata);
		String date = begindata.replace("-", "").replace(" ", "").replace(":", "");
		JasperHelper.export("pdf", "温度报表-"+date, "temperature.jasper", param, dataSource, request, response);
	}
	/**
	 * 粮温趋势
	 * @param model
	 * @return
	 */
	@RequestMapping("tendencyUI")
	public String tendencyUI(Model model){
		String kd = getPara("kd");
		model.addAttribute("kd", kd);
		return Common.BACKGROUND_PATH + "/warehouse/tendency";
	}
	/**
	 * 查找粮温数据，形成粮温趋势图
	 * @return
	 */
	@RequestMapping("tendency")
	@ResponseBody
	public WarehouseInfoFormMap tendencyUI(){
		WarehouseInfoFormMap warehouseInfo = getFormMap(WarehouseInfoFormMap.class);
		
		String id = warehouseInfo.getStr("wID");
		String beginDate = warehouseInfo.getStr("beginDate");
		String endDate = warehouseInfo.getStr("endDate");
		if(Common.isEmpty(id)){
			return null;
		}else{
			if(Common.isEmpty(beginDate) && Common.isEmpty(endDate)){
				//获取当前时间
				Date nowDate = new Date();
				//获取一个月前时间
				Date beforeDate = DateUtils.dateBefore(nowDate, 1,Calendar.MONTH);
				beginDate = DateUtils.dateFormatToShort(beforeDate);
				endDate = DateUtils.dateFormatToShort(nowDate);
			}else if(Common.isEmpty(beginDate)){
				Date end = DateUtils.parseDate(endDate);
				Date begin = DateUtils.dateBefore(end, 1,Calendar.MONTH);
				beginDate = DateUtils.dateFormatToShort(begin);
				endDate = DateUtils.dateFormatToShort(end);
			}else if(Common.isEmpty(endDate)){
				Date begin = DateUtils.parseDate(beginDate);
				Date end = DateUtils.dateAfter(begin, 1, Calendar.MONTH);
				beginDate = DateUtils.dateFormatToShort(begin);
				endDate = DateUtils.dateFormatToShort(end);
			}
			
			beginDate += " 00:00:00";
			endDate += " 23:59:59";
			
			warehouseInfo.set("beginDate", beginDate);
			warehouseInfo.set("endDate", endDate);
			
			List<WarehouseInfoFormMap> list = warehouseInfoServer.findTemperatureTendency(warehouseInfo);
			if(list == null || list.size()<1){
				return null;
			}else{
				warehouseInfo = ObjectConvertJson(list, warehouseInfo);
				return warehouseInfo;
			}
		}
	}
	
	
	private WarehouseInfoFormMap ObjectConvertJson(List<WarehouseInfoFormMap> list,WarehouseInfoFormMap warehouseInfo){
		warehouseInfo = new WarehouseInfoFormMap();
		StringBuffer date = new StringBuffer();
		StringBuffer inTem = new StringBuffer();
		StringBuffer outTem = new StringBuffer();
		StringBuffer maxTem = new StringBuffer();
		StringBuffer minTem = new StringBuffer();
		date.append("[");
		inTem.append("[");
		outTem.append("[");
		maxTem.append("[");
		minTem.append("[");
		
		for(WarehouseInfoFormMap info:list){
			date.append("'"+DateUtils.dateFormatToLong(info.getDate("cjsj"))+"',");
			inTem.append(info.getFloat("wTemperature")+",");
			outTem.append(info.getFloat("gTemperature")+",");
			maxTem.append(info.getFloat("maxTemperature")+",");
			minTem.append(info.getFloat("minTemperature")+",");
		}
		warehouseInfo.set("cjsj", date.substring(0, date.length()-1)+"]");
		warehouseInfo.set("inTem", inTem.substring(0, inTem.length()-1)+"]");
		warehouseInfo.set("outTem", outTem.substring(0, outTem.length()-1)+"]");
		warehouseInfo.set("maxTem", maxTem.substring(0, maxTem.length()-1)+"]");
		warehouseInfo.set("minTem", minTem.substring(0, minTem.length()-1)+"]");
		
		return warehouseInfo;
	}
	
	
	private String convertWarehouseInfo(String str,int layer,int colum,int row){
		StringBuffer result = new StringBuffer();
		String[] temps = str.split(" ");
		String[] tempArr = new String[temps.length];
		int index = 0,temIndex = 0;
		if(temps.length == layer*colum*row){
		   for(int l = 0;l<layer;l++){
			   for(int r=0;r<row;r++){
			   for(int c = 0;c<colum;c++){
					   index = l*colum*row + r*colum +c;
					   temIndex = (layer-l-1)*colum*row + r*colum +(colum-c-1);
					   tempArr[temIndex] = temps[index];
				   }
			   }
		   }
		   
		   for(int k=0;k<tempArr.length;k++){
			   result.append(tempArr[k]+" ");
		   }
		}
		return result.toString();
	}
}
