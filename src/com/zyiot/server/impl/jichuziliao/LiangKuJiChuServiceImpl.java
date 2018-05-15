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
import com.zyiot.entity.jichuziliao.LiangKuJiChuFormMap;
import com.zyiot.mapper.jichuziliao.LiangKuJiChuMapper;
import com.zyiot.server.jichuziliao.LiangKuJiChuServiceI;
import com.zyiot.util.Constant;
@Service("liangKuJiChu")
public class LiangKuJiChuServiceImpl implements LiangKuJiChuServiceI {
	@Autowired
	private LiangKuJiChuMapper liangKuJiChuMapper;
	@Override
	@SystemLog(module="粮库基础信息",methods="添加",description="添加成功")
	public void addLiangKuJiChu(LiangKuJiChuFormMap liangKuJiChuFormMap)
			throws Exception {
		liangKuJiChuMapper.addEntity(liangKuJiChuFormMap);
	}

	@Override
	@SystemLog(module="粮库基础信息",methods="修改",description="修改成功")
	@Transactional(readOnly =false)
	public void editLiangKuJiChu(LiangKuJiChuFormMap liangKuJiChuFormMap)
			throws Exception {
		LiangKuJiChuFormMap liangKuJiChuFormMap2 = liangKuJiChuMapper.findLiangKuJiChuById(Integer.parseInt(liangKuJiChuFormMap.getStr("id")));
		
		if(liangKuJiChuFormMap2.getInt(Constant.VERSION) == Integer.parseInt(liangKuJiChuFormMap.getStr(Constant.VERSION))){
			
			liangKuJiChuFormMap.set(Constant.VERSION, liangKuJiChuFormMap2.getInt(Constant.VERSION)+1);
			liangKuJiChuMapper.updateEntity(liangKuJiChuFormMap);
			
			liangKuJiChuFormMap2.remove("id");
			addOperatorLog(liangKuJiChuFormMap2,"update");
			
		}else{
			throw new Exception("[数据已被修改]");
		}
		
	}

	@Override
	@SystemLog(module="粮库基础信息",methods="删除",description="删除成功")
	@Transactional(readOnly =false)
	public void dropLiangKuJiChu(String id) throws Exception {
		LiangKuJiChuFormMap liangKuJiChuFormMap = liangKuJiChuMapper.findLiangKuJiChuById(Integer.parseInt(id));
		
		liangKuJiChuMapper.deleteEntityByKey("id", id, LiangKuJiChuFormMap.class);
		liangKuJiChuFormMap.remove("id");
		addOperatorLog(liangKuJiChuFormMap,"delete");
	}

	@Override
	public List<LiangKuJiChuFormMap> findByPage(
			LiangKuJiChuFormMap liangKuJiChuFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return liangKuJiChuMapper.findByPage(liangKuJiChuFormMap);
	}

	@Override
	public LiangKuJiChuFormMap findLiangKuJiChuById(int id) {
		return liangKuJiChuMapper.findLiangKuJiChuById(id);
	}
	private void addOperatorLog(LiangKuJiChuFormMap liangKuJiChuFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		liangKuJiChuFormMap.remove("wName");
		liangKuJiChuFormMap.set(Constant.ENTITY_TABLE, "t_warehouse_location_archives_his");
		liangKuJiChuFormMap.set("wlahSQL", sql);
		liangKuJiChuFormMap.set("wlahUser", session.getAttribute("userSessionId"));
		liangKuJiChuFormMap.set("wlahType", type);
		liangKuJiChuFormMap.set("wlahOpDate", new Timestamp(System.currentTimeMillis()));
		liangKuJiChuMapper.addEntity(liangKuJiChuFormMap);
	}
}
