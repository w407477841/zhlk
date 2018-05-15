package com.zyiot.server.impl.weight;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.entity.weight.WeighingFormMap;
import com.zyiot.mapper.StoreInfoMapper;
import com.zyiot.mapper.weight.CarMapper;
import com.zyiot.mapper.weight.ReportHarborMapper;
import com.zyiot.mapper.weight.WeighingMapper;
import com.zyiot.server.weight.WeighingServerI;
import com.zyiot.util.CalculateUtils;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.StorageChangeUtil;

@Service("weighingServer")
public class WeighingServerImpl implements WeighingServerI {

	@Autowired
	private WeighingMapper weighingMapper;
	@Autowired
	private ReportHarborMapper reportHarborMapper;
	@Autowired
	private StoreInfoMapper storeInfoMapper;
	@Autowired
	private CarMapper carMapper;
	@Override
	@SystemLog(module="称重数据",methods="添加",description="添加成功")
	public void addWeighing(WeighingFormMap weighingFormMap) throws Exception {
		weighingMapper.addEntity(weighingFormMap);
	}

	@Override
	@Transactional(readOnly=false)
	@SystemLog(module="称重数据",methods="复重",description="复重成功")
	public void editWeighing(WeighingFormMap weighingFormMap) throws Exception {
		WeighingFormMap weighing = weighingMapper.findWeighingById(weighingFormMap.getInt("id"));
		
		weighingFormMap.set(Constant.VERSION, weighingFormMap.getInt(Constant.VERSION)+1);
		weighingMapper.updateEntity(weighingFormMap);
		
		addOperatorLog(weighing, "resetWeighing");
	}
	/**
	 * 修改称重信息
	 */
	@Override
	@Transactional(readOnly=false)
	@SystemLog(module="称重数据",methods="修改",description="修改成功")
	public void setWeighing(WeighingFormMap weighingFormMap) throws Exception {
		String bId = weighingFormMap.getStr("bId");
		String id = weighingFormMap.getStr("id");
		WeighingFormMap weighingForm = weighingMapper.findWeighingById(Integer.parseInt(id));
//		if(weighingForm.getFloat("grossWeight") == null){
//			weighingFormMap.remove("grossWeight");
//		}else if(weighingForm.getFloat("tare") == null){
//			weighingFormMap.remove("tare");
//		}
		
		ReportHarborFormMap reportHarborFormMap = reportHarborMapper.findReportHarborByBId(bId);
		//称重信息未进行汇总提交
		//只进行称重信息修改
		if(reportHarborFormMap.getBigDecimal("totalWeight") == null){
			if(weighingForm.getInt(Constant.VERSION) == Integer.parseInt(weighingFormMap.getStr(Constant.VERSION))){
				weighingFormMap.set(Constant.VERSION, weighingForm.getInt(Constant.VERSION)+1);
				
				weighingMapper.updateEntity(weighingFormMap);
				addOperatorLog(weighingForm, "modification");
			}else{
				throw new Exception("[数据已被修改]");
			}
		}else{ //称重信息已经汇总提交--修改
			if(weighingForm.getInt(Constant.VERSION) == Integer.parseInt(weighingFormMap.getStr(Constant.VERSION))){
				weighingFormMap.set(Constant.VERSION, weighingForm.getInt(Constant.VERSION)+1);
				
				weighingMapper.updateEntity(weighingFormMap);
				addOperatorLog(weighingForm, "modification");
			}else{
				throw new Exception("[数据已被修改]");
			}
			
			double oTotalWeight = reportHarborFormMap.getBigDecimal("totalWeight").doubleValue();
			
			// 根据单据号获取称重分组信息---以车辆分组
			List<WeighingFormMap> weighingList = weighingMapper.getTotalWeightByBId(bId);
			
			
			String weightPerson = weighingFormMap.getStr("weightPerson");;
			double totalGrossWeight = 0, totalTare = 0;
			for (WeighingFormMap weighing : weighingList) {
				//一辆车总毛重
				double totalGross =  weighing.getDouble("totalGrossWeight");
				totalGrossWeight += totalGross;
				//称毛次数
				long grossWeightCount = weighing.getLong("grossWeightCount");
				//称皮次数
				long tareCount = weighing.getLong("tarCount");
				// 皮重重量除以称重次数，再乘以毛重次数，使其毛重次数和皮重次数相等
				double tare = weighing.getDouble("totalTare");
				if(grossWeightCount != tareCount){
					//计算称皮平均重量
					double tarWeight = CalculateUtils.div(tare+"", tareCount+"", 2);
					//总皮重，--使其毛重皮重称重次数相同
					double allTare = CalculateUtils.mul(tarWeight+"", grossWeightCount+"");
					totalTare += allTare;
				}else{
					totalTare+=tare;
				}
				
			}
			totalGrossWeight = CalculateUtils.round(totalGrossWeight+"", 0);
			totalTare = CalculateUtils.round(totalTare+"", 0);
			//总重量
			double totalWeight = CalculateUtils.sub(totalGrossWeight+"", totalTare+"");
			
			reportHarborFormMap.set("weightAuthor", weightPerson);
			reportHarborFormMap.set("grossWeight", totalGrossWeight);
			reportHarborFormMap.set("tare", totalTare);
			reportHarborFormMap.set("totalWeight", totalWeight);
			// 获取总扣量比
			float totalReduce = reportHarborFormMap.getFloat("totalReduce");
			
			//获取扣除比例
			double reduceRate = CalculateUtils.div(totalReduce+"", 100+"", 3);
			//扣除重量
			double reduceWeight = CalculateUtils.mul(totalWeight+"", reduceRate+"");
			//真实重量
			double weight = CalculateUtils.sub(totalWeight+"", reduceWeight+"");
			//结算数量
			double trueWeight = CalculateUtils.round(weight+"", 0);
			reportHarborFormMap.set("trueWeight",trueWeight );
			
			float buyPrice = reportHarborFormMap.getFloat("buyPrice");
			//单价
			double price = CalculateUtils.div(buyPrice+"", 50+"", 3);
			//结算金额
			double sumMoney = CalculateUtils.mul(trueWeight+"", price+"");
			//四舍五入后--实际结算金额
			double money = CalculateUtils.round(sumMoney+"", 1);
			reportHarborFormMap.set("sumMoney",money );
			
			reportHarborFormMap.set("weightEndDate",DateUtils.dateFormatToLong(new Date()));
			reportHarborFormMap.set("isAdd", "2");
			reportHarborFormMap.set("payStatus", "待结算");
			// 更新报港数据
			FormMapUtil.toUPDATEFormMap(reportHarborFormMap);
			reportHarborMapper.updateEntity(reportHarborFormMap);

			//根据单据号清除车辆使用信息
			carMapper.ClearUsedCarByBId(bId);
					
			// 获取仓号信息
			int wId = reportHarborFormMap.getInt("wId");
			String inOrOut = reportHarborFormMap.getStr("inOrOut");
			// 根据仓号信息获取实时库存
			StorageInfoFormMap storageInfoFormMap = storeInfoMapper.findByWarehouseId(wId);
			String cangku = storageInfoFormMap.getStr("cangKu");
			//改变重量
			double changeWeight = CalculateUtils.sub(totalWeight+"", oTotalWeight+"");
			
			double afterWeight = 0;
			if (inOrOut.equals("1")) { // 出库
				afterWeight = CalculateUtils.sub(cangku, changeWeight+"");
				storageInfoFormMap.set("cangKu", Common.numberConvertString(afterWeight, 0));
			} else {// 入库
				afterWeight = CalculateUtils.add(cangku, changeWeight+"");
				storageInfoFormMap.set("cangKu", Common.numberConvertString(afterWeight, 0));
			}
			
			StorageChangeUtil.addChangeLog(storageInfoFormMap.getInt("id"), cangku, changeWeight+"", afterWeight+"", "修改称重", "t_weight_weighing", id, reportHarborMapper);
			
			// 更新实时库存
			FormMapUtil.toUPDATEFormMap(storageInfoFormMap);
			storeInfoMapper.updateEntity(storageInfoFormMap);
			
			//当库存为空时，进行清空时间点记录
			if(afterWeight == 0 ){
				StorageChangeUtil.addEmptyData(wId+"", reportHarborMapper,reportHarborFormMap.getStr("weightEndDate"));
			}
		}
		
		
	}
	
