package com.zyiot.task;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import com.zyiot.entity.TemperatureAlarmFormMap;
import com.zyiot.entity.WarehouseInfoFormMap;
import com.zyiot.entity.WarehouseInfoTransformFormMap;
import com.zyiot.entity.dataDocking.InterfaceDataConfigFormMap;
import com.zyiot.server.TemperatureAlarmServerI;
import com.zyiot.server.WarehouseInfoServerI;
import com.zyiot.server.dataDocking.InterfaceDataConfigServerI;
import com.zyiot.util.BatchInsertParameter;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.PropertiesUtils;
/**
 * 定时获取最高温度和最低温度为NULL的温度信息值
 * 并根据温度数据组进行计算最高温度和最低温度，并更新数据。
 * @author Lip
 *
 */
@Component
@Lazy(false)
public class WarehouseInfoTask {
	Logger log = Logger.getLogger(WarehouseInfoTask.class);
	@Autowired
	private WarehouseInfoServerI warehouseInfoServer;
	@Autowired
	private InterfaceDataConfigServerI interfaceDataConfigServer;
	@Autowired
	private TemperatureAlarmServerI temperatureAlarmServer;
	/**
	 * 获取温度的最大值和最小值
	 * @author Lip
	 * 每天六点定时执行
	 */
	//@Scheduled(cron="0 0/20 * * * ? ")
	public void getValuesOfMaxAndMin()
	{
		log.info("========获取仓房最高和最低温度===========");
		log.info("=============开始==================");
		
		//获取为空的数据
		List<WarehouseInfoFormMap> lists = new ArrayList<WarehouseInfoFormMap>();
		List<WarehouseInfoFormMap> results = new ArrayList<WarehouseInfoFormMap>();
		try {
			lists = warehouseInfoServer.findMaxAndMinValuesOfNull();
		} catch (Exception e) {
			log.error("==========数据获取有误========="+e);
		}
		//判断是否有数据
		if(lists != null && lists.size()>0){
			Date beginDate = new Date();
			
			int total = 0;
			WarehouseInfoFormMap warehouseInfoFormMap;
			
			for(WarehouseInfoFormMap warehouseInfo:lists){
				float max = 0f;
				float min = 0f;
				float temp = 0f;
				//获取温度集合
				String info = warehouseInfo.getStr("wCoordinate");
				if(!Common.isEmpty(info)){
					String [] temperatures = info.split(" ");
					if(temperatures !=null && temperatures.length>0){
						//把第一个数据赋值为最大值和最小值
						try {
							if(Common.isCanConvertFloat(temperatures[0])){
								temp = Float.parseFloat(temperatures[0]);
								min = temp;
								max = temp;
							}
						} catch (NumberFormatException e2) {
							log.error("===数据转换异常:id："+warehouseInfo.getInt("id")+",data:"+temperatures[0]+"===");
						}
						for(String temperature:temperatures){
							try {
								if(Common.isCanConvertFloat(temperature)){
									temp = Float.parseFloat(temperature);
									if(temp>max){
										max = temp;
									}else if(temp<min){
										min = temp;
									}
								}
							} catch (NumberFormatException e) {
								log.error("===数据转换异常:id："+warehouseInfo.getInt("id")+",data:"+temperature+"===");
							}
						}
						warehouseInfoFormMap = new WarehouseInfoFormMap();
						
						warehouseInfoFormMap.set("id", warehouseInfo.getInt("id"));
						warehouseInfoFormMap.set("maxTemperature", max);
						warehouseInfoFormMap.set("minTemperature", min);
						results.add(warehouseInfoFormMap);
						
						
					}else{
						log.info("=========id："+warehouseInfo.getInt("id")+",wCoordinate:转换后为NULL=======");
					}
				}else{
					log.info("=========id："+warehouseInfo.getInt("id")+",wCoordinate:NULL=======");
				}
			}
			
			if(results !=null && results.size()>0){
				//批量更新的最大条数限制
				//由于数据处理块能够存1048576，所以数据过长会抛出异常
				//com.mysql.jdbc.PacketTooBigException
				int baseInt = 8000;
				if(results.size()>baseInt){
					int count = results.size();
					int groups = 0;
					if(count%baseInt == 0){
						groups = count/baseInt;
					}else{
						groups = count/baseInt + 1;
					}
					
					for(int i = 0;i<groups;i++){
						int updateCount = 0;
						if(i== (groups-1)){
							 try {
								 updateCount = warehouseInfoServer.bashUpdateMaxAndMinValues(results.subList(i*baseInt, i*baseInt+count%baseInt));
								 if(updateCount == 1){
									 total+=count%baseInt;
								 }
							} catch (Exception e) {
								log.error("=======bashUpdateMaxAndMinValues========="+e);
							}
						}else{
							try {
								updateCount = warehouseInfoServer.bashUpdateMaxAndMinValues(results.subList(i*baseInt, (i+1)*baseInt));
								if(updateCount == 1){
									 total+=baseInt;
								 }
							} catch (Exception e) {
								log.error("=======bashUpdateMaxAndMinValues========="+e);
							}
						}
					}
					
				}else{
					try {
						total = warehouseInfoServer.bashUpdateMaxAndMinValues(results);
						if(total == 1){
							total = results.size();
						}
					} catch (Exception e) {
						log.error("=======bashUpdateMaxAndMinValues========="+e);
					}
				}
			}
			
			log.info("=========需要转换的数据条数："+lists.size()+"=======");
			log.info("====开始转换时间："+DateUtils.dateFormatToLong(beginDate)+"=====");
			
			
			Date endDate = new Date();
			log.info("====结束转换时间："+DateUtils.dateFormatToLong(endDate)+"=====");
			
			log.info("=========数据转换成功条数："+total+"=======");
		}else{
			log.info("=============无数据==================");
		}
		
		log.info("=============结束==================");
	}

