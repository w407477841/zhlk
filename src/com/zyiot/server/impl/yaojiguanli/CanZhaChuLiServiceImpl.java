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
import com.zyiot.entity.yaojiguanli.CanZhaChuLiFormMap;
import com.zyiot.mapper.yaojiguanli.CanZhaChuLiMapper;
import com.zyiot.server.yaojiguanli.CanZhaChuLiServiceI;
import com.zyiot.util.Constant;
@Service("canZhaChuLiService")
public class CanZhaChuLiServiceImpl implements CanZhaChuLiServiceI {
	@Autowired
	private CanZhaChuLiMapper canZhaChuLiMapper;
	@Override
	@SystemLog(module="残渣处理",methods="添加",description="添加成功")
	public void addCanZhaChuLi(CanZhaChuLiFormMap canZhaChuLiFormMap)
			throws Exception {
		canZhaChuLiMapper.addEntity(canZhaChuLiFormMap);
	}

	@Override
	@SystemLog(module="残渣处理",methods="更新",description="更新成功")
	@Transactional(readOnly=false)
	public void editCanZhaChuLi(CanZhaChuLiFormMap canZhaChuLiFormMap)
			throws Exception {
		CanZhaChuLiFormMap canZhaChuLiFormMap2 = canZhaChuLiMapper.findCanZhaChuLiById(Integer.parseInt(canZhaChuLiFormMap.getStr("id")));
		
		if(canZhaChuLiFormMap2.getInt(Constant.VERSION) == Integer.parseInt(canZhaChuLiFormMap.getStr(Constant.VERSION))){
			canZhaChuLiFormMap.set(Constant.VERSION, canZhaChuLiFormMap2.getInt(Constant.VERSION)+1);
			
			canZhaChuLiMapper.updateEntity(canZhaChuLiFormMap);
			
			addOperatorLog(canZhaChuLiFormMap2,"update");
		}else{
			throw new Exception("[数据已被修改]");
		}

	}

	@Override
	@SystemLog(module="残渣处理",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropCanZhaChuLi(String id)
			throws Exception {
		CanZhaChuLiFormMap canZhaChuLiFormMap = canZhaChuLiMapper.findCanZhaChuLiById(Integer.parseInt(id));
		
		canZhaChuLiMapper.deleteEntityByKey("id", id, CanZhaChuLiFormMap.class);
		addOperatorLog(canZhaChuLiFormMap,"delete");
		
	}

	@Override
	public List<CanZhaChuLiFormMap> findByPage(
			CanZhaChuLiFormMap canZhaChuLiFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return canZhaChuLiMapper.findByPage(canZhaChuLiFormMap);
	}

	@Override
	public List<CanZhaChuLiFormMap> findByAttr(
			CanZhaChuLiFormMap canZhaChuLiFormMap) {
		return canZhaChuLiMapper.findByAttr(canZhaChuLiFormMap);
	}

	@Override
	public CanZhaChuLiFormMap findById(int id) throws Exception {
		return canZhaChuLiMapper.findCanZhaChuLiById(id);
	}
	private void addOperatorLog(CanZhaChuLiFormMap canZhaChuLiFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		canZhaChuLiFormMap.remove("wLocation");
		canZhaChuLiFormMap.set(Constant.ENTITY_TABLE, "t_medicament_dispose_his");
		canZhaChuLiFormMap.set("mdhSQL", sql);
		canZhaChuLiFormMap.set("mdhUser", session.getAttribute("userSessionId"));
		canZhaChuLiFormMap.set("mdhType", type);
		canZhaChuLiFormMap.set("mdhOpDate", new Timestamp(System.currentTimeMillis()));
	    canZhaChuLiMapper.addEntity(canZhaChuLiFormMap);
	}
}
