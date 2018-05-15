package com.zyiot.server.impl.cangkuzhinenghuaxitong;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterConfigFormMap;
import com.zyiot.mapper.cangkuzhinenghuaxitong.AmmeterConfigMapper;
import com.zyiot.server.cangkuzhinenghuaxitong.AmmeterConfigServerI;

@Service("ammeterConfigServer")
public class AmmeterConfigServerImpl implements AmmeterConfigServerI {
	@Autowired
	AmmeterConfigMapper ammeterConfigMapper;

	public List<AmmeterConfigFormMap> findAmmeterConfigByPage(
			AmmeterConfigFormMap u, int pageSize, int pageNum) {
		if (pageSize >= 0 || pageNum >= 0)
			PageHelper.startPage(pageNum, pageSize);
		return ammeterConfigMapper.findAmmeterConfigByPage(u);
	}

	@SystemLog(module = "智能电表配置", methods = "新增", description = "成功")
	public void add(AmmeterConfigFormMap u) throws Exception {
		ammeterConfigMapper.addEntity(u);
	}

	@SystemLog(module = "智能电表配置", methods = "修改", description = "成功")
	public void edit(AmmeterConfigFormMap u) throws Exception {
		ammeterConfigMapper.updateEntity(u);
	}

	@SystemLog(module = "智能电表配置", methods = "删除", description = "成功")
	public void delete(String id) throws Exception {
		ammeterConfigMapper.deleteEntityByKey(id, id,
				AmmeterConfigFormMap.class);
	}

	@Override
	public List<AmmeterConfigFormMap> findCangKuDianWei(AmmeterConfigFormMap u) {
		return ammeterConfigMapper.findCangKuDianWei(u);
	}
}
