package com.zyiot.server.impl.fuwupingtai;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.fuwupingtai.XinXiFaBuFormMap;
import com.zyiot.mapper.fuwupingtai.XinXiFaBuMapper;
import com.zyiot.server.fuwupingtai.XinXiFaBuServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMap;
@Service("xinXiFaBuServer")
public class XinXiFaBuServerImpl implements XinXiFaBuServerI {

	@Autowired
	private XinXiFaBuMapper xinXiFaBuMapper;
	@Override
	@SystemLog(module="信息发布",methods="添加",description="添加成功")
	public void addXinXiFaBu(XinXiFaBuFormMap xinXiFaBuFormMap)
			throws Exception {
		xinXiFaBuMapper.addEntity(xinXiFaBuFormMap);
	}

	@Override
	@SystemLog(module="信息发布",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editXinXiFaBu(XinXiFaBuFormMap xinXiFaBuFormMap)
			throws Exception {
		XinXiFaBuFormMap xinXiFaBuFormMap2 = xinXiFaBuMapper.findXinXiFaBuById(Integer.parseInt(xinXiFaBuFormMap.getStr("id")));
		if(xinXiFaBuFormMap2.getInt(Constant.VERSION) == Integer.parseInt(xinXiFaBuFormMap.getStr(Constant.VERSION))){
			xinXiFaBuFormMap.set(Constant.VERSION, xinXiFaBuFormMap2.getInt(Constant.VERSION)+1);
			
			xinXiFaBuMapper.updateEntity(xinXiFaBuFormMap);
			
			addOperatorLog(xinXiFaBuFormMap2, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}

	}

	@Override
	@SystemLog(module="信息发布",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropXinXiFaBu(String id) throws Exception {
		XinXiFaBuFormMap xinXiFaBuFormMap = xinXiFaBuMapper.findXinXiFaBuById(Integer.parseInt(id));
		
		xinXiFaBuMapper.deleteEntityByKey("id", id, XinXiFaBuFormMap.class);
		
		addOperatorLog(xinXiFaBuFormMap, "delete");
	}

	@Override
	public List<XinXiFaBuFormMap> findByPage(XinXiFaBuFormMap xinXiFaBuFormMap,
			int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return xinXiFaBuMapper.findByPage(xinXiFaBuFormMap);
	}

	@Override
	public XinXiFaBuFormMap findXinXiFaBuById(int id) throws Exception {
		return xinXiFaBuMapper.findXinXiFaBuById(id);
	}
	
	@Override
	public XinXiFaBuFormMap lookXinXiFaBuById(int id) throws Exception {
		return xinXiFaBuMapper.lookXinXiFaBuById(id);
	}

	@Override
	public List<FormMap<String, Object>> findXinXiType() {
		return xinXiFaBuMapper.findXinXiType();
	}
	
	private void addOperatorLog(XinXiFaBuFormMap xinXiFaBuFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		xinXiFaBuFormMap.set(Constant.ENTITY_TABLE, "t_info_release_his");
		xinXiFaBuFormMap.set("irhSQL", sql);
		xinXiFaBuFormMap.set("irhUser", session.getAttribute("userSessionId"));
		xinXiFaBuFormMap.set("irhType", type);
		xinXiFaBuFormMap.set("irhOpDate", new Timestamp(System.currentTimeMillis()));
		xinXiFaBuMapper.addEntity(xinXiFaBuFormMap);
	}
	
}
