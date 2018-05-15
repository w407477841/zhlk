package com.zyiot.server.impl.weight;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.ictehi.grainplat.service.GrainplatService;
import com.ictehi.grainplat.service.GrainplatServicePortType;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.dataDocking.InterfaceDataConfigFormMap;
import com.zyiot.entity.weight.CarFormMap;
import com.zyiot.entity.weight.QualityCheckFormMap;
import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.entity.weight.WeighingFormMap;
import com.zyiot.mapper.StoreInfoMapper;
import com.zyiot.mapper.dataDocking.InterfaceDataConfigMapper;
import com.zyiot.mapper.weight.CarMapper;
import com.zyiot.mapper.weight.QualityCheckMapper;
import com.zyiot.mapper.weight.ReportHarborMapper;
import com.zyiot.mapper.weight.WeighingMapper;
import com.zyiot.server.weight.ReportHarborServerI;
import com.zyiot.util.CalculateUtils;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.StorageChangeUtil;

@Service("reportharborServer")
public class ReportHarborServerImpl implements ReportHarborServerI {
	@Autowired
	private ReportHarborMapper reportHarborMapper;
	@Autowired
	private QualityCheckMapper qualityCheckMapper;
	@Autowired
	private CarMapper carMapper;
	@Autowired
	private StoreInfoMapper storeInfoMapper;
	@Autowired
	private InterfaceDataConfigMapper interfaceDataConfigMapper;
	@Autowired
	private WeighingMapper weighingMapper;
	@Override
	@SystemLog(module="报港信息",methods="添加",description="添加成功")
	@Transactional(readOnly=false)
	public String addReportHarbor(ReportHarborFormMap reportHarborFormMap,QualityCheckFormMap qualityCheckFormMap)
			throws Exception {
		String Bid =reportHarborMapper.getMaxBId(DateUtils.dateToShortString(new Date()));
		if(Bid == null){//如果当前日期是第一个
			Bid = DateUtils.dateToShortString(new Date())+"1001";
		}else{
			String head = Bid.substring(0,8);
			String tial = Bid.substring(8);
			Bid = head+ (Integer.parseInt(tial)+1);
		}
		
		reportHarborFormMap.set("bId", Bid);
		reportHarborMapper.addEntity(reportHarborFormMap);
		qualityCheckFormMap.set("bId", Bid);
		qualityCheckMapper.addEntity(qualityCheckFormMap);
		return Bid;
	}

	@Override
	@SystemLog(module="报港信息",methods="添加",description="添加成功")
	@Transactional(readOnly=false)
	public String addReportHarbor(ReportHarborFormMap reportHarborFormMap)
			throws Exception {
		String Bid =reportHarborMapper.getMaxBId(DateUtils.dateToShortString(new Date()));
		if(Bid == null){//如果当前日期是第一个
			Bid = DateUtils.dateToShortString(new Date())+"1001";
		}else{
			String head = Bid.substring(0,8);
			String tial = Bid.substring(8);
			Bid = head+ (Integer.parseInt(tial)+1);
		}
		reportHarborFormMap.set("bId", Bid);
		reportHarborMapper.addEntity(reportHarborFormMap);
		return Bid;
	}
	
	@Override
	@SystemLog(module="质检信息",methods="添加",description="添加成功")
	@Transactional(readOnly=false)
	public String addQualityCheck(ReportHarborFormMap reportHarborFormMap,QualityCheckFormMap qualityCheckFormMap) throws Exception {
		String bId = reportHarborFormMap.getStr("bId");
		ReportHarborFormMap reportHarbor = reportHarborMapper.findReportHarborByBId(bId);
		QualityCheckFormMap qualityCheck = qualityCheckMapper.findQualityCheckByBId(bId);
		if(reportHarbor != null){
			if(qualityCheck == null){ //没有质检信息
				if(Integer.parseInt(reportHarborFormMap.getStr(Constant.VERSION)) == reportHarbor.getInt(Constant.VERSION)){
					reportHarborFormMap.set(Constant.VERSION, reportHarbor.getInt(Constant.VERSION)+1);
					reportHarborMapper.updateEntity(reportHarborFormMap);
					addOperatorLog(reportHarbor, "update");
					qualityCheckFormMap.set("bId", bId);
					qualityCheckMapper.addEntity(qualityCheckFormMap);
					return bId;
				}else{
					throw new Exception("[数据已被修改]");
				}
			}else{
				throw new Exception("[数据已经质检]");
			}
		}else{
			throw new Exception("[数据有误]");
		}
	}

