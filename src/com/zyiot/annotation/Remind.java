package com.zyiot.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ ElementType.PARAMETER, ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
@Documented
/**
 * 
 * @author Administrator
 *type=1  根据提供的userIds进行提醒
 *type=2  根据提供的roleIds进行提醒
 *
 */
public @interface Remind {

	String type() default "1";

	String[] userIds() default {};

	String[] roleIds() default {};

	String url();

	String remindType();

	String remindContent();

	boolean isNeedParam() default false;

}
