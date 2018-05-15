package com.zyiot.server.impl.jichuziliao;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.jichuziliao.RenYuanDangAnFormMap;
import com.zyiot.mapper.jichuziliao.RenYuanDangAnMapper;
import com.zyiot.server.jichuziliao.RenYuanDangAnServiceI;
import com.zyiot.util.Constant;
@Service("renYuanDangAnService")
public class RenYuanDangAnServiceImpl implements RenYuanDangAnServiceI {
	@Autowired
	private RenYuanDangAnMapper renYuanDangAnMapper;
	@Override
	@SystemLog(module="人员档案",methods="档案添加",description="添加成功")
	public void addRenYuanDangAn(RenYuanDangAnFormMap renYuanDangAnFormMap)
			throws Exception {
		renYuanDangAnMapper.addEntity(renYuanDangAnFormMap);
	}

	@Override
	@SystemLog(module="人员档案",methods="档案修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editRenYuanDangAn(RenYuanDangAnFormMap renYuanDangAnFormMap)
			throws Exception {
		RenYuanDangAnFormMap renYuanDangAnFormMap2 =renYuanDangAnMapper.findRenYuanDangAnById(Integer.parseInt(renYuanDangAnFormMap.getStr("id")));
		
		if(renYuanDangAnFormMap2.getInt(Constant.VERSION) == Integer.parseInt(renYuanDangAnFormMap.getStr(Constant.VERSION))){
			
			renYuanDangAnFormMap.set(Constant.VERSION, renYuanDangAnFormMap2.getInt(Constant.VERSION)+1);
			
			renYuanDangAnMapper.updateEntity(renYuanDangAnFormMap);
			
			renYuanDangAnFormMap2.remove("id");
			addOperatorLog(renYuanDangAnFormMap2,"update");
		}else{
			throw new Exception("[数据已被修改]");
		}
		
		
	}

	@Override
	@SystemLog(module="人员档案",methods="档案删除",description="删除成功")
	@Transactional(readOnly = false)
	public void dropRenYuanDangAn(String id) throws Exception {
		RenYuanDangAnFormMap renYuanDangAnFormMap =renYuanDangAnMapper.findRenYuanDangAnById(Integer.parseInt(id));
		
		renYuanDangAnMapper.deleteEntityByKey("id", id, RenYuanDangAnFormMap.class);
		
		renYuanDangAnFormMap.remove("id");
		addOperatorLog(renYuanDangAnFormMap,"update");
	}

	@Override
	public List<RenYuanDangAnFormMap> findByPage(
			RenYuanDangAnFormMap renYuanDangAnFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return renYuanDangAnMapper.findByPage(renYuanDangAnFormMap);
	}

	@Override
	public RenYuanDangAnFormMap findRenYuanDangAnById(int id) {
		return renYuanDangAnMapper.findRenYuanDangAnById(id);
	}
	@Override
	public List<RenYuanDangAnFormMap> findByAttr(
			RenYuanDangAnFormMap renYuanDangAnFormMap) {
		return renYuanDangAnMapper.findByAttr(renYuanDangAnFormMap);
	}
	private void addOperatorLog(RenYuanDangAnFormMap renYuanDangAnFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		renYuanDangAnFormMap.set(Constant.ENTITY_TABLE, "t_person_archives_his");
		renYuanDangAnFormMap.set("pahSQL", sql);
		renYuanDangAnFormMap.set("pahUser", session.getAttribute("userSessionId"));
		renYuanDangAnFormMap.set("pahType", type);
		renYuanDangAnFormMap.set("pahOpDate", new Timestamp(System.currentTimeMillis()));
		renYuanDangAnMapper.addEntity(renYuanDangAnFormMap);
	}

	
}
