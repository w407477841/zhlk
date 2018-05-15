package com.zyiot.util;

import java.util.Date;

import org.apache.shiro.SecurityUtils;

import com.zyiot.entity.StorageEmptyFormMap;
import com.zyiot.mapper.BaseMapper;

/**
 * 库存变换记录表
 * @author Admin
 * @date 2017年10月18日 下午2:35:17
 */
public class StorageChangeUtil {
	/**
	 * 
	 * @param oId 原始ID
	 * @param storageWeight 库存量
	 * @param changeWeight  变换量
	 * @param afterWeight 变换后数量
	 * @param changeType 变化类型
	 * @param operateTable 操作数据表
	 * @param operateID 操作数据表示
	 * @param baseMapper
	 * @throws Exception 
	 */
	public static void addChangeLog(int oId,String storageWeight,String changeWeight,String afterWeight,String changeType,String operateTable,String operateID, BaseMapper baseMapper) throws Exception{
		FormMap<String, Object> base = new FormMap<String,Object>();
		
		base.set("oId", oId);
		base.set("storageWeight", storageWeight);
		base.set("changeWeight", changeWeight);
		base.set("afterWeight", afterWeight);
		base.set("changeType", changeType);
		base.set("operateTable", operateTable);
		base.set("operateID", operateID);
		base.set("changeDate", DateUtils.dateFormatToLong(new Date(System.currentTimeMillis())));
		base.set("changeUser", SecurityUtils.getSubject().getSession().getAttribute("userSessionId"));
		base.set(Constant.ENTITY_TABLE, "t_storage_change");
		baseMapper.addEntity(base);
	}
	/**
	 * 清空仓库记录
	 * @param wId 仓号
	 * @param baseMapper
	 * @param endDate 清空时间
	 * @throws Exception
	 */
	public static void addEmptyData(String wId,BaseMapper baseMapper,String endDate) throws Exception{
		StorageEmptyFormMap storageEmpty = new StorageEmptyFormMap();
		storageEmpty.set("wId", wId);
		storageEmpty.set("emptyDate", endDate);
		FormMapUtil.toADDFormMap(storageEmpty);
		baseMapper.addEntity(storageEmpty);
	}
}
