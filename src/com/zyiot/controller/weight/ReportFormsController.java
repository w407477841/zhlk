package com.zyiot.controller.weight;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.entity.weight.WeighingFormMap;
import com.zyiot.server.weight.ReportFormsServerI;
import com.zyiot.server.weight.ReportHarborServerI;
import com.zyiot.server.weight.WeighingServerI;
import com.zyiot.util.CalculateUtils;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.MyPage;
import com.zyiot.util.PropertiesUtils;
/**
 * 查询报表
 * @author Admin
 * @date 2017年6月8日 下午3:06:12
 */
@Controller
@RequestMapping("reportForms")
public class ReportFormsController extends BaseController {
	@Autowired
	private ReportFormsServerI reportFormsServer;
	@Autowired
	private ReportHarborServerI reportHarborServer;
	@Autowired
	private WeighingServerI weighingServer;
	@RequestMapping("onelist")
	public String oneList(){
		return Constant.BACKGROUND_PATH+"/weight/reportForms/onelist";
	}
	@RequestMapping("twolist")
	public String twoList(){
		return Constant.BACKGROUND_PATH+"/weight/reportForms/twolist";
	}
	@RequestMapping("threelist")
	public String threeList(){
		return Constant.BACKGROUND_PATH+"/weight/reportForms/threelist";
	}
	
	@RequestMapping("fourlist")
	public String fourList(){
		return Constant.BACKGROUND_PATH+"/weight/reportForms/fourlist";
	}
	
	@RequestMapping("fivelist")
	public String fiveList(){
		return Constant.BACKGROUND_PATH+"/weight/reportForms/fivelist";
	}
	@RequestMapping("sixlist")
	public String six(){
		return Constant.BACKGROUND_PATH+"/weight/reportForms/sixlist";
	}
	
	@RequestMapping("sevenlist")
	public String seven(){
		return Constant.BACKGROUND_PATH+"/weight/reportForms/sevenlist";
	}
	