	@Override
	@Transactional(readOnly=false)
	@SystemLog(module="称重数据",methods="删除",description="删除成功")
	public void dropWeighing(String id) throws Exception {
		WeighingFormMap weighing = weighingMapper.findWeighingById(Integer.parseInt(id));
		
		weighingMapper.deleteEntityByKey("id", id, WeighingFormMap.class);
		
		addOperatorLog(weighing, "resetWeighing");
	}

	@Override
	public List<WeighingFormMap> findByPage(WeighingFormMap weighingFormMap,
			int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return weighingMapper.findByPage(weighingFormMap);
	}
	
	@Override
	public List<WeighingFormMap> findCanUpdateByPage(
			WeighingFormMap weighingFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return weighingMapper.findCanUpdateByPage(weighingFormMap);
	}
	
	@Override
	public WeighingFormMap findWeighingById(int id) {
		return weighingMapper.findWeighingById(id);
	}

	@Override
	public List<WeighingFormMap> findWeighingByBId(String bId) {
		return weighingMapper.findWeighingByBId(bId);
	}

	@Override
	public WeighingFormMap findWeighingByWeighing(
			WeighingFormMap weighingFormMap) {
		return weighingMapper.findWeighingByWeighing(weighingFormMap);
	}

	@Override
	public WeighingFormMap findLastWeighingByBIdAndCarId(String bId, String carId) {
		return weighingMapper.findLastWeighingByBIdAndCarId(bId, carId);
	}
	/**
	 * 散户称重---未驳车
	 */
	@Override
	@Transactional(readOnly = false)
	@SystemLog(module="称重数据",methods="散户汇总",description="成功")
	public void retailWeighingEnd(WeighingFormMap weighingFormMap)
			throws Exception {
		String bId = weighingFormMap.getStr("bId");
		
		String weightPerson = weighingFormMap.getStr("weightPerson");
		float grossWeight = weighingFormMap.getFloat("grossWeight");
		float tare = weighingFormMap.getFloat("tare");
		//总重
		double totalWeight = CalculateUtils.sub(grossWeight+"", tare+"");
		// 更新称重信息
		weighingMapper.updateEntity(weighingFormMap);

		// 根据单据号查找报港信息
		ReportHarborFormMap reportHarborFormMap = reportHarborMapper.findReportHarborByBId(bId);
		int id = reportHarborFormMap.getInt("id");
		reportHarborFormMap.set("weightAuthor", weightPerson);
		reportHarborFormMap.set("grossWeight", grossWeight);
		reportHarborFormMap.set("tare", tare);
		reportHarborFormMap.set("totalWeight", totalWeight);
		// 获取总扣量比
		float totalReduce = reportHarborFormMap.getFloat("totalReduce");
		//获取扣除比例
		double reduceRate = CalculateUtils.div(totalReduce+"", 100+"", 3);
		//扣除重量
		double reduceWeight = CalculateUtils.mul(totalWeight+"", reduceRate+"");
		//真实重量
		double weight = CalculateUtils.sub(totalWeight+"", reduceWeight+"");
		//结算数量
		double trueWeight = CalculateUtils.round(weight+"", 0);
		reportHarborFormMap.set("trueWeight",trueWeight );
		
		float buyPrice = reportHarborFormMap.getFloat("buyPrice");
		//单价
		double price = CalculateUtils.div(buyPrice+"", 50+"", 3);
		//结算金额
		double sumMoney = CalculateUtils.mul(trueWeight+"", price+"");
		//四舍五入后--实际结算金额
		double money = CalculateUtils.round(sumMoney+"", 1);
		reportHarborFormMap.set("sumMoney",money );
		
		reportHarborFormMap.set("weightEndDate",DateUtils.dateFormatToLong(new Date()));
		reportHarborFormMap.set("isAdd", "2");
		reportHarborFormMap.set("payStatus", "待结算");
		// 更新报港数据
		FormMapUtil.toUPDATEFormMap(reportHarborFormMap);
		reportHarborMapper.updateEntity(reportHarborFormMap);

		// 获取仓号信息
		int wId = reportHarborFormMap.getInt("wId");
		String inOrOut = reportHarborFormMap.getStr("inOrOut");
		// 根据仓号信息获取实时库存
		StorageInfoFormMap storageInfoFormMap = storeInfoMapper.findByWarehouseId(wId);
		String cangku = storageInfoFormMap.getStr("cangKu");
		
		double afterWeight = 0;
		if (inOrOut.equals("1")) { // 出库
			afterWeight = CalculateUtils.sub(cangku, totalWeight+"");
			storageInfoFormMap.set("cangKu", Common.numberConvertString(afterWeight, 0));
		} else {// 入库
			afterWeight = CalculateUtils.add(cangku, totalWeight+"");
			storageInfoFormMap.set("cangKu", Common.numberConvertString(afterWeight, 0));
		}
		
		StorageChangeUtil.addChangeLog(storageInfoFormMap.getInt("id"), cangku, totalWeight+"", afterWeight+"", "散户称重", reportHarborFormMap.getStr(Constant.ENTITY_TABLE), id+"", reportHarborMapper);
		// 更新实时库存
		FormMapUtil.toUPDATEFormMap(storageInfoFormMap);
		storeInfoMapper.updateEntity(storageInfoFormMap);
		
		//当库存为空时，进行清空时间点记录
		if(afterWeight == 0 ){
			StorageChangeUtil.addEmptyData(wId+"", reportHarborMapper,DateUtils.dateFormatToLong(new Date()));
		}
	}
	
