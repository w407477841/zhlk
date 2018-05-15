package com.zyiot.listener;

import java.io.IOException;
import java.net.ServerSocket;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.zyiot.util.PropertiesUtils;
import com.zyiot.util.ServerSocketConnection;

public class SocketStartListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent arg0) {

	}

	public void contextInitialized(ServletContextEvent arg0) {
		String open = PropertiesUtils.getPropertyByName("socket.properties")
				.getProperty("open");
		int iPort = 10001;
		if (open != null && open.equals("1")) { // 开启socket
			ServletContext sc = arg0.getServletContext();
			try {
				String port = PropertiesUtils.getPropertyByName(
						"socket.properties").getProperty("sever_port");
				if (port != null && !port.equals("")) {
					iPort = Integer.parseInt(port);
				}
				ServerSocket server = new ServerSocket(iPort);
				Mythread my = new Mythread(sc, server);
				my.start();
				System.out.println("===socket已启动===");
			} catch (IOException e) {
				System.out.println("=======socket启动异常，可能端口【" + iPort
						+ "】被占用======");
			}
		} else {
			System.out.println("===socket未启动，如需开启，请设置参数===");
		}
	}
}

class Mythread extends Thread {
	private ServletContext sc;
	private ServerSocket server;

	public Mythread(ServletContext sc, ServerSocket server) {
		this.sc = sc;
		this.server = server;
	}

	public void run() {
		try {
			while (true) {
				ServerSocketConnection ssc;
				ssc = new ServerSocketConnection(server.accept(), sc);

				ssc.start();
			}
		} catch (IOException e) {
		}
	}
}
