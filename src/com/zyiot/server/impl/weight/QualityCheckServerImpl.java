package com.zyiot.server.impl.weight;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyiot.entity.weight.QualityCheckFormMap;
import com.zyiot.mapper.weight.QualityCheckMapper;
import com.zyiot.server.weight.QualityCheckServerI;
@Service("qualityCheckServer")
public class QualityCheckServerImpl implements QualityCheckServerI {
	@Autowired
	private QualityCheckMapper qualityCheckMapper;
	@Override
	public void editQualityCheck(QualityCheckFormMap qualityCheckFormMap)
			throws Exception {
		qualityCheckMapper.updateEntity(qualityCheckFormMap);
	}

	@Override
	public QualityCheckFormMap findQualityCheckByBId(String bId) {
		return qualityCheckMapper.findQualityCheckByBId(bId);
	}

}
