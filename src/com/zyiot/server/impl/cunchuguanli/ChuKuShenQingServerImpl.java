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
import com.zyiot.entity.cunchuguanli.ChuKuShenQingFormMap;
import com.zyiot.entity.cunchuguanli.ChuKuShenQingTransferToolsFormMap;
import com.zyiot.mapper.cunchuguanli.ChuKuShenQingMapper;
import com.zyiot.mapper.cunchuguanli.ChuKuShenQingTransferToolsMapper;
import com.zyiot.server.cunchuguanli.ChuKuShenQingServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
@Service("chuKuShenQingServer")
public class ChuKuShenQingServerImpl implements ChuKuShenQingServerI {

	@Autowired	
	private ChuKuShenQingMapper chuKuShenQingMapper;
	@Autowired
	private ChuKuShenQingTransferToolsMapper chuKuShenQingTransferToolsMapper;
	@Override
	@SystemLog(module="出库申请",methods="添加",description="添加成功")
	@Transactional(readOnly=false)
	public void addChuKuShenQing(ChuKuShenQingFormMap chuKuShenQingFormMap)
			throws Exception {
		updateVersion(chuKuShenQingFormMap);
		
		chuKuShenQingMapper.addEntity(chuKuShenQingFormMap);
	}

	@Override
	@SystemLog(module="出库申请",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editChuKuShenQing(ChuKuShenQingFormMap chuKuShenQingFormMap)
			throws Exception {
		ChuKuShenQingFormMap chuKuShenQingFormMap2 = chuKuShenQingMapper.findChuKuShenQingById(Integer.parseInt(chuKuShenQingFormMap.getStr("id")));
		
		String process = chuKuShenQingFormMap2.getStr("gsaProcess");
		//等待审批和审批通过的数据不能进行修改
		if(process.equals(Constant.STATUS_APPROVE) || process.equals(Constant.STATUS_APPLICANT)){
			throw new Exception("[数据不能进行修改]");
		}else{
			if(chuKuShenQingFormMap2.getInt(Constant.VERSION) == Integer.parseInt(chuKuShenQingFormMap.getStr(Constant.VERSION))){
				updateVersion(chuKuShenQingFormMap);
				
				chuKuShenQingFormMap.set(Constant.VERSION, chuKuShenQingFormMap2.getInt(Constant.VERSION)+1);
				chuKuShenQingMapper.updateEntity(chuKuShenQingFormMap);
				addOperatorLog(chuKuShenQingFormMap2, "update");
			}else{
				throw new Exception("[数据已被修改]");
			}
		}
		
	}
	

	@Override
	@SystemLog(module="出库申请",methods="提交审批",description="提交成功")
	public void approveChuKuShenQing(ChuKuShenQingFormMap chuKuShenQingFormMap)
			throws Exception {
		ChuKuShenQingFormMap chuKuShenQingFormMap2 = chuKuShenQingMapper.findChuKuShenQingById(Integer.parseInt(chuKuShenQingFormMap.getStr("id")));
		String process = chuKuShenQingFormMap2.getStr("gsaProcess");
		//等待审批和审批通过的数据不能进行提交审批
		if(process.equals(Constant.STATUS_APPROVE) || process.equals(Constant.STATUS_APPLICANT)){
			throw new Exception("[数据不能进行提交]");
		}else{
			chuKuShenQingMapper.updateEntity(chuKuShenQingFormMap);
		}
	}

	@Override
	@SystemLog(module="出库申请",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropChuKuShenQing(String id) throws Exception {
		ChuKuShenQingFormMap chuKuShenQingFormMap = chuKuShenQingMapper.findChuKuShenQingById(Integer.parseInt(id));
		String process = chuKuShenQingFormMap.getStr("gsaProcess");
		//审批通过的数据不能进行删除
		if(process.equals(Constant.STATUS_APPLICANT)){
			throw new Exception("[数据不能进行删除]");
		}else{
			//删除传输工具中的数据
			String gsaTransferTools = chuKuShenQingFormMap.getStr("gsaTransferTools");
			if(!Common.isEmpty(gsaTransferTools)){
				String [] temp = gsaTransferTools.split(",");
				for(String t:temp){
					chuKuShenQingTransferToolsMapper.deleteEntityByKey("id", t, ChuKuShenQingTransferToolsFormMap.class);
				}
			}
			
			chuKuShenQingMapper.deleteEntityByKey("id", id, ChuKuShenQingFormMap.class);
			
			addOperatorLog(chuKuShenQingFormMap, "delete");
		}
	}

	@Override
	public List<ChuKuShenQingFormMap> findByPage(
			ChuKuShenQingFormMap chuKuShenQingFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return chuKuShenQingMapper.findByPage(chuKuShenQingFormMap);
	}

	@Override
	public List<ChuKuShenQingFormMap> findShenPiByPage(
			ChuKuShenQingFormMap chuKuShenQingFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return chuKuShenQingMapper.findShenPiByPage(chuKuShenQingFormMap);
	}
	
	@Override
	public ChuKuShenQingFormMap findChuKuShenQingById(int id) throws Exception {
		return chuKuShenQingMapper.findChuKuShenQingById(id);
	}
	
	@Override
	public ChuKuShenQingFormMap lookChuKuShenQingById(int id) throws Exception {
		return chuKuShenQingMapper.lookChuKuShenQingById(id);
	}
	
	/**
	 * 更新传输工具状态
	 * @param chuKuShenQingFormMap
	 */
	private void updateVersion(ChuKuShenQingFormMap chuKuShenQingFormMap){
		String gsaTransferTools = chuKuShenQingFormMap.getStr("gsaTransferTools");
		if(!Common.isEmpty(gsaTransferTools)){
			String [] temp = gsaTransferTools.split(",");
			for(String t:temp){
				chuKuShenQingTransferToolsMapper.updateVersion(Integer.parseInt(t));
			}
		}
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
