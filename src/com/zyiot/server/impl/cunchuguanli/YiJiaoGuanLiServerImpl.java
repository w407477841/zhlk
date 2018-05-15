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
import com.zyiot.entity.cunchuguanli.YiJiaoGuanLiFormMap;
import com.zyiot.entity.jichuziliao.CangFangXinXiFormMap;
import com.zyiot.mapper.cunchuguanli.YiJiaoGuanLiMapper;
import com.zyiot.mapper.jichuziliao.CangFangXinXiMapper;
import com.zyiot.server.cunchuguanli.YiJiaoGuanLiServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
@Service("yiJiaoGuanLiServer")
public class YiJiaoGuanLiServerImpl implements YiJiaoGuanLiServerI {
	@Autowired
	private YiJiaoGuanLiMapper yiJiaoGuanLiMapper;
	@Autowired
	public CangFangXinXiMapper cangFangXinXiMapper;
	@Override
	@SystemLog(module="移交管理",methods="添加",description="添加成功")
	@Transactional(readOnly=false)
	public void addYiJiaoGuanLi(YiJiaoGuanLiFormMap yiJiaoGuanLiFormMap)
			throws Exception {
		yiJiaoGuanLiMapper.addEntity(yiJiaoGuanLiFormMap);
		
		//修改仓库基础信息中的保管人
		CangFangXinXiFormMap cangFangXinXiFormMap = cangFangXinXiMapper.findBywId(Integer.parseInt(yiJiaoGuanLiFormMap.getStr("wtId")));
		CangFangXinXiFormMap cangFangXinXiFormMap2 = new CangFangXinXiFormMap();
		
		cangFangXinXiFormMap2.set("id", cangFangXinXiFormMap.getInt("id"));
		cangFangXinXiFormMap2.set("waStoreman", Integer.parseInt(yiJiaoGuanLiFormMap.getStr("wtNowStoreman")));
		FormMapUtil.toUPDATEFormMap(cangFangXinXiFormMap2);
		
		cangFangXinXiMapper.updateEntity(cangFangXinXiFormMap2);
	}

	

	@Override
	@SystemLog(module="移交管理",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropYiJiaoGuanLi(String id) throws Exception {
		YiJiaoGuanLiFormMap yiJiaoGuanLiFormMap = yiJiaoGuanLiMapper.findById(id, YiJiaoGuanLiFormMap.class);
		
		yiJiaoGuanLiMapper.deleteEntityByKey("id", id, YiJiaoGuanLiFormMap.class);
		
		yiJiaoGuanLiFormMap.remove("id");
		addOperatorLog(yiJiaoGuanLiFormMap, "delete");
	}

	@Override
	public List<YiJiaoGuanLiFormMap> findByPage(
			YiJiaoGuanLiFormMap yiJiaoGuanLiFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return yiJiaoGuanLiMapper.findByPage(yiJiaoGuanLiFormMap);
	}

	@Override
	public YiJiaoGuanLiFormMap findYiJiaoGuanLiById(int id) throws Exception {
		return yiJiaoGuanLiMapper.findYiJiaoGuanLiById(id);
	}
	private void addOperatorLog(YiJiaoGuanLiFormMap yiJiaoGuanLiFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		yiJiaoGuanLiFormMap.set(Constant.ENTITY_TABLE, "t_warehouse_transfer_his");
		yiJiaoGuanLiFormMap.set("wthSQL", sql);
		yiJiaoGuanLiFormMap.set("wthUser", session.getAttribute("userSessionId"));
		yiJiaoGuanLiFormMap.set("wthType", type);
		yiJiaoGuanLiFormMap.set("wthOpDate", new Timestamp(System.currentTimeMillis()));
		yiJiaoGuanLiMapper.addEntity(yiJiaoGuanLiFormMap);
	}
}
