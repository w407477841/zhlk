package com.zyiot.controller.baobiaochaxun;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
/**
 * 分点明细报表
 * @author Admin
 * @date 2017年12月28日 上午11:29:38
 */
@Controller
@RequestMapping("fendianmingxi")
public class FendianmingxiBaoBiaoController extends BaseController {
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
	
	@RequestMapping("list")
	public String list(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/baobiaochaxun/cangkubaobiao/fendianbaobiaolist";
	}
	
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
		model.addAttribute("mingcheng", mingcheng);
		model.addAttribute("locationId", locationStr);
		model.addAttribute("propertyList", propertyStr);
		model.addAttribute("varietyList", varietyStr);
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/baobiaochaxun/cangkubaobiao/fendianbaobiaoshow";
	}
	@RequestMapping("findDetailStorageByPage")
	@ResponseBody
	public MyPage<StorageInfoFormMap> findDetailStorageByPage(int page, int rows){
		StorageInfoFormMap storageInfoFormMap = getFormMap(StorageInfoFormMap.class);
		String locationList = storageInfoFormMap.getStr("locationList");
		String propertyList = storageInfoFormMap.getStr("propertyList");
		String varietyList = storageInfoFormMap.getStr("varietyList");
		String selectmingcheng = storageInfoFormMap.getStr("selectmingcheng");
		if(!Common.isEmpty(locationList)){  //选择库点
			List<Integer> lList = new ArrayList<Integer>();
			String[] arr = locationList.substring(0, locationList.length()-1).split(",");
			for(String str:arr){
				lList.add(Integer.parseInt(str));
			}
			storageInfoFormMap.set("locationList", lList);
		}else{//未选择库点
			if(!Common.isEmpty(selectmingcheng)){  //选择企业
				List<Integer> lList = new ArrayList<Integer>();
				List<WarehouseLocationInterfaceFormMap> list = warehouseLocationInterfaceServer.findAllByXinYongDaiMa(selectmingcheng);
				for(WarehouseLocationInterfaceFormMap form:list){
					lList.add(Integer.parseInt(form.getStr("location_no")));
				}
				storageInfoFormMap.set("locationList", lList);
			}
		}
		if(!Common.isEmpty(propertyList)){ //选择粮食属性
			List<Integer> lList = new ArrayList<Integer>();
			String[] arr = propertyList.substring(0, propertyList.length()-1).split(",");
			for(String str:arr){
				lList.add(Integer.parseInt(str));
			}
			storageInfoFormMap.set("propertyList", lList);
		}
		if(!Common.isEmpty(varietyList)){//选择粮食品种
			List<Integer> lList = new ArrayList<Integer>();
			String[] arr = varietyList.substring(0, varietyList.length()-1).split(",");
			for(String str:arr){
				lList.add(Integer.parseInt(str));
			}
			storageInfoFormMap.set("varietyList", lList);
		}
		List<StorageInfoFormMap> list = storageService.findDetailStorageByPage(storageInfoFormMap, rows, page);
		return toMyPage(list);
	}
	
	@RequestMapping("export")
	public void report(HttpServletRequest request,HttpServletResponse response) {
		//企业
		String mingcheng = request.getParameter("mingcheng");
		//仓房
		String locationStr = request.getParameter("locationId");
		//性质
		String propertyStr = request.getParameter("propertyList");
		//品种
		String varietyStr = request.getParameter("varietyList");
		
		//参数
		FormMap<String,Object> param = new FormMap<String,Object>();
		
		//性质列表
		List<Integer> propertyList = new ArrayList<Integer>();
		//粮库列表
		List<Integer> LocationList = new ArrayList<Integer>();
		//品种列表
		List<String> varietyList = new ArrayList<String>();
		
		
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
		
		List<StorageInfoFormMap> ls = storageService.findAllGrainProperty();
		Map<String,String> propertyMap = new HashMap<String,String>();
		for(StorageInfoFormMap form:ls){
			propertyMap.put(form.getInt("quanZhong")+"", form.getStr("text"));
		}
		
		if(!Common.isEmpty(locationStr)){//选择粮库
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
			for(int i=0;i<arr.length;i++){
				if(i<2){ //最多显示两个性质
					propertyList.add(Integer.parseInt(arr[i]));					
				}
			}
		}else{ //未选择粮食性质
			for(int i = 0;i<ls.size();i++){
				if(i<2){ //最多显示两个性质
					StorageInfoFormMap form = ls.get(i);
					propertyList.add(form.getInt("quanZhong"));					
				}
			}
		}
		
		if(!Common.isEmpty(varietyStr)){//选择粮食品种
			String[] arr = varietyStr.substring(0, varietyStr.length()-1).split(",");
			for(int i=0;i<arr.length;i++){
				if(i<2){
					varietyList.add(arr[i]);					
				}
			}
		}else{ //未选择粮食品种
			List<StorageInfoFormMap> list = storageService.findAllGrainVariety();
			for(int i=0;i<list.size();i++){
				if(i<2){
					StorageInfoFormMap form = list.get(i);
					varietyList.add(form.getStr("variety"));
				}
			}
		}
		//查询粮食属性
		StringBuffer propertyBuffer = new StringBuffer();
		//查询库点
		StringBuffer localtionBuffer = new StringBuffer();
		//查询粮食品种
		StringBuffer varietyBuffer = new StringBuffer();
		
		//显示粮食属性
		List<Map<String,String>> property = new ArrayList<Map<String,String>>();
		//显示粮食品种
		List<Map<String,String>> variety = new ArrayList<Map<String,String>>();
		Map<String,String> map = new HashMap<String,String>();
		for(int i = 0;i<propertyList.size();i++){
				propertyBuffer.append("\"");
				propertyBuffer.append(propertyList.get(i));
				propertyBuffer.append("\"");
				propertyBuffer.append(",");
				
				map = new HashMap<String,String>();
				map.put("id", propertyList.get(i)+"");
				map.put("propertyName", propertyMap.get(propertyList.get(i)+""));
				property.add(map);
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
				varietyBuffer.append("\"");
				varietyBuffer.append(varietyList.get(i));
				varietyBuffer.append("\"");
				varietyBuffer.append(",");
				
				map = new HashMap<String,String>();
				map.put("id", varietyList.get(i));
				map.put("varietyName", varietyMap.get(varietyList.get(i)));
				variety.add(map);
		}
		
		//查询条件
	    FormMap<String,Object> base = new FormMap<String,Object>();
	    base.set("LocationList", LocationList);
	    base.set("propertyList", propertyList);
	    base.set("varietyList", varietyList);
	    //查询汇总数据
	    List<StorageInfoFormMap> storageList = storageService.findSumStorage(base);
	    List<String> daima = new ArrayList<String>();
	    if(!Common.isEmpty(mingcheng)){
	    	daima.add(mingcheng);
	    }else{
	    	for(StorageInfoFormMap form:storageList){
	    		if(!daima.contains(form.getStr("tongyixinyongdaima"))){
	    			if(!Common.isEmpty(form.getStr("tongyixinyongdaima"))){
	    				daima.add(form.getStr("tongyixinyongdaima"));	    				
	    			}
	    		}
	    	}
	    }
	    List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
	    Map<String,Object> total = new HashMap<String,Object>();
	    Map<String,Object>  maps;
	    //NumberFormat nf = NumberFormat.getInstance();
		//nf.setGroupingUsed(false);
		DecimalFormat df = new DecimalFormat(",###");
	    for(String dm:daima){
	    	 maps = new HashMap<String,Object>();
	    	
	    	for(StorageInfoFormMap form:storageList){
	    		//信用代码一致
	    		if(dm.equals(form.getStr("tongyixinyongdaima"))){
	    			maps.put("companyName", form.getStr("qiyemingcheng"));
	    			String v = form.getStr("name");
	    			String p = form.getStr("quanZhong");
	    			for(int i = 0;i<propertyList.size();i++){
	    				for(int j = 0;j<varietyList.size();j++){
	    					if(propertyList.get(i) == Integer.parseInt(p) && varietyList.get(j).equals(v)){
	    						 maps.put("totalWeight"+(i*2+j+1), df.format(form.getDouble("totalWeight")));
	    						 Object obj =  total.get("totalWeight"+(i*2+j+1));
	    						 double totalWeight = 0;
	    						 if(obj != null){
	    							 totalWeight = Double.parseDouble(obj.toString().replace(",", ""));
	    						 }
	    						 total.put("totalWeight"+(i*2+j+1),df.format(totalWeight+form.getDouble("totalWeight")));
	    					}
	    				}
	    			}
	    		}
	    	}
	    	if(!maps.isEmpty()){
	    		result.add(maps);
	    	}
	    }
	    if(!total.isEmpty()){
	    	total.put("companyName", "合计");
	    	result.add(total);
	    }
	    
	    
	   
//	    map.put("companyName", "江苏中源物联网");
//	    map.put("propertyId", "99");
//	    map.put("varietyId", "111");
//	    map.put("totalWeight", "2365963");
//	    result.add(map);
//	    
//	    map = new HashMap<String,String>();
//	    map.put("companyName", "江苏中源物联网1");
//	    map.put("propertyId", "112");
//	    map.put("varietyId", "112");
//	    map.put("totalWeight", "123456");
//	    result.add(map);
		
		param.set("locationStr", localtionBuffer.toString());
		param.set("varietyStr", varietyBuffer.toString().substring(0, varietyBuffer.toString().length()-1));
		param.set("propertyStr", propertyBuffer.toString().substring(0, propertyBuffer.toString().length()-1));
		param.set("propertyList", property);
		param.set("varietyList", variety);
		
		param.set("dataList", result);
		param.set("createDate", DateUtils.dateFormatToShortChinese(new Date()));
		//方式
		String showType = request.getParameter("showType");
		if(showType.equalsIgnoreCase("html")){
			JasperHelper.export(showType, "分点明细报表", "detailStorageHtml.jasper", param, dataSource, request, response);
		}else{
			JasperHelper.export(showType, "分点明细报表", "detailStorage.jasper", param, dataSource, request, response);
		}
	}
}