	/**
	 * @author Lip
	 * 
	 * 温度报表生成，温度进行转换
	 */
	//@Scheduled(cron="0 0/20 * * * ? ")
	public void getNeedTransformData(){
		List<WarehouseInfoFormMap> lists = new ArrayList<WarehouseInfoFormMap>();
		try {
			lists = warehouseInfoServer.findNeedTransformData();
		} catch (Exception e) {
			log.error("===Class:WarehouseInfoTask==Method:getNeedTransformData==Exception:findNeedTransformData=="+e);
			return;
		}
		
		if(lists!=null && lists.size()>0){
			WarehouseInfoTransformFormMap transformMap;
			for(WarehouseInfoFormMap warehouseInfo:lists){
				int layer = warehouseInfo.getInt("wHeight");
				int column = warehouseInfo.getInt("wColumn");
				int row = warehouseInfo.getInt("wRow");
				int id = warehouseInfo.getInt("id");
				String data = warehouseInfo.getStr("wCoordinate");
				String[] dataArr = data.split(" ");
				if(dataArr.length == layer*column*row){
					List<WarehouseInfoTransformFormMap> result = new ArrayList<WarehouseInfoTransformFormMap>();
					for(int r = 0;r<row;r++){ //行
						for(int l=0;l<layer;l++){ //层
							transformMap = new WarehouseInfoTransformFormMap();
							transformMap.put("oid", id);
							transformMap.put("rowNum", r+1);
							transformMap.put("layNum", "S"+(layer-l));
							int index;
						    for(int c = 0;c<column;c++){ //列
								index = row*column*l + column*r + c;
								String str = dataArr[index];
								if(!Common.isCanConvertFloat(str)){
									transformMap.put("C"+(c+1), 300f);
								}else{
									transformMap.put("C"+(c+1), Float.parseFloat(dataArr[index]));
								}
							}
						    result.add(transformMap);
						}
					}
					try {
						warehouseInfoServer.bathSaveWarehouseInfoTransform(BatchInsertParameter.wrap(result));
					} catch (Exception e) {
						log.error("===Class:WarehouseInfoTask==Method:getNeedTransformData==Exception:bathSaveWarehouseInfoTransform=="+e);
						return;
					}
				}
			}
		}
	}

