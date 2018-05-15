package com.zyiot.server.impl;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

import org.springframework.transaction.annotation.Transactional;

import com.zyiot.annotation.SystemLog;
import com.zyiot.mapper.BaseMapper;
import com.zyiot.server.BaseServerI;
import com.zyiot.util.ReflectUtil;

/**
 * 
 * @author Administrator
 * 
 * @param <T>
 *            Entity
 * @param <E>
 *            Mapper
 */
public class BaseServerImpl<T, E> implements BaseServerI<T, E> {
	BaseMapper b = null;
	Class c = null;

	public BaseServerImpl() {

		c = getGenericType(0);
	}

	public void setBasemapper() {
		if (b != null)
			return;

		Class mapper = getGenericType(1);

		Field fields[] = getClass().getDeclaredFields();
		for (Field field : fields) {
			if (field.getType().getName().equals(mapper.getName())) {

				b = (BaseMapper) ReflectUtil.getFieldValue(this,
						field.getName());
			}
		}

	}

	/*
	 * 获取泛型
	 */
	public Class getGenericType(int index) {
		Type genType = getClass().getGenericSuperclass();
		if (!(genType instanceof ParameterizedType)) {
			return Object.class;
		}
		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
		if (index >= params.length || index < 0) {
			throw new RuntimeException("Index outof bounds");
		}
		if (!(params[index] instanceof Class)) {
			return Object.class;
		}
		return (Class) params[index];
	}

	@Transactional(readOnly = false)
	@SystemLog()
	public int add(T t) throws Exception {
		setBasemapper();

		return b.addEntity(t);
	}

	@Transactional(readOnly = false)
	@SystemLog()
	public int edit(T t) throws Exception {
		setBasemapper();
		return b.updateEntity(t);
	}

	@Transactional(readOnly = false)
	@SystemLog()
	public int deleteByAttr(T t) throws Exception {
		setBasemapper();
		return b.deleteEntityByNames(t);
	}
}
