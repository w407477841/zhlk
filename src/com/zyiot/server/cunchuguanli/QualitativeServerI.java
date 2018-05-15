package com.zyiot.server.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.QualitativeFormMap;

public interface QualitativeServerI {
	public List<QualitativeFormMap> findByPage(QualitativeFormMap q,
			int pageSize, int pageNum);

	public List<QualitativeFormMap> findCk();

	public void addQualitative(QualitativeFormMap q) throws Exception;

}
