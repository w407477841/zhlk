package com.zyiot.server.impl.cunchuguanli;

import org.springframework.stereotype.Service;

import com.zyiot.entity.cunchuguanli.InStorageFormMap;
import com.zyiot.mapper.cunchuguanli.InStorageMapper;
import com.zyiot.server.cunchuguanli.InStorageServerI;
import com.zyiot.server.impl.BaseServerImpl;

@Service("inStorageServer")
public class InStorageServerImpl extends
		BaseServerImpl<InStorageFormMap, InStorageMapper> implements
		InStorageServerI {

}
