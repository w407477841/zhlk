package com.zyiot.server.impl.dataDocking;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ictehi.grainplat.service.GrainplatService;
import com.ictehi.grainplat.service.GrainplatServicePortType;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.WarehouseFormMap;
import com.zyiot.entity.WarehouseInfoFormMap;
import com.zyiot.entity.dataDocking.ContrastLocationFormMap;
import com.zyiot.entity.dataDocking.ContrastWarehouseFormMap;
import com.zyiot.entity.dataDocking.InterfaceDataConfigFormMap;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.mapper.WarehouseLocationMapper;
import com.zyiot.mapper.WarehouseMapper;
import com.zyiot.mapper.dataDocking.ContrastLocationMapper;
import com.zyiot.mapper.dataDocking.ContrastWarehouseMapper;
import com.zyiot.mapper.dataDocking.InterfaceDataConfigMapper;
import com.zyiot.mapper.shebeiguanli.DaXingSheBeiMapper;
import com.zyiot.mapper.yaojiguanli.YaoJiKuCunMapper;
import com.zyiot.server.dataDocking.DataDockingServerI;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
@Service("warehouseInfoDockingServer")
public class DataDockingServerImpl implements
		DataDockingServerI {
	
	@Autowired
	private InterfaceDataConfigMapper interfaceDataConfigMapper;
	@Autowired
	private ContrastLocationMapper contrastLocationMapper;
	@Autowired
	private ContrastWarehouseMapper contrastWarehouseMapper;
	@Autowired
	private WarehouseMapper warehouseMapper;
	@Autowired
	private WarehouseLocationMapper warehouseLocationMapper;
	
	@Autowired
	private YaoJiKuCunMapper yaoJiKuCunMapper;
	@Autowired
	private DaXingSheBeiMapper daXingSheBeiMapper;
	@Override
	@SystemLog(module="粮情对接",methods="数据对接",description="对接成功")
	@Transactional(readOnly=false)
	public int WarehouseInfoDataDocking() throws Exception {
		com.ictehi.grainplat.service.GrainplatService s = new GrainplatService();
		GrainplatServicePortType ss = s.getGrainplatServiceHttpSoap11Endpoint();
		//需要数据传输的实体类型
		WarehouseInfoFormMap warehouseInfoFormMap = new WarehouseInfoFormMap();
		//根据实体类获取数据库表名
		//根据数据表名获取配置数据信息
		InterfaceDataConfigFormMap interfaceDataConfigFormMap = interfaceDataConfigMapper.findInterfaceDataConfigByTableName(FormMapUtil.getTableName(warehouseInfoFormMap));
		if(interfaceDataConfigFormMap == null){
			interfaceDataConfigFormMap = new InterfaceDataConfigFormMap();
			interfaceDataConfigFormMap.set("idcTableName", FormMapUtil.getTableName(warehouseInfoFormMap));
			interfaceDataConfigFormMap.set("idcPrimaryKey", "id");
			interfaceDataConfigFormMap.set("idcPrimaryValue", "0");
			FormMapUtil.toADDFormMap(interfaceDataConfigFormMap);
			interfaceDataConfigMapper.addEntity(interfaceDataConfigFormMap);
		}
		
		//根据配置数据信息进行筛选需要上传的数据
		//由于是根据ID进行存放，所以筛选进行大于操作筛选
		//如有不同请另行编写方法
		List<FormMap<String,Object>> lists = interfaceDataConfigMapper.findGreatThanData(interfaceDataConfigFormMap);
		//存放json数据
		StringBuffer jsondata;
		if(lists!=null && lists.size()>0){
			//获取企业和库点
			ContrastLocationFormMap contrastLocationFormMap;
			//获取仓厫编码和货位编码
			ContrastWarehouseFormMap contrastWarehouseFormMap;
			//存放最大的id值
			int bigId = Integer.parseInt(interfaceDataConfigFormMap.getStr("idcPrimaryValue"));
			//存放执行的条数
			int count = 0;
			//获取仓库结构，长、宽、高
			WarehouseFormMap warehouseFormMap;
			for(FormMap<String,Object> formMap:lists){
				if(formMap.getInt("id")>bigId){
					bigId = formMap.getInt("id");
				}
				System.out.println("=======bigId:"+bigId);
				WarehouseFormMap warehouse = warehouseMapper.findWarehouseById(formMap.getInt("wWarehouse"));
				if(warehouse == null){
					continue;
				}
				contrastLocationFormMap = contrastLocationMapper.findContrastLocationByWLNO(warehouse.getInt("wLocation")+"");
				contrastWarehouseFormMap = contrastWarehouseMapper.findContrastWarehouseByWID(formMap.getInt("wWarehouse"));
				if(contrastLocationFormMap == null || contrastWarehouseFormMap ==null){
					continue;
				}
				warehouseFormMap = warehouseMapper.findWarehouseById(formMap.getInt("wWarehouse"));
				jsondata =  new StringBuffer();
				jsondata.append("{");
				jsondata.append("storehouse:'");
				jsondata.append(contrastWarehouseFormMap.getStr("cangfangbianhao"));
				jsondata.append("',house:'");
				jsondata.append(contrastWarehouseFormMap.getStr("huoweibianhao"));
				jsondata.append("',allocation:'");
				jsondata.append("");
				jsondata.append("',houseStoreID:'");
				jsondata.append("");
				jsondata.append("',inTemp:'");
				jsondata.append(FormatFloat(formMap.getFloat("wTemperature")));
				jsondata.append("',inH:'");
				jsondata.append(FormatFloat(formMap.getFloat("wHumidity")));
				jsondata.append("',outTemp:'");
				jsondata.append(FormatFloat(formMap.getFloat("gTemperature")));
				jsondata.append("',outH:'");
				jsondata.append(FormatFloat(formMap.getFloat("gHumidity")));
				jsondata.append("',maxTemp:'");
				jsondata.append("");
				jsondata.append("',minTemp:'");
				jsondata.append("");
				jsondata.append("',averageTemp:'");
				jsondata.append("");
				jsondata.append("',time:'");
				jsondata.append(formMap.getStr("wDate")+formMap.getStr("wTime"));
				
				jsondata.append("',points:[");
				jsondata.append(conventJSONData(formMap.getStr("wCoordinate"),warehouseFormMap));
				jsondata.append("]");
				
				jsondata.append("}");
				int resu = ss.saveOrUpdateGrainDepotInfo(jsondata.toString(), jsondata.toString().length()+"", 4, contrastLocationFormMap.getStr("kuqubianma"), contrastLocationFormMap.getStr("tongyixinyongdaima"));
				if(resu != 0){
					//count = -1;
					//throw new Exception(resu+"");
				}else{
					count ++;
				}
			}
			
			interfaceDataConfigFormMap.set("idcPrimaryValue", bigId);
			FormMapUtil.toUPDATEFormMap(interfaceDataConfigFormMap);
			interfaceDataConfigMapper.updateEntity(interfaceDataConfigFormMap);
			return count;
		}else{
			return 0;
		}
	}
	
	@Override
	@SystemLog(module="药剂对接",methods="数据对接",description="成功")
	@Transactional(readOnly=false)
	public int DrugDataDocking() throws Exception {
		com.ictehi.grainplat.service.GrainplatService s = new GrainplatService();
		GrainplatServicePortType ss = s.getGrainplatServiceHttpSoap11Endpoint();
		
		YaoJiKuCunFormMap yaoJiKuCun = new YaoJiKuCunFormMap();
	    //根据实体类获取数据库表名
		//根据数据表名获取配置数据信息
		InterfaceDataConfigFormMap interfaceDataConfigFormMap = interfaceDataConfigMapper.findInterfaceDataConfigByTableName(FormMapUtil.getTableName(yaoJiKuCun));
		if(interfaceDataConfigFormMap == null){
			interfaceDataConfigFormMap = new InterfaceDataConfigFormMap();
			interfaceDataConfigFormMap.set("idcTableName", FormMapUtil.getTableName(yaoJiKuCun));
			interfaceDataConfigFormMap.set("idcPrimaryKey", "addDate");
			interfaceDataConfigFormMap.set("idcPrimaryValue", "2000-01-01 00:00:00");
			FormMapUtil.toADDFormMap(interfaceDataConfigFormMap);
			interfaceDataConfigMapper.addEntity(interfaceDataConfigFormMap);
		}
		Date nowDate = new Date();
		List<YaoJiKuCunFormMap> lists = yaoJiKuCunMapper.findDataDocking(interfaceDataConfigFormMap.getStr("idcPrimaryValue"));
	    if(lists !=null && lists.size()>0){
			//保存上传成功的数据条数
			int count = 0;
			StringBuffer jsondata = new StringBuffer();
			ContrastLocationFormMap contrastLocationFormMap ;
			for(YaoJiKuCunFormMap formMap :lists){
				jsondata = new StringBuffer();
				contrastLocationFormMap = contrastLocationMapper.findContrastLocationByWLNO(formMap.getInt("mrWLNo")+"");
				if(contrastLocationFormMap == null){
					continue;
				}
				jsondata.append("{");
				jsondata.append("drug_code:'");
				jsondata.append(formMap.getInt("mrDrug"));
				jsondata.append("',units:'");
				jsondata.append(formMap.getStr("text"));
				jsondata.append("',specifications:'");
				jsondata.append(formMap.getStr("mrStandard"));
				jsondata.append("',surplus_count:'");
				jsondata.append(formMap.getInt("mrNumber"));
				jsondata.append("',original_id:'");
				jsondata.append(formMap.getInt("id"));
				jsondata.append("'");
				jsondata.append("}");
				int resu = ss.saveOrUpdateGrainDepotInfo(jsondata.toString(), jsondata.toString().length()+"", 9, contrastLocationFormMap.getStr("kuqubianma"), contrastLocationFormMap.getStr("tongyixinyongdaima"));
				if(resu !=0){
					count = -1;
					throw new Exception(resu+"");
				}else{
					count ++;
				}
			}
			interfaceDataConfigFormMap.set("idcPrimaryValue", DateUtils.dateFormatToLong(nowDate));
			FormMapUtil.toUPDATEFormMap(interfaceDataConfigFormMap);
			interfaceDataConfigMapper.updateEntity(interfaceDataConfigFormMap);
			
			return count;
	    }else{
			return 0;
		}
	}
	
	@Override
	@SystemLog(module="设备对接",methods="数据对接",description="成功")
	@Transactional(readOnly = false)
	public int equipmentDataDocking() throws Exception {
		com.ictehi.grainplat.service.GrainplatService s = new GrainplatService();
		GrainplatServicePortType ss = s.getGrainplatServiceHttpSoap11Endpoint();
		
		DaXingSheBeiFormMap daXingSheBeiFormMap = new DaXingSheBeiFormMap();
		//根据实体类获取数据库表名
		//根据数据表名获取配置数据信息
		InterfaceDataConfigFormMap interfaceDataConfigFormMap = interfaceDataConfigMapper.findInterfaceDataConfigByTableName(FormMapUtil.getTableName(daXingSheBeiFormMap));
		if(interfaceDataConfigFormMap == null){
			interfaceDataConfigFormMap = new InterfaceDataConfigFormMap();
			interfaceDataConfigFormMap.set("idcTableName", FormMapUtil.getTableName(daXingSheBeiFormMap));
			interfaceDataConfigFormMap.set("idcPrimaryKey", "leAddDate");
			interfaceDataConfigFormMap.set("idcPrimaryValue", "2000-01-01 00:00:00");
			FormMapUtil.toADDFormMap(interfaceDataConfigFormMap);
			interfaceDataConfigMapper.addEntity(interfaceDataConfigFormMap);
		}
		Date nowDate = new Date();
		
		List<DaXingSheBeiFormMap> list = daXingSheBeiMapper.findDataDocking(interfaceDataConfigFormMap.getStr("idcPrimaryValue"));
		
		if(list != null && list.size()>0){
			//保存上传成功的数据条数
			int count = 0;
			StringBuffer jsondata;
			ContrastLocationFormMap contrastLocationFormMap;
			for(DaXingSheBeiFormMap daXingSheBei:list){
				jsondata = new StringBuffer();
				
				contrastLocationFormMap = contrastLocationMapper.findContrastLocationByWLNO(daXingSheBei.getInt("leWLNo")+"");
				if(contrastLocationFormMap == null){
					continue;
				}
				
				jsondata.append("{");
				jsondata.append("equipment_group_id:'");
				jsondata.append(daXingSheBei.getInt("leType"));
				jsondata.append("',type_name:'");
				jsondata.append(daXingSheBei.getStr("text"));
				jsondata.append("',measuring_unit_code:'");
				jsondata.append(daXingSheBei.getInt("leUnit"));
				jsondata.append("',original_id:'");
				jsondata.append(daXingSheBei.getInt("id"));
				jsondata.append("',equipment:[{");
				jsondata.append("equipment_name:'");
				jsondata.append(daXingSheBei.getStr("leName"));
				jsondata.append("',measuring_unit_code:'");
				jsondata.append(daXingSheBei.getInt("leUnit"));
				jsondata.append("',equipment_group_id:'");
				jsondata.append(daXingSheBei.getInt("leType"));
				jsondata.append("',equipment_model:'");
				jsondata.append(daXingSheBei.getStr("leNo"));
				jsondata.append("',equipment_spec:'");
				jsondata.append(daXingSheBei.getStr("leStandard"));
				jsondata.append("',manufacturer:'");
				jsondata.append(daXingSheBei.getStr("leManufacturingUnit"));
				jsondata.append("',procurement_price:'");
				jsondata.append(daXingSheBei.getFloat("leWorth"));
				jsondata.append("',original_id:'");
				jsondata.append(daXingSheBei.getInt("id"));
				jsondata.append("'}]");
				jsondata.append("}");
				
				int resu = ss.saveOrUpdateGrainDepotInfo(jsondata.toString(), jsondata.toString().length()+"", 12, contrastLocationFormMap.getStr("kuqubianma"), contrastLocationFormMap.getStr("tongyixinyongdaima"));
				if(resu !=0){
					count = -1;
					throw new Exception(resu+"");
				}else{
					count ++;					
				}
				
			}
			
			interfaceDataConfigFormMap.set("idcPrimaryValue", DateUtils.dateFormatToLong(nowDate));
			FormMapUtil.toUPDATEFormMap(interfaceDataConfigFormMap);
			interfaceDataConfigMapper.updateEntity(interfaceDataConfigFormMap);
			
			return count;
		}else{
			return 0;					
		}
		
	}
	
	/**
	 * 将温度数据转换成json格式
	 * @param src
	 * @return
	 * @throws Exception 
	 */
	private String conventJSONData(String src,WarehouseFormMap warehouseFormMap) throws Exception{
		int height = warehouseFormMap.getInt("wHeight");
		int column = warehouseFormMap.getInt("wColumn");
		int row = warehouseFormMap.getInt("wRow");
		String [] temps = src.split(" ");
		if(temps.length == height*column*row){
			StringBuffer result = new StringBuffer();
			int point;
			for(int k = 0;k<height;k++){
				for(int j=0;j<row;j++){
					for(int i=0;i<column;i++){
						point = k*(column*row)+j*column+i;
						float emp = -1000;
						if(!Common.isCanConvertFloat(temps[point])){
							
						}else{
							emp = Float.parseFloat(temps[point]);
							if(emp>100 || emp <-100){
								emp = -1000;
							}
						}
						result.append("{");
						result.append("temp:'");
						result.append(emp);
						result.append("',X:'");
						result.append((column-i));
						result.append("',Y:'");
						result.append((j+1));
						result.append("',Z:'");
						result.append((k+1));
						result.append("',rod:'");
						result.append("1");
						result.append("',point:'");
						result.append(FormatLengthToFour(point));
						result.append("'}");
						result.append(",");
					}
				}
			}
			return result.toString().substring(0, result.toString().length()-1);
		}else{
			throw new Exception("数据长度有误！");
		}
	}
	/**
	 * 格式化成长度为四的字符串
	 * @param point
	 * @return
	 */
	private String FormatLengthToFour(int point){
		StringBuffer result = new StringBuffer();
		String srcStr = String.valueOf(point);
		for(int i=0;i<4-srcStr.length();i++){
			result.append("0");
		}
		result.append(srcStr);
		
		return result.toString();
	}
	/**
	 * 对数据进行四舍五入操作，保留一位小数
	 * @param src
	 * @return
	 */
	private Float FormatFloat(float src){
		BigDecimal bd = new BigDecimal(src);
		src = bd.setScale(1, BigDecimal.ROUND_HALF_UP).floatValue();
		return src;
	}
	
}
