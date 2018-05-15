package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.UserLoginLogFormMap;

public interface UserLoginLogMapper extends BaseMapper {
	List<UserLoginLogFormMap> findLoginLogByPage(UserLoginLogFormMap userLoginLogFormMap);
}
