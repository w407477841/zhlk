package com.zyiot.mapper.weight;

import java.util.List;

import com.zyiot.entity.weight.ReportHarborFormMap;
import com.zyiot.mapper.BaseMapper;
/**
 * 查询报表
 * @author Admin
 * @date 2017年6月8日 下午3:10:32
 */
public interface ReportFormsMapper extends BaseMapper {
	public List<ReportHarborFormMap> oneReportFormsByPage(ReportHarborFormMap reportHarborFormMap);
	public List<ReportHarborFormMap> twoReportFormsByPage(ReportHarborFormMap reportHarborFormMap);
	public List<ReportHarborFormMap> threeReportFormsByPage(ReportHarborFormMap reportHarborFormMap);
	public List<ReportHarborFormMap> fourReportFormsByPage(ReportHarborFormMap reportHarborFormMap);
	public List<ReportHarborFormMap> fiveReportFormsByPage(ReportHarborFormMap reportHarborFormMap);
	public List<ReportHarborFormMap> sixReportFormsByPage(ReportHarborFormMap reportHarborFormMap);
	public List<ReportHarborFormMap> sevenReportFormsByPage(ReportHarborFormMap reportHarborFormMap);
}