	/**
	 * @author Lip
	 * 
	 * 获取需要进行温度报警数据处理
	 */
	//@Scheduled(cron="0 0/30 * * * ? ")
	public void getTemperatureAlarm(){
		TemperatureAlarmFormMap temperatureAlarmFormMap =  new TemperatureAlarmFormMap();
		String tableName = null;
		try {
			tableName = FormMapUtil.getTableName(temperatureAlarmFormMap);
		} catch (Exception e) {
			log.error("===Class:WarehouseInfoTask===Method:getTemperatureAlarm===Exception:getTableName=="+e);
			return;
		}
		//根据表名获取需要进行报警测试的数据
		InterfaceDataConfigFormMap interfaceDataConfigFormMap = interfaceDataConfigServer.findByTableName(tableName);
		
		if(interfaceDataConfigFormMap == null){
			interfaceDataConfigFormMap = new InterfaceDataConfigFormMap();
			interfaceDataConfigFormMap.set("idcTableName", tableName);
			interfaceDataConfigFormMap.set("idcPrimaryKey", "id");
			interfaceDataConfigFormMap.set("idcPrimaryValue", "0");
			try {
				FormMapUtil.toADDFormMap(interfaceDataConfigFormMap);
				interfaceDataConfigServer.addInterfaceDataConfig(interfaceDataConfigFormMap);
			} catch (Exception e) {
				log.error("===Class:WarehouseInfoTask===Method:getTemperatureAlarm===Exception:addInterfaceDataConfig=="+e);
				return;
			}
		}
		//获取报警温度
		String alarm = PropertiesUtils.getPropertyByName("qitibaojing.properties").getProperty("t_alarm");
		float tAlarm = Float.parseFloat(alarm);
		//开始id
		int id = Integer.parseInt(interfaceDataConfigFormMap.getStr("idcPrimaryValue"));
		//记录操作的最大id；
		int maxId = id;
		//获取数据
		List<WarehouseInfoFormMap> lists = warehouseInfoServer.findTemperatureAlarm(id);
		
		if(lists!=null && lists.size()>0){
			for(WarehouseInfoFormMap warehouseInfo:lists){
				float maxT = warehouseInfo.getFloat("maxTemperature");
				int wiId = warehouseInfo.getInt("id");
				if(wiId>maxId){
					maxId = wiId;
				}
				//当最高温度大于等于报警值时，对数据报警点位查找
				if(maxT>=tAlarm){
					int row = warehouseInfo.getInt("wRow");
					int column = warehouseInfo.getInt("wColumn");
					int layer = warehouseInfo.getInt("wHeight");
					//获取温度数据
					String temps = warehouseInfo.getStr("wCoordinate");
					String[] tempArr = temps.split(" ");
					
					if(tempArr != null && tempArr.length == row*column*layer){
						StringBuffer position = new StringBuffer();
						temperatureAlarmFormMap = new TemperatureAlarmFormMap();
						for(int l=0;l<layer;l++){ // 层
							for(int r=0;r<row;r++){ //行
								for(int c=0;c<column;c++){ //列
									int index = row*column*l+column*r+c;
									if(Common.isCanConvertFloat(tempArr[index])){
										float tem = Float.parseFloat(tempArr[index]);
										if(tem<100){ //温度大于100为坏点
											if(tem>=tAlarm){
												position.append("第"+(layer-l)+"层,");
												position.append("第"+(r+1)+"行,");
												position.append("第"+(c+1)+"列,");
												position.append("报警温度为："+tem+";");
											}
										}
									}
								}
							}
						}
						if(position.length()>0){
							temperatureAlarmFormMap.set("wId", warehouseInfo.getInt("wWarehouse"));
							temperatureAlarmFormMap.set("position", position.toString());
							temperatureAlarmFormMap.set("alarmTemperature", tAlarm);
							temperatureAlarmFormMap.set("alarmDate", new Timestamp(System.currentTimeMillis()));
							temperatureAlarmFormMap.set("cjsj", warehouseInfo.getDate("cjsj"));
							temperatureAlarmFormMap.set("wiId", wiId);
							
							try {
								FormMapUtil.toADDFormMap(temperatureAlarmFormMap);
								temperatureAlarmServer.addTemperatureAlarm(temperatureAlarmFormMap);
							} catch (Exception e) {
								log.error("===Class:WarehouseInfoTask===Method:getTemperatureAlarm===Exception:addTemperatureAlarm=="+e);
							}
						}
					}
				}
			}
			interfaceDataConfigFormMap.set("idcPrimaryValue", maxId);
			try {
				FormMapUtil.toUPDATEFormMap(interfaceDataConfigFormMap);
				interfaceDataConfigServer.editInterfaceDataConfig(interfaceDataConfigFormMap);
			} catch (Exception e) {
				log.error("===Class:WarehouseInfoTask===Method:getTemperatureAlarm===Exception:editInterfaceDataConfig=="+e);
			}
		}
	}
}
