package com.zyiot.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;

import com.zyiot.util.FormMap;
import com.zyiot.util.PropertiesUtils;

public class InitPropListener implements ServletContextListener {
	Logger logger = Logger.getLogger(InitPropListener.class);

	public void contextDestroyed(ServletContextEvent arg0) {

	}

	public void contextInitialized(ServletContextEvent arg0) {
		String appName = PropertiesUtils.getProperties().getProperty("appName");
		// 项目名称
		String appNameWidth = PropertiesUtils.getProperties().getProperty(
				"appNameWidth");
		// 项目名称长度

		String WS_IP = PropertiesUtils.getPropertyByName(
				"webservice.properties").getProperty("WS_IP");
		String WS_PORT = PropertiesUtils.getPropertyByName(
				"webservice.properties").getProperty("WS_PORT");

		String lhq = PropertiesUtils
				.getPropertyByName("qitibaojing.properties").getProperty("lhq");
		String yq = PropertiesUtils.getPropertyByName("qitibaojing.properties")
				.getProperty("yq");
		String eyht = PropertiesUtils.getPropertyByName(
				"qitibaojing.properties").getProperty("eyht");
		String cwlhq = PropertiesUtils.getPropertyByName(
				"qitibaojing.properties").getProperty("cwlhq");

		FormMap<String, Object> f = new FormMap<>();
		f.put("appName", appName);
		f.put("appNameWidth", appNameWidth);
		f.put("WS_IP", WS_IP);
		f.put("WS_PORT", WS_PORT);
		f.put("lhq", lhq);
		f.put("cwlhq", cwlhq);
		f.put("yq", yq);
		f.put("eyht", eyht);
		arg0.getServletContext().setAttribute("prop", f);
	}
}
