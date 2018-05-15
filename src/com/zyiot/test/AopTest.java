package com.zyiot.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zyiot.entity.UserFormMap;
import com.zyiot.mapper.UserMapper;
import com.zyiot.server.UserServerI;
import com.zyiot.util.EhcacheUtils;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring-application.xml" })
public class AopTest {
	@Autowired
	UserServerI userServer;

	@Autowired
	UserMapper userMapper;

	@Test
	public void initConfig() {
		HashMap<String, Object> tm = new HashMap<String, Object>();
		tm.put("table_name", "'ly_user'");
		tm.put("database_name", "'wzglxt'");
		List<HashMap<String, Object>> lh = userMapper.initTableField(tm);
		for (HashMap<String, Object> hashMap : lh) {
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("field", hashMap.get("COLUMN_NAME"));
			System.out.println("field=" + hashMap.get("COLUMN_NAME"));
			String ble = hashMap.get("TABLE_NAME").toString();// 表名
			EhcacheUtils.put(ble, m);// 某表对应的主键和字段放到缓存
		}
	}

	@Test
	public void aoptest() {

		userServer.findUserByPage(new UserFormMap(), 2, 1);
	}

}
