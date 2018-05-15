package com.zyiot.server.impl.weight;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.weight.CarFormMap;
import com.zyiot.mapper.weight.CarMapper;
import com.zyiot.server.weight.CarServerI;
import com.zyiot.util.Constant;
@Service("carServer")
public class CarServerImpl implements CarServerI {
	@Autowired
	private CarMapper carMapper;
	@Override
	@SystemLog(module="车辆档案",methods="添加",description="添加成功")
	public void addCar(CarFormMap carFormMap) throws Exception {
		carMapper.addEntity(carFormMap);
	}

	@Override
	@SystemLog(module="车辆档案",methods="更新",description="更新成功")
	@Transactional(readOnly=false)
	public void editCar(CarFormMap carFormMap) throws Exception {
		CarFormMap car = carMapper.findCarById(Integer.parseInt(carFormMap.getStr("id")));
		if(car.getInt(Constant.VERSION) == Integer.parseInt(carFormMap.getStr(Constant.VERSION))){
			carFormMap.set(Constant.VERSION, car.getInt(Constant.VERSION)+1);
			carMapper.updateEntity(carFormMap);
			
			addOperatorLog(car, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
		
		
	}

	@Override
	@SystemLog(module="车辆档案",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropCar(String id) throws Exception {
		CarFormMap car = carMapper.findCarById(Integer.parseInt(id));
		
		carMapper.deleteEntityByKey("id", id, CarFormMap.class);
		
		addOperatorLog(car, "delete");
	}

	@Override
	public CarFormMap findCarById(int id) {
		return carMapper.findCarById(id);
	}

	@Override
	public List<CarFormMap> findByPage(CarFormMap carFormMap, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return carMapper.findByPage(carFormMap);
	}
	
	@Override
	public List<CarFormMap> findNotUsedByPage(String bId, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return carMapper.findNotUsedByPage(bId);
	}
	@Override
	public List<CarFormMap> findNotUsedCar() {
		return carMapper.findNotUsedCar();
	}
	
	@Override
	public List<CarFormMap> findCarByBId(String bId) {
		return carMapper.findCarByBId(bId);
	}
	
	@Override
	@Transactional(readOnly=false)
	public void ClearUsedCarById(int id) throws Exception {
		CarFormMap carFormMap = carMapper.findCarById(id);
		
		carMapper.ClearUsedCarById(id);
		
		addOperatorLog2(carFormMap, "clearUsed");
	}

	@Override
	@Transactional(readOnly=false)
	public void ClearUsedCarByBId(String bId) throws Exception {
		List<CarFormMap> carList = carMapper.findCarByBId(bId);
		
		carMapper.ClearUsedCarByBId(bId);
		
		for(CarFormMap car:carList){
			addOperatorLog2(car, "clearUsed");
		}
	}

	private void addOperatorLog(CarFormMap carFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		carFormMap.set(Constant.ENTITY_TABLE, "t_weight_car_archives_his");
		carFormMap.set("execSQL", sql);
		carFormMap.set("execUser", session.getAttribute("userSessionId"));
		carFormMap.set("execType", type);
		carFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		carMapper.addEntity(carFormMap);
	}
	private void addOperatorLog2(CarFormMap carFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		carFormMap.set(Constant.ENTITY_TABLE, "t_weight_car_archives_his");
		carFormMap.set("execUser", session.getAttribute("userSessionId"));
		carFormMap.set("execType", type);
		carFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		carMapper.addEntity(carFormMap);
	}

	@Override
	public CarFormMap isUsed(String rfid) {
		return carMapper.isUsed(rfid);
	}

	

	

}
