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
import com.zyiot.entity.zijinguankong.ZiJinJieSuanFormMap;
import com.zyiot.mapper.zijinguankong.ZiJinJieSuanMapper;
import com.zyiot.server.zijinguankong.ZiJinJieSuanServiceI;
import com.zyiot.util.Constant;
@Service("ziJinJieSuanService")
public class ZiJinJieSuanServiceImpl implements ZiJinJieSuanServiceI {
	@Autowired
	private ZiJinJieSuanMapper ziJinJieSuanMapper;
	@Override
	@SystemLog(module="资金结算",methods="添加",description="添加成功")
	public void addZiJinJieSuan(ZiJinJieSuanFormMap ziJinJieSuanFormMap)
			throws Exception {
			ziJinJieSuanMapper.addEntity(ziJinJieSuanFormMap);
	}

	@Override
	@SystemLog(module="资金结算",methods="修改",description="修改成功")
	@Transactional(readOnly = false)
	public void editZiJinJieSuan(ZiJinJieSuanFormMap ziJinJieSuanFormMap)
			throws Exception {
		
        ZiJinJieSuanFormMap ziJinJieSuanFormMap2 =  ziJinJieSuanMapper.findZiJinJieSuanById(Integer.parseInt(ziJinJieSuanFormMap.getStr("id")));
		
		if(ziJinJieSuanFormMap2.getInt(Constant.VERSION) == Integer.parseInt(ziJinJieSuanFormMap.getStr(Constant.VERSION))){
			ziJinJieSuanFormMap.set(Constant.VERSION, ziJinJieSuanFormMap2.getInt(Constant.VERSION)+1);
			ziJinJieSuanMapper.updateEntity(ziJinJieSuanFormMap);
			
			addOperatorLog(ziJinJieSuanFormMap2,"update");
		}else{
			throw new Exception("[数据已被更新]");
		}	
		
	}

	@Override
	@SystemLog(module="资金结算",methods="删除",description="删除成功")
	@Transactional
	public void dropZiJinJieSuan(String id) throws Exception {
		 ZiJinJieSuanFormMap ziJinJieSuanFormMap =  ziJinJieSuanMapper.findZiJinJieSuanById(Integer.parseInt(id));
			
		ziJinJieSuanMapper.deleteEntityByKey("id", id, ZiJinJieSuanFormMap.class);
		
		addOperatorLog(ziJinJieSuanFormMap,"delete");
	}

	@Override
	public List<ZiJinJieSuanFormMap> findByPage(
			ZiJinJieSuanFormMap ziJinJieSuanFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return ziJinJieSuanMapper.findByPage(ziJinJieSuanFormMap);
	}

	@Override
	public ZiJinJieSuanFormMap findZiJinJieSuanById(int id) {
		return ziJinJieSuanMapper.findZiJinJieSuanById(id);
	}
	private void addOperatorLog(ZiJinJieSuanFormMap ziJinJieSuanFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		ziJinJieSuanFormMap.set(Constant.ENTITY_TABLE, "t_bankroll_balance_his");
		ziJinJieSuanFormMap.set("bbhSQL", sql);
		ziJinJieSuanFormMap.set("bbhUser", session.getAttribute("userSessionId"));
		ziJinJieSuanFormMap.set("bbhType", type);
		ziJinJieSuanFormMap.set("bbhOpDate", new Timestamp(System.currentTimeMillis()));
	    ziJinJieSuanMapper.addEntity(ziJinJieSuanFormMap);
	}
}
