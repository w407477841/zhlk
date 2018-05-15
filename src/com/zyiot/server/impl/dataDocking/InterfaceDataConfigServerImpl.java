package com.zyiot.server.impl.dataDocking;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyiot.entity.dataDocking.InterfaceDataConfigFormMap;
import com.zyiot.mapper.dataDocking.InterfaceDataConfigMapper;
import com.zyiot.server.dataDocking.InterfaceDataConfigServerI;
@Service("interfaceDataConfigServer")
public class InterfaceDataConfigServerImpl implements
		InterfaceDataConfigServerI {
	@Autowired
	private InterfaceDataConfigMapper interfaceDataConfigMapper;
	@Override
	public InterfaceDataConfigFormMap findByTableName(String tableName) {
		return interfaceDataConfigMapper.findInterfaceDataConfigByTableName(tableName);
	}
	@Override
	public void addInterfaceDataConfig(
			InterfaceDataConfigFormMap interfaceDataConfigFormMap)
			throws Exception {
		interfaceDataConfigMapper.addEntity(interfaceDataConfigFormMap);
	}
	@Override
	public void editInterfaceDataConfig(
			InterfaceDataConfigFormMap interfaceDataConfigFormMap)
			throws Exception {
		interfaceDataConfigMapper.updateEntity(interfaceDataConfigFormMap);
	}

}
