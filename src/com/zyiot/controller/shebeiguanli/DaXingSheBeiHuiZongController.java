package com.zyiot.controller.shebeiguanli;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiFormMap;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.JasperHelper;

@Controller
@RequestMapping("daxingshebeihuizong")
public class DaXingSheBeiHuiZongController extends BaseController {
	@Autowired
	private DataSource dataSource;
	@RequestMapping("listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/shebeihuizonglist";
	}
	@RequestMapping("createPDFReport")
	public void createPDFReport(HttpServletRequest request,HttpServletResponse response){
		DaXingSheBeiFormMap DaXingSheBeiFormMap = getFormMap(DaXingSheBeiFormMap.class);
		
		JasperHelper.export("pdf", "设备汇总", "equipment.jasper", DaXingSheBeiFormMap, dataSource, request, response);
	}
	@RequestMapping("createExcelReport")
	public void createExcelReport(HttpServletRequest request,HttpServletResponse response){
		DaXingSheBeiFormMap DaXingSheBeiFormMap = getFormMap(DaXingSheBeiFormMap.class);

		JasperHelper.export("excel", "设备汇总", "equipment.jasper", DaXingSheBeiFormMap,dataSource, request, response);
	}
	@RequestMapping("createWordReport")
	public void createWordReport(HttpServletRequest request,HttpServletResponse response){
		DaXingSheBeiFormMap DaXingSheBeiFormMap = getFormMap(DaXingSheBeiFormMap.class);
		
		JasperHelper.export("word", "设备汇总", "equipment.jasper", DaXingSheBeiFormMap,dataSource, request, response);
	}
	
}
