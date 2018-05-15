package com.zyiot.server.impl.shebeiguanli;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiFormMap;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiFuJianFormMap;
import com.zyiot.mapper.shebeiguanli.DaXingSheBeiFuJianMapper;
import com.zyiot.mapper.shebeiguanli.DaXingSheBeiMapper;
import com.zyiot.server.shebeiguanli.DaXingSheBeiServiceI;
import com.zyiot.util.Constant;
@Service("daXingSheBeiService")
public class DaXingSheBeiServiceImpl implements DaXingSheBeiServiceI {
	@Autowired
	private DaXingSheBeiMapper daXingSheBeiMapper;
	@Autowired
	private DaXingSheBeiFuJianMapper daXingSheBeiFuJianMapper;
	
	@Override
	@SystemLog(module="设备管理",methods="添加",description="添加成功")
	@Transactional(readOnly=false)
	public void addDaXingSheBei(DaXingSheBeiFormMap daXingSheBeiFormMap)
			throws Exception {
		String sonId = daXingSheBeiFormMap.getStr("leSon");
		if(sonId !=null && sonId.length()>0){
			String[] idList = sonId.split(",");
			for(String id:idList){
				daXingSheBeiFuJianMapper.updateVersion(Integer.parseInt(id));
			}
		}
		
		daXingSheBeiMapper.addEntity(daXingSheBeiFormMap);
	}

	@Override
	@SystemLog(module="设备管理",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editDaXingSheBei(DaXingSheBeiFormMap daXingSheBeiFormMap)
			throws Exception {
		DaXingSheBeiFormMap daXingSheBeiFormMap2 = daXingSheBeiMapper.findDaXingSheBeiById(Integer.parseInt(daXingSheBeiFormMap.getStr("id")));
		if(daXingSheBeiFormMap2.getInt(Constant.VERSION) == Integer.parseInt(daXingSheBeiFormMap.getStr(Constant.VERSION))){
			String sonId = daXingSheBeiFormMap.getStr("leSon");
			if(sonId !=null && sonId.length()>0){
				String[] idList = sonId.split(",");
				for(String id:idList){
					daXingSheBeiFuJianMapper.updateVersion(Integer.parseInt(id));
				}
			}
			daXingSheBeiFormMap.set("leDataOperator", daXingSheBeiFormMap2.getInt("leDataOperator"));
			daXingSheBeiFormMap.set(Constant.VERSION, daXingSheBeiFormMap2.getInt(Constant.VERSION)+1);
			daXingSheBeiMapper.updateEntity(daXingSheBeiFormMap);
			addOperatorLog(daXingSheBeiFormMap2,"update");
		}else{
			throw new Exception("[数据已被修改]");
		}
	}

	@Override
	@SystemLog(module="设备管理",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropDaXingSheBei(String id)
			throws Exception {
		DaXingSheBeiFormMap daXingSheBeiFormMap = daXingSheBeiMapper.findDaXingSheBeiById(Integer.parseInt(id));
		String sonId = daXingSheBeiFormMap.getStr("leSon");
		if(sonId !=null && sonId.length()>0){
			String[] idList = sonId.split(",");
			for(String sid:idList){
				daXingSheBeiFuJianMapper.deleteEntityByKey("id", sid, DaXingSheBeiFuJianFormMap.class);
			}
		}
		
		daXingSheBeiMapper.deleteEntityByKey("id", id, DaXingSheBeiFormMap.class);
		addOperatorLog(daXingSheBeiFormMap,"delete");
	}

	@Override
	public List<DaXingSheBeiFormMap> findByPage(
			DaXingSheBeiFormMap daXingSheBeiFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		
		return daXingSheBeiMapper.findByPage(daXingSheBeiFormMap);
	}

	@Override
	public List<DaXingSheBeiFormMap> findByAttr(
			DaXingSheBeiFormMap daXingSheBeiFormMap) {
		return daXingSheBeiMapper.findByAttr(daXingSheBeiFormMap);
	}

	@Override
	public DaXingSheBeiFormMap findDaXingSheBeiById(int id) {
		return daXingSheBeiMapper.findDaXingSheBeiById(id);
	}
	private void addOperatorLog(DaXingSheBeiFormMap daXingSheBeiFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		daXingSheBeiFormMap.set(Constant.ENTITY_TABLE, "t_large_equipment_his");
		daXingSheBeiFormMap.set("lehSQL", sql);
		daXingSheBeiFormMap.set("lehUser", session.getAttribute("userSessionId"));
		daXingSheBeiFormMap.set("lehType", type);
		daXingSheBeiFormMap.set("lehOpDate", new Timestamp(System.currentTimeMillis()));
		daXingSheBeiMapper.addEntity(daXingSheBeiFormMap);
	}

	@Override
	public List<DaXingSheBeiFormMap> findAllName() {
		return daXingSheBeiMapper.findAllName();
	}
}
