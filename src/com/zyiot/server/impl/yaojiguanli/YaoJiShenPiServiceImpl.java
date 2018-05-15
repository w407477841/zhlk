package com.zyiot.server.impl.yaojiguanli;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.yaojiguanli.YaoJiShenPiFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiShenQingFormMap;
import com.zyiot.mapper.yaojiguanli.YaoJiShenPiMapper;
import com.zyiot.mapper.yaojiguanli.YaoJiShenQingMapper;
import com.zyiot.server.yaojiguanli.YaoJiShenPiServiceI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
@Service("yaoJiShenPiService")
public class YaoJiShenPiServiceImpl implements YaoJiShenPiServiceI {
	@Autowired
	private YaoJiShenPiMapper yaoJiShenPiMapper;
	@Autowired
	private YaoJiShenQingMapper yaoJiShenQingMapper;
	@Override
	public List<YaoJiShenPiFormMap> findByPage(
			YaoJiShenPiFormMap yaoJiShenPiFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return yaoJiShenPiMapper.findByPage(yaoJiShenPiFormMap);
	}
	@Override
	@SystemLog(module="药剂审批",methods="审批",description="审批成功")
	@Transactional(readOnly=false)
	public void auditingYaoJiShenQing(YaoJiShenQingFormMap yaoJiShenQingFormMap)
			throws Exception {
		Session session = SecurityUtils.getSubject().getSession();
		YaoJiShenQingFormMap yaoJiShenQingFormMap2 = yaoJiShenQingMapper.findYaoJiShenQingById(Integer.parseInt(yaoJiShenQingFormMap.getStr("id")));
		
		if(yaoJiShenQingFormMap2.getInt(Constant.VERSION) == Integer.parseInt(yaoJiShenQingFormMap.getStr(Constant.VERSION))){
			yaoJiShenQingFormMap.set(Constant.VERSION, yaoJiShenQingFormMap2.getInt(Constant.VERSION)+1);
			yaoJiShenQingFormMap.set("maAuditor", session.getAttribute("userSessionId"));
			yaoJiShenQingFormMap.set("maAuditingDate", new Timestamp(System.currentTimeMillis()));
			
			yaoJiShenQingMapper.updateEntity(yaoJiShenQingFormMap);
			addOperatorLog(yaoJiShenQingFormMap2,"auditing");
			
			YaoJiShenPiFormMap yaoJiShenPiFormMap = new YaoJiShenPiFormMap();
			yaoJiShenPiFormMap.set("maBill", yaoJiShenQingFormMap2.getStr("maBill"));
			yaoJiShenPiFormMap.set("maAuditor", session.getAttribute("userSessionId"));
			yaoJiShenPiFormMap.set("maResult", yaoJiShenQingFormMap.getStr("maProcess"));
			yaoJiShenPiFormMap.set("maOpinion", yaoJiShenQingFormMap.getStr("maOpinion"));
			yaoJiShenPiFormMap.set("maAuditingDate", new Timestamp(System.currentTimeMillis()));
			FormMapUtil.toADDFormMap(yaoJiShenPiFormMap);
			
			yaoJiShenPiMapper.addEntity(yaoJiShenPiFormMap);
			
		}else{
			throw new Exception("[数据已被修改]");
		}
	}
	private void addOperatorLog(YaoJiShenQingFormMap yaoJiShenQingFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		yaoJiShenQingFormMap.set(Constant.ENTITY_TABLE, "t_medicament_apply_his");
		yaoJiShenQingFormMap.set("mahSQL", sql);
		yaoJiShenQingFormMap.set("mahUser", session.getAttribute("userSessionId"));
		yaoJiShenQingFormMap.set("mahType", type);
		yaoJiShenQingFormMap.set("mahOpDate", new Timestamp(System.currentTimeMillis()));
	    yaoJiShenQingMapper.addEntity(yaoJiShenQingFormMap);
	}

}
