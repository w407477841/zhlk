package com.zyiot.server.impl.weight;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.weight.VarietyFormMap;
import com.zyiot.mapper.weight.VarietyMapper;
import com.zyiot.server.weight.VarietyServerI;
import com.zyiot.util.Constant;
/**
 * 品种档案
 * @author Lip
 * @date 2017年4月25日 上午10:46:07
 */
@Service("varietyServer")
public class VarietyServerImpl implements VarietyServerI {
	@Autowired
	private VarietyMapper varietyMapper;
	@Override
	public void addVariety(VarietyFormMap varietyFormMap) throws Exception {
		varietyMapper.addEntity(varietyFormMap);
	}

	@Override
	@SystemLog(module="品种档案",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editVariety(VarietyFormMap varietyFormMap) throws Exception {
		VarietyFormMap variety = varietyMapper.findVarietyById(Integer.parseInt(varietyFormMap.getStr("id")));
		if(variety.getInt(Constant.VERSION) == Integer.parseInt(varietyFormMap.getStr(Constant.VERSION))){
			varietyFormMap.set(Constant.VERSION, variety.getInt(Constant.VERSION)+1);
			varietyMapper.updateEntity(varietyFormMap);
			addOperatorLog(variety, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
	}

	@Override
	public void dropVariety(String id) throws Exception {
		varietyMapper.deleteEntityByKey("id", id, VarietyFormMap.class);
	}

	@Override
	public VarietyFormMap findVarietyById(int id) {
		return varietyMapper.findVarietyById(id);
	}

	@Override
	public List<VarietyFormMap> findByPage(VarietyFormMap varietyFormMap,
			int pageSize, int pageNum) {
		return varietyMapper.findByPage(varietyFormMap);
	}

	@Override
	public List<VarietyFormMap> findAll() {
		return varietyMapper.findAll();
	}
	private void addOperatorLog(VarietyFormMap varietyFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		varietyFormMap.set(Constant.ENTITY_TABLE, "t_weight_grain_variety_his");
		varietyFormMap.set("execSQL", sql);
		varietyFormMap.set("execUser", session.getAttribute("userSessionId"));
		varietyFormMap.set("execType", type);
		varietyFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		varietyMapper.addEntity(varietyFormMap);
	}

	@Override
	public List<VarietyFormMap> findEnableVariety() {
		return varietyMapper.findEnableVariety();
	}

	@Override
	public List<VarietyFormMap> findTopMenuVariety() {
		return varietyMapper.findTopMenuVariety();
	}
}
