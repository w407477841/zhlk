package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.entity.UserLoginLogFormMap;
import com.zyiot.mapper.UserLoginLogMapper;
import com.zyiot.server.UserLoginLogServerI;

@Service("userLoginLogServer")
/**
 *处理登录日志逻辑
 */
public class UserLoginLogServerImpl implements UserLoginLogServerI {
	@Autowired
	UserLoginLogMapper userLoginLogMapper;
	public UserLoginLogMapper getUserLoginLogMapper() {
		return userLoginLogMapper;
	}
	public void setUserLoginLogMapper(UserLoginLogMapper userLoginLogMapper) {
		this.userLoginLogMapper = userLoginLogMapper;
	}
	@Transactional(readOnly=false)
	public int addLoginLog(UserLoginLogFormMap userLoginLogFormMap)
			throws Exception {
		return userLoginLogMapper.addEntity(userLoginLogFormMap);
	}
	@Override
	public List<UserLoginLogFormMap> findLoginLogByPage(
			UserLoginLogFormMap userLoginLogFormMap, int pageSize, int pageNum) {
		if( pageSize>=0 && pageNum>=0){
			PageHelper.startPage(pageNum, pageSize);
		}
		
		return userLoginLogMapper.findLoginLogByPage(userLoginLogFormMap);
	}

}
