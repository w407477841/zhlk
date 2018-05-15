package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.LunHuanRuKuZhengLiHaoFormMap;
import com.zyiot.mapper.BaseMapper;

public interface LunHuanRuKuZhengLiHaoMapper extends BaseMapper {
	
	public List<LunHuanRuKuZhengLiHaoFormMap> findByPage(LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap);
	
	public LunHuanRuKuZhengLiHaoFormMap findLunHuanRuKuZhengLiHaoById(int id);
	
	public LunHuanRuKuZhengLiHaoFormMap findCheckDetailById(int id);

}