	@Override
	@SystemLog(module="报港信息",methods="补录",description="补录成功")
	@Transactional(readOnly=false)
	public String additionalReportHarbor(
			ReportHarborFormMap reportHarborFormMap,
			QualityCheckFormMap qualityCheckFormMap) throws Exception {
		String Bid =reportHarborMapper.getMaxBId(DateUtils.dateToShortString(new Date()));
		if(Bid == null){//如果当前日期是第一个
			Bid = DateUtils.dateToShortString(new Date())+"1001";
		}else{
			String head = Bid.substring(0,8);
			String tial = Bid.substring(8);
			Bid = head+ (Integer.parseInt(tial)+1);
		}
		
		float grossWeight = Float.parseFloat(reportHarborFormMap.getStr("grossWeight"));
		float tare = Float.parseFloat(reportHarborFormMap.getStr("tare"));
		//总重
		double totalWeight = CalculateUtils.sub(grossWeight+"", tare+"");
		reportHarborFormMap.set("totalWeight", totalWeight);
		
		// 获取总扣量比
		float totalReduce = Float.parseFloat(reportHarborFormMap.getStr("totalReduce"));
		//获取扣除比例
		double reduceRate = CalculateUtils.div(totalReduce+"", 100+"", 3);
		//扣除重量
		double reduceWeight = CalculateUtils.mul(totalWeight+"", reduceRate+"");
		//真实重量
		double weight = CalculateUtils.sub(totalWeight+"", reduceWeight+"");
		//结算数量
		double trueWeight = CalculateUtils.round(weight+"", 0);
		reportHarborFormMap.set("trueWeight",trueWeight );
		
		float buyPrice = Float.parseFloat(reportHarborFormMap.getStr("buyPrice"));
		//单价
		double price = CalculateUtils.div(buyPrice+"", 50+"", 3);
		//结算金额
		double sumMoney = CalculateUtils.mul(trueWeight+"", price+"");
		//四舍五入后--实际结算金额
		double money = CalculateUtils.round(sumMoney+"", 1);
		reportHarborFormMap.set("sumMoney",money );
		
		reportHarborFormMap.set("isAdd", "2");
		reportHarborFormMap.set("payStatus", "待结算");
		reportHarborFormMap.set("addRecord", "1");
		//添加报港数据
		reportHarborFormMap.set("bId", Bid);
		reportHarborMapper.addEntity(reportHarborFormMap);
		//添加质检数据
		qualityCheckFormMap.set("bId", Bid);
		qualityCheckMapper.addEntity(qualityCheckFormMap);
		
		//添加称重数据
		WeighingFormMap weightingFormMap = new WeighingFormMap();
		weightingFormMap.set("bId", Bid);
		weightingFormMap.set("carId", reportHarborFormMap.getStr("shipId"));
		weightingFormMap.set("grossWeight", reportHarborFormMap.getStr("grossWeight"));
		weightingFormMap.set("tare", reportHarborFormMap.getStr("tare"));
		weightingFormMap.set("grossWeightDate", reportHarborFormMap.getStr("weightEndDate"));
		weightingFormMap.set("tarDate", reportHarborFormMap.getStr("weightEndDate"));
		weightingFormMap.set("weightPerson", reportHarborFormMap.getStr("weightAuthor"));
		
		FormMapUtil.toADDFormMap(weightingFormMap);
		weighingMapper.addEntity(weightingFormMap);
		
		// 获取仓号信息
		int wId = Integer.parseInt(reportHarborFormMap.getStr("wId"));
		String inOrOut = reportHarborFormMap.getStr("inOrOut");
		// 根据仓号信息获取实时库存
		StorageInfoFormMap storageInfoFormMap = storeInfoMapper.findByWarehouseId(wId);
		String cangku = storageInfoFormMap.getStr("cangKu");
		double afterWeights = 0;
		if (inOrOut.equals("1")) { // 出库
			afterWeights =CalculateUtils.sub(cangku, totalWeight+"");
			storageInfoFormMap.set("cangKu", Common.numberConvertString(afterWeights, 0));
		} else {// 入库
			afterWeights = CalculateUtils.add(cangku, totalWeight+"");
			storageInfoFormMap.set("cangKu", Common.numberConvertString(afterWeights, 0));
		}
		
		StorageChangeUtil.addChangeLog(storageInfoFormMap.getInt("id"), cangku, totalWeight+"", afterWeights+"", "补录", reportHarborFormMap.getStr(Constant.ENTITY_TABLE), "-1", reportHarborMapper);
		// 更新实时库存
		FormMapUtil.toUPDATEFormMap(storageInfoFormMap);
		storeInfoMapper.updateEntity(storageInfoFormMap);
		
		//当库存为空时，进行清空时间点记录
		if(afterWeights == 0 ){
			StorageChangeUtil.addEmptyData(wId+"", reportHarborMapper,reportHarborFormMap.getStr("weightEndDate"));
		}
		return Bid;
	}
	
