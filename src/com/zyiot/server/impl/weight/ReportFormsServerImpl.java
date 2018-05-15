package com.zyiot.server.impl.weight;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.mapper.weight.ReportFormsMapper;
import com.zyiot.server.weight.ReportFormsServerI;

@Service("reportFormsServer")
public class ReportFormsServerImpl implements ReportFormsServerI {
	@Autowired
	private ReportFormsMapper reportFormsMapper;
	@Override
	public List<ReportHarborFormMap> oneReportFormsByPage(
			ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return reportFormsMapper.oneReportFormsByPage(reportHarborFormMap);
	}

	@Override
	public List<ReportHarborFormMap> twoReportFormsByPage(
			ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return reportFormsMapper.twoReportFormsByPage(reportHarborFormMap);
	}

	@Override
	public List<ReportHarborFormMap> threeReportFormsByPage(
			ReportHarborFormMap reportHarborFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return reportFormsMapper.threeReportFormsByPage(reportHarborFormMap);
	}

	@Override
	public List<ReportHarborFormMap> fourReportFormsByPage(
			ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return reportFormsMapper.fourReportFormsByPage(reportHarborFormMap);
	}

	@Override
	public List<ReportHarborFormMap> fiveReportFormsByPage(
			ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return reportFormsMapper.fiveReportFormsByPage(reportHarborFormMap);
	}
	@Override
	public List<ReportHarborFormMap> sixReportFormsByPage(
			ReportHarborFormMap reportHarborFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return reportFormsMapper.sixReportFormsByPage(reportHarborFormMap);
	}

	@Override
	public List<ReportHarborFormMap> sevenReportFormsByPage(
			ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return reportFormsMapper.sevenReportFormsByPage(reportHarborFormMap);
	}

}
