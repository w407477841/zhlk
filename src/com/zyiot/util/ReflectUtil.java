package com.zyiot.util;

import java.lang.reflect.Field;

import org.apache.log4j.Logger;

public class ReflectUtil {
	 static Logger log = Logger.getLogger(ReflectUtil.class);
	 /**
     * Use reflection to obtain the specified object within the specified object
     * @param obj:target object
     * @param fieldName:target properties
     * @return target properties value
     */
    public static Object getFieldValue(Object obj, String fieldName) {
        Object result = null;
        Field field = ReflectUtil.getField(obj, fieldName);
        if (field != null) {
           field.setAccessible(true);
           try {
               result = field.get(obj);
           } catch (IllegalArgumentException e) {
             //  log.error("=====Class:ReflectUtil=======Method:getFieldValue===Exception:IllegalArgumentException=="+e.getMessage());
               e.printStackTrace();
           } catch (IllegalAccessException e) {
        	   //log.error("=====Class:ReflectUtil=======Method:getFieldValue===Exception:IllegalAccessException=="+e.getMessage());
        	   e.printStackTrace();
           }
        }
        return result;
    }
   
    /**
     * Use reflection to obtain the specified properties within the specified object
     * @param obj:target object 
     * @param fieldName:target properties
     * @return target field
     */
    private static Field getField(Object obj, String fieldName) {
        Field field = null;
       for (Class<?> clazz=obj.getClass(); clazz != Object.class; clazz=clazz.getSuperclass()) {
           try {
               field = clazz.getDeclaredField(fieldName);
               break;
           } catch (NoSuchFieldException e) {
        	  e.printStackTrace();
           }
        }
        return field;
    }

    /**
     * Use reflection to set the specified properties value within the specified object
     * @param obj target object 
     * @param fieldName target properties 
      * @param fieldValue target proterties value 
     */
    public static void setFieldValue(Object obj, String fieldName,
           Object fieldValue) {
        Field field = ReflectUtil.getField(obj, fieldName);
        if (field != null) {
           try {
               field.setAccessible(true);
               field.set(obj, fieldValue);
           } catch (IllegalArgumentException e) {
        	   log.error("=====Class:ReflectUtil=======Method:setFieldValue===Exception:IllegalArgumentException=="+e);
           } catch (IllegalAccessException e) {
        	   log.error("=====Class:ReflectUtil=======Method:setFieldValue===Exception:IllegalAccessException=="+e);
           }
        }
        else{System.out.println("不存在该属性");}
     }
}
