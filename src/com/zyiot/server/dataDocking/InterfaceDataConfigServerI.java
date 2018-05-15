package com.zyiot.server.dataDocking;

import com.zyiot.entity.dataDocking.InterfaceDataConfigFormMap;

public interface InterfaceDataConfigServerI {
	public InterfaceDataConfigFormMap findByTableName(String tableName);
	
	public void addInterfaceDataConfig(InterfaceDataConfigFormMap interfaceDataConfigFormMap) throws Exception;
	
	public void editInterfaceDataConfig(InterfaceDataConfigFormMap interfaceDataConfigFormMap) throws Exception;
}
