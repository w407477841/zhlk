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
import com.zyiot.entity.cunchuguanli.RuKuFangAnFormMap;
import com.zyiot.mapper.cunchuguanli.RuKuFangAnMapper;
import com.zyiot.server.cunchuguanli.RuKuFangAnServerI;
import com.zyiot.util.Constant;
@Service("ruKuFangAnServer")
public class RuKuFangAnServerImpl implements RuKuFangAnServerI {

	@Autowired
	private RuKuFangAnMapper ruKuFangAnMapper;
	@Override
	@SystemLog(module="入库方案",methods="添加",description="添加成功")
	public void addRuKuFangAn(RuKuFangAnFormMap ruKuFangAnFormMap)
			throws Exception {
		ruKuFangAnMapper.addEntity(ruKuFangAnFormMap);
	}

	@Override
	@SystemLog(module="入库方案",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editRuKuFangAn(RuKuFangAnFormMap ruKuFangAnFormMap)
			throws Exception {
		RuKuFangAnFormMap ruKuFangAnFormMap2 = ruKuFangAnMapper.findRuKuFangAnById(Integer.parseInt(ruKuFangAnFormMap.getStr("id")));
		
		if(ruKuFangAnFormMap2.getInt(Constant.VERSION) == Integer.parseInt(ruKuFangAnFormMap.getStr(Constant.VERSION))){
			ruKuFangAnFormMap.set(Constant.VERSION, ruKuFangAnFormMap2.getInt(Constant.VERSION)+1);
			ruKuFangAnMapper.updateEntity(ruKuFangAnFormMap);
			addOperatorLog(ruKuFangAnFormMap2, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
	}

	@Override
	@SystemLog(module="入库方案",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropRuKuFangAn(String id) throws Exception {
		RuKuFangAnFormMap ruKuFangAnFormMap = ruKuFangAnMapper.findRuKuFangAnById(Integer.parseInt(id));
		
		ruKuFangAnMapper.deleteEntityByKey("id", id, RuKuFangAnFormMap.class);
		
		addOperatorLog(ruKuFangAnFormMap, "delete");
	}

	@Override
	public List<RuKuFangAnFormMap> findByPage(
			RuKuFangAnFormMap ruKuFangAnFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return ruKuFangAnMapper.findByPage(ruKuFangAnFormMap);
	}

	@Override
	public RuKuFangAnFormMap findRuKuFangAnById(int id) throws Exception {
		return ruKuFangAnMapper.findRuKuFangAnById(id);
	}
	
	@Override
	public RuKuFangAnFormMap lookRuKuFangAnById(int id) throws Exception {
		return ruKuFangAnMapper.lookRuKuFangAnById(id);
	}

	private void addOperatorLog(RuKuFangAnFormMap ruKuFangAnFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		ruKuFangAnFormMap.remove("category");
		ruKuFangAnFormMap.remove("wlName");
		ruKuFangAnFormMap.remove("wName");
		ruKuFangAnFormMap.remove("variety");
		ruKuFangAnFormMap.set(Constant.ENTITY_TABLE, "t_putin_storage_plan_his");
		ruKuFangAnFormMap.set("psphSQL", sql);
		ruKuFangAnFormMap.set("psphUser", session.getAttribute("userSessionId"));
		ruKuFangAnFormMap.set("psphType", type);
		ruKuFangAnFormMap.set("psphOpDate", new Timestamp(System.currentTimeMillis()));
		ruKuFangAnMapper.addEntity(ruKuFangAnFormMap);
	}

	
}
