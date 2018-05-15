package com.zyiot.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 在需要生成LOG的方法上server 加上 
 * @author Administrator
 *
 */
  
@Target({ElementType.PARAMETER, ElementType.METHOD})  
@Retention(RetentionPolicy.RUNTIME)  
@Documented  
public @interface SystemLog {
	String module()  default "";  
	String methods()  default ""; 
    String description()  default ""; 
}
