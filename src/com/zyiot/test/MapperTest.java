package com.zyiot.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyiot.entity.UserFormMap;
import com.zyiot.mapper.BaseMapper;
import com.zyiot.mapper.UserMapper;
import com.zyiot.server.UserServerI;
import com.zyiot.server.impl.UserServerImpl;
import com.zyiot.util.ConfigUtils;
import com.zyiot.util.EhcacheUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.MapUtil;
import com.zyiot.util.PropertiesUtils;


@RunWith(SpringJUnit4ClassRunner.class)      

@ContextConfiguration({"classpath:spring-application.xml"})  
public class MapperTest {
	
	@Autowired
	UserServerI userServer;
	
	
	@Autowired 
	UserMapper userMapper;
	@Test
   public void initConfig(){
		HashMap<String, Object> tm = new HashMap<String, Object>();
		tm.put("table_name", "'ly_user'");
		tm.put("database_name","'wzglxt'");
		 List<HashMap<String, Object>> lh = userMapper.initTableField(tm);
		 for (HashMap<String, Object> hashMap : lh) {
			 Map<String, Object> m = new HashMap<String, Object>();
				m.put("field", hashMap.get("COLUMN_NAME"));
				System.out.println("field="+hashMap.get("COLUMN_NAME"));
				String ble =hashMap.get("TABLE_NAME").toString();//表名
				EhcacheUtils.put(ble, m);//某表对应的主键和字段放到缓存
		}
   }


	@Test
	public void CacheableTest1(){
	//userServer.findUserById(2);
	}
		@Test
	public void CacheableTest2(){
	
	List keys = EhcacheUtils.getKeys();
	for (int i = 0; i < keys.size(); i++) {
		Object key=keys.get(i);
		Object value=EhcacheUtils.get(key);
		if(value instanceof UserFormMap){
			MapUtil.sysoMapKeyAndVal((UserFormMap)value);
		}
		else{
			for(Map.Entry<String, Object> m:((HashMap<String,Object>)value).entrySet()){
				key=m.getKey();
				String name=m.getValue().getClass().getName();
				System.out.println(key+" "+m.getValue());
				
			}
			
		}
	}
	
		}
	
	
}
