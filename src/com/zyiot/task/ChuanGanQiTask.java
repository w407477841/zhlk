package com.zyiot.task;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import com.zyiot.entity.ChuanGanQiBaoJingFormMap;
import com.zyiot.entity.ChuanGanQiDataFormMap;
import com.zyiot.entity.ChuanGanQiFormMap;
import com.zyiot.mapper.ChuanGanQiBaoJingMapper;
import com.zyiot.mapper.ChuanGanQiDataMapper;
import com.zyiot.mapper.ChuanGanQiMapper;
import com.zyiot.util.BatchInsertParameter;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.PropertiesUtils;

@Component
@Lazy(false)
public class ChuanGanQiTask {
	@Autowired
	ChuanGanQiMapper chuanGanQiMapper;
	@Autowired
	ChuanGanQiDataMapper chuanGanQiDataMapper;
	@Autowired
	ChuanGanQiBaoJingMapper chuanGanQiBaoJingMapper;

	//@Scheduled(cron = "0 15 *  * * ? ")
	public void taskSaveDatas() throws Exception {
		List<ChuanGanQiDataFormMap> list = new ArrayList<ChuanGanQiDataFormMap>();
		//获取所有传感器数据
		List<ChuanGanQiFormMap> l = chuanGanQiMapper.findByAttr(new ChuanGanQiFormMap());

		int size = l.size();
		String time = DateUtils.dateFormatToLong(new Date());
		
		Properties properties = PropertiesUtils.getPropertyByName("qitibaojing.properties");
		//数据是否过滤，1：不过滤，2：过滤
		String dataFilter = properties.getProperty("dataFilter");
		//氧气基准值
		int baselineO2 = Integer.parseInt(properties.getProperty("baseline_o2"));
		//氧气误差范围
		int errorValueO2 = Integer.parseInt(properties.getProperty("error_value_o2"));
		//氧气小数位
		int decimalO2 = Integer.parseInt(properties.getProperty("decimal_o2"));
		//氧气正常范围值
		String[] normalRangeO2 = properties.getProperty("normal_range_o2").split("-");
		
		//二氧化碳基准值
		int baselineCO2 = Integer.parseInt(properties.getProperty("baseline_co2"));
		//二氧化碳误差范围
		int errorValueCO2 = Integer.parseInt(properties.getProperty("error_value_co2"));
		//二氧化碳小数位
		int decimalCO2 = Integer.parseInt(properties.getProperty("decimal_co2"));
		//二氧化碳正常范围值
		String[] normalRangeCO2 = properties.getProperty("normal_range_co2").split("-");
		
		//磷化氢是否过滤，1：不过滤，2：过滤
		String dataFilterPh3 = properties.getProperty("data_filter_ph3");
		//数据基值
		String baseData = properties.getProperty("basedata_ph3");
		//数据范围值
		String[] normalRangePh3 = properties.getProperty("normal_range_ph3").split("-");
		ChuanGanqiClient client = null;
		for (int i = 0; i < size; i++) {
			ChuanGanQiFormMap cgq = l.get(i);
			String ip = cgq.getStr("cIp");
			String port = cgq.getStr("cPort");
			String zl = cgq.getStr("zl");
			String id = cgq.get("id") + "";
			String lx = cgq.getStr("lx");
			
			client = new ChuanGanqiClient(ip, Integer.parseInt(port));
			ChuanGanQiDataFormMap f = new ChuanGanQiDataFormMap();
			String datas = client.getStr(zl);
			
			//数据过滤，并且是氧气或者二氧化碳
			if((lx.equals("o2") || lx.equals("co2")) && dataFilter.equals("2")){
				if(lx.equals("o2")){//氧气值过滤
					//获取氧气的值
					float o = Float.parseFloat(datas);
					//最小值
					float min = Float.parseFloat(normalRangeO2[0]);
					//最大值
					float max = Float.parseFloat(normalRangeO2[1]);
					if(o<min || o>max){//不在取值范围内
						String temp = Common.random(baselineO2, errorValueO2, decimalO2);
						f.put("datas", temp);
					}else{//正常数据
						f.put("datas", datas);
					}
				}else if(lx.equals("co2")){//二氧化碳值过滤
					//获取二氧化碳的值
					float co = Float.parseFloat(datas);
					//最小值
					float min = Float.parseFloat(normalRangeCO2[0]);
					//最大值
					float max = Float.parseFloat(normalRangeCO2[1]);
					if(co<min || co>max){//不在取值范围内
						String temp = Common.random(baselineCO2, errorValueCO2, decimalCO2);
						f.put("datas", temp);
					}else{//正常数据
						f.put("datas", datas);
					}
				}
			} 
			//数据过滤，并且是磷化氢
			else if((lx.equals("h3p") || lx.equals("h3pW")) && dataFilterPh3.equals("2")){
				//获取磷化氢的值
				float ph = Float.parseFloat(datas);
				//最小值
				float min = Float.parseFloat(normalRangePh3[0]);
				//最大值
				float max = Float.parseFloat(normalRangePh3[1]);
				if(ph<min || ph>max){//不在取值范围内
					f.put("datas", baseData);
				}else{//正常数据
					f.put("datas", datas);
				}
			}else{
				f.put("datas", datas);
			}
			
//			if(dataFilter.equals("2")){//进行数据过滤(co2,o2)
//				if(lx.equals("o2")){//氧气值过滤
//					//获取氧气的值
//					float o = Float.parseFloat(datas);
//					//最小值
//					float min = Float.parseFloat(normalRangeO2[0]);
//					//最大值
//					float max = Float.parseFloat(normalRangeO2[1]);
//					if(o<min || o>max){//不在取值范围内
//						String temp = Common.random(baselineO2, errorValueO2, decimalO2);
//						f.put("datas", temp);
//					}else{//正常数据
//						f.put("datas", datas);
//					}
//				}else if(lx.equals("co2")){//二氧化碳值过滤
//					//获取二氧化碳的值
//					float co = Float.parseFloat(datas);
//					//最小值
//					float min = Float.parseFloat(normalRangeCO2[0]);
//					//最大值
//					float max = Float.parseFloat(normalRangeCO2[1]);
//					if(co<min || co>max){//不在取值范围内
//						String temp = Common.random(baselineCO2, errorValueCO2, decimalCO2);
//						f.put("datas", temp);
//					}else{//正常数据
//						f.put("datas", datas);
//					}
//				}else{ //磷化氢
//					if(dataFilterPh3.equals("2")){//磷化氢过滤
//						//获取磷化氢的值
//						float ph = Float.parseFloat(datas);
//						//最小值
//						float min = Float.parseFloat(normalRangePh3[0]);
//						//最大值
//						float max = Float.parseFloat(normalRangePh3[1]);
//						if(ph<min || ph>max){//不在取值范围内
//							f.put("datas", baseData);
//						}else{//正常数据
//							f.put("datas", datas);
//						}
//					}else{
//						f.put("datas", datas);
//					}
//				}
//			}else{ //未进行数据过滤(co2,o2)
//				if(dataFilterPh3.equals("2")){//磷化氢过滤
//					if(lx.equals("h3p") || lx.equals("h3pW")){ //是否是磷化氢，是的进行处理
//						//获取磷化氢的值
//						float ph = Float.parseFloat(datas);
//						//最小值
//						float min = Float.parseFloat(normalRangePh3[0]);
//						//最大值
//						float max = Float.parseFloat(normalRangePh3[1]);
//						if(ph<min || ph>max){//不在取值范围内
//							f.put("datas", baseData);
//						}else{//正常数据
//							f.put("datas", datas);
//						}
//					}else{
//						f.put("datas", datas);
//					}
//				}else{//不进行过滤
//					f.put("datas", datas);
//				}
//				f.put("datas", datas);
//			}
			
			f.put("chuanganqi_id", id);
			f.put("cjsj", time);
			list.add(f);
			client.close();
			Thread.sleep(500);
		}
		if (client != null)
			client.close();
		chuanGanQiDataMapper.batchSave(BatchInsertParameter.wrap(list));
		baojing();
	}

	
	public void baojing() throws Exception {
		List<ChuanGanQiDataFormMap> datas = chuanGanQiDataMapper.getAllDatas();
		List<ChuanGanQiBaoJingFormMap> batchList = new ArrayList<ChuanGanQiBaoJingFormMap>();
		Map<String, String> m = new HashMap<String, String>();
		m.put("h3p", "lhq");
		m.put("h3pW", "cwlhq");
		m.put("o2", "yq");
		m.put("co2", "eyht");
		int size = datas.size();
		for (int i = 0; i < size; i++) {
			ChuanGanQiDataFormMap data = datas.get(i);
			String[] cgqNames = data.getStr("cgqName").split(",");
			String[] dataArray = data.getStr("datas").split(",");
			int j = 0;
			for (String s : cgqNames) {

				Double d1 = Double.parseDouble(dataArray[j].replace("PPM", "")
						.replace("VOL%", ""));
				Double d2 = Double.parseDouble(PropertiesUtils
						.getPropertyByName("qitibaojing.properties")
						.getProperty(m.get(s)));
				if (d1 >= d2) {
					if (s.equals("h3pW")) {
						s = "";
					} else if (s.equals("h3p")) {
						s = "磷化氢";
					} else if (s.equals("co2")) {
						s = "二氧化碳";
					} else if (s.equals("o2")) {
						s = "氧气";
					}
					ChuanGanQiBaoJingFormMap baojing = new ChuanGanQiBaoJingFormMap();
					baojing.put("common", data.getStr("ckName") + s + "已超过预设值"
							+ "  当前：<font color='red'>" + d1 + "</font>");
					baojing.put("cjsj", data.getStr("cjsj"));
					batchList.add(baojing);
				}
				j++;

			}
			if (batchList.size() > 0) {
				chuanGanQiBaoJingMapper.batchSave(BatchInsertParameter
						.wrap(batchList));
			}
		}
	}
}

class ChuanGanQiThread implements Runnable {
	private String ip;
	private String port;
	private String zl;
	private String data;
	private String chuanganqi_id;
	private String time;
	private List<ChuanGanQiDataFormMap> list;

	public ChuanGanQiThread(String ip, String port, String zl, List<ChuanGanQiDataFormMap> list,
			String chuanganqi_id, String cjsj) {
		this.ip = ip;
		this.port = port;
		this.zl = zl;
		this.list = list;
		this.chuanganqi_id = chuanganqi_id;
		this.time = cjsj;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public void run() {

		try {
			ChuanGanqiClient client = new ChuanGanqiClient(ip,
					Integer.parseInt(port));

			setData(client.getStr(zl));
			ChuanGanQiDataFormMap f = new ChuanGanQiDataFormMap();
			f.put("datas", getData());
			f.put("chuanganqi_id", chuanganqi_id);
			f.put("cjsj", time);
			synchronized (list) {
				list.add(f);
			}
			Thread.sleep(500);
		} catch (InterruptedException e) {

		}

	}
}