package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.UserLoginLogFormMap;

public interface UserLoginLogServerI {
	public int addLoginLog(UserLoginLogFormMap userLoginLogFormMap)throws Exception;
	public List<UserLoginLogFormMap> findLoginLogByPage(UserLoginLogFormMap userLoginLogFormMap,int pageSize,int pageNum);
}
