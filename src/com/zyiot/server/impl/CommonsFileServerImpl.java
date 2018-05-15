package com.zyiot.server.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyiot.entity.CommonsFileFormMap;
import com.zyiot.mapper.BusinessManagerMapper;
import com.zyiot.server.CommonsFileServerI;
@Service("fileManager")
public class CommonsFileServerImpl implements CommonsFileServerI{
	@Autowired
	private BusinessManagerMapper fmapper;
	@Override
	public int saveFileMsg(CommonsFileFormMap m) {
		try {
			return fmapper.addEntity(m);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	@Override
	public CommonsFileFormMap queryFile(String id) {
		return fmapper.findBysid(id);
	}

}
