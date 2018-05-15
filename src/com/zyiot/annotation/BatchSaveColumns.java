package com.zyiot.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
/**
 * 用于批量导入需要的字段
 * {column1,column2,column3}
 */
@Target({ElementType.TYPE})  
@Retention(RetentionPolicy.RUNTIME)  
@Inherited
@Documented  
public @interface BatchSaveColumns {
 String[] columns()  ;
 int startColumn() default 1 ;
}
