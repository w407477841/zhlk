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
import com.zyiot.entity.cunchuguanli.ChuKuFangAnFormMap;
import com.zyiot.mapper.cunchuguanli.ChuKuFangAnMapper;
import com.zyiot.server.cunchuguanli.ChuKuFangAnServerI;
import com.zyiot.util.Constant;
@Service("chuKuFangAnServer")
public class ChuKuFangAnServerImpl implements ChuKuFangAnServerI {

	@Autowired
	private ChuKuFangAnMapper chuKuFangAnMapper;
	@Override
	@SystemLog(module="出库方案",methods="添加",description="添加成功")
	public void addChuKuFangAn(ChuKuFangAnFormMap chuKuFangAnFormMap)
			throws Exception {
		chuKuFangAnMapper.addEntity(chuKuFangAnFormMap);
	}

	@Override
	@SystemLog(module="出库方案",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editChuKuFangAn(ChuKuFangAnFormMap chuKuFangAnFormMap)
			throws Exception {
          ChuKuFangAnFormMap chuKuFangAnFormMap2 = chuKuFangAnMapper.findChuKuFangAnById(Integer.parseInt(chuKuFangAnFormMap.getStr("id")));
		
		if(chuKuFangAnFormMap2.getInt(Constant.VERSION) == Integer.parseInt(chuKuFangAnFormMap.getStr(Constant.VERSION))){
			chuKuFangAnFormMap.set(Constant.VERSION, chuKuFangAnFormMap2.getInt(Constant.VERSION)+1);
			chuKuFangAnMapper.updateEntity(chuKuFangAnFormMap);
			
			addOperatorLog(chuKuFangAnFormMap2, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
	}

	@Override
	@SystemLog(module="出库方案",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropChuKuFangAn(String id) throws Exception {
		ChuKuFangAnFormMap chuKuFangAnFormMap = chuKuFangAnMapper.findChuKuFangAnById(Integer.parseInt(id));
		
		chuKuFangAnMapper.deleteEntityByKey("id", id, ChuKuFangAnFormMap.class);
		
		addOperatorLog(chuKuFangAnFormMap, "delete");
	}

	@Override
	public List<ChuKuFangAnFormMap> findByPage(
			ChuKuFangAnFormMap chuKuFangAnFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return chuKuFangAnMapper.findByPage(chuKuFangAnFormMap);
	}

	@Override
	public ChuKuFangAnFormMap findChuKuFangAnById(int id) throws Exception {
		return chuKuFangAnMapper.findChuKuFangAnById(id);
	}

	@Override
	public ChuKuFangAnFormMap lookChuKuFangAnById(int id) throws Exception {
		return chuKuFangAnMapper.lookChuKuFangAnById(id);
	}
	private void addOperatorLog(ChuKuFangAnFormMap chuKuFangAnFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		chuKuFangAnFormMap.remove("wlName");
		chuKuFangAnFormMap.remove("wName");
		chuKuFangAnFormMap.remove("category");
		chuKuFangAnFormMap.remove("variety");
		chuKuFangAnFormMap.set(Constant.ENTITY_TABLE, "t_getout_storage_plan_his");
		chuKuFangAnFormMap.set("gsphSQL", sql);
		chuKuFangAnFormMap.set("gsphUser", session.getAttribute("userSessionId"));
		chuKuFangAnFormMap.set("gsphType", type);
		chuKuFangAnFormMap.set("gsphOpDate", new Timestamp(System.currentTimeMillis()));
		chuKuFangAnMapper.addEntity(chuKuFangAnFormMap);
	}

}
