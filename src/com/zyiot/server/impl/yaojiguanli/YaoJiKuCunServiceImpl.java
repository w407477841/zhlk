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
import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.mapper.yaojiguanli.YaoJiKuCunMapper;
import com.zyiot.server.yaojiguanli.YaoJiKuCunServiceI;
import com.zyiot.util.Constant;
@Service("yaoJiKuCunService")
public class YaoJiKuCunServiceImpl implements YaoJiKuCunServiceI {

	@Autowired
	private YaoJiKuCunMapper yaoJiKuCunMapper;
	@Override
	@SystemLog(module="药剂库存",methods="添加",description="增加成功")
	public void addYaoJiKuCun(YaoJiKuCunFormMap yaoJiKuCunFormMap)
			throws Exception {
		yaoJiKuCunMapper.addEntity(yaoJiKuCunFormMap);
	}

	@Override
	@SystemLog(module="药剂库存",methods="修改",description="修改成功")
	@Transactional(readOnly = false)
	public void editYaoJiKuCun(YaoJiKuCunFormMap yaoJiKuCunFormMap) throws Exception {
		YaoJiKuCunFormMap yaoJiKuCunFormMap2 = yaoJiKuCunMapper.findYaoJiKuCunById(Integer.parseInt(yaoJiKuCunFormMap.getStr("id")));
		if(Integer.parseInt(yaoJiKuCunFormMap.getStr(Constant.VERSION)) == yaoJiKuCunFormMap2.getInt(Constant.VERSION)){
			yaoJiKuCunFormMap.set(Constant.VERSION, yaoJiKuCunFormMap2.getInt(Constant.VERSION)+1);
			
			yaoJiKuCunMapper.updateEntity(yaoJiKuCunFormMap);
			addOperatorLog(yaoJiKuCunFormMap2,"update");
		}else{
			throw new Exception("[已被修改]");
		}
	}

	@Override
	@Transactional(readOnly=false)
	@SystemLog(module="药剂库存",methods="删除",description="删除成功")
	public void deleteYaoJiKuCunById(String id)
			throws Exception {
		YaoJiKuCunFormMap yaoJiKuCunFormMap = yaoJiKuCunMapper.findYaoJiKuCunById(Integer.parseInt(id));
		yaoJiKuCunMapper.deleteEntityByKey("id",id,YaoJiKuCunFormMap.class);
		
     	addOperatorLog(yaoJiKuCunFormMap,"delete");
	}

	@Override
	public List<YaoJiKuCunFormMap> findByPage(
			YaoJiKuCunFormMap yaoJiKuCunFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return yaoJiKuCunMapper.findByPage(yaoJiKuCunFormMap);
	}

	@Override
	public List<YaoJiKuCunFormMap> findByAttr(
			YaoJiKuCunFormMap yaoJiKuCunFormMap) {
		return yaoJiKuCunMapper.findByAttr(yaoJiKuCunFormMap);
	}

	@Override
	public YaoJiKuCunFormMap findById(int id) throws Exception {
		return yaoJiKuCunMapper.findYaoJiKuCunById(id);
	}

	@Override
	@SystemLog(module="药剂库存",methods="续增",description="续增成功")
	@Transactional(readOnly=false)
	public void increaseYaoJiKuCun(YaoJiKuCunFormMap yaoJiKuCunFormMap)
			throws Exception {
		YaoJiKuCunFormMap yaoJiKuCunFormMap2 = yaoJiKuCunMapper.findYaoJiKuCunById(Integer.parseInt(yaoJiKuCunFormMap.getStr("id")));
		if(Integer.parseInt(yaoJiKuCunFormMap.getStr(Constant.VERSION)) == yaoJiKuCunFormMap2.getInt(Constant.VERSION)){
			yaoJiKuCunFormMap.set(Constant.VERSION, yaoJiKuCunFormMap2.getInt(Constant.VERSION)+1);
			yaoJiKuCunFormMap.set("mrNumber", yaoJiKuCunFormMap2.getInt("mrNumber")+Integer.parseInt(yaoJiKuCunFormMap.getStr("mrNumber")));
			
			yaoJiKuCunMapper.updateEntity(yaoJiKuCunFormMap);
			addOperatorLog(yaoJiKuCunFormMap2,"increase");
			
		}else{
			throw new Exception("[已被修改]");
		}
	}
	
	private void addOperatorLog(YaoJiKuCunFormMap yaoJiKuCunFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		yaoJiKuCunFormMap.set(Constant.ENTITY_TABLE, "t_medicament_repository_his");
		yaoJiKuCunFormMap.set("mrhSQL", sql);
		yaoJiKuCunFormMap.set("mrhUser", session.getAttribute("userSessionId"));
		yaoJiKuCunFormMap.set("mrhType", type);
		yaoJiKuCunFormMap.set("mrhOpDate", new Timestamp(System.currentTimeMillis()));
	    yaoJiKuCunMapper.addEntity(yaoJiKuCunFormMap);
	}

	@Override
	public List<YaoJiKuCunFormMap> findAll() {
		return yaoJiKuCunMapper.findAll();
	}

	@Override
	public YaoJiKuCunFormMap lookById(int id) throws Exception {
		return yaoJiKuCunMapper.lookYaoJiKuCunById(id);
	}
}
