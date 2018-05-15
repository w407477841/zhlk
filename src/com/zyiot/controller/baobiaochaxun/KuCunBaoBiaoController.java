package com.zyiot.controller.baobiaochaxun;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.weight.VarietyFormMap;
import com.zyiot.entity.yuanchengjiankongjiekou.WarehouseLocationInterfaceFormMap;
import com.zyiot.server.StorageServerI;
import com.zyiot.server.StorageServiceI;
import com.zyiot.server.weight.VarietyServerI;
import com.zyiot.server.yuanchengjiankongjiekou.WarehouseLocationInterfaceServerI;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.JasperHelper;
import com.zyiot.util.MyPage;
import com.zyiot.util.PropertiesUtils;
/**
 * 实时库存报表
 * @author Admin
 * @date 2017年12月28日 上午11:31:14
 */
@Controller
@RequestMapping("kucunbaobiao")
public class KuCunBaoBiaoController extends BaseController {
	@Autowired	
	private StorageServerI   sService;
	@Autowired
	private StorageServiceI   storageService;
	@Autowired
	private DataSource dataSource;
	@Autowired
	private VarietyServerI varietyServer;
	
	@Autowired
	private WarehouseLocationInterfaceServerI warehouseLocationInterfaceServer;
	/**
	 * 显示库存列表
	 * @return
	 */
	@RequestMapping("list")
	public String list(Model model){
		Properties properties = PropertiesUtils.getPropertyByName("weightConfig.properties");
		model.addAttribute("writeUnit", properties.getProperty("companyName"));
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/baobiaochaxun/cangkubaobiao/kucunbaobiaolist";
	}
	/**
	 * 显示库存报表数据
	 * @return
	 */
	@RequestMapping("show")
	public String show(Model model){
		//企业
		String mingcheng = getPara("mingcheng");
		//仓房
		String locationStr = getPara("locationId");
		//性质
		String propertyStr = getPara("propertyList");
		//品种
		String varietyStr = getPara("varietyList");
		//单位
		String writeUnit =getPara("writeUnit");
		
		//String writeDate = getPara("writeDate");
		String writeDate = DateUtils.dateFormatToShortChinese(new Date());
		
		model.addAttribute("mingcheng", mingcheng);
		model.addAttribute("locationId", locationStr);
		model.addAttribute("propertyList", propertyStr);
		model.addAttribute("varietyList", varietyStr);
		model.addAttribute("writeUnit", writeUnit);
		model.addAttribute("writeDate", writeDate);
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/baobiaochaxun/cangkubaobiao/kucunbaobiaoshow";
	}
	/**
	 * 查询数据
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("findCurrentStorageByPage")
	@ResponseBody
	public MyPage<StorageInfoFormMap> findCurrentStorageByPage(int page, int rows){
		StorageInfoFormMap storageInfoFormMap = getFormMap(StorageInfoFormMap.class);
		String locationList = storageInfoFormMap.getStr("locationList");
		String propertyList = storageInfoFormMap.getStr("propertyList");
		String varietyList = storageInfoFormMap.getStr("varietyList");
		String selectmingcheng = storageInfoFormMap.getStr("selectmingcheng");
		if(!Common.isEmpty(locationList)){
			List<Integer> lList = new ArrayList<Integer>();
			String[] arr = locationList.substring(0, locationList.length()-1).split(",");
			for(String str:arr){
				lList.add(Integer.parseInt(str));
			}
			storageInfoFormMap.set("locationList", lList);
		}else{
			if(!Common.isEmpty(selectmingcheng)){
				List<Integer> lList = new ArrayList<Integer>();
				List<WarehouseLocationInterfaceFormMap> list = warehouseLocationInterfaceServer.findAllByXinYongDaiMa(selectmingcheng);
				for(WarehouseLocationInterfaceFormMap form:list){
					lList.add(Integer.parseInt(form.getStr("location_no")));
				}
				storageInfoFormMap.set("locationList", lList);
			}
		}
		if(!Common.isEmpty(propertyList)){
			List<Integer> lList = new ArrayList<Integer>();
			String[] arr = propertyList.substring(0, propertyList.length()-1).split(",");
			for(String str:arr){
				lList.add(Integer.parseInt(str));
			}
			storageInfoFormMap.set("propertyList", lList);
		}
		if(!Common.isEmpty(varietyList)){
			List<Integer> lList = new ArrayList<Integer>();
			String[] arr = varietyList.substring(0, varietyList.length()-1).split(",");
			for(String str:arr){
				lList.add(Integer.parseInt(str));
			}
			storageInfoFormMap.set("varietyList", lList);
		}
		List<StorageInfoFormMap> list = storageService.findCurrentStorageByPage(storageInfoFormMap, rows, page);
		return toMyPage(list);
	}
	@RequestMapping("export")
	public void report(HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
		}
		//企业
		String mingcheng = request.getParameter("mingcheng");
		//仓房
		String locationStr = request.getParameter("locationId");
		//性质
		String propertyStr = request.getParameter("propertyList");
		//品种
		String varietyStr = request.getParameter("varietyList");
		//单位
		String writeUnit = request.getParameter("writeUnit").trim();
		//方式
		String showType = request.getParameter("showType");
		if(showType.equalsIgnoreCase("html")){
			try {
				writeUnit = new String(writeUnit.getBytes("iso-8859-1"), "utf-8");
			} catch (UnsupportedEncodingException e) {
				
			}
		}else{
			try {
				writeUnit = URLDecoder.decode(writeUnit.trim(), "utf-8");
				writeUnit = new String(writeUnit.getBytes("iso-8859-1"), "utf-8");
			} catch (UnsupportedEncodingException e) {
			}
		}
		
		//日期
		//String writeDate = request.getParameter("writeDate");
		String writeDate = DateUtils.dateFormatToShortChinese(new Date());
		//参数
		FormMap<String,Object> param = new FormMap<String,Object>();
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		//性质列表
		List<Integer> propertyList = new ArrayList<Integer>();
		//粮库列表
		List<Integer> LocationList = new ArrayList<Integer>();
		//品种列表
		List<String> varietyList = new ArrayList<String>();
		//获取📱目录，粮食品种不进行详细分类
		Map<String,String> varietyMap = new HashMap<String,String>();
		List<VarietyFormMap> vlist = varietyServer.findTopMenuVariety();
		for(VarietyFormMap v:vlist){
			varietyMap.put(v.getInt("id").toString(), v.getStr("definedText"));
		}
//		varietyMap.put("111", "小麦");
//		varietyMap.put("112", "玉米");
//		varietyMap.put("113", "稻谷");
//		varietyMap.put("119", "谷物");
//		varietyMap.put("211", "压榨油");
//		varietyMap.put("212", "浸出油");
//		varietyMap.put("231", "小麦粉");
//		varietyMap.put("232", "混合小麦粉");
//		varietyMap.put("236", "大米");
		
		if(!Common.isEmpty(locationStr)){  //未选择粮库
			String[] arr = locationStr.substring(0, locationStr.length()-1).split(",");
			for(String str:arr){
				LocationList.add(Integer.parseInt(str));
			}
		}else{
			if(Common.isEmpty(mingcheng)){  //未选择企业
				List<StorageInfoFormMap> list = storageService.findAllWarehouseLocation();
				for(StorageInfoFormMap form:list){
					LocationList.add(Integer.parseInt(form.getStr("source")));
				}
			}else{
				List<WarehouseLocationInterfaceFormMap> list = warehouseLocationInterfaceServer.findAllByXinYongDaiMa(mingcheng);
				for(WarehouseLocationInterfaceFormMap form:list){
					LocationList.add(Integer.parseInt(form.getStr("location_no")));
				}
			}
		}
		if(!Common.isEmpty(propertyStr)){//选择粮食性质
			String[] arr = propertyStr.substring(0, propertyStr.length()-1).split(",");
			for(String str:arr){
				propertyList.add(Integer.parseInt(str));
			}
		}else{ //未选择粮食性质
			List<StorageInfoFormMap> list = storageService.findAllGrainProperty();
			for(StorageInfoFormMap form:list){
				propertyList.add(form.getInt("quanZhong"));
			}
		}
		
		if(!Common.isEmpty(varietyStr)){//选择粮食品种
			String[] arr = varietyStr.substring(0, varietyStr.length()-1).split(",");
			for(String str:arr){
				varietyList.add(str);
			}
		}else{ //未选择粮食品种
			List<StorageInfoFormMap> list = storageService.findAllGrainVariety();
			for(StorageInfoFormMap form:list){
				varietyList.add(form.getStr("variety"));
			}
		}
		
		FormMap<String,Object> base = new FormMap<String,Object>();
		base.put("propertyList", propertyList);
		base.put("LocationList", LocationList);
		base.put("varietyList", varietyList);
		
		List<StorageInfoFormMap> list = storageService.findCurrentTotalWeight(base);
		Map<String,Object> temp;
		for(int property:propertyList){
			temp = new HashMap<String,Object>();
			for(StorageInfoFormMap formMap:list){
				int p = Integer.parseInt(formMap.getStr("quanZhong"));
				if(property == p){
					temp.put("grainProperty", formMap.getStr("grainProperty"));
					double weight = formMap.getDouble("weight").doubleValue();
					//NumberFormat nf = NumberFormat.getInstance();
					//nf.setGroupingUsed(false);
					
					DecimalFormat df = new DecimalFormat(",###");
					for(int i =0;i<varietyList.size();i++){  //遍历选中的品种--最多三个品种
						String var = varietyList.get(i);
						if(formMap.getStr("variety").equals(var)){
							//保证其品种排序--在表格中的排序
							temp.put("key"+i, df.format(weight));
						}
					}
					
				}
			}
			if(!temp.isEmpty()){
				for(int i =0;i<varietyList.size();i++){  //遍历选中的品种--最多三个品种
					String var = varietyList.get(i);
					temp.put("keyName"+i, varietyMap.get(var));
				}
				result.add(temp);
			}
		}
		
		StringBuffer propertyBuffer = new StringBuffer();
		StringBuffer localtionBuffer = new StringBuffer();
		StringBuffer vaietyBuffer = new StringBuffer();
		
		for(int i = 0;i<propertyList.size();i++){
			if(i == propertyList.size()-1){
				propertyBuffer.append("\"");
				propertyBuffer.append(propertyList.get(i));
				propertyBuffer.append("\"");
			}else{
				propertyBuffer.append("\"");
				propertyBuffer.append(propertyList.get(i));
				propertyBuffer.append("\"");
				propertyBuffer.append(",");
			}
		}
		for(int i = 0;i<LocationList.size();i++){
			if(i == LocationList.size()-1){
				localtionBuffer.append("\"");
				localtionBuffer.append(LocationList.get(i));
				localtionBuffer.append("\"");
			}else{
				localtionBuffer.append("\"");
				localtionBuffer.append(LocationList.get(i));
				localtionBuffer.append("\"");
				localtionBuffer.append(",");
			}
		}
		for(int i = 0;i<varietyList.size();i++){
			if(i == varietyList.size()-1){
				vaietyBuffer.append("\"");
				vaietyBuffer.append(varietyList.get(i));
				vaietyBuffer.append("\"");
			}else{
				vaietyBuffer.append("\"");
				vaietyBuffer.append(varietyList.get(i));
				vaietyBuffer.append("\"");
				vaietyBuffer.append(",");
			}
		}
		param.set("locationList", localtionBuffer.toString());
		param.set("propertyList", propertyBuffer.toString());
		param.set("varietyList", vaietyBuffer.toString());
		
		param.set("tempList", result);
		param.set("writeUnit", writeUnit);
		param.set("writeDate", writeDate);
		if(showType.equalsIgnoreCase("html")){
			JasperHelper.export("html", "实时库存报表", "storageReportHtml.jasper", param, dataSource, request, response);
		}else{
			JasperHelper.export(showType, "实时库存报表", "storageReport.jasper", param, dataSource, request, response);
		}
	}
}
