package com.zyiot.server.impl.zhiliangguanli;

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
import com.zyiot.entity.weight.QualityCheckFormMap;
import com.zyiot.entity.zhiliangguanli.QualityManagerFormMap;
import com.zyiot.mapper.weight.QualityCheckMapper;
import com.zyiot.mapper.zhiliangguanli.QualityManagerMapper;
import com.zyiot.server.zhiliangguanli.QualityManagerServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
@Service("qualityManagerServer")
public class QualityManagerServerImpl implements QualityManagerServerI {
	@Autowired
	private QualityManagerMapper qualityManagerMapper;
	@Autowired
	private QualityCheckMapper qualityCheckMapper;
	//@Autowired
	//private StoreInfoMapper storeInfoMapper;
	@Override
	@SystemLog(module="质量管理",methods="添加",description="成功")
	public void addQualityManagerFormMap(
			QualityManagerFormMap qualityManagerFormMap) throws Exception {
		//String wId = qualityManagerFormMap.getStr("wId");
		//StorageInfoFormMap storageInfoFormMap = storeInfoMapper.findByWarehouseId(Integer.parseInt(wId));
		//qualityManagerFormMap.set("currentWeight", storageInfoFormMap.getStr("cangKu"));
		String Bid =qualityManagerMapper.findQualityManagerNumber(DateUtils.dateToShortString(new Date()));
		if(Bid == null){//如果当前日期是第一个
			Bid = DateUtils.dateToShortString(new Date())+"1001";
		}else{
			String head = Bid.substring(0,8);
			String tial = Bid.substring(8);
			Bid = head+ (Integer.parseInt(tial)+1);
		}
		qualityManagerFormMap.set("dNumber", Bid);
		qualityManagerMapper.addEntity(qualityManagerFormMap);
	}

	@Override
	@Transactional(readOnly=false)
	@SystemLog(module="质量管理",methods="修改",description="成功")
	public void editQualityManagerFormMap(QualityManagerFormMap qualityManagerFormMap) throws Exception {
		QualityManagerFormMap qmm = qualityManagerMapper.findQualityManagerById(Integer.parseInt(qualityManagerFormMap.getStr("id")));
		
		if(qmm.getInt(Constant.VERSION) == Integer.parseInt(qualityManagerFormMap.getStr(Constant.VERSION))){
			qualityManagerFormMap.set(Constant.VERSION, qmm.getInt(Constant.VERSION)+1);
			qualityManagerMapper.updateEntity(qualityManagerFormMap);
			addOperatorLog(qmm, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
		
	}

	@Override
	@Transactional(readOnly=false)
	@SystemLog(module="质量管理",methods="删除",description="成功")
	public void dropQualityManagerFormMap(String id) throws Exception {
		QualityManagerFormMap qmm = qualityManagerMapper.findQualityManagerById(Integer.parseInt(id));
		qualityManagerMapper.deleteEntityByKey("id", id, QualityManagerFormMap.class);
		addOperatorLog(qmm, "delete");
	}

	@Override
	public List<QualityCheckFormMap> findByPage(
			QualityCheckFormMap qualityCheckFormMap, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return qualityCheckMapper.findQualityCheck(qualityCheckFormMap);
	}

	@Override
	public List<QualityManagerFormMap> findByPage(
			QualityManagerFormMap qualityManagerFormMap, int pageSize,
			int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return qualityManagerMapper.findQualityManagerByPage(qualityManagerFormMap);
	}

	@Override
	public QualityManagerFormMap findQualityManagerById(int id) {
		return qualityManagerMapper.findQualityManagerById(id);
	}
	
	
	private void addOperatorLog(QualityManagerFormMap qualityManagerFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		qualityManagerFormMap.remove("wlId");
		qualityManagerFormMap.set(Constant.ENTITY_TABLE, "t_quality_manager_his");
		qualityManagerFormMap.set("execSQL", sql);
		qualityManagerFormMap.set("execUser", session.getAttribute("userSessionId"));
		qualityManagerFormMap.set("execType", type);
		qualityManagerFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		qualityManagerMapper.addEntity(qualityManagerFormMap);
	}

	
}
