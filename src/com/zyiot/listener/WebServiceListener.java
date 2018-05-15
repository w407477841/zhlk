package com.zyiot.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.xml.ws.Endpoint;

import com.zyiot.util.PropertiesUtils;
import com.zyiot.webservice.impl.GrainPlatformImpl;

public class WebServiceListener implements ServletContextListener {
	private static String WS_IP;
	private static String WS_PORT;
	static {
		WS_IP = PropertiesUtils.getPropertyByName("").getProperty("WS_IP");
		WS_PORT = PropertiesUtils.getPropertyByName("").getProperty("WS_PORT");
	}

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {

	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		WS_IP = PropertiesUtils.getPropertyByName("webservice.properties")
				.getProperty("WS_IP");
		WS_PORT = PropertiesUtils.getPropertyByName("webservice.properties")
				.getProperty("WS_PORT");
		// WebService的发布地址
		String address = "http://" + WS_IP + ":" + WS_PORT
				+ "/WS/GrainPlatform";
		// 发布WebService，WebServiceImpl类是WebServie接口的具体实现类
		Endpoint.publish(address,
				new GrainPlatformImpl(arg0.getServletContext()));
		System.out.println("使用WebServicePublishListener发布webservice成功!");

	}
}
