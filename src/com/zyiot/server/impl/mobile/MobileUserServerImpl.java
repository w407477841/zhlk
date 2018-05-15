package com.zyiot.server.impl.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.entity.UserFormMap;
import com.zyiot.mapper.mobile.MobileUserMapper;
import com.zyiot.server.mobile.MobileUserServerI;
@Service
public class MobileUserServerImpl implements MobileUserServerI {
    @Autowired
	private MobileUserMapper mobileUserMapper;
	@Override
	public List<UserFormMap> findByPage(UserFormMap userFormMap,int pageSize,int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return mobileUserMapper.findByPage(userFormMap);
	}

	@Override
	public void addOrEditUserRole(UserFormMap userFormMap)throws Exception {
		UserFormMap u = mobileUserMapper.findByUserId(userFormMap.getStr("userId"));
		if(u == null){
			mobileUserMapper.addUserRole(userFormMap);
		}else{
			mobileUserMapper.editUserRole(userFormMap);
		}
	}

}
