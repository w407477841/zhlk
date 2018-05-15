package com.zyiot.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
/**
 * 
 * 在页面跳转的controller上加save；
 * 在form表单保存，修改时使用remove
 *
 */

public @interface Token {

    boolean save() default false;

    boolean remove() default false;
}
