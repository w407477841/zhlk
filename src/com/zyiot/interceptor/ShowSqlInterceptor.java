package com.zyiot.interceptor;

import java.util.List;
import java.util.Properties;

import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMap;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;

@Intercepts({@Signature(type=Executor.class,method="query",args={ MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class })})  
public class ShowSqlInterceptor implements Interceptor{

	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		  MappedStatement mappedStatement=(MappedStatement)invocation.getArgs()[0];      
		    Object parameter = invocation.getArgs()[1];   
		    BoundSql boundSql = mappedStatement.getBoundSql(parameter);   
		    String originalSql = boundSql.getSql().trim();
		    ParameterMap p=    mappedStatement.getParameterMap();
		  List<ParameterMapping> l=  p.getParameterMappings();
		  for(int i=0;l!=null&&i<l.size();i++){
			 System.out.println( l.get(i).getProperty());
			  
		  }
		  
		    System.out.println(originalSql);
		return invocation.proceed();
	}

	@Override
	public Object plugin(Object arg0) {
		// TODO Auto-generated method stub
		return Plugin.wrap(arg0, this); 
	}

	@Override
	public void setProperties(Properties arg0) {
		// TODO Auto-generated method stub
		
	}

}
