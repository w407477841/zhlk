package com.zyiot.shiro.filter;

import javax.inject.Inject;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.springframework.beans.factory.annotation.Autowired;

import com.zyiot.entity.UserFormMap;
import com.zyiot.mapper.UserMapper;



public class SysUserFilter extends PathMatchingFilter {

	@Autowired
	private UserMapper userMapper;

    @Override
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {

        String username = (String)SecurityUtils.getSubject().getPrincipal();
        UserFormMap userFormMap = new UserFormMap();
		userFormMap.put("accountName", "" + username + "");
        request.setAttribute("user", userMapper.findByAttr(userFormMap));
        System.out.println("类SysUserFilter第26行");
        return true;
        
    }
}