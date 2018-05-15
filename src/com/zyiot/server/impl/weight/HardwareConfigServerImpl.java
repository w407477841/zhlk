package com.zyiot.server.impl.weight;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.entity.weight.HardwareConfigFormMap;
import com.zyiot.mapper.weight.HardwareConfigMapper;
import com.zyiot.server.weight.HardwareConfigServerI;
import com.zyiot.util.Constant;

@Service("hardwareConfigServer")
public class HardwareConfigServerImpl implements HardwareConfigServerI {
	@Autowired
	private HardwareConfigMapper hardwareConfigMapper;
	@Override
	public void addHardwareConfig(HardwareConfigFormMap hardwareConfigFormMap)
			throws Exception {
		hardwareConfigMapper.addEntity(hardwareConfigFormMap);
	}

	@Override
	@Transactional(readOnly = false)
	public void editHardwareConfig(HardwareConfigFormMap hardwareConfigFormMap)
			throws Exception {
		HardwareConfigFormMap hardwareConfig = hardwareConfigMapper.findByMacAndType(hardwareConfigFormMap.getStr("mac"), Constant.RFID_CAR);
		
		hardwareConfigFormMap.set(Constant.VERSION, hardwareConfig.getInt(Constant.VERSION)+1);
		hardwareConfigMapper.updateEntity(hardwareConfigFormMap);
		
		addOperatorLog(hardwareConfig, "update");
	}

	@Override
	public void dropHardwareConfig(String id) throws Exception {
		hardwareConfigMapper.deleteEntityByKey("id", id, HardwareConfigFormMap.class);
	}

	@Override
	public HardwareConfigFormMap findByMacAndType(String mac, String carType) {
		return hardwareConfigMapper.findByMacAndType(mac, carType);
	}

	@Override
	public List<HardwareConfigFormMap> findByCarType(String carType,int pageNum,int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return hardwareConfigMapper.findByCarType(carType);
	}
	
	private void addOperatorLog(HardwareConfigFormMap hardwareConfigFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		hardwareConfigFormMap.set(Constant.ENTITY_TABLE, "t_weight_hardware_config_his");
		hardwareConfigFormMap.set("execSQL", sql);
		hardwareConfigFormMap.set("execUser", session.getAttribute("userSessionId"));
		hardwareConfigFormMap.set("execType", type);
		hardwareConfigFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		hardwareConfigMapper.addEntity(hardwareConfigFormMap);
	}
}
