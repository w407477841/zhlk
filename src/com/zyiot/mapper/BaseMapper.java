package com.zyiot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zyiot.util.BatchInsertParameter;

/**
 * 已经实现基本的 增,删,改,查接口,不需要重复写
 * 所有mapper都继承这个BaseMapper
 */
public interface BaseMapper {

	/**
	 * 系统开启时，查询出所有表及其字段
	 * @param formMap
	 * @return
	 */
	public <T> List<T> initTableField(T formMap);
	/**
	 * 添加方法。
	 * @param formMap
	 * @return
	 * @throws Exception
	 */
	public int addEntity(Object formMap)throws Exception;
	
	/**
	 * 需要调用FormMapUtil.toADDFormMap
	 * 修改单个对象务必带上id 否则会全部修改
	 * 需要做乐观锁的，请带上版本字段
	 * @param formMap
	 * @return
	 * @throws Exception
	 */
	public int updateEntity(Object formMap)throws Exception;
	
	
	/**
	 *  需要调用FormMapUtil.toUPDATEFormMap
	 * 删除对象 生成的语句为   where key=val;
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int deleteEntityByKey(@Param("param_key")String key,@Param("param_val")String val,@Param("param_clazz")Class c)throws Exception;
	/** 需要调用FormMapUtil.toDELETEFormMap
	 * @param formMap 
	 * value全用String类型 
	 * 如果u.put(key,"a,b,c") 则生成 key in ('a','b','c')
	 * 如果u.put(key,"a") 则生成 key='a';
	 * @return
	 * @throws Exception
	 */
	public int deleteEntityByNames(Object formMap)throws Exception;
	
	
    public int batchSave(BatchInsertParameter bip )throws Exception;
    
    
    public <T> T findById(@Param("id")String id,@Param("class")Class<T> t);
    
    
    public<T> List<T> findByAttr(T t);
}
