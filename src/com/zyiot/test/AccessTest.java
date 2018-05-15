package com.zyiot.test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class AccessTest extends BaseDao {
	Connection con = null;
	Statement s = null;
	ResultSet rs = null;

	/**
	 * 执行查询
	 */
	public void seach() {
		try {
			con = getConnection();
			s = con.createStatement();// 创建SQL语句对象

			rs = s.executeQuery("select * from  温度采集值 "); // 查询员工信息
			while (rs.next()) {
				System.out.println(rs.getObject(1));
			}
			System.out.println("__________执行完毕___________ ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			CloseConnection(con, rs, s);
		}
	}

	public static void main(String[] args) {

		AccessTest t = new AccessTest();
		t.seach();

	}
}
