package com.zyiot.controller;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.github.pagehelper.PageInfo;
import com.zyiot.util.Common;
import com.zyiot.util.FormMap;
import com.zyiot.util.MyPage;


public class BaseController {
	
	protected static final String ERROR="error";
	protected static final String SUCCESS="success";
	/**
	 * 封装对象前台表单中设置对象名  如：name="resFormMap.name"
	 * @param clazz
	 * @return
	 */
	public <T> T getFormMap(Class<T> clazz){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();  
		Enumeration<String> en = request.getParameterNames();
		T t = null;
		try {
			t = clazz.newInstance();
			@SuppressWarnings("unchecked")
			FormMap<String, Object> map = (FormMap<String, Object>) t;
			String order = "",sort="";
			while (en.hasMoreElements()) {
				String nms = en.nextElement().toString();
				if(nms.endsWith("[]")){
					String[] as = request.getParameterValues(nms);
					if(as!=null&&as.length!=0&&as.toString()!="[]"){
						String mname = t.getClass().getSimpleName().toUpperCase();
						if(nms.toUpperCase().startsWith(mname)){
							nms=nms.substring(nms.toUpperCase().indexOf(mname)+1);
							map.put( nms,as);
						}
					}
				}else{
					String as = request.getParameter(nms);
					if(!Common.isEmpty(as)){
						String mname = t.getClass().getSimpleName().toUpperCase();
						if(nms.toUpperCase().startsWith(mname)){
							nms=nms.substring(mname.length()+1);
							map.put( nms, as);
						}
						if(nms.toLowerCase().equals("order"))order = as;
						if(nms.toLowerCase().equals("sort"))sort = as;
					}else{
						String mname = t.getClass().getSimpleName().toUpperCase();
						if(nms.toUpperCase().startsWith(mname)){
							nms=nms.substring(mname.length()+1);
							map.put( nms, null);
						}
					}
				}
			}
			if(!Common.isEmpty(order) && !Common.isEmpty(sort)){
				String orders[] =order.split(",");
				String sorts[]=sort.split(",");
				String orderby="";
				for(int i=0;i<orders.length;i++){
					orderby+=sorts[i]+" "+orders[i]+",";
				}
				orderby=orderby.substring(0, orderby.length()-1);
				
				map.put("orderby", " order by " + orderby);
				}
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return  t;
	}
	/**
	 * 
	 * 封装对象，前台表单中未设置对象名 如 ：name="name"
	 */
	public <T> T getFormMapNoName(Class<T> clazz){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();  
		Enumeration<String> en = request.getParameterNames();
		T t = null;
		try {
			t = clazz.newInstance();
			@SuppressWarnings("unchecked")
			FormMap<String, Object> map = (FormMap<String, Object>) t;
			String order = "",sort="";
			while (en.hasMoreElements()) {
				String nms = en.nextElement().toString();
				if(!nms.startsWith("_")){
					
				
				if(nms.endsWith("[]")){
					String[] as = request.getParameterValues(nms);
				
							map.put( nms,as);
					
					
				}else{
					String as = request.getParameter(nms);
				
							if(as!=null){
							map.put( nms, as);

						if(nms.toLowerCase().equals("column"))order = as;
						if(nms.toLowerCase().equals("sort"))sort = as;
							}
				}}
			}
			if(!Common.isEmpty(order) && !Common.isEmpty(sort))
				map.put("orderby", " order by " + order + " " + sort);
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return  t;
	}
	
	/**
	 * 专门给修改用的，如有些值特意修改成''
	 * @param clazz
	 * @return
	 */
	public <T> T getFormMap2Edit(Class<T> clazz){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();  
		Enumeration<String> en = request.getParameterNames();
		T t = null;
		try {
			t = clazz.newInstance();
			@SuppressWarnings("unchecked")
			FormMap<String, Object> map = (FormMap<String, Object>) t;
			while (en.hasMoreElements()) {
				String nms = en.nextElement().toString();
				if(nms.endsWith("[]")){
					String[] as = request.getParameterValues(nms);
						String mname = t.getClass().getSimpleName().toUpperCase();
						if(nms.toUpperCase().startsWith(mname)){
							nms=nms.substring(nms.toUpperCase().indexOf(mname)+1);
							map.put( nms,as);
					}
				}else{
					String as = request.getParameter(nms);
						String mname = t.getClass().getSimpleName().toUpperCase();
						if(nms.toUpperCase().startsWith(mname)){
							nms=nms.substring(mname.length()+1);
							map.put( nms, as);
						}
					}
			}
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return  t;
	}
	
	/**
	 * 获取页面传递的某一个参数值,
	 */
	public String getPara(String key){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();  
		return request.getParameter(key);
	}
	
	public HttpServletRequest getHttpServletRequest(){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();  
		return request;
	}
	
	/**
	 * 获取页面传递的某一个数组值,
	 */
	public String[] getParaValues(String key){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();  
		if(request.getParameterValues(key)==null) return request.getParameterValues(key+"[]");
		return request.getParameterValues(key);
	}
/**
 * 将结果封装成自定义page类 
 */
	public <T> MyPage<T> toMyPage(List<T> l){
		PageInfo<T> ret=new PageInfo<T>(l);
		MyPage<T> retpage=new MyPage<T>();
		retpage.setRows(ret.getList());
		retpage.setTotal(ret.getTotal());
		retpage.setPageSize(ret.getPageSize());
		retpage.setPageNum(ret.getPageNum());
		return retpage;
	}
	
}
