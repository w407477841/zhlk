package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.CangKuDianWeiFormMap;

public interface CangKuDianWeiServerI {
	List<CangKuDianWeiFormMap> findDianWeiByPage(
			CangKuDianWeiFormMap cangKuDianWeiFormMap, int pageSize, int pageNum);

	List<CangKuDianWeiFormMap> findDianWeiByAttr(
			CangKuDianWeiFormMap cangKuDianWeiFormMap);

	CangKuDianWeiFormMap findById(String id);

	void addCangKuDianWei(CangKuDianWeiFormMap cangKuDianWeiFormMap)
			throws Exception;

	public void editCangKuDianWei(CangKuDianWeiFormMap cangKuDianWeiFormMap)
			throws Exception;

	public void deleteOne(String id) throws Exception;
	/**
	 * 根据仓库点位id 获取传感器数据
	 * @param id
	 * @return
	 */
	public List<CangKuDianWeiFormMap> findDataById(String id);
}
