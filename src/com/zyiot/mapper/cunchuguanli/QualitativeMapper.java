package com.zyiot.mapper.cunchuguanli;

import java.util.List;

import com.zyiot.entity.cunchuguanli.QualitativeFormMap;
import com.zyiot.mapper.BaseMapper;

public interface QualitativeMapper extends BaseMapper {
	List<QualitativeFormMap> findByPage(QualitativeFormMap q);

	List<QualitativeFormMap> findCk();

}