	@RequestMapping("oneReportFormsByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> oneReportFormsByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		List<ReportHarborFormMap> list = reportFormsServer.oneReportFormsByPage(reportHarborFormMap,rows,page);
		return toMyPage(list);
	}
	@RequestMapping("twoReportFormsByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> twoReportFormsByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		String addDate = reportHarborFormMap.getStr("addDate");
		String addDateEnd = reportHarborFormMap.getStr("addDateEnd");
		String payDate = reportHarborFormMap.getStr("payDate");
		String payDateEnd = reportHarborFormMap.getStr("payDateEnd");
		
		if(!Common.isEmpty(addDate)){
			reportHarborFormMap.set("addDate", addDate+" 00:00:00");
		}
		if(!Common.isEmpty(addDateEnd)){
			reportHarborFormMap.set("addDateEnd", addDateEnd+" 23:59:59");
		}
		if(!Common.isEmpty(payDate)){
			reportHarborFormMap.set("payDate", payDate+" 00:00:00");
		}
		if(!Common.isEmpty(payDateEnd)){
			reportHarborFormMap.set("payDateEnd", payDateEnd+" 23:59:59");
		}
		List<ReportHarborFormMap> list = reportFormsServer.twoReportFormsByPage(reportHarborFormMap,rows,page);
		return toMyPage(list);
	}
	@RequestMapping("threeReportFormsByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> threeReportFormsByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		String addDate = reportHarborFormMap.getStr("addDate");
		String addDateEnd = reportHarborFormMap.getStr("addDateEnd");
		if(!Common.isEmpty(addDate)){
			reportHarborFormMap.set("addDate", addDate+" 00:00:00");
		}
		if(!Common.isEmpty(addDateEnd)){
			reportHarborFormMap.set("addDateEnd", addDateEnd+" 23:59:59");
		}
		List<ReportHarborFormMap> list = reportFormsServer.threeReportFormsByPage(reportHarborFormMap, rows, page);
		return toMyPage(list);
	}
	@RequestMapping("fourReportFormsByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> fourReportFormsByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		List<ReportHarborFormMap> list = reportFormsServer.fourReportFormsByPage(reportHarborFormMap,rows,page);
		return toMyPage(list);
	}
	@RequestMapping("fiveReportFormsByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> fiveReportFormsByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		String addDate = reportHarborFormMap.getStr("addDate");
		String addDateEnd = reportHarborFormMap.getStr("addDateEnd");
		if(!Common.isEmpty(addDate)){
			reportHarborFormMap.set("addDate", addDate+" 00:00:00");
		}
		if(!Common.isEmpty(addDateEnd)){
			reportHarborFormMap.set("addDateEnd", addDateEnd+" 23:59:59");
		}
		List<ReportHarborFormMap> list = reportFormsServer.fiveReportFormsByPage(reportHarborFormMap,rows,page);
		return toMyPage(list);
	}
	@RequestMapping("sixReportFormsByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> sixReportFormsByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		List<ReportHarborFormMap> list = reportFormsServer.sixReportFormsByPage(reportHarborFormMap, rows, page);
		return toMyPage(list);
	}
	@RequestMapping("sevenReportFormsByPage")
	@ResponseBody
	public MyPage<ReportHarborFormMap> sevenReportFormsByPage(int rows,int page){
		ReportHarborFormMap reportHarborFormMap = getFormMap(ReportHarborFormMap.class);
		String beginDate = reportHarborFormMap.getStr("beginDate");
		String endDate = reportHarborFormMap.getStr("endDate");
		if(!Common.isEmpty(beginDate)){
			reportHarborFormMap.set("beginDate", beginDate+" 00:00:00");
		}
		if(!Common.isEmpty(endDate)){
			reportHarborFormMap.set("endDate", endDate+" 23:59:59");
		}
		List<ReportHarborFormMap> list = reportFormsServer.sevenReportFormsByPage(reportHarborFormMap,rows,page);
		return toMyPage(list);
	}
	/**
	 * 打印过磅单
	 * @param model
	 * @return
	 */
	@RequestMapping("sevenReportFormsByPrint")
	public String sevenReportFormsByPrint(Model model){
		ReportHarborFormMap reportHarborFormMap = new ReportHarborFormMap();
		reportHarborFormMap.set("bId", getPara("bId"));
		reportHarborFormMap.set("beginDate", getPara("beginDate"));
		reportHarborFormMap.set("endDate", getPara("endDate"));
		reportHarborFormMap.set("inOrOut", getPara("inOrOut"));
		String beginDate = reportHarborFormMap.getStr("beginDate");
		String endDate = reportHarborFormMap.getStr("endDate");
		if(!Common.isEmpty(beginDate)){
			reportHarborFormMap.set("beginDate", beginDate+" 00:00:00");
		}
		if(!Common.isEmpty(endDate)){
			reportHarborFormMap.set("endDate", endDate+" 23:59:59");
		}
		String bId = reportHarborFormMap.getStr("bId");
		if(!Common.isEmpty(bId)){//单据号为必填项，若无单据号，则不做处理
			int maxLength = 0;
			//获取报港信息
			ReportHarborFormMap reportHarbor = reportHarborServer.printReportHarborByBId(bId);
			if(reportHarbor!=null){
				//1:出库，2：入库
				String inOrOut = reportHarbor.getStr("inOrOut");
				Properties properties = PropertiesUtils.getPropertyByName("weightConfig.properties");
				String companyName = properties.getProperty("companyName");
				String userName = reportHarbor.getStr("userName");
				if(inOrOut.equals("1")){
					reportHarbor.put("getOutCompany", companyName);
					reportHarbor.put("putInCompany", userName);
				}else{
					reportHarbor.put("getOutCompany", userName);
					reportHarbor.put("putInCompany", companyName);
				}
				
				reportHarbor.set("createDate", DateUtils.dateFormatToShortChinese(new Date()));
			}
			//根据条件获取称重信息
			List<WeighingFormMap> weighingList = weighingServer.findWeighingByAttr(reportHarborFormMap);
			//存放称重车辆名称
			Set<String> carName = new HashSet<String>();
			//存放处理后的数据List
			//Map key：为车辆，value：称重数据集合
			//List<Map> Map:存放皮重、毛重
			//List<Map<String,List<Map<String,String>>>> result = new ArrayList<Map<String,List<Map<String,String>>>>();
			
			List<FormMap<String,Object>> resultObject = new ArrayList<FormMap<String,Object>>();
			//存放车辆称重信息
			//Map<String,List<Map<String,String>>> carWeighingMap ;
			
			FormMap<String,Object> carWeighingFormMap;
			//当有数据时进行数据处理
			if(weighingList != null && weighingList.size()>0){
				//查找所使用车辆名称
				for(WeighingFormMap weighing:weighingList){
					carName.add(weighing.getStr("carId"));
				}
				
				for(String car:carName){ //根据车牌号进行遍历查询
					//存放称重信息，每条都包含皮重和毛重
					List<Map<String,String>> carWeighingList = new ArrayList<Map<String,String>>();
					
					//carWeighingMap = new HashMap<String,List<Map<String,String>>>();
					
					carWeighingFormMap = new FormMap<String,Object>();
					//存放临时的称重信息--主要是使毛重和皮重完整
					Map<String,String> temp = new HashMap<String,String>();
					String tarStr,grossWeightStr;
					//遍历所有的称重信息
					for(WeighingFormMap weighing:weighingList){
						String carId = weighing.getStr("carId");
						if(car.equals(carId)){ //车牌相同，进行数据处理转化
							Object tar = weighing.get("tare");
							Object grossWeight = weighing.get("grossWeight");
							if(tar != null){
								temp.put("tare", Math.round(Float.parseFloat(tar.toString()))+"");
							}
							if(grossWeight != null){
								temp.put("grossWeight", Math.round(Float.parseFloat(grossWeight.toString()))+"");
							}
							
							tarStr = temp.get("tare");
							grossWeightStr = temp.get("grossWeight");
							//当皮重和毛重都不为null时，说明一条完整信息
							if(!Common.isEmpty(tarStr) && !Common.isEmpty(grossWeightStr)){
								temp.put("trueWeight", Math.round(CalculateUtils.sub(grossWeightStr, tarStr))+"");
								//放入列表
								carWeighingList.add(temp);
								//清空数据
								temp = new HashMap<String,String>();
							}
							
						}
					}
					//寻找最长称重数据长度
					if(carWeighingList.size()>maxLength){
						maxLength = carWeighingList.size();
					}
					
					if(car.equals("脚粮")){ //判断是否是脚粮
						float totalGrossWeight = 0,totalTar = 0;;
						for(Map<String,String> map:carWeighingList){ //计算脚粮的总毛重和皮重
							totalGrossWeight+=Float.parseFloat(map.get("grossWeight"));
							totalTar+=Float.parseFloat(map.get("tare"));
						}
						if(totalGrossWeight - totalTar>0){//如果脚粮有重量，则添加，若无重量，则不进行操作
							carWeighingFormMap.put("carName", car);
							carWeighingFormMap.put("weighingList", carWeighingList);
							//carWeighingMap.put(car, carWeighingList);
							//result.add(carWeighingMap);
							resultObject.add(carWeighingFormMap);
						}
					}else{
						carWeighingFormMap.put("carName", car);
						carWeighingFormMap.put("weighingList", carWeighingList);
						//carWeighingMap.put(car, carWeighingList);
						//result.add(carWeighingMap);
						resultObject.add(carWeighingFormMap);
						//carWeighingMap.put(car, carWeighingList);
						//result.add(carWeighingMap);
					}
				}
			}
			//处理数据，使成为10 的整数被
			if(maxLength>0){
				int tem = maxLength %10;
				if(tem != 0){
					maxLength = (maxLength /10 + 1 )*10;
				}
				model.addAttribute("maxLength", maxLength);
			}
			model.addAttribute("carList", resultObject);
			model.addAttribute("reportHarbor", reportHarbor);
		}
		return Constant.BACKGROUND_PATH+"/weight/reportForms/printweighing";
	}
	
	
}
