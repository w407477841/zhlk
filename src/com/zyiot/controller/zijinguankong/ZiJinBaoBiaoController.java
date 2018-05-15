package com.zyiot.controller.zijinguankong;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JExcelApiExporter;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.zijinguankong.ZiJinBaoBiaoFormMap;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.JasperHelper;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("zijinbaobiao")
public class ZiJinBaoBiaoController extends BaseController {
	Logger log = Logger.getLogger(ZiJinBaoBiaoController.class);
	@Autowired
	private DataSource dataSource;
	
	@RequestMapping("listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/zijinguankong/zijinbaobiaolist";
	}
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage findByPage(){
		return null;
	}
	@RequestMapping("createPDFReport")
	public void createPDFReport(HttpServletRequest request,HttpServletResponse response){
		ZiJinBaoBiaoFormMap ziJinBaoBiaoFormMap = getFormMap(ZiJinBaoBiaoFormMap.class);
		
		JasperHelper.export("pdf", DateUtils.dateToString(new Date()), "bankrollsimple.jasper", ziJinBaoBiaoFormMap, dataSource, request, response);
	}
	@RequestMapping("createExcelReport")
	public void createExcelReport(HttpServletRequest request,HttpServletResponse response){
		ZiJinBaoBiaoFormMap ziJinBaoBiaoFormMap = getFormMap(ZiJinBaoBiaoFormMap.class);

		JasperHelper.export("excel", DateUtils.dateToString(new Date()), "bankrollsimple.jasper", ziJinBaoBiaoFormMap,dataSource, request, response);
	}
	@RequestMapping("createWordReport")
	public void createWordReport(HttpServletRequest request,HttpServletResponse response){
		ZiJinBaoBiaoFormMap ziJinBaoBiaoFormMap = getFormMap(ZiJinBaoBiaoFormMap.class);
		
		JasperHelper.export("word", DateUtils.dateToString(new Date()), "bankrollsimple.jasper", ziJinBaoBiaoFormMap,dataSource, request, response);
	}
	@RequestMapping("createReport")
	@ResponseBody
	public String createReport(HttpServletRequest request,HttpServletResponse response){
		ZiJinBaoBiaoFormMap ziJinBaoBiaoFormMap = getFormMap(ZiJinBaoBiaoFormMap.class);
		
		try {
			Connection connection = dataSource.getConnection();
			
			InputStream in = ZiJinBaoBiaoController.class.getResourceAsStream("/jasper/bankrollhtml.jasper");
			JasperPrint jasperPrint = JasperFillManager.fillReport(in, ziJinBaoBiaoFormMap, connection);
			String path = "/html/"+DateUtils.dateToString(new Date())+".html";
			String savePath = request.getServletContext().getRealPath(path);
			JasperExportManager.exportReportToHtmlFile(jasperPrint, savePath);
			
			return path;
		} catch (SQLException e) {
			log.error("===Class:ZiJinBaoBiaoController==Exception:SQLException"+e);
			return "error";
		} catch (JRException e) {
			log.error("===Class:ZiJinBaoBiaoController==Exception:JRException"+e);
			return "error";
		}
		
	}
}
