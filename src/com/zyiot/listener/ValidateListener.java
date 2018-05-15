package com.zyiot.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.zyiot.util.PropertiesUtils;

public class ValidateListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent arg0) {

	}

	public void contextInitialized(ServletContextEvent servletContextEvent) {
		servletContextEvent.getServletContext().setAttribute(
				"needValidateClosed", "1");

		servletContextEvent.getServletContext().setAttribute("location_id",
				PropertiesUtils.findPropertiesKey("location_id"));
	}

}