	/**
	 * 添加脚粮--驳车数据--进行汇总提交
	 */
	@Override
	@Transactional(readOnly = false)
	@SystemLog(module="称重数据",methods="驳载汇总",description="成功")
	public void addFootGrainWeighing(WeighingFormMap weighingFormMap)
			throws Exception {
		String bId = weighingFormMap.getStr("bId");
		//若无称重信息，则不能进行提交
		List<WeighingFormMap> weighings = weighingMapper.findWeighingByBId(bId);
		if(weighings == null || weighings.size() == 0){
			throw new RuntimeException("未进行称重，不可进行提交");
		}
		// 添加脚粮数据
		weighingMapper.addEntity(weighingFormMap);

		// 根据单据号获取称重分组信息---以车辆分组
		List<WeighingFormMap> weighingList = weighingMapper.getTotalWeightByBId(bId);
		
		String weightPerson  = weighingFormMap.getStr("weightPerson");;
		double totalGrossWeight = 0, totalTare = 0;
		for (WeighingFormMap weighing : weighingList) {
			//称毛次数
			long grossWeightCount = weighing.getLong("grossWeightCount");
			//称皮次数
			long tareCount = weighing.getLong("tarCount");
			if(grossWeightCount !=0 && tareCount == 0){
				throw new RuntimeException("称皮次数有误！");
			}
			
			//一辆车总毛重
			double totalGross =  weighing.getDouble("totalGrossWeight");
			totalGrossWeight += totalGross;
			
			// 皮重重量除以称重次数，再乘以毛重次数，使其毛重次数和皮重次数相等
			double tare = weighing.getDouble("totalTare");
			//计算称皮平均重量
			double tarWeight = CalculateUtils.div(tare+"", tareCount+"", 2);
			//总皮重，--使其毛重皮重称重次数相同
			double allTare = CalculateUtils.mul(tarWeight+"", grossWeightCount+"");
			totalTare += allTare;
		}
		totalGrossWeight = CalculateUtils.round(totalGrossWeight+"", 0);
		totalTare = CalculateUtils.round(totalTare+"", 0);
		//总重量
		double totalWeight = CalculateUtils.sub(totalGrossWeight+"", totalTare+"");
		// 根据单据号查找报港信息
		ReportHarborFormMap reportHarborFormMap = reportHarborMapper.findReportHarborByBId(bId);
		int id = reportHarborFormMap.getInt("id");
		
		reportHarborFormMap.set("weightAuthor", weightPerson);
		reportHarborFormMap.set("grossWeight", totalGrossWeight);
		reportHarborFormMap.set("tare", totalTare);
		reportHarborFormMap.set("totalWeight", totalWeight);
		// 获取总扣量比
		float totalReduce = reportHarborFormMap.getFloat("totalReduce");
		
		//获取扣除比例
		double reduceRate = CalculateUtils.div(totalReduce+"", 100+"", 3);
		//扣除重量
		double reduceWeight = CalculateUtils.mul(totalWeight+"", reduceRate+"");
		//真实重量
		double weight = CalculateUtils.sub(totalWeight+"", reduceWeight+"");
		//结算数量
		double trueWeight = CalculateUtils.round(weight+"", 0);
		reportHarborFormMap.set("trueWeight",trueWeight );
		
		float buyPrice = reportHarborFormMap.getFloat("buyPrice");
		//单价
		double price = CalculateUtils.div(buyPrice+"", 50+"", 3);
		//结算金额
		double sumMoney = CalculateUtils.mul(trueWeight+"", price+"");
		//四舍五入后--实际结算金额
		double money = CalculateUtils.round(sumMoney+"", 1);
		reportHarborFormMap.set("sumMoney",money );
		
		reportHarborFormMap.set("weightEndDate",DateUtils.dateFormatToLong(new Date()));
		reportHarborFormMap.set("isAdd", "2");
		reportHarborFormMap.set("payStatus", "待结算");
		// 更新报港数据
		FormMapUtil.toUPDATEFormMap(reportHarborFormMap);
		reportHarborMapper.updateEntity(reportHarborFormMap);

		//根据单据号清除车辆使用信息
		carMapper.ClearUsedCarByBId(bId);
				
		// 获取仓号信息
		int wId = reportHarborFormMap.getInt("wId");
		String inOrOut = reportHarborFormMap.getStr("inOrOut");
		// 根据仓号信息获取实时库存
		StorageInfoFormMap storageInfoFormMap = storeInfoMapper.findByWarehouseId(wId);
		String cangku = storageInfoFormMap.getStr("cangKu");
		double afterWeight = 0;
		
		if (inOrOut.equals("1")) { // 出库
			afterWeight = CalculateUtils.sub(cangku, totalWeight+"");
			storageInfoFormMap.set("cangKu", Common.numberConvertString(afterWeight, 0));
		} else {// 入库
			afterWeight = CalculateUtils.add(cangku, totalWeight+"");
			storageInfoFormMap.set("cangKu", Common.numberConvertString(afterWeight, 0));
		}
		
		StorageChangeUtil.addChangeLog(storageInfoFormMap.getInt("id"), cangku, totalWeight+"", afterWeight+"", "称重驳车", reportHarborFormMap.getStr(Constant.ENTITY_TABLE), id+"", reportHarborMapper);
		// 更新实时库存
		FormMapUtil.toUPDATEFormMap(storageInfoFormMap);
		storeInfoMapper.updateEntity(storageInfoFormMap);
		
		//当库存为空时，进行清空时间点记录
		if(afterWeight == 0 ){
			StorageChangeUtil.addEmptyData(wId+"", reportHarborMapper,DateUtils.dateFormatToLong(new Date()));
		}
	}

	@Override
	public List<WeighingFormMap> findRetailWeightByPage(int pageSize,int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return weighingMapper.findRetailWeightByPage();
	}

	@Override
	public List<WeighingFormMap> findUsedCarWeightByPage(int pageSize,int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return weighingMapper.findUsedCarWeightByPage();
	}

	@Override
	public List<WeighingFormMap> findAllWeighingByBIdAndCarId(int pageSize,
			int pageNum, String bId, String carId) {
		PageHelper.startPage(pageNum, pageSize);
		return weighingMapper.findAllWeighingByBIdAndCarId(bId, carId);
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
	public List<WeighingFormMap> findAllWeighingByBId(int pageSize,
			int pageNum, String bId) {
		PageHelper.startPage(pageNum, pageSize);
		return weighingMapper.findWeighingByBId(bId);
	}

	@Override
	public List<WeighingFormMap> findWeighingByAttr(
			ReportHarborFormMap reportHarborFormMap) {
		return weighingMapper.findWeighingByAttr(reportHarborFormMap);
	}
	
}
