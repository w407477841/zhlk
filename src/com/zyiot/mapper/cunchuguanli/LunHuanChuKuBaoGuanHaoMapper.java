package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.LunHuanChuKuBaoGuanHaoFormMap;
import com.zyiot.mapper.BaseMapper;

public interface LunHuanChuKuBaoGuanHaoMapper extends BaseMapper {
	
	public List<LunHuanChuKuBaoGuanHaoFormMap> findByPage(LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap);
	
	public LunHuanChuKuBaoGuanHaoFormMap findLunHuanChuKuBaoGuanHaoById(int id);
	/**
	 * 查询仓库的第一次库存质检信息
	 * @param id
	 * @return
	 */
	public LunHuanChuKuBaoGuanHaoFormMap findCheckDetailById(int id);
}
