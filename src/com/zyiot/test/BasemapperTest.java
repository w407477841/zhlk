package com.zyiot.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
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
import com.zyiot.util.BatchInsertParameter;
import com.zyiot.util.ConfigUtils;
import com.zyiot.util.Constant;
import com.zyiot.util.EhcacheUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MapUtil;
import com.zyiot.util.POIUtils;
import com.zyiot.util.PasswordHelper;
import com.zyiot.util.PropertiesUtils;


@RunWith(SpringJUnit4ClassRunner.class)      

@ContextConfiguration({"classpath:spring-application.xml"})  
public class BasemapperTest {
	
	@Autowired
	UserServerI userServer;
	@Autowired
	UserMapper userMapper;
	@Test
	   public void initConfig(){
			HashMap<String, Object> tm = new HashMap<String, Object>();
			tm.put("table_name", "'t_user','t_resources','t_log'");
			tm.put("database_name","'zyiot'");
			 List<HashMap<String, Object>> lh = userMapper.initTableField(tm);
			 System.out.println(lh.size());
			 for (HashMap<String, Object> hashMap : lh) {
				 Map<String, Object> m = new HashMap<String, Object>();
					m.put("field", hashMap.get("COLUMN_NAME"));
					m.put("column_key","id");

					System.out.println("field="+hashMap.get("COLUMN_NAME"));
					String ble =hashMap.get("TABLE_NAME").toString();//表名
					EhcacheUtils.put(ble, m);//某表对应的主键和字段放到缓存
			}
	   }

	
    public void addEntityTest(){
    	//添加用户信息
    	UserFormMap u=new UserFormMap();
    	u.put("userName", "王一飞1");
    	u.put("accountName", "wangyifei1");
    	u.put("password","123456");
    	//加密，及加入credentialsSalt验证
    	PasswordHelper passwordHelper=new PasswordHelper();
    	passwordHelper.encryptPassword(u);
    	try {
    		FormMapUtil.toADDFormMap(u);
			userServer.insertUser(u);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
    	
    }
public void 	updateEntityTest(){
    	UserFormMap u=new UserFormMap();
    	u.put("id", "816");
    	u.put("accountName", "wangyifei");
    	u.put("version","0");
    	//u.put(Constant.ENTITY_TABLE,"ly_user"); 
    	try {
    		FormMapUtil.toUPDATEFormMap(u);
			userServer.updateUser(u);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
}
public void deleteEntityByKeyTest(){
	
	try {
		int ret=userServer.deleteUser("userName", "王一飞");
		System.out.println(ret);
	} catch (Exception e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	}
	
}
public void deleteEntityBynamesTest(){
	FormMap<String ,Object> f=new FormMap();
	UserFormMap u=new UserFormMap();
	u.put("userName","王一飞,王二非");
	try {
		FormMapUtil.toDELETEFormMap(u);
		int ret =userServer.deleteUserByNames(u);
		System.out.println(ret);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
}
public void batchSaveTest() throws FileNotFoundException{
	
	List<UserFormMap> l=null;
	File file=new File("D:/user.xls");
		InputStream is=new FileInputStream(file);
		try {
			l=POIUtils.getList(is, new UserFormMap(),null, null);
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NullPointerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	try {//1643 1318 1366;
		long tstart=System.currentTimeMillis();
		System.out.println();
		int ret=userServer.batchSaveUsers(l);
		long tend=System.currentTimeMillis();
		System.out.println("耗时"+(tend-tstart)+"ms");
		
		//获取错误记录
	List<String> errorList= (List<String>) EhcacheUtils.get(Thread.currentThread().getName());
	for(int i=0;i<errorList.size();i++){
		System.out.println(errorList.get(i));
		}
	EhcacheUtils.remove(Thread.currentThread().getName());
	
	} catch (Exception e) {
		e.printStackTrace();
	}
}
public void findByIdTest(){
	
	UserFormMap u;
	try {
		u = userServer.findUserById(2);
		MapUtil.sysoMapKeyAndVal(u);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
}

public void findByAttrtest(){
	UserFormMap u=new UserFormMap();
	List<UserFormMap> l=null;
	try {
			
		l = userServer.findUserByAttr(u);
	} catch (Exception e) {
		e.printStackTrace();
	}
	for(int i=0;l!=null&&i<l.size();i++){
		System.out.println("==================================");
		MapUtil.sysoMapKeyAndVal(l.get(i));
	}
}
public  void findBypageTest(){
	UserFormMap u=new UserFormMap();
	List<UserFormMap> l=null;
	try {
		PageHelper.startPage(0,1 );
		l = userServer.findUserByPage(u, 1,1);
		PageInfo page = new PageInfo(l);
		System.out.println(page.getFirstPage()+"  "+page.getLastPage());
	} catch (Exception e) {
		e.printStackTrace();
	}
	for(int i=0;l!=null&&i<l.size();i++){
		System.out.println("==================================");
		MapUtil.sysoMapKeyAndVal(l.get(i));
	}
}

public void test(){
	try {
		getList(new ArrayList());
	} catch (InstantiationException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (IllegalAccessException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}


public <E> E getList(E e) throws InstantiationException, IllegalAccessException{
List l=(List) e.getClass().newInstance();
System.out.println(l.getClass().getName());
return (E)l;
}

}
