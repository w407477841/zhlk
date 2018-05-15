package com.zyiot.util;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.base.JRBaseReport;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRRtfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.util.JRLoader;

import org.apache.log4j.Logger;

@SuppressWarnings("deprecation")
public class JasperHelper {

	private static Logger logger = Logger.getLogger(JasperHelper.class);
	public static final String PRINT_TYPE = "print";  
    public static final String PDF_TYPE = "pdf";  
    public static final String EXCEL_TYPE = "excel";  
    public static final String HTML_TYPE = "html";  
    public static final String WORD_TYPE = "word";  
    
	public static void prepareReport(JasperReport jasperReport, String type) {
		logger.debug("The method======= prepareReport() start.......................");
		/*
		 * 如果导出的是excel，则需要去掉周围的margin
		 */
		if ("excel".equals(type))
			try {
				Field margin = JRBaseReport.class.getDeclaredField("leftMargin");
				margin.setAccessible(true);
				margin.setInt(jasperReport, 0);
				margin = JRBaseReport.class.getDeclaredField("topMargin");
				margin.setAccessible(true);
				margin.setInt(jasperReport, 0);
				margin = JRBaseReport.class.getDeclaredField("bottomMargin");
				margin.setAccessible(true);
				margin.setInt(jasperReport, 0);
				Field pageHeight = JRBaseReport.class.getDeclaredField("pageHeight");
				pageHeight.setAccessible(true);
				pageHeight.setInt(jasperReport, 2147483647);
			} catch (Exception exception) {
			}
	}

	/**
	 * 导出Excel表
	 * 
	 * @param jasperPrint
	 * @param defaultFilename
	 *            文件名
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws JRException
	 */
	private static void exportExcel(JasperPrint jasperPrint,
			String defaultFilename, HttpServletRequest request,
			HttpServletResponse response) throws IOException, JRException {
		logger.debug("执行导出excel   The method======= exportExcel() start.......................");

		response.setContentType("application/vnd.ms-excel");
		String defaultname = null;
		if (defaultFilename.trim() != null && defaultFilename != null) {
			defaultname = defaultFilename + ".xls";
		} else {
			defaultname = "export.xls";
		}
		//String fileName = new String(defaultname.getBytes("gbk"), "ISO8859_1");
		response.setHeader("Content-disposition", "attachment; filename="
				+ defaultname);
		ServletOutputStream ouputStream = response.getOutputStream();
		JRXlsExporter exporter = new JRXlsExporter();
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
		exporter.setParameter(
				JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
				Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET,
				Boolean.FALSE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND,
				Boolean.FALSE);
		exporter.exportReport();
		ouputStream.flush();
		ouputStream.close();
	}

	/**
	 * * 导出pdf，注意此处中文问题，
	 * 
	 * 这里应该详细说：主要在ireport里变下就行了。看图
	 * 
	 * 1）在ireport的classpath中加入iTextAsian.jar 2）在ireport画jrxml时，看ireport最左边有个属性栏。
	 * 
	 * 下边的设置就在点字段的属性后出现。 pdf font name ：STSong-Light ，pdf encoding ：UniGB-UCS2-H
	 * 
	 * @param jasperPrint
	 * @param defaultFilename
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws JRException
	 */
	private static void exportPdf(JasperPrint jasperPrint,
			String defaultFilename, HttpServletRequest request,
			HttpServletResponse response) throws IOException, JRException {
		response.setContentType("application/pdf");
		String defaultname = null;
		if (defaultFilename.trim() != null && defaultFilename != null) {
			defaultname = defaultFilename + ".pdf";
		} else {
			defaultname = "export.pdf";
		}
		//String fileName = new String(defaultname.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-disposition", "attachment; filename="
				+ defaultname);
		ServletOutputStream ouputStream = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, ouputStream);
		ouputStream.flush();
		ouputStream.close();
	}

	/**
	 * 导出html
	 */
	private static void exportHtml(JasperPrint jasperPrint,
			String defaultFilename, HttpServletRequest request,
			HttpServletResponse response) throws IOException, JRException {
		response.setContentType("text/html");
		ServletOutputStream ouputStream = response.getOutputStream();
		JRHtmlExporter exporter = new JRHtmlExporter();
		exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
				Boolean.FALSE);
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.CHARACTER_ENCODING, "UTF-8");
		exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);

		exporter.exportReport();

		ouputStream.flush();
		ouputStream.close();
	}

	/**
	 * 导出Word 文档
	 * 
	 * @param jasperPrint
	 * @param defaultFilename
	 * @param request
	 * @param response
	 * @throws JRException
	 * @throws IOException
	 */
	@SuppressWarnings({ "rawtypes" })
	private static void exportWord(JasperPrint jasperPrint,
			String defaultFilename, HttpServletRequest request,
			HttpServletResponse response) throws JRException, IOException {
		response.setContentType("application/msword;charset=utf-8");
		String defaultname = null;
		if (defaultFilename.trim() != null && defaultFilename != null) {
			defaultname = defaultFilename + ".doc";
		} else {
			defaultname = "export.doc";
		}
		//String fileName = new String(defaultname.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-disposition", "attachment; filename="
				+ defaultname);
		JRExporter exporter = new JRRtfExporter();
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_STREAM,
				response.getOutputStream());

		exporter.exportReport();
	}
	/** 
     * 按照类型导出不同格式文件 
     *  
     * @param datas 
     *            数据 
     * @param type 
     *            文件类型 
     * @param is 
     *            jasper文件的来源 
     * @param request 
     * @param response 
     * @param defaultFilename默认的导出文件的名称 
     */  
	public static void export(String type,String defaultFilename,String jasperName,FormMap<String, Object> parameters,DataSource dataSource, HttpServletRequest request, HttpServletResponse response) {  
           logger.debug("导出判断     The method======= export() start.......................");  
           try {  
        	InputStream in = JasperHelper.class.getResourceAsStream("/jasper/"+jasperName);
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(in);  
            //prepareReport(jasperReport, type);  
            System.out.println(request.getServletContext().getRealPath("/").replace("\\", "/")+"WEB-INF/classes/");
            parameters.set("SUBREPORT_DIR", request.getServletContext().getRealPath("/").replace("\\", "/")+"WEB-INF/classes/jasper/");
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, dataSource.getConnection());  
            String agent = (String)request.getHeader("USER-AGENT");     
            if(agent != null && agent.indexOf("Firefox") != -1) {
            // firefox      
            	defaultFilename = new String(defaultFilename.getBytes("UTF-8"),"ISO-8859-1");
            }else{
            // others
            	defaultFilename = URLEncoder.encode(defaultFilename, "UTF-8");
            }
            //defaultFilename = new String(defaultFilename.getBytes("iso-8859-1"), "utf-8");
            if (EXCEL_TYPE.equals(type)) {  
             exportExcel(jasperPrint,defaultFilename, request, response);  
            } else if (PDF_TYPE.equals(type)) {  
             exportPdf(jasperPrint,defaultFilename, request, response);  
            } else if (HTML_TYPE.equals(type)) {  
             exportHtml(jasperPrint,defaultFilename, request, response);  
            } else if (WORD_TYPE.equals(type)) {  
             exportWord(jasperPrint,defaultFilename, request, response);  
            }  
           } catch (Exception e) {  
        	   logger.error("===数据导出异常==="+e); 
           }  
          }  
	
}
