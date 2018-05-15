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
import com.zyiot.entity.cunchuguanli.CangRongFenPeiFormMap;
import com.zyiot.mapper.cunchuguanli.CangRongFenPeiMapper;
import com.zyiot.server.cunchuguanli.CangRongFenPeiServerI;
import com.zyiot.util.Constant;
@Service("cangRongFenPeiServer")
public class CangRongFenPeiServerImpl implements CangRongFenPeiServerI {

	@Autowired
	private CangRongFenPeiMapper cangRongFenPeiMapper;
	@Override
	@SystemLog(module="仓容分配",methods="添加",description="添加成功")
	public void addCangRongFenPei(CangRongFenPeiFormMap cangRongFenPeiFormMap)
			throws Exception {
		cangRongFenPeiMapper.addEntity(cangRongFenPeiFormMap);
	}

	@Override
	@SystemLog(module="仓容分配",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editCangRongFenPei(CangRongFenPeiFormMap cangRongFenPeiFormMap)
			throws Exception {
		CangRongFenPeiFormMap cangRongFenPeiFormMap2 = cangRongFenPeiMapper.findCangRongFenPeiById(Integer.parseInt(cangRongFenPeiFormMap.getStr("id")));
		
		if(cangRongFenPeiFormMap2.getInt(Constant.VERSION) == Integer.parseInt(cangRongFenPeiFormMap.getStr(Constant.VERSION))){
			cangRongFenPeiFormMap.set(Constant.VERSION, cangRongFenPeiFormMap2.getInt(Constant.VERSION)+1);
			
			cangRongFenPeiMapper.updateEntity(cangRongFenPeiFormMap);
			
			addOperatorLog(cangRongFenPeiFormMap2, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
	}

	@Override
	@SystemLog(module="仓容分配",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropCangRongFenPei(String id) throws Exception {
		CangRongFenPeiFormMap cangRongFenPeiFormMap = cangRongFenPeiMapper.findCangRongFenPeiById(Integer.parseInt(id));
		
		cangRongFenPeiMapper.deleteEntityByKey("id", id, CangRongFenPeiFormMap.class);
		
		addOperatorLog(cangRongFenPeiFormMap, "delete");
	}

	@Override
	public List<CangRongFenPeiFormMap> findByPage(
			CangRongFenPeiFormMap cangRongFenPeiFormMap, int pageNum,
			int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return cangRongFenPeiMapper.findByPage(cangRongFenPeiFormMap);
	}

	@Override
	public CangRongFenPeiFormMap findCangRongFenPeiById(int id)
			throws Exception {
		return cangRongFenPeiMapper.findCangRongFenPeiById(id);
	}
	
	
	private void addOperatorLog(CangRongFenPeiFormMap cangRongFenPeiFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		cangRongFenPeiFormMap.remove("wLocation");
		cangRongFenPeiFormMap.set(Constant.ENTITY_TABLE, "t_warehouse_storage_capacity_his");
		cangRongFenPeiFormMap.set("wschSQL", sql);
		cangRongFenPeiFormMap.set("wschUser", session.getAttribute("userSessionId"));
		cangRongFenPeiFormMap.set("wschType", type);
		cangRongFenPeiFormMap.set("wschOpDate", new Timestamp(System.currentTimeMillis()));
		cangRongFenPeiMapper.addEntity(cangRongFenPeiFormMap);
	}
	
}
