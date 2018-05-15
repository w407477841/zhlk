package com.zyiot.server.impl.weight;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.weight.WeighingVideoConfigFormMap;
import com.zyiot.mapper.weight.WeighingVideoConfigMapper;
import com.zyiot.server.weight.WeighingVideoConfigServerI;
import com.zyiot.util.Constant;

@Service("weighingVideoConfigServer")
public class WeighingVideoConfigServerImpl implements
		WeighingVideoConfigServerI {
	@Autowired
	private WeighingVideoConfigMapper weighingVideoConfigMapper;
	
	@Override
	@SystemLog(module="称重视频配置",methods="添加",description="添加成功")
	public void addWeighingVideoConfig(
			WeighingVideoConfigFormMap weighingVideoConfigFormMap)
			throws Exception {
		weighingVideoConfigMapper.addEntity(weighingVideoConfigFormMap);
	}

	@Override
	@Transactional(readOnly=false)
	@SystemLog(module="称重视频配置",methods="修改",description="修改成功")
	public void editWeighingVideoConfig(WeighingVideoConfigFormMap weighingVideoConfigFormMap)throws Exception {
		WeighingVideoConfigFormMap weighingVideoConfig = weighingVideoConfigMapper.findWeighingVideoConfigById(weighingVideoConfigFormMap.getInt("id"));
		
		weighingVideoConfigFormMap.set(Constant.VERSION, weighingVideoConfigFormMap.getInt(Constant.VERSION)+1);
		weighingVideoConfigMapper.updateEntity(weighingVideoConfigFormMap);
		
		addOperatorLog(weighingVideoConfig, "update");
	}
	
	@Override
	@Transactional(readOnly=false)
	@SystemLog(module="称重视频配置",methods="删除",description="删除成功")
	public void dropWeighingVideoConfig(String id) throws Exception {
		WeighingVideoConfigFormMap weighingVideoConfig = weighingVideoConfigMapper.findWeighingVideoConfigById(Integer.parseInt(id));
		
		weighingVideoConfigMapper.deleteEntityByKey("id", id, WeighingVideoConfigFormMap.class);
		
		addOperatorLog(weighingVideoConfig, "delete");
	}

	@Override
	public List<WeighingVideoConfigFormMap> findByPage(
			WeighingVideoConfigFormMap weighingVideoConfigFormMap, int pageNum,
			int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return weighingVideoConfigMapper.findByPage(weighingVideoConfigFormMap);
	}

	@Override
	public List<WeighingVideoConfigFormMap> findWeighingVideoConfigByMAC(String mac) {
		return weighingVideoConfigMapper.findWeighingVideoConfigByMAC(mac);
	}

	@Override
	public WeighingVideoConfigFormMap findWeighingVideoConfigById(int id) {
		return weighingVideoConfigMapper.findWeighingVideoConfigById(id);
	}
	
	private void addOperatorLog(WeighingVideoConfigFormMap weighingVideoConfigFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		weighingVideoConfigFormMap.set(Constant.ENTITY_TABLE, "t_weight_video_config_his");
		weighingVideoConfigFormMap.set("execSQL", sql);
		weighingVideoConfigFormMap.set("execUser", session.getAttribute("userSessionId"));
		weighingVideoConfigFormMap.set("execType", type);
		weighingVideoConfigFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		weighingVideoConfigMapper.addEntity(weighingVideoConfigFormMap);
	}


	
}
