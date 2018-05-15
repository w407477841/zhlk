package com.zyiot.server;

public interface BaseServerI<T, E> {

	public int add(T t) throws Exception;

	public int edit(T t) throws Exception;

	public int deleteByAttr(T t) throws Exception;

}
