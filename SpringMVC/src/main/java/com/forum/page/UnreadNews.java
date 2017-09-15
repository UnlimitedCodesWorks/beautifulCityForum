package com.forum.page;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import com.forum.login.LoginBean;

public class UnreadNews {
	Connection con=null;
	public UnreadNews(){
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
	
	public int find(String userId,HttpSession session){
		LoginBean login=(LoginBean)session.getAttribute("userBean");
		PreparedStatement sql = null;
		ResultSet rs=null;
		String time="";
		int unreadNum=0;
		try {
			sql=con.prepareStatement("select * from user where userId=?");
			sql.setString(1, userId);
			rs=sql.executeQuery();
			if(rs.next()){
				time=rs.getString("userReadTime");
				if(time==null){
					time="0";
				}
			}
			String sqlStm="select count(*) from theme,themefloor,floor,user "
					+ "where themefloor.themeId=theme.themeId and themefloor.floorId=floor.floorId and floorUserId=user.userId and hide=1 and postUserId=? and floorTime>? "
					+ "UNION select count(*) from userresponse,floor,themefloor,theme,user where userresponse.floorId=floor.floorId and floor.floorId=themefloor.floorId "
					+ "and themefloor.themeId=theme.themeId and responseId=user.userId and hide=1 and floorUserId=? and responseTime>? ";
			sql=con.prepareStatement(sqlStm);
			sql.setString(1, userId);
			sql.setString(2, time);
			sql.setString(3, userId);
			sql.setString(4, time);
			rs=sql.executeQuery();
			while(rs.next()){
				unreadNum+=rs.getInt(1);
			}
			login.setUnreadNews(unreadNum);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return unreadNum;
	}
}
