package com.zyiot.server.impl.cunchuguanli;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.cunchuguanli.ChuKuShenPiFormMap;
import com.zyiot.entity.cunchuguanli.ChuKuShenQingFormMap;
import com.zyiot.mapper.cunchuguanli.ChuKuShenPiMapper;
import com.zyiot.mapper.cunchuguanli.ChuKuShenQingMapper;
import com.zyiot.server.cunchuguanli.ChuKuShenPiServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
@Service("chuKuShenPiServer")
public class ChuKuShenPiServerImpl implements ChuKuShenPiServerI {
	@Autowired
	private ChuKuShenPiMapper chuKuShenPiMapper;
	@Autowired
	private ChuKuShenQingMapper chuKuShenQingMapper;
	@Override
	@SystemLog(module="出库审批",methods="审批",description="审批完成")
	@Transactional(readOnly=false)
	public void auditingChuKuShenQing(ChuKuShenQingFormMap chuKuShenQingFormMap)
			throws Exception {
        ChuKuShenQingFormMap chuKuShenQingFormMap2 = chuKuShenQingMapper.findChuKuShenQingById(Integer.parseInt(chuKuShenQingFormMap.getStr("id")));
		
		String process = chuKuShenQingFormMap2.getStr("gsaProcess");
		//出库审批
		if(!process.equals(Constant.STATUS_APPROVE)){
			throw new Exception("[数据不能进行审批]");
		}else{
			if(chuKuShenQingFormMap2.getInt(Constant.VERSION) == Integer.parseInt(chuKuShenQingFormMap.getStr(Constant.VERSION))){
				//出库申请状态更新
				chuKuShenQingFormMap.set(Constant.VERSION, chuKuShenQingFormMap2.getInt(Constant.VERSION)+1);
				chuKuShenQingMapper.updateEntity(chuKuShenQingFormMap);
				addOperatorLog(chuKuShenQingFormMap2, "auditing");
				
				//添加出库申请审批项
				ChuKuShenPiFormMap chuKuShenPiFormMap = new ChuKuShenPiFormMap();
				chuKuShenPiFormMap.set("gsaApplyBill", chuKuShenQingFormMap.getStr("gsaApplyBill"));
				chuKuShenPiFormMap.set("gsaAuditor", chuKuShenQingFormMap.getInt("gsaAuditor"));
				chuKuShenPiFormMap.set("gsaAuditingDate", chuKuShenQingFormMap.getTimestamp("gsaAuditingDate"));
				chuKuShenPiFormMap.set("gsaProcess", chuKuShenQingFormMap.getStr("gsaProcess"));
				chuKuShenPiFormMap.set("gsaRemark", chuKuShenQingFormMap.getStr("gsaRemark"));
				FormMapUtil.toADDFormMap(chuKuShenPiFormMap);
				chuKuShenPiMapper.addEntity(chuKuShenPiFormMap);				
			}else{
				throw new Exception("[数据已被修改]");
			}
		}
	}

	@Override
	public List<ChuKuShenPiFormMap> findByPage(
			ChuKuShenPiFormMap chuKuShenPiFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return chuKuShenPiMapper.findByPage(chuKuShenPiFormMap);
	}

	@Override
	public List<ChuKuShenPiFormMap> findByBill(ChuKuShenPiFormMap chuKuShenPiFormMap) {
		return chuKuShenPiMapper.findByAttr(chuKuShenPiFormMap);
	}
	
	private void addOperatorLog(ChuKuShenQingFormMap chuKuShenQingFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		chuKuShenQingFormMap.remove("wLocation");
		chuKuShenQingFormMap.set(Constant.ENTITY_TABLE, "t_getout_storage_apply_his");
		chuKuShenQingFormMap.set("gsahSQL", sql);
		chuKuShenQingFormMap.set("gsahUser", session.getAttribute("userSessionId"));
		chuKuShenQingFormMap.set("gsahType", type);
		chuKuShenQingFormMap.set("gsahOpDate", new Timestamp(System.currentTimeMillis()));
		chuKuShenQingMapper.addEntity(chuKuShenQingFormMap);
	}
}
