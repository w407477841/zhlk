package com.zyiot.interceptor;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.lang.reflect.TypeVariable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import org.apache.commons.beanutils.MethodUtils;
import org.apache.ibatis.binding.MapperMethod.ParamMap;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.resultset.DefaultResultSetHandler;
import org.apache.ibatis.executor.resultset.ResultSetHandler;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.log4j.Logger;

import com.zyiot.annotation.TableSeg;
import com.zyiot.util.Constant;
import com.zyiot.util.EhcacheUtils;
import com.zyiot.util.FormMap;
@Intercepts({@Signature(type=ResultSetHandler.class,method="handleResultSets",args={ Statement.class})})
public class ResultChange implements Interceptor {
Logger logger=Logger.getLogger(ResultChange.class); 
	public Object intercept(Invocation invocation) throws Throwable {
		if(invocation.getTarget() instanceof DefaultResultSetHandler){
			DefaultResultSetHandler handler=(DefaultResultSetHandler) invocation.getTarget();
			ParameterHandler parameterHandler=(ParameterHandler) ReflectHelper.getValueByFieldName(handler,"parameterHandler");
			MappedStatement mappedStatement = (MappedStatement)ReflectHelper.getValueByFieldName(handler, "mappedStatement");
			if(getMethodName(mappedStatement.getId()).equals(Constant.FINDBYID)){
				logger.debug("==================修改返回值["+Constant.FINDBYID);
				Object parameterObj=parameterHandler.getParameterObject();
			String fields[]=null;
			if(parameterObj instanceof ParamMap ){
			ParamMap pm=(ParamMap) parameterObj;
			Class clazz=(Class) pm.get("class");
			TableSeg table=(TableSeg) clazz.getAnnotation(TableSeg.class);
			String tableName=table.tableName();
			HashMap<String,Object> mp=(HashMap<String, Object>) EhcacheUtils.get(tableName);
			 fields=((String) mp.get("field")).split(",");
			Statement stmt=(Statement) invocation.getArgs()[0];
			ResultSet rs=stmt.getResultSet();
			List<Object> retList=new ArrayList<Object>();
			while(rs.next()&&fields!=null){
				Object retObject=clazz.newInstance();
				for(int i=0;i<fields.length;i++){
					Object [] args={fields[i],rs.getObject(fields[i])==null?"":rs.getObject(fields[i])};
					MethodUtils.invokeMethod(retObject, "put",args );
				}
				retList.add(retObject);
			}
			return retList;
				}
			}
			
			if(getMethodName(mappedStatement.getId()).equals(Constant.FINDBYATTR)){
				logger.debug("==================修改返回值["+Constant.FINDBYATTR);
				Object parameterObj=parameterHandler.getParameterObject();
				String fields[]=null;
				if(parameterObj instanceof FormMap ){
				Class clazz=parameterObj.getClass();
				TableSeg table=(TableSeg) clazz.getAnnotation(TableSeg.class);
				String tableName=table.tableName();
				HashMap<String,Object> mp=(HashMap<String, Object>) EhcacheUtils.get(tableName);
				 fields=((String) mp.get("field")).split(",");
				Statement stmt=(Statement) invocation.getArgs()[0];
				ResultSet rs=stmt.getResultSet();
				return toChangeResultMap(rs,fields,clazz);
					}
				}
		}
			
		return invocation.proceed();
	}

	@Override
	public Object plugin(Object arg0) {
		return Plugin.wrap(arg0, this);
	}

	@Override
	public void setProperties(Properties arg0) {
		// TODO Auto-generated method stub
		
	}
	/**
	 * 截取方法名
	 * @param method
	 * @return
	 */
		private String getMethodName(String method) {
			int lastIndex = method.lastIndexOf(".");
			String methodName = method.substring(lastIndex + 1);
			return methodName;
		}

	public 	List<Object> toChangeResultMap(ResultSet rs,String []fields,Class clazz) throws InstantiationException, IllegalAccessException, NoSuchMethodException, InvocationTargetException, SQLException{
		List<Object> retList=new ArrayList<Object>();
		while(rs.next()&&fields!=null){
			Object retObject=clazz.newInstance();
			for(int i=0;i<fields.length;i++){
			//	System.out.println(retObject.getClass().getName()+"  "+fields[i]+"  "+rs.getObject(fields[i]));
				Object [] args={fields[i],rs.getObject(fields[i])==null?"":rs.getObject(fields[i])};
				MethodUtils.invokeMethod(retObject, "put",args );
			}
			retList.add(retObject);
		}
		return retList;
	}
		
}
