package com.forum.page;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Refresh {
	Connection con=null;
	PreparedStatement sql = null;
	ResultSet rs;
	TimeHandle time=new TimeHandle();
	String json="";
	String sqlStm = null;
	public Refresh(){
		String driver="com.mysql.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/countryforum?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		String user="root";
		String password="15869105934";
		try {
			Class.forName(driver);
			con=DriverManager.getConnection(url,user,password);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String refresh(){
		return "";
	}
}
