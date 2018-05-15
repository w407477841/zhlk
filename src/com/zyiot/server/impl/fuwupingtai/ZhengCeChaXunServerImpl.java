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
import com.zyiot.entity.fuwupingtai.ZhengCeChaXunFormMap;
import com.zyiot.mapper.fuwupingtai.ZhengCeChaXunMapper;
import com.zyiot.server.fuwupingtai.ZhengCeChaXunServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMap;
@Service("zhengCeChaXunServer")
public class ZhengCeChaXunServerImpl implements ZhengCeChaXunServerI {

	@Autowired
	private ZhengCeChaXunMapper zhengCeChaXunMapper;
	@Override
	@SystemLog(module="政策查询",methods="添加",description="添加成功")
	public void addZhengCeChaXun(ZhengCeChaXunFormMap zhengCeChaXunFormMap)
			throws Exception {
		zhengCeChaXunMapper.addEntity(zhengCeChaXunFormMap);
	}

	@Override
	@SystemLog(module="政策查询",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editZhengCeChaXun(ZhengCeChaXunFormMap zhengCeChaXunFormMap)
			throws Exception {
		ZhengCeChaXunFormMap zhengCeChaXunFormMap2 = zhengCeChaXunMapper.findZhengCeChaXunById(Integer.parseInt(zhengCeChaXunFormMap.getStr("id")));
		if(zhengCeChaXunFormMap2.getInt(Constant.VERSION) == Integer.parseInt(zhengCeChaXunFormMap.getStr(Constant.VERSION))){
			zhengCeChaXunFormMap.set(Constant.VERSION, zhengCeChaXunFormMap2.getInt(Constant.VERSION)+1);
			
			zhengCeChaXunMapper.updateEntity(zhengCeChaXunFormMap);
			
			addOperatorLog(zhengCeChaXunFormMap2, "update");
			
		}else{
			throw new Exception("[数据已被修改]");
		}

	}

	@Override
	@SystemLog(module="政策查询",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropZhengCeChaXun(String id) throws Exception {
		ZhengCeChaXunFormMap zhengCeChaXunFormMap = zhengCeChaXunMapper.findZhengCeChaXunById(Integer.parseInt(id));
		
		zhengCeChaXunMapper.deleteEntityByKey("id", id, ZhengCeChaXunFormMap.class);

		addOperatorLog(zhengCeChaXunFormMap, "delete");
	}

	@Override
	public List<ZhengCeChaXunFormMap> findByPage(
			ZhengCeChaXunFormMap zhengCeChaXunFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return zhengCeChaXunMapper.findByPage(zhengCeChaXunFormMap);
	}

	@Override
	public ZhengCeChaXunFormMap findZhengCeChaXunById(int id) throws Exception {
		return zhengCeChaXunMapper.findZhengCeChaXunById(id);
	}

	@Override
	public ZhengCeChaXunFormMap lookZhengCeChaXunById(int id) throws Exception {
		return zhengCeChaXunMapper.lookZhengCeChaXunById(id);
	}

	@Override
	public List<FormMap<String, Object>> findZhengCeType() {
		return zhengCeChaXunMapper.findZhengCeType();
	}
	private void addOperatorLog(ZhengCeChaXunFormMap zhengCeChaXunFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		zhengCeChaXunFormMap.set(Constant.ENTITY_TABLE, "t_policy_query_his");
		zhengCeChaXunFormMap.set("pqhSQL", sql);
		zhengCeChaXunFormMap.set("pqhUser", session.getAttribute("userSessionId"));
		zhengCeChaXunFormMap.set("pqhType", type);
		zhengCeChaXunFormMap.set("pqhOpDate", new Timestamp(System.currentTimeMillis()));
		zhengCeChaXunMapper.addEntity(zhengCeChaXunFormMap);
	}
}
