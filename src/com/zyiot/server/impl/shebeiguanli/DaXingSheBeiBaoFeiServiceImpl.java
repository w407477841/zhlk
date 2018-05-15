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
import com.zyiot.entity.shebeiguanli.DaXingSheBeiBaoFeiFormMap;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiFormMap;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiWeiXiuFormMap;
import com.zyiot.mapper.shebeiguanli.DaXingSheBeiBaoFeiMapper;
import com.zyiot.mapper.shebeiguanli.DaXingSheBeiMapper;
import com.zyiot.mapper.shebeiguanli.DaXingSheBeiWeiXiuMapper;
import com.zyiot.server.shebeiguanli.DaXingSheBeiBaoFeiServiceI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
@Service("daXingSheBeiBaoFeiService")
public class DaXingSheBeiBaoFeiServiceImpl implements
		DaXingSheBeiBaoFeiServiceI {
	@Autowired
	private DaXingSheBeiBaoFeiMapper daXingSheBeiBaoFeiMapper;
	@Autowired
	private DaXingSheBeiMapper daXingSheBeiMapper;
	@Autowired
	private DaXingSheBeiWeiXiuMapper daXingSheBeiWeiXiuMapper;
	@Override
	@SystemLog(module="设备报废",methods="添加",description="添加成功")
	@Transactional(readOnly=false)
	public void addDaXingSheBeiBaoFei(
			DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap)
			throws Exception {
		daXingSheBeiBaoFeiMapper.addEntity(daXingSheBeiBaoFeiFormMap);
		
		//设备报废，删除库存数据
		String id = daXingSheBeiBaoFeiFormMap.getStr("leId");
		DaXingSheBeiFormMap daXingSheBeiFormMap = daXingSheBeiMapper.findDaXingSheBeiById(Integer.parseInt(id));
		daXingSheBeiMapper.deleteEntityByKey("id", id, DaXingSheBeiFormMap.class);
		addOperatorLog(daXingSheBeiFormMap, "wreck");
		
		//设备报废，删除维修记录
		List<DaXingSheBeiWeiXiuFormMap> daXingSheBeiWeiXiuList = daXingSheBeiWeiXiuMapper.findByLeId(Integer.parseInt(id));
		if(daXingSheBeiWeiXiuList!=null && daXingSheBeiWeiXiuList.size()>0){
			for(DaXingSheBeiWeiXiuFormMap dxsbwx:daXingSheBeiWeiXiuList){
				daXingSheBeiWeiXiuMapper.deleteEntityByKey("id", dxsbwx.getInt("id")+"", DaXingSheBeiWeiXiuFormMap.class);
				addOperatorLog(dxsbwx, "wreck");
			}
		}

	}

	@Override
	@SystemLog(module="设备报废",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editDaXingSheBeiBaoFei(
			DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap)
			throws Exception {
		DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap2 = daXingSheBeiBaoFeiMapper.findDaXingSheBeiBaoFeiById(Integer.parseInt(daXingSheBeiBaoFeiFormMap.getStr("id")));
		if(daXingSheBeiBaoFeiFormMap2.getInt(Constant.VERSION) == Integer.parseInt(daXingSheBeiBaoFeiFormMap.getStr(Constant.VERSION))){
			daXingSheBeiBaoFeiFormMap.set(Constant.VERSION, daXingSheBeiBaoFeiFormMap2.getInt(Constant.VERSION)+1);
			daXingSheBeiBaoFeiMapper.updateEntity(daXingSheBeiBaoFeiFormMap);
			daXingSheBeiBaoFeiFormMap2.remove("leNo");
			daXingSheBeiBaoFeiFormMap2.remove("leName");
			addOperatorLog(daXingSheBeiBaoFeiFormMap2, "update");			
		}else{
			throw new Exception("[数据已被修改]");
		}
	}

	@Override
	@SystemLog(module="设备报废",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropDaXingSheBeiBaoFei(String id) throws Exception {
		DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap = daXingSheBeiBaoFeiMapper.findDaXingSheBeiBaoFeiById(Integer.parseInt(id));
		daXingSheBeiBaoFeiFormMap.remove("leNo");
		daXingSheBeiBaoFeiFormMap.remove("leName");
		daXingSheBeiBaoFeiMapper.deleteEntityByKey("id", id, DaXingSheBeiBaoFeiFormMap.class);
		addOperatorLog(daXingSheBeiBaoFeiFormMap, "delete");
		
		int leId = daXingSheBeiBaoFeiFormMap.getInt("leId");
		
		//删除报废记录，恢复到库存中
		DaXingSheBeiFormMap daXingSheBeiFormMap = daXingSheBeiMapper.findHistoryById(leId);
		FormMapUtil.toADDFormMap(daXingSheBeiFormMap);
		daXingSheBeiMapper.addEntity(daXingSheBeiFormMap);
		
		List<DaXingSheBeiWeiXiuFormMap> list = daXingSheBeiMapper.findRepairHistoryById(leId);
		if(list != null){
			for(DaXingSheBeiWeiXiuFormMap wx:list){
				FormMapUtil.toADDFormMap(wx);
				daXingSheBeiMapper.addEntity(wx);
			}
		}
	}

	@Override
	public List<DaXingSheBeiBaoFeiFormMap> findByPage(
			DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return daXingSheBeiBaoFeiMapper.findByPage(daXingSheBeiBaoFeiFormMap);
	}

	@Override
	public List<DaXingSheBeiBaoFeiFormMap> findByAttr(
			DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap) {
		return daXingSheBeiBaoFeiMapper.findByAttr(daXingSheBeiBaoFeiFormMap);
	}

	@Override
	public DaXingSheBeiBaoFeiFormMap findDaXingSheBeiBaoFeiById(int id) {
		return daXingSheBeiBaoFeiMapper.findDaXingSheBeiBaoFeiById(id);
	}
	/**
	 * 大型设备报废历史操作
	 * @param daXingSheBeiBaoFeiFormMap
	 * @param type
	 * @throws Exception
	 */
	private void addOperatorLog(DaXingSheBeiBaoFeiFormMap daXingSheBeiBaoFeiFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		daXingSheBeiBaoFeiFormMap.set(Constant.ENTITY_TABLE, "t_large_equipment_wreck_his");
		daXingSheBeiBaoFeiFormMap.set("lewhSQL", sql);
		daXingSheBeiBaoFeiFormMap.set("lewhUser", session.getAttribute("userSessionId"));
		daXingSheBeiBaoFeiFormMap.set("lewhType", type);
		daXingSheBeiBaoFeiFormMap.set("lewhOpDate", new Timestamp(System.currentTimeMillis()));
		daXingSheBeiBaoFeiMapper.addEntity(daXingSheBeiBaoFeiFormMap);
	}
	/**
	 * 大型设备历史操作
	 * @param daXingSheBeiFormMap
	 * @param type
	 * @throws Exception
	 */
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
	/**
	 * 大型设备维修历史操作
	 * @param daXingSheBeiWeiXiuFormMap
	 * @param type
	 * @throws Exception
	 */
	private void addOperatorLog(DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		daXingSheBeiWeiXiuFormMap.set(Constant.ENTITY_TABLE, "t_large_equipment_repair_his");
		daXingSheBeiWeiXiuFormMap.set("lerhSQL", sql);
		daXingSheBeiWeiXiuFormMap.set("lerhUser", session.getAttribute("userSessionId"));
		daXingSheBeiWeiXiuFormMap.set("lerhType", type);
		daXingSheBeiWeiXiuFormMap.set("lerhOpDate", new Timestamp(System.currentTimeMillis()));
		daXingSheBeiWeiXiuMapper.addEntity(daXingSheBeiWeiXiuFormMap);
	}
}
