package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.ChuKuShenQingTransferToolsFormMap;
import com.zyiot.mapper.BaseMapper;

public interface ChuKuShenQingTransferToolsMapper extends BaseMapper {
	List<ChuKuShenQingTransferToolsFormMap> findByPage(ChuKuShenQingTransferToolsFormMap chuKuShenQingTransferTools);
	/**
	 * 更新状态
	 * @param id
	 */
	void updateVersion(int id);
	/**
	 * 清除未使用的数据
	 * @param dataOperator
	 */
	void clearNoUsed(int dataOperator);
	
	List<ChuKuShenQingTransferToolsFormMap> findByIds(List<Integer> ids);
	
}
