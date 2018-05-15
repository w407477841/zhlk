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
import com.zyiot.entity.cunchuguanli.ShouKuanTongZhiDanFormMap;
import com.zyiot.mapper.cunchuguanli.ShouKuanTongZhiDanMapper;
import com.zyiot.server.cunchuguanli.ShouKuanTongZhiDanServerI;
import com.zyiot.util.Constant;
@Service("shouKuanTongZhiDanServer")
public class ShouKuanTongZhiDanServerImpl implements ShouKuanTongZhiDanServerI {
	@Autowired
	private ShouKuanTongZhiDanMapper shouKuanTongZhiDanMapper;
	@Override
	@SystemLog(module="收款单通知",methods="添加",description="添加成功")
	public void addShouKuanTongZhiDan(
			ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap)
			throws Exception {
		shouKuanTongZhiDanMapper.addEntity(shouKuanTongZhiDanFormMap);
	}

	@Override
	@SystemLog(module="收款单通知",methods="添加",description="添加成功")
	@Transactional(readOnly = false)
	public void editShouKuanTongZhiDan(
			ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap)
			throws Exception {
		ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap2 = shouKuanTongZhiDanMapper.findShouKuanTongZhiDanById(Integer.parseInt(shouKuanTongZhiDanFormMap.getStr("id")));
		
		if(shouKuanTongZhiDanFormMap2.getInt(Constant.VERSION) == Integer.parseInt(shouKuanTongZhiDanFormMap.getStr(Constant.VERSION))){
			shouKuanTongZhiDanFormMap.set(Constant.VERSION, shouKuanTongZhiDanFormMap2.getInt(Constant.VERSION)+1);
			shouKuanTongZhiDanMapper.updateEntity(shouKuanTongZhiDanFormMap);
			addOperatorLog(shouKuanTongZhiDanFormMap2, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}

	}

	@Override
	@SystemLog(module="收款单通知",methods="添加",description="添加成功")
	@Transactional(readOnly = false)
	public void dropShouKuanTongZhiDan(String id) throws Exception {
		ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap = shouKuanTongZhiDanMapper.findShouKuanTongZhiDanById(Integer.parseInt(id));
		
		shouKuanTongZhiDanMapper.deleteEntityByKey("id", id, ShouKuanTongZhiDanFormMap.class);
		
		addOperatorLog(shouKuanTongZhiDanFormMap, "delete");
	}

	@Override
	public List<ShouKuanTongZhiDanFormMap> findByPage(
			ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap, int pageNum,
			int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return shouKuanTongZhiDanMapper.findByPage(shouKuanTongZhiDanFormMap);
	}

	@Override
	public ShouKuanTongZhiDanFormMap findShouKuanTongZhiDanById(int id) throws Exception {
		return shouKuanTongZhiDanMapper.findShouKuanTongZhiDanById(id);
	}
	
	@Override
	public ShouKuanTongZhiDanFormMap lookShouKuanTongZhiDanById(int id)
			throws Exception {
		return shouKuanTongZhiDanMapper.lookShouKuanTongZhiDanById(id);
	}
	
	private void addOperatorLog(ShouKuanTongZhiDanFormMap shouKuanTongZhiDanFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		shouKuanTongZhiDanFormMap.remove("wLocation");
		shouKuanTongZhiDanFormMap.set(Constant.ENTITY_TABLE, "t_credit_note_his");
		shouKuanTongZhiDanFormMap.set("cnhSQL", sql);
		shouKuanTongZhiDanFormMap.set("cnhUser", session.getAttribute("userSessionId"));
		shouKuanTongZhiDanFormMap.set("cnhType", type);
		shouKuanTongZhiDanFormMap.set("cnhOpDate", new Timestamp(System.currentTimeMillis()));
		shouKuanTongZhiDanMapper.addEntity(shouKuanTongZhiDanFormMap);
	}

	
}
