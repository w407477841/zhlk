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
import com.zyiot.entity.fuwupingtai.YuYueJiaoLiangFormMap;
import com.zyiot.mapper.fuwupingtai.YuYueJiaoLiangMapper;
import com.zyiot.server.fuwupingtai.YuYueJiaoLiangServerI;
import com.zyiot.util.Constant;
@Service("yuYueJiaoLiangServer")
public class YuYueJiaoLiangServerImpl implements YuYueJiaoLiangServerI {
	@Autowired
	private YuYueJiaoLiangMapper yuYueJiaoLiangMapper;
	@Override
	@SystemLog(module="预约缴粮",methods="添加",description="添加成功")
	public void addYuYueJiaoLiang(YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap)
			throws Exception {
		yuYueJiaoLiangMapper.addEntity(yuYueJiaoLiangFormMap);
	}

	@Override
	@SystemLog(module="预约缴粮",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editYuYueJiaoLiang(YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap)
			throws Exception {
		YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap2 = yuYueJiaoLiangMapper.findYuYueJiaoLiangById(Integer.parseInt(yuYueJiaoLiangFormMap.getStr("id")));
		
		if(yuYueJiaoLiangFormMap2.getInt(Constant.VERSION) == Integer.parseInt(yuYueJiaoLiangFormMap.getStr(Constant.VERSION))){
			yuYueJiaoLiangFormMap.set(Constant.VERSION, yuYueJiaoLiangFormMap2.getInt(Constant.VERSION)+1);
			
			yuYueJiaoLiangMapper.updateEntity(yuYueJiaoLiangFormMap);
			
			addOperatorLog(yuYueJiaoLiangFormMap2, "update");
		}else{
			throw new Exception("[数据已更改]");
		}
	}

	@Override
	@SystemLog(module="预约缴粮",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropYuYueJiaoLiang(String id) throws Exception {
		YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap = yuYueJiaoLiangMapper.findYuYueJiaoLiangById(Integer.parseInt(id));
		
		yuYueJiaoLiangMapper.deleteEntityByKey("id", id, YuYueJiaoLiangFormMap.class);
		
		addOperatorLog(yuYueJiaoLiangFormMap, "delete");
	}

	@Override
	public List<YuYueJiaoLiangFormMap> findByPage(
			YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap, int pageNum,
			int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return yuYueJiaoLiangMapper.findByPage(yuYueJiaoLiangFormMap);
	}

	@Override
	public YuYueJiaoLiangFormMap findYuYueJiaoLiangById(int id)
			throws Exception {
		return yuYueJiaoLiangMapper.findYuYueJiaoLiangById(id);
	}
	
	private void addOperatorLog(YuYueJiaoLiangFormMap yuYueJiaoLiangFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		yuYueJiaoLiangFormMap.set(Constant.ENTITY_TABLE, "t_appointment_grain_his");
		yuYueJiaoLiangFormMap.set("aghSQL", sql);
		yuYueJiaoLiangFormMap.set("aghUser", session.getAttribute("userSessionId"));
		yuYueJiaoLiangFormMap.set("aghType", type);
		yuYueJiaoLiangFormMap.set("aghOpDate", new Timestamp(System.currentTimeMillis()));
		yuYueJiaoLiangMapper.addEntity(yuYueJiaoLiangFormMap);
	}
}
