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
import com.zyiot.entity.jichuziliao.CangFangXinXiFormMap;
import com.zyiot.mapper.jichuziliao.CangFangXinXiMapper;
import com.zyiot.server.jichuziliao.CangFangXinXiServiceI;
import com.zyiot.util.Constant;
@Service("cangFangXinXiService")
public class CangFangXinXiServiceImpl implements CangFangXinXiServiceI {
	@Autowired
	private CangFangXinXiMapper cangFangXinXiMapper;
	@Override
	@SystemLog(module="仓房信息",methods="添加",description="添加成功")
	public void addCangFangXinXi(CangFangXinXiFormMap cangFangXinXiFormMap)
			throws Exception {
		cangFangXinXiMapper.addEntity(cangFangXinXiFormMap);
	}

	@Override
	@SystemLog(module="仓房信息",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editCangFangXinXi(CangFangXinXiFormMap cangFangXinXiFormMap)
			throws Exception {
		CangFangXinXiFormMap cangFangXinXiFormMap2 = cangFangXinXiMapper.findCangFangXinXiById(Integer.parseInt(cangFangXinXiFormMap.getStr("id")));
		if(cangFangXinXiFormMap2.getInt(Constant.VERSION) == Integer.parseInt(cangFangXinXiFormMap.getStr(Constant.VERSION))){
			cangFangXinXiFormMap.set(Constant.VERSION, cangFangXinXiFormMap2.getInt(Constant.VERSION)+1);
			
			cangFangXinXiMapper.updateEntity(cangFangXinXiFormMap);
			
			cangFangXinXiFormMap2.remove("id");
			cangFangXinXiFormMap2.remove("wLocationId");
			addOperatorLog(cangFangXinXiFormMap2,"update");
		}else{
			throw new Exception("[信息已被修改]");
		}
		
		
		
	}

	@Override
	@SystemLog(module="仓房信息",methods="删除",description="删除成功")
	@Transactional
	public void dropCangFangXinXi(String id) throws Exception {
		CangFangXinXiFormMap cangFangXinXiFormMap = cangFangXinXiMapper.findCangFangXinXiById(Integer.parseInt(id));
		
		cangFangXinXiMapper.deleteEntityByKey("id", id, CangFangXinXiFormMap.class);
		
		cangFangXinXiFormMap.remove("id");
		addOperatorLog(cangFangXinXiFormMap,"delete");
	}

	@Override
	public List<CangFangXinXiFormMap> findByPage(
			CangFangXinXiFormMap cangFangXinXiFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return cangFangXinXiMapper.findByPage(cangFangXinXiFormMap);
	}

	@Override
	public CangFangXinXiFormMap findCangFangXinXiById(int id) {
		return cangFangXinXiMapper.findCangFangXinXiById(id);
	}
	
	@Override
	public CangFangXinXiFormMap findStoremanBywId(int id) throws Exception{
		return cangFangXinXiMapper.findStroremanById(id);
	}
	private void addOperatorLog(CangFangXinXiFormMap cangFangXinXiFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		cangFangXinXiFormMap.remove("wLocationId");
		cangFangXinXiFormMap.set(Constant.ENTITY_TABLE, "t_warehouse_archives_his");
		cangFangXinXiFormMap.set("wahSQL", sql);
		cangFangXinXiFormMap.set("wahUser", session.getAttribute("userSessionId"));
		cangFangXinXiFormMap.set("wahType", type);
		cangFangXinXiFormMap.set("wahOpDate", new Timestamp(System.currentTimeMillis()));
	    cangFangXinXiMapper.addEntity(cangFangXinXiFormMap);
	}

}
