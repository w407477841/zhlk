package com.zyiot.server.impl.weight;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyiot.entity.weight.QualityFormMap;
import com.zyiot.mapper.weight.QualityMapper;
import com.zyiot.server.weight.QualityServerI;

@Service("qualityServer")
public class QualityServerImpl implements QualityServerI {
	@Autowired
	private QualityMapper qualityMapper;
	@Override
	public List<QualityFormMap> findByVarietyId(int varietyId) {
		return qualityMapper.findByVarietyId(varietyId);
	}
	@Override
	public List<QualityFormMap> findQualityByVarietyId(int varietyId) {
		return qualityMapper.findQualityByVarietyId(varietyId);
	}

}
