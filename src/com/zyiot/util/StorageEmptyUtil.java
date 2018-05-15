package com.zyiot.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.zyiot.entity.StorageEmptyFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 实时库存清空时，进行清空记录
 * @author Admin
 * @date 2017年7月27日 下午2:19:43
 */
public class StorageEmptyUtil {
	/**
	 * 清空仓库记录
	 * @param wId 仓号
	 * @param baseMapper
	 * @throws Exception
	 */
	public static void addEmptyData(String wId,BaseMapper baseMapper) throws Exception{
		StorageEmptyFormMap storageEmpty = new StorageEmptyFormMap();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		storageEmpty.set("wId", wId);
		storageEmpty.set("emptyDate", df.format(new Date()));
		FormMapUtil.toADDFormMap(storageEmpty);
		baseMapper.addEntity(storageEmpty);
	}
	
	
}
