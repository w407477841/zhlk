package com.zyiot.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.enterprise.inject.Default;

/**
 * 需要给两个值<br>
 * tableName = "表名"<br>
 * id = "表的主键"(如果是多个主建,默认为第一个)<br>
 * version ="版本号"  需要使用乐观锁时填写   (字段名称随意，类型bigint，default 0)
 *
 */
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface TableSeg {
	/**
	 * 表名
	 * @return
	 */
	public String tableName();
	
	/**
	 * 表的主键,如果是多个主建,默认为第一个
	 * @return
	 */
	public String id();
	
	
	/**
	 * 表示记录版本字段，用于更新
	 * 
	 */
	
	public String version() default "" ;

}