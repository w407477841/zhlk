package com.zyiot.interceptor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.apache.ibatis.binding.MapperMethod.ParamMap;
import org.apache.ibatis.executor.statement.PreparedStatementHandler;
import org.apache.ibatis.executor.statement.RoutingStatementHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;

import com.zyiot.annotation.TableSeg;
import com.zyiot.util.BatchInsertParameter;
import com.zyiot.util.Constant;
import com.zyiot.util.EhcacheUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.ReflectUtil;

@Intercepts({ @Signature(method = "prepare", type = StatementHandler.class, args = { Connection.class }) })
public class UtilInterceptor implements Interceptor {
	private static final String FIELDS = "fields";
	private static final String VALUES = "values";
	private static final String WHERE = "where";
	private static final String UPDATE = "update";
	private static final String SQL = "sql";

	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		if (invocation.getTarget() instanceof RoutingStatementHandler) {
			RoutingStatementHandler handler = (RoutingStatementHandler) invocation
					.getTarget();
			StatementHandler delegate = (StatementHandler) ReflectHelper
					.getValueByFieldName(handler, "delegate");
			PreparedStatementHandler preparedStatementHandler = (PreparedStatementHandler) delegate;
			BoundSql boundSql = delegate.getBoundSql();
			// System.out.println(ReflectHelper.getValueByFieldName(boundSql,
			// SQL));
			Object obj = boundSql.getParameterObject();
			// 通过反射获取delegate父类FormMapStatementHandler的mappedStatement属性
			MappedStatement mappedStatement = (MappedStatement) ReflectHelper
					.getValueByFieldName(delegate, "mappedStatement");
			;
			// 获得id名称
			String methodName = getMethodName(mappedStatement.getId());
			// System.out.println(methodName);
			if (methodName.equals(Constant.ADDENTITY)) {
				FormMap<String, Object> FormMap = (FormMap<String, Object>) obj;
				Map<String, String> results = getParametersFormFormMap(FormMap);
				String tableName = results.get(Constant.ENTITY_TABLE);
				if (tableName == null || "".equals(tableName)) {
					throw new Exception("[参数异常：缺少" + Constant.ENTITY_TABLE
							+ "]");
				}
				String sql = "insert into "
						+ results.get(Constant.ENTITY_TABLE) + "("
						+ results.get(FIELDS) + ") values("
						+ results.get(VALUES) + ")";
				System.out
						.println("==========================================");
				System.out.println(sql);
				System.out
						.println("==========================================");
				ReflectUtil.setFieldValue(boundSql, SQL, sql);
			} else if (methodName.equals(Constant.UPDATEENTITY)) {
				FormMap<String, Object> base = (FormMap<String, Object>) obj;
				Map<String, String> results = getUpdateFormBase(base);
				String tableName = results.get(Constant.ENTITY_TABLE);
				if (tableName == null || "".equals(tableName)) {
					throw new Exception("[参数异常：缺少" + Constant.ENTITY_TABLE
							+ "]");
				}
				String sql = "update " + tableName + " set "
						+ results.get(UPDATE) + results.get(WHERE);
				// 利用反射设置当前BoundSql对应的sql属性为我们建立好的分页Sql语句
				System.out.println("sql>>>" + sql);
				try {
					Session session = SecurityUtils.getSubject().getSession();
					session.setAttribute("sql_str", sql);
				} catch (Exception e) {

				}

				ReflectUtil.setFieldValue(boundSql, SQL, sql);

			} else if (methodName.equals(Constant.DELETEENTITYBYKEY)) {
				ParamMap p = (ParamMap) obj;
				Class c = (Class) p.get("param_clazz");
				TableSeg tableSeg = (TableSeg) c.getAnnotation(TableSeg.class);
				String sql = boundSql.getSql();
				int indexOfTable = sql.indexOf("table");
				// 将sql中table替换成 对应的表名
				sql = sql.substring(0, indexOfTable) + tableSeg.tableName()
						+ sql.substring(indexOfTable + 5);
				System.out
						.println("==========================================");
				System.out.println(sql);
				Session session = SecurityUtils.getSubject().getSession();
				session.setAttribute("sql_str", sql);
				System.out
						.println("==========================================");
				ReflectUtil.setFieldValue(boundSql, SQL, sql);
			} else if (methodName.equals(Constant.DELETEENTITYBYNAMES)) {
				FormMap<String, Object> base = (FormMap<String, Object>) obj;
				Map<String, String> results = getDeleteFormBase(base);
				String tableName = results.get(Constant.ENTITY_TABLE);
				if (tableName == null || "".equals(tableName)) {
					throw new Exception("[参数异常：缺少" + Constant.ENTITY_TABLE
							+ "]");
				}
				String sql = "delete from " + tableName + results.get(WHERE);
				// 利用反射设置当前BoundSql对应的sql属性为我们建立好的分页Sql语句
				System.out
						.println("==========================================");
				System.out.println(sql);
				System.out
						.println("==========================================");
				ReflectUtil.setFieldValue(boundSql, SQL, sql);

			}
			// 批量导入
			else if (methodName.equals(Constant.BATCHSAVE)) {
				// PreparedStatement ps = (PreparedStatement) invocation
				// .getArgs()[0];
				Connection conn = (Connection) invocation.getArgs()[0];
				BatchInsertParameter bip = (BatchInsertParameter) obj;
				String sql = "insert into " + bip.getTableName()
						+ bip.getFields() + " values " + bip.getValues() + ";";
				System.out
						.println("==========================================");
				System.out.println(sql);
				System.out
						.println("==========================================");
				PreparedStatement ps = conn.prepareStatement(sql);
				HashMap<String, Integer> paramSort = bip.getParamSort();
				List<FormMap<String, Object>> parameterObject = (List) bip
						.getData();
				ps.clearBatch();
				ps.clearParameters();
				@SuppressWarnings("rawtypes")
				int batchSize = bip.getBatchSize();
				int i = 0;
				getNextFormMap(parameterObject, ps, paramSort, 0);
				//
				// for(FormMap<String,Object> formMap:parameterObject){
				// Set<String> keys=formMap.keySet();
				// Iterator<String> it=keys.iterator();
				// while(it.hasNext()){
				// String next=it.next();
				// ps.setObject(paramSort.get(next), formMap.get(next));
				// }
				// ps.executeUpdate();
				// }
				ps = conn.prepareStatement("select 1 from dual");// mybatis还会往下执行sql。
																	// 不将sql换掉还会执行一次。
				return ps;
			} else if (methodName.equals(Constant.FINDBYID)) {
				ParamMap p = (ParamMap) obj;
				Class c = (Class) p.get("class");
				String id_val = (String) p.get("id");
				TableSeg tableSeg = (TableSeg) c.getAnnotation(TableSeg.class);
				String tableName = tableSeg.tableName();
				Map<String, Object> m = (Map<String, Object>) EhcacheUtils
						.get(tableName);
				String fields = (String) m.get("field");
				String id_key = (String) m.get("column_key");
				String sql = "select " + fields + " from " + tableName
						+ " where " + id_key + "='" + id_val + "'";
				System.out
						.println("==========================================");
				System.out.println(sql);
				System.out
						.println("==========================================");
				ReflectUtil.setFieldValue(boundSql, SQL, sql);
			} else if (methodName.equals(Constant.FINDBYATTR)) {
				Class c = (Class) obj.getClass();
				TableSeg tableSeg = (TableSeg) c.getAnnotation(TableSeg.class);
				String tableName = tableSeg.tableName();
				Map<String, Object> m = (Map<String, Object>) EhcacheUtils
						.get(tableName);
				String fields = (String) m.get("field");
				Map<String, String> results = getFindByAttrFormBase((FormMap<String, Object>) obj);
				String sql = "select " + fields + " from " + tableName
						+ results.get(WHERE);
				if (results.get(Constant.ORDER_BY) != null) {
					sql += " order by " + results.get(Constant.ORDER_BY);
				}
				System.out
						.println("==========================================");
				System.out.println(sql);
				System.out
						.println("==========================================");
				ReflectUtil.setFieldValue(boundSql, SQL, sql);
			}

		}

