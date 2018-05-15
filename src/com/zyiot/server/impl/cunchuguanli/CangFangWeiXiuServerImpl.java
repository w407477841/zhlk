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
import com.zyiot.entity.cunchuguanli.CangFangWeiXiuFormMap;
import com.zyiot.mapper.cunchuguanli.CangFangWeiXiuMapper;
import com.zyiot.server.cunchuguanli.CangFangWeiXiuServerI;
import com.zyiot.util.Constant;
@Service("cangFangWeiXiuServer")
public class CangFangWeiXiuServerImpl implements CangFangWeiXiuServerI {
	@Autowired
	private CangFangWeiXiuMapper cangFangWeiXiuMapper;
	@Override
	@SystemLog(module="仓房维修",methods="添加",description="添加成功")
	public void addCangFangWeiXiu(CangFangWeiXiuFormMap cangFangWeiXiuFormMap)
			throws Exception {
		cangFangWeiXiuMapper.addEntity(cangFangWeiXiuFormMap);
	}

	@Override
	@SystemLog(module="仓房维修",methods="更新",description="更新成功")
	@Transactional(readOnly=false)
	public void editCangFangWeiXiu(CangFangWeiXiuFormMap cangFangWeiXiuFormMap)
			throws Exception {
		CangFangWeiXiuFormMap cangFangWeiXiuFormMap2 = cangFangWeiXiuMapper.findCangFangWeiXiuById(Integer.parseInt(cangFangWeiXiuFormMap.getStr("id")));
		
		if(cangFangWeiXiuFormMap2.getInt(Constant.VERSION) == Integer.parseInt(cangFangWeiXiuFormMap.getStr(Constant.VERSION))){
			cangFangWeiXiuFormMap.set(Constant.VERSION, cangFangWeiXiuFormMap2.getInt(Constant.VERSION)+1);
			cangFangWeiXiuMapper.updateEntity(cangFangWeiXiuFormMap);	
			
			cangFangWeiXiuFormMap2.remove("wLocation");
			addOperatorLog(cangFangWeiXiuFormMap2, "update");
		}else{
			throw new Exception("[内容已被修改]");
		}
	}

	@Override
	@SystemLog(module="仓房维修",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropCangFangWeiXiu(String id) throws Exception {
		CangFangWeiXiuFormMap cangFangWeiXiuFormMap = cangFangWeiXiuMapper.findCangFangWeiXiuById(Integer.parseInt(id));
		
		cangFangWeiXiuMapper.deleteEntityByKey("id", id, CangFangWeiXiuFormMap.class);
		
		cangFangWeiXiuFormMap.remove("wLocation");
		addOperatorLog(cangFangWeiXiuFormMap, "delete");
	}

	@Override
	public List<CangFangWeiXiuFormMap> findByPage(
			CangFangWeiXiuFormMap cangFangWeiXiuFormMap, int pageIndex,
			int pageSize) {
		PageHelper.startPage(pageIndex, pageSize);
		return cangFangWeiXiuMapper.findByPage(cangFangWeiXiuFormMap);
	}

	@Override
	public CangFangWeiXiuFormMap findCangFangWeiXiuById(int id) throws Exception{
		return cangFangWeiXiuMapper.findCangFangWeiXiuById(id);
	}
	
	private void addOperatorLog(CangFangWeiXiuFormMap cangFangWeiXiuFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		cangFangWeiXiuFormMap.set(Constant.ENTITY_TABLE, "t_warehouse_repair_his");
		cangFangWeiXiuFormMap.set("wrhSQL", sql);
		cangFangWeiXiuFormMap.set("wrhUser", session.getAttribute("userSessionId"));
		cangFangWeiXiuFormMap.set("wrhType", type);
		cangFangWeiXiuFormMap.set("wrhOpDate", new Timestamp(System.currentTimeMillis()));
	    cangFangWeiXiuMapper.addEntity(cangFangWeiXiuFormMap);
	}

}
