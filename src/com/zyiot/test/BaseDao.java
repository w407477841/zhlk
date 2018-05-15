package com.zyiot.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class BaseDao {
	Connection con = null;
	Statement s = null;
	ResultSet rs = null;

	// 得到联接
	public Connection getConnection() {
		try {
			// 加载JDBC-ODBC桥驱动程序
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");

			// 方式一 通过驱动联接
			// con = DriverManager
			// .getConnection("jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ=D:\\software\\access\\粮情监控数据.mdb; pwd=liurenkui");
			// 方式二 通过数据源与数据库建立连接
			con = DriverManager.getConnection("jdbc:odbc:lq");
			System.out.println("连接成功");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

	/**
	 * 关闭数据源
	 */
	public void CloseConnection(Connection con, ResultSet rs, Statement s) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (s != null) {
				s.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
