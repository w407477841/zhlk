package com.zyiot.server.weight;

import java.util.List;

import com.zyiot.entity.weight.ReportHarborFormMap;
/**
 * 查询报表
 * @author Admin
 * @date 2017年6月8日 下午3:10:12
 */
public interface ReportFormsServerI {
	public List<ReportHarborFormMap> oneReportFormsByPage(ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum);
	public List<ReportHarborFormMap> twoReportFormsByPage(ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum);
	public List<ReportHarborFormMap> threeReportFormsByPage(ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum);
	public List<ReportHarborFormMap> fourReportFormsByPage(ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum);
	public List<ReportHarborFormMap> fiveReportFormsByPage(ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum);
	public List<ReportHarborFormMap> sixReportFormsByPage(ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum);
	public List<ReportHarborFormMap> sevenReportFormsByPage(ReportHarborFormMap reportHarborFormMap,int pageSize,int pageNum);
}