	@Override
	@SystemLog(module="报港信息",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editReportHarbor(ReportHarborFormMap reportHarborFormMap)
			throws Exception {
		ReportHarborFormMap reportHarbor = reportHarborMapper.findReportHarborById(Integer.parseInt(reportHarborFormMap.getStr("id")));
		if(reportHarbor.getInt(Constant.VERSION) == Integer.parseInt(reportHarborFormMap.getStr(Constant.VERSION))){
			reportHarborFormMap.set(Constant.VERSION, reportHarbor.getInt(Constant.VERSION)+1);
			reportHarborMapper.updateEntity(reportHarborFormMap);
			addOperatorLog(reportHarbor, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
	}
	
	@Override
	@SystemLog(module="报港信息",methods="基础信息修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editBasicReportHarbor(ReportHarborFormMap reportHarborFormMap)
			throws Exception {
		ReportHarborFormMap reportHarbor = reportHarborMapper.findReportHarborById(Integer.parseInt(reportHarborFormMap.getStr("id")));
		if(reportHarbor.getInt(Constant.VERSION) == Integer.parseInt(reportHarborFormMap.getStr(Constant.VERSION))){
			reportHarborFormMap.set(Constant.VERSION, reportHarbor.getInt(Constant.VERSION)+1);
			reportHarborMapper.updateEntity(reportHarborFormMap);
			addOperatorLog(reportHarbor, "basicUpdate");
			//是否仓号发生改变
			//原始仓号
			int owId = reportHarbor.getInt("wId");
			int wId = Integer.parseInt(reportHarborFormMap.getStr("wId"));
			//当仓号发生变化时，要进行仓库粮食变换
			if(owId != wId){
				//说明已经进仓数据，需数据调整
				if(reportHarbor.getBigDecimal("totalWeight") != null){
					//原始仓库信息
					StorageInfoFormMap ostorage = storeInfoMapper.findByWarehouseId(owId);
					StorageInfoFormMap storage = storeInfoMapper.findByWarehouseId(wId);
					String inOrOut = reportHarbor.getStr("inOrOut");
					//原始库存
					String ocangku = ostorage.getStr("cangKu");
					String cangku = storage.getStr("cangKu");
					//数量
					String changeWeight = reportHarbor.getBigDecimal("totalWeight").toString();
					double oafterWeight = 0;
					double afterWeight = 0;
					if(inOrOut.equals("1")){ //出库
						//加上出库的数量
						oafterWeight = CalculateUtils.add(ocangku, changeWeight);
						ostorage.set("cangKu", Common.numberConvertString(oafterWeight, 0));
						//减去出库的数量
						afterWeight = CalculateUtils.sub(cangku, changeWeight);
						storage.set("cangKu", Common.numberConvertString(afterWeight, 0));
					}else{
						//减去入库的数量
						oafterWeight = CalculateUtils.sub(ocangku, changeWeight);
						ostorage.set("cangKu", Common.numberConvertString(oafterWeight, 0));
						//加上入库的数量
						afterWeight = CalculateUtils.add(cangku, changeWeight);
						storage.set("cangKu", Common.numberConvertString(afterWeight, 0));
					}
					
					StorageChangeUtil.addChangeLog(ostorage.getInt("id"), ocangku, changeWeight, oafterWeight+"", "修改称重", "t_weight_weighing", ostorage.getInt("id")+"", reportHarborMapper);
					// 更新实时库存
					FormMapUtil.toUPDATEFormMap(ostorage);
					storeInfoMapper.updateEntity(ostorage);
					//当库存为空时，进行清空时间点记录
					if(oafterWeight == 0 ){
						StorageChangeUtil.addEmptyData(owId+"", reportHarborMapper,reportHarbor.getStr("weightEndDate"));
					}
					
					StorageChangeUtil.addChangeLog(storage.getInt("id"), cangku, changeWeight, afterWeight+"", "修改称重", "t_weight_weighing", storage.getInt("id")+"", reportHarborMapper);
					// 更新实时库存
					FormMapUtil.toUPDATEFormMap(storage);
					storeInfoMapper.updateEntity(storage);
					//当库存为空时，进行清空时间点记录
					if(afterWeight == 0 ){
						StorageChangeUtil.addEmptyData(wId+"", reportHarborMapper,reportHarbor.getStr("weightEndDate"));
					}
				}
			}
			
		}else{
			throw new Exception("[数据已被修改]");
		}
	}


	@Override
	@SystemLog(module="报港信息",methods="质检信息修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editCheckReportHarbor(ReportHarborFormMap reportHarborFormMap,
			QualityCheckFormMap qualityCheckFormMap) throws Exception {
		String bId = reportHarborFormMap.getStr("bId");
		//获取原始报港信息
		ReportHarborFormMap report = reportHarborMapper.findReportHarborByBId(bId);
		String status = report.getStr("payStatus");
		//如果为空，或者未未结算，可进行修改
		if(status == null || status.equals("待结算")){
			float totalReduce =Float.parseFloat(reportHarborFormMap.getStr("totalReduce"));
			float buyPrice = Float.parseFloat(reportHarborFormMap.getStr("buyPrice"));
			//总扣量会影响其重量，价格会影响总金额
			if(totalReduce != report.getFloat("totalReduce") || buyPrice != report.getFloat("buyPrice")){
				reportHarborFormMap.set("id", report.getInt("id"));
				reportHarborFormMap.set(Constant.VERSION, report.getInt(Constant.VERSION)+1);
				//当总重为null时，只进行其相应值更改
				if(report.getBigDecimal("totalWeight") == null){
					reportHarborMapper.updateEntity(reportHarborFormMap);
					addOperatorLog(report, "checkUpdate");
				}else{ //更改其相应值和关联值
					if(totalReduce != report.getFloat("totalReduce")){ //修改扣重 -- 重量修改
						double totalWeight = report.getBigDecimal("totalWeight").doubleValue();
						//获取扣除比例
						double reduceRate = CalculateUtils.div(totalReduce+"", 100+"", 3);
						//扣除重量
						double reduceWeight = CalculateUtils.mul(totalWeight+"", reduceRate+"");
						//真实重量
						double weight = CalculateUtils.sub(totalWeight+"", reduceWeight+"");
						//结算数量
						double trueWeight = CalculateUtils.round(weight+"", 0);
						reportHarborFormMap.set("trueWeight",new BigDecimal(trueWeight) );
					}else{ //未修改扣重
						reportHarborFormMap.set("trueWeight",report.getBigDecimal("trueWeight") );
					}
					
					double trueWeight = reportHarborFormMap.getBigDecimal("trueWeight").doubleValue();
					//单价
					double price = CalculateUtils.div(buyPrice+"", 50+"", 3);
					//结算金额
					double sumMoney = CalculateUtils.mul(trueWeight+"", price+"");
					//四舍五入后--实际结算金额
					double money = CalculateUtils.round(sumMoney+"", 1);
					reportHarborFormMap.set("sumMoney",money );
					
					reportHarborMapper.updateEntity(reportHarborFormMap);
					addOperatorLog(report, "checkUpdate");
				}
			}else{
				reportHarborFormMap.set("id", report.getInt("id"));
				reportHarborFormMap.set(Constant.VERSION, report.getInt(Constant.VERSION)+1);
				reportHarborMapper.updateEntity(reportHarborFormMap);
				addOperatorLog(report, "checkUpdate");
			}
			
			QualityCheckFormMap qualityCheck = qualityCheckMapper.findQualityCheckByBId(bId);
			
			if(qualityCheck.getInt(Constant.VERSION) == Integer.parseInt(qualityCheckFormMap.getStr(Constant.VERSION))){
				qualityCheckFormMap.set(Constant.VERSION, qualityCheck.getInt(Constant.VERSION)+1);
				
				qualityCheckMapper.updateEntity(qualityCheckFormMap);
				addOperatorLog(qualityCheck, "edit");
			}else{
				throw new Exception("[数据已被修改]");
			}
		}else{//结算完成，不可进行修改
			throw new Exception("[数据已被修改]");
		}
	}
	
	@Override
	@SystemLog(module="报港信息",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropReportHarbor(String id) throws Exception {
		//报港信息
		ReportHarborFormMap reportHarbor = reportHarborMapper.findReportHarborById(Integer.parseInt(id));
		String bId = reportHarbor.getStr("bId");
		
		//质检信息
		QualityCheckFormMap qualityCheck = qualityCheckMapper.findQualityCheckByBId(bId);
		
		//绑定车辆信息
		List<CarFormMap> carList = carMapper.findCarByBId(bId);
		//解绑车辆信息
		if(carList!=null && carList.size()>0){
			carMapper.ClearUsedCarByBId(bId);
			for(CarFormMap car:carList){
				addOperatorLog(car, "clearUsed");
			}
		}
		//有质检信息
		if(qualityCheck != null){
			//删除质检信息
			qualityCheckMapper.deleteEntityByKey("bId", bId, QualityCheckFormMap.class);
			addOperatorLog(qualityCheck, "delete");
		}
		//删除报港信息
		reportHarborMapper.deleteEntityByKey("id", id, ReportHarborFormMap.class);
		addOperatorLog(reportHarbor, "delete");
	}
	
	@Override
	@SystemLog(module="报港信息",methods="补录删除",description="补录删除成功")
	@Transactional(readOnly=false)
	public void dropAdditionalReportHarbor(String id) throws Exception {
		//报港信息
		ReportHarborFormMap reportHarbor = reportHarborMapper.findReportHarborById(Integer.parseInt(id));
		String bId = reportHarbor.getStr("bId");
		
		if(reportHarbor.getStr("payStatus") !="结算完成"){
			float weight = reportHarbor.getBigDecimal("totalWeight").floatValue();
			// 获取仓号信息
			int wId = reportHarbor.getInt("wId");
			String inOrOut = reportHarbor.getStr("inOrOut");
			
			//质检信息
			QualityCheckFormMap qualityCheck = qualityCheckMapper.findQualityCheckByBId(bId);
			//删除质检信息
			qualityCheckMapper.deleteEntityByKey("bId", bId, QualityCheckFormMap.class);
			addOperatorLog(qualityCheck, "delete");
			
			WeighingFormMap weightFormMap = new WeighingFormMap();
			weightFormMap.set("bId", bId);
			List<WeighingFormMap> list = weighingMapper.findByAttr(weightFormMap);
			if(list != null && list.size()>0){
				for(WeighingFormMap w:list){
					weighingMapper.deleteEntityByKey("id", w.getInt("id")+"", WeighingFormMap.class);
					addOperatorLog(w, "delete");
				}
			}
			
			
			//删除报港信息
			reportHarborMapper.deleteEntityByKey("id", id, ReportHarborFormMap.class);
			addOperatorLog(reportHarbor, "delete");
			
			// 根据仓号信息获取实时库存
			StorageInfoFormMap storageInfoFormMap = storeInfoMapper.findByWarehouseId(wId);
			String cangku = storageInfoFormMap.getStr("cangKu");
			double afterWeights = 0;
			if (inOrOut.equals("1")) { // 出库
				afterWeights =CalculateUtils.add(cangku, weight+"");
				storageInfoFormMap.set("cangKu", Common.numberConvertString(afterWeights, 0));
			} else {// 入库
				afterWeights = CalculateUtils.sub(cangku, weight+"");
				storageInfoFormMap.set("cangKu", Common.numberConvertString(afterWeights, 0));
			}
			
			StorageChangeUtil.addChangeLog(storageInfoFormMap.getInt("id"), cangku, weight+"", afterWeights+"", "补录删除", "t_weight_report_harbor", id, reportHarborMapper);
			// 更新实时库存
			FormMapUtil.toUPDATEFormMap(storageInfoFormMap);
			storeInfoMapper.updateEntity(storageInfoFormMap);
			
			//当库存为空时，进行清空时间点记录
			if(afterWeights == 0 ){
				StorageChangeUtil.addEmptyData(wId+"", reportHarborMapper,reportHarbor.getStr("weightEndDate"));
			}
		}else{
			throw new RuntimeException();
		}
	}

	@Override
	public List<ReportHarborFormMap> findByPage(
			ReportHarborFormMap reportHarborFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return reportHarborMapper.findByPage(reportHarborFormMap);
	}
	

	@Override
	public List<ReportHarborFormMap> findAllByPage(
			ReportHarborFormMap reportHarborFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return reportHarborMapper.findAllByPage(reportHarborFormMap);
	}
	
	@Override
	public List<QualityCheckFormMap> findAllCheckByPage(
			QualityCheckFormMap qualityCheckFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return reportHarborMapper.findAllCheckByPage(qualityCheckFormMap);
	}
	
	@Override
	public ReportHarborFormMap findReportHarborById(int id) {
		return reportHarborMapper.findReportHarborById(id);
	}
	
	@Override
	public ReportHarborFormMap findReportHarborByBId(String bId) {
		return reportHarborMapper.findReportHarborByBId(bId);
	}
	
	
	@Override
	public ReportHarborFormMap findNotCheckReportHarborByBId(String bId) {
		return reportHarborMapper.findNotCheckReportHarborByBId(bId);
	}

	@Override
	public ReportHarborFormMap findReportHarborByCardId(String cardId) {
		return reportHarborMapper.findReportHarborByCardId(cardId);
	}
	
	@Override
	public ReportHarborFormMap findIsCheckByCardId(String cardId) {
		// TODO Auto-generated method stub
		return null;
	}

	private void addOperatorLog(ReportHarborFormMap reportHarborFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		reportHarborFormMap.set(Constant.ENTITY_TABLE, "t_weight_report_harbor_his");
		reportHarborFormMap.set("execSQL", sql);
		reportHarborFormMap.set("execUser", session.getAttribute("userSessionId"));
		reportHarborFormMap.set("execType", type);
		reportHarborFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		reportHarborMapper.addEntity(reportHarborFormMap);
	}
	private void addOperatorLog(QualityCheckFormMap qualityCheckFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		qualityCheckFormMap.set(Constant.ENTITY_TABLE, "t_weight_quality_check_his");
		qualityCheckFormMap.set("execSQL", sql);
		qualityCheckFormMap.set("execUser", session.getAttribute("userSessionId"));
		qualityCheckFormMap.set("execType", type);
		qualityCheckFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		qualityCheckMapper.addEntity(qualityCheckFormMap);
	}
	private void addOperatorLog(CarFormMap carFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		carFormMap.set(Constant.ENTITY_TABLE, "t_weight_car_archives_his");
		carFormMap.set("execUser", session.getAttribute("userSessionId"));
		carFormMap.set("execType", type);
		carFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		carMapper.addEntity(carFormMap);
	}
	private void addOperatorLog(WeighingFormMap weighingFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		weighingFormMap.set(Constant.ENTITY_TABLE, "t_weight_weighing_his");
		weighingFormMap.set("execSQL", sql);
		weighingFormMap.set("execUser", session.getAttribute("userSessionId"));
		weighingFormMap.set("execType", type);
		weighingFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		weighingMapper.addEntity(weighingFormMap);
	}
	@Override
	public ReportHarborFormMap printReportHarborByBId(String bId) {
		return reportHarborMapper.printReportHarborByBId(bId);
	}

	@Override
	@Transactional(readOnly=false)
	public ReportHarborFormMap findDetailReportHarborByBId(String bId) throws Exception{
		
		ReportHarborFormMap report = reportHarborMapper.findReportHarborByBId(bId);
		
		report.set("printCount", report.getInt("printCount")+1);
		FormMapUtil.toUPDATEFormMap(report);
		reportHarborMapper.updateEntity(report);
		
		return reportHarborMapper.findDetailReportHarborByBId(bId);
	}

	@Override
	public ReportHarborFormMap findBasicReportHarborById(int id) {
		return reportHarborMapper.findBasicReportHarborById(id);
	}

	@Override
	public ReportHarborFormMap findCheckReportHarborById(int id) {
		return reportHarborMapper.findCheckReportHarborById(id);
	}

	@Override
	public List<ReportHarborFormMap> findSettleAccountByPage(
			ReportHarborFormMap reportHarborFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return reportHarborMapper.findSettleAccountByPage(reportHarborFormMap);
	}

	@Override
	public ReportHarborFormMap findDetailReportHarborById(int id) {
		return reportHarborMapper.findDetailReportHarborById(id);
	}

	@Override
	public String findPayPlanIdByWId(String wId) {
		return reportHarborMapper.findPayPlanIdByWId(wId);
	}

	@Override
	public List<ReportHarborFormMap> findAdditionalByPage(
			ReportHarborFormMap reportHarborFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return reportHarborMapper.findAdditionalByPage(reportHarborFormMap);
	}

	@Transactional(readOnly = false)
	public void shijiduijie() throws Exception {
		InterfaceDataConfigFormMap data = interfaceDataConfigMapper
				.findInterfaceDataConfigByTableName("t_weight_report_harbor");
		String idcPrimaryValue = "2011-01-01 00:00:00";
		String lastTime = "";
		if (data != null) {
			lastTime = data.getStr("idcPrimaryValue");
			if (lastTime == null || lastTime.equals("")) {
				lastTime = idcPrimaryValue;
			}

		} else {
			lastTime = idcPrimaryValue;
		}
		List<ReportHarborFormMap> list = reportHarborMapper
				.shijiduijie(lastTime);
		com.ictehi.grainplat.service.GrainplatService s = new GrainplatService();
		GrainplatServicePortType context = s
				.getGrainplatServiceHttpSoap11Endpoint();
		for (ReportHarborFormMap report : list) {
			StringBuffer json = new StringBuffer("{");
			json.append("storehouse:'").append(report.getStr("storehouse"))
					.append("',");// 仓房国际编码
			json.append("house : '").append(report.getStr("house"))
					.append("',");// 仓敖编码
			json.append("inOutID : '").append(report.getStr("inOutID"))
					.append("',");// 流水单号
			json.append("inOutType: '").append(report.getStr("inOutType"))
					.append("',");// 出入库类型
			json.append("date:'").append(report.getStr("date")).append("',");// 日期
			json.append("grainKind:'").append(report.get("grainKind"))
					.append("',");// 品种
			json.append("netWeight:'")
					.append(report.getBigDecimal("netWeight") == null ? "0"
							: report.getBigDecimal("netWeight").intValue())
					.append("',");
			json.append("settleWeight:'")
					.append(report.getBigDecimal("settleWeight") == null ? "0"
							: report.getBigDecimal("settleWeight").intValue())
					.append("',");

			json.append("grainAttribute:'")
					.append(report.get("grainAttribute")).append("',");// 性质
			json.append("grade:'").append(report.get("grade")).append("',");// 等级
			json.append("customerName:'").append(report.get("customerName"))
					.append("',");// 客户名称
			json.append("allocation:'").append(report.get("allocation"))
					.append("',");// 货位编码
			json.append("IDcardNo:'").append(report.get("IDcardNo"))
					.append("',");// 身份证号
			json.append("plateNumber:'").append(report.get("plateNumber"))
					.append("',");// 车船号
			json.append("unitPrice:'").append(report.get("unitPrice"))
					.append("',");// 单价
			json.append("grossWeight:'").append(report.get("grossWeight"))
					.append("',");// 毛重
			json.append("tareWeight:'").append(report.get("tareWeight"))
					.append("',");// 皮重
			json.append("deductWeight:'").append(report.get("deductWeight"))
					.append("',");// 总扣量
			json.append("settleMoney:'").append(report.get("settleMoney"))
					.append("',");// 结算金额
			json.append("DBarCode:'").append(report.get("DBarCode"))
					.append("',");// 结算金额
			json.append("URL:'").append(report.get("URL")).append("',");// 结算金额
			json.append("items:").append(report.getStr("items"));

			json.append("}");
			// System.out.println(json.toString());
			int ret = context.saveOrUpdateGrainDepotInfo(json.toString(),
					json.length() + "", 3, report.getStr("orgCode"),
					report.getStr("entCode"));
			if (ret == 0) {
				lastTime = report.getStr("execDate");
			}
			System.out.println(ret);
		}

		if (data == null) {// 进行初始化
			data = new InterfaceDataConfigFormMap();
			data.put("idcTableName", "t_weight_report_harbor");
			data.put("idcPrimaryKey", "execDate");
			data.put("idcPrimaryValue", lastTime);
			data.put("version", "1");
			FormMapUtil.toADDFormMap(data);
			interfaceDataConfigMapper.addEntity(data);
		} else {
			data.put("idcPrimaryValue", lastTime);
			FormMapUtil.toUPDATEFormMap(data);
			interfaceDataConfigMapper.updateEntity(data);
		}

	}

	@Override
	public QualityCheckFormMap findLastByWId(String wId) {
		return reportHarborMapper.findLastByWId(wId);
	}

	@Override
	public QualityCheckFormMap findPrintCheckByBId(String bId) {
		return qualityCheckMapper.findPrintCheckByBId(bId);
	}

	@Override
	public List<ReportHarborFormMap> findPrintByPage(
			ReportHarborFormMap reportHarborFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return reportHarborMapper.findPrintByPage(reportHarborFormMap);
	}
	
}
