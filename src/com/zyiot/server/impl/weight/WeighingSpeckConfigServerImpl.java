package com.zyiot.server.impl.weight;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.weight.WeighingSpeckConfigFormMap;
import com.zyiot.mapper.weight.WeighingSpeckConfigMapper;
import com.zyiot.server.weight.WeighingSpeckConfigServerI;

@Service("weighingSpeckConfigServer")
public class WeighingSpeckConfigServerImpl implements
		WeighingSpeckConfigServerI {
	@Autowired
	private WeighingSpeckConfigMapper weighingSpeckConfigMapper;
	@Override
	@SystemLog(module="语音配置",methods="添加",description="添加成功")
	public void addWeighingSpeckConfig(
			WeighingSpeckConfigFormMap weighingSpeckConfigFormMap)
			throws Exception {
		weighingSpeckConfigMapper.addEntity(weighingSpeckConfigFormMap);
	}

	@Override
	@SystemLog(module="语音配置",methods="修改",description="修改成功")
	public void editWeighingSpeckConfig(
			WeighingSpeckConfigFormMap weighingSpeckConfigFormMap)
			throws Exception {
		weighingSpeckConfigMapper.updateEntity(weighingSpeckConfigFormMap);
	}

	@Override
	@SystemLog(module="语音配置",methods="删除",description="删除成功")
	public void dropWeighingSpeckConfig(String id)
			throws Exception {
		weighingSpeckConfigMapper.deleteEntityByKey("id", id, WeighingSpeckConfigFormMap.class);
	}

	@Override
	public List<WeighingSpeckConfigFormMap> findByPage(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return weighingSpeckConfigMapper.findByPage();
	}

	@Override
	public WeighingSpeckConfigFormMap findWeighingSpeckConfigByMac(String mac) {
		return weighingSpeckConfigMapper.findByMAC(mac);
	}

}