		return invocation.proceed();
	}

	@Override
	public Object plugin(Object target) {
		if (target instanceof RoutingStatementHandler) {
			return Plugin.wrap(target, this);
		} else {
			return target;
		}
		// return Plugin.wrap(target, this);
	}

	public void setProperties(Properties arg0) {

	}

	private FormMap<String, Object> getNextFormMap(
			List<FormMap<String, Object>> parameterObject,
			PreparedStatement ps, HashMap<String, Integer> paramSort, int count) {
		if (parameterObject == null || parameterObject.size() <= 0) {
			return null;
		}
		List<FormMap<String, Object>> retList = new ArrayList<FormMap<String, Object>>();
		int i = 0;
		Iterator<FormMap<String, Object>> itr = parameterObject.iterator();
		while (itr.hasNext()) {
			FormMap<String, Object> nextFormMap = itr.next();
			Set<String> keys = nextFormMap.keySet();
			Iterator<String> it = keys.iterator();
			try {
				while (it.hasNext()) {
					String next = it.next();
					ps.setObject(paramSort.get(next), nextFormMap.get(next));
				}

				// for(FormMap<String,Object> formMap:parameterObject){
				// retList.add(formMap);
				// i+=1;
				//
				// Set<String> keys=formMap.keySet();
				// Iterator<String> it=keys.iterator();
				// try {
				// while(it.hasNext()){
				// String next=it.next();
				// ps.setObject(paramSort.get(next), formMap.get(next));
				// }
				// ps.addBatch();
				// if (i % batchSize == 0) {
				// ps.executeBatch();
				// }
				itr.remove();
				i += 1;

				ps.executeUpdate();
			} catch (SQLException e) {
				getNextFormMap(parameterObject, ps, paramSort, i + count);
				List<String> errorList = (List<String>) EhcacheUtils.get(Thread
						.currentThread().getName());
				if (errorList == null)
					errorList = new ArrayList<String>();
				errorList.add("第" + (i + count) + "条添加失败");
				EhcacheUtils.put(Thread.currentThread().getName(), errorList);
				// e.printStackTrace();
			}
		}
		// if (parameterObject.size() % batchSize != 0) {
		// ps.executeBatch();
		// }

		return null;
	}

	/**
	 * 截取方法名
	 * 
	 * @param method
	 * @return
	 */
	private String getMethodName(String method) {
		int lastIndex = method.lastIndexOf(".");
		String methodName = method.substring(lastIndex + 1);
		return methodName;
	}

	/**
	 * 使用在add方法 获取 tableName fileds values
	 * 
	 * @param FormMap
	 * @return
	 */
	private Map<String, String> getParametersFormFormMap(
			FormMap<String, Object> FormMap) {
		List<String> fields = new ArrayList<String>();
		List<Object> values = new ArrayList<Object>();
		Map<String, String> results = new HashMap<String, String>();
		Set<String> sets = FormMap.keySet();
		for (String key : sets) {
			if (key.equals(Constant.ENTITY_TABLE)) {// 将表名加入
				results.put(Constant.ENTITY_TABLE,
						FormMap.getStr(Constant.ENTITY_TABLE));
			}
			// 将字段分别加入到两个list
			else {
				fields.add(key);
				values.add(FormMap.get(key));
			}
		}
		results.put(FIELDS, ListToString(fields));
		results.put(VALUES, ListObjectToString(values));
		return results;
	}

	/**
	 * 使用在update方法 获取 tableName where update
	 * 
	 * @param formMap
	 * @return
	 */

	private Map<String, String> getUpdateFormBase(
			FormMap<String, Object> formMap) {
		FormMap<String, Object> base = formMap;
		StringBuffer update = new StringBuffer();
		StringBuffer where = new StringBuffer(" where 1=1 ");
		Map<String, String> results = new HashMap<String, String>();
		String idKey = base.getStr(Constant.PRIMARY_KEY);
		Object idVal = base.get(idKey);
		if (idVal != null && !idVal.equals("")) {
			where.append(" and ").append(idKey).append("=").append(idVal + "");
		}
		String versionKey = base.getStr(Constant.UPDATE_VERSION);
		String versionVal = "";
		try {
			versionVal = base.getStr(versionKey);
			if (!versionKey.equals("")) {
				where.append(" and ").append(versionKey).append("=")
						.append(versionVal);
				update.append(versionKey).append("=").append("'")
						.append(Integer.parseInt(versionVal) + 1).append("',");
			}
			base.remove(Constant.PRIMARY_KEY);
			base.remove(idKey);
			base.remove(Constant.UPDATE_VERSION);
			base.remove(versionKey);
			Set<String> sets = base.keySet();
			for (String key : sets) {
				if (key.equals(Constant.ENTITY_TABLE)) {
					results.put(Constant.ENTITY_TABLE,
							base.getStr(Constant.ENTITY_TABLE));
				} else {
					update.append(key).append("=");
					if (base.get(key) == null || base.get(key).equals("")) {
						update.append("NULL,");
					} else {
						update.append("'").append(base.get(key)).append("',");
					}
				}
			}
			results.put(WHERE, where.toString());
			results.put(
					UPDATE,
					update.toString().substring(0,
							update.toString().length() - 1));
			return results;
		} catch (ClassCastException e) {
			int versionValint = base.getInt(versionKey);
			if (!versionKey.equals("")) {
				where.append(" and ").append(versionKey).append("=")
						.append(versionValint);
				update.append(versionKey).append("=").append("'")
						.append(versionValint + 1).append("',");
			}
			base.remove(Constant.PRIMARY_KEY);
			base.remove(idKey);
			base.remove(Constant.UPDATE_VERSION);
			base.remove(versionKey);
			Set<String> sets = base.keySet();
			for (String key : sets) {
				if (key.equals(Constant.ENTITY_TABLE)) {
					results.put(Constant.ENTITY_TABLE,
							base.getStr(Constant.ENTITY_TABLE));
				} else {
					update.append(key).append("=");
					if (base.get(key).equals("") || base.get(key) == null) {
						update.append("NULL,");
					} else {
						update.append("'").append(base.get(key)).append("',");
					}
				}
			}
			results.put(WHERE, where.toString());
			results.put(
					UPDATE,
					update.toString().substring(0,
							update.toString().length() - 1));
			return results;
		}

	}

	/**
	 * 使用在delete方法 获取 tableName where
	 * 
	 * @param formMap
	 * @return
	 */
	private Map<String, String> getDeleteFormBase(
			FormMap<String, Object> formMap) {
		FormMap<String, Object> base = formMap;
		StringBuffer where = new StringBuffer(" where 1=1 ");
		Map<String, String> results = new HashMap<String, String>();
		Set<String> sets = base.keySet();
		for (String key : sets) {
			if (key.equals(Constant.ENTITY_TABLE)) {
				results.put(Constant.ENTITY_TABLE,
						base.getStr(Constant.ENTITY_TABLE));
			} else if (key.equals(Constant.ORDER_BY)) {
				results.put(Constant.ORDER_BY, base.getStr(Constant.ORDER_BY));
			} else {

				String val = "";
				try {
					val = base.getStr(key);
					boolean isContains = val.contains(",");
					if (isContains) {
						String[] ps = val.split(",");
						StringBuffer params = new StringBuffer();
						for (int i = 0; i < ps.length; i++) {
							params.append("'").append(ps[i]).append("'")
									.append(",");
						}
						where.append(" and ")
								.append(key)
								.append(" in(")
								.append(params.substring(0, params.length() - 1))
								.append(")");
					} else {
						where.append(" and ").append(key).append("='")
								.append(base.get(key)).append("'");
					}

				} catch (ClassCastException e) {
					where.append(" and ").append(key).append("='")
							.append(base.get(key)).append("'");
					results.put(WHERE, where.toString());
					return results;
				}

			}
		}
		results.put(WHERE, where.toString());
		return results;
	}

	public Map<String, String> getFindByAttrFormBase(
			FormMap<String, Object> formmap) {
		return getDeleteFormBase(formmap);
	}

	private String ListToString(List<String> list) {
		String result = list.toString();
		result = result.substring(1, result.length() - 1);
		result = result.replace(", ", ",");
		return result;
	}

	private String ListObjectToString(List<Object> list) {
		StringBuffer str = new StringBuffer();
		for (Object obj : list) {
			if(obj == null){
				str.append("null,");				
			}else{
				str.append("'").append(obj.toString()).append("',");
			}
		}
		return str.toString().substring(0, str.toString().length() - 1);
	}

}
