package com.zyiot.server.impl.zijinguankong;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.zijinguankong.ZiJinJiHuaFormMap;
import com.zyiot.mapper.zijinguankong.ZiJinJiHuaMapper;
import com.zyiot.server.zijinguankong.ZiJinJiHuaServiceI;
import com.zyiot.util.Constant;
@Service("ziJinJiHuaService")
public class ZiJinJiHuaServiceImpl implements ZiJinJiHuaServiceI {
	@Autowired
	private ZiJinJiHuaMapper ziJinJiHuaMapper;
	@Override
	@SystemLog(module="资金计划",methods="添加",description="添加成功")
	public void addZiJinJiHua(ZiJinJiHuaFormMap ziJinJiHuaFormMap)
			throws Exception {
		ziJinJiHuaMapper.addEntity(ziJinJiHuaFormMap);
	}

	@Override
	@SystemLog(module="资金计划",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editZiJinJiHua(ZiJinJiHuaFormMap ziJinJiHuaFormMap)
			throws Exception {
		ZiJinJiHuaFormMap ziJinJiHuaFormMap2 = ziJinJiHuaMapper.findZiJinJiHuaById(Integer.parseInt(ziJinJiHuaFormMap.getStr("id")));
		
		if(ziJinJiHuaFormMap2.getInt(Constant.VERSION) == Integer.parseInt(ziJinJiHuaFormMap.getStr(Constant.VERSION))){
			ziJinJiHuaFormMap.set(Constant.VERSION, ziJinJiHuaFormMap2.getInt(Constant.VERSION)+1);
			
			ziJinJiHuaMapper.updateEntity(ziJinJiHuaFormMap);
			ziJinJiHuaFormMap2.remove("id");
			addOperatorLog(ziJinJiHuaFormMap2,"update");
		}else{
			throw new Exception("[数据已被修改]");
		}
		
	}

	@Override
	@SystemLog(module="资金计划",methods="删除",description="删除成功")
	@Transactional
	public void dropZiJinJiHua(String id) throws Exception {
		ZiJinJiHuaFormMap ziJinJiHuaFormMap = ziJinJiHuaMapper.findZiJinJiHuaById(Integer.parseInt(id));
		
		ziJinJiHuaMapper.deleteEntityByKey("id", id, ZiJinJiHuaFormMap.class);
		
		addOperatorLog(ziJinJiHuaFormMap,"delete");
	}

	@Override
	public List<ZiJinJiHuaFormMap> findByPage(ZiJinJiHuaFormMap ziJinJiHuaFormMap,
			int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return ziJinJiHuaMapper.findByPage(ziJinJiHuaFormMap);
	}

	@Override
	public ZiJinJiHuaFormMap findZiJinJiHuaById(int id) {
		return ziJinJiHuaMapper.findZiJinJiHuaById(id);
	}
	private void addOperatorLog(ZiJinJiHuaFormMap ziJinJiHuaFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		ziJinJiHuaFormMap.set(Constant.ENTITY_TABLE, "t_bankroll_plan_his");
		ziJinJiHuaFormMap.set("bphSQL", sql);
		ziJinJiHuaFormMap.set("bphUser", session.getAttribute("userSessionId"));
		ziJinJiHuaFormMap.set("bphType", type);
		ziJinJiHuaFormMap.set("bphOpDate", new Timestamp(System.currentTimeMillis()));
	    ziJinJiHuaMapper.addEntity(ziJinJiHuaFormMap);
	}

	@Override
	public List<ZiJinJiHuaFormMap> findAllZiJinJiHua() {
		return ziJinJiHuaMapper.findByAttr(new ZiJinJiHuaFormMap());
	}
}
