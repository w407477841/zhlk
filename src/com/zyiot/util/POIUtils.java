package com.zyiot.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.zyiot.annotation.BatchSaveColumns;

/**
 * 读写EXCEL文件
 */
public class POIUtils {
	public static int GUDINGZICHAN_START_ROWNUM=1;
	public static int TIAOBO_START_ROWNUM=1;
	/**
	 * @author lijianning
	 * Email：mmm333zzz520@163.com
	 * date：2015-11-11
	 * @param exportData 列表头
	 * @param lis 数据集
	 * @param fileName 文件名
	 * 
	 */
	public static void exportToExcel(HttpServletResponse response, List<Map<String, Object>> exportData, List<?> lis,
			String fileName) {
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			ExcelUtil.createWorkBook(exportData, lis).write(os);
			byte[] content = os.toByteArray();
			InputStream is = new ByteArrayInputStream(content);
			// 设置response参数，可以打开下载页面
			response.reset();
			response.setContentType("application/vnd.ms-excel;charset=utf-8");
			response.setHeader("Content-Disposition",
					"attachment;filename=" + new String((fileName + ".xls").getBytes(), "iso-8859-1"));
			ServletOutputStream out = response.getOutputStream();
			bis = new BufferedInputStream(is);
			bos = new BufferedOutputStream(out);
			byte[] buff = new byte[2048];
			int bytesRead;
			// Simple read/write loop.
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
				try {
					if (bis != null)
					bis.close();
					if (bos != null)
						bos.close();
				} catch (IOException e) {
				}
			
		}
	}
	/**
	 * 返回String
	 * @param cell
	 * @return
	 */
	 public static String getCellStringValue(HSSFCell cell) {    
	        String cellValue = "";  
	        if(cell==null) return "";
	        switch (cell.getCellType()) {    
	        case HSSFCell.CELL_TYPE_STRING:   // 字符串类型
	            cellValue = cell.getStringCellValue();    
	            if(cellValue.trim().equals("")||cellValue.trim().length()<=0)    
	                cellValue=" ";    
	            break;    
	        case HSSFCell.CELL_TYPE_NUMERIC: // 数值类型
	            cellValue = String.valueOf(cell.getNumericCellValue());    
	            break;    
	        case HSSFCell.CELL_TYPE_FORMULA: // 公式
	            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);    
	            cellValue = String.valueOf(cell.getNumericCellValue());    
	            break;    
	        case HSSFCell.CELL_TYPE_BLANK:    
	            cellValue=" ";    
	            break;    
	        case HSSFCell.CELL_TYPE_BOOLEAN:    
	            break;    
	        case HSSFCell.CELL_TYPE_ERROR:    
	            break;    
	        default:    
	            break;    
	        }    
	        return cellValue;    
	    }
	/**
	 * 
	 * @param columns 需要迭代字段
	 * @param startnum 开始行号
	 * @param ips InputStream
	 * @param clazz  
	 * @param column 例外字段   需要额外添加的字段值都一样
	 * @param columnList  需要额外添加的例外字段值不一样  ps:暂时未实现
	 * @return
	 * @throws IOException
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
public static <E> List<E>
getList(InputStream ips ,E clazz,HashMap<String,Object> column,List<HashMap<String,Object>> coulumnList ) throws IOException, InstantiationException, IllegalAccessException,NullPointerException,Exception{
	boolean flag = clazz.getClass().isAnnotationPresent(BatchSaveColumns.class);
	if(!flag){
		throw new Exception("["+clazz.getClass().getName()+"]不存在@BatchSaveColumns");	
	} 
	BatchSaveColumns anno=clazz.getClass().getAnnotation(BatchSaveColumns.class);
	String[] columns =anno.columns();
	int startnum=anno.startColumn();
	
	HSSFWorkbook wb = new HSSFWorkbook(ips);
	 HSSFSheet sheet = wb.getSheetAt(0);
	 int rowcount = sheet.getLastRowNum();  
	
	 List<E> list=new ArrayList<E>();
	 for(int i=startnum;i<=rowcount;i++){
		 HSSFRow row = sheet.getRow(i); 
		 if(row==null||
				 row.getCell(1)==null||
				 "".equals(POIUtils.getCellStringValue(row.getCell(1)).trim())) continue;
		 
		 
		 //E fm= (E) clazz.getClass().newInstance();
		 FormMap<String ,Object> fm=(FormMap<String, Object>) clazz.getClass().newInstance();
		 for(int j=0;j<columns.length;j++){
			 HSSFCell cell= row.getCell(j);
			 fm.put(columns[j],POIUtils.getCellStringValue(cell));
		 }
		 if(column!=null){
		 for(Map.Entry<String,Object> m:column.entrySet()){
		 fm.put(m.getKey(),m.getValue());
		 }}
		 list.add((E)fm);
		 }
	return (List<E>) list;
	}

}