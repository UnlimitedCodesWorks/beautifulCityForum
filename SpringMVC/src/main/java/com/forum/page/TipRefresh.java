package com.forum.page;

import java.sql.SQLException;

public class TipRefresh extends Refresh {
	public TipRefresh(){
		super();
	}
	
	public String refresh(int startIndex,int endIndex,String userId){
		String json="{\"tips\":[";
		try {
			sql=con.prepareStatement("select * from tip,theme where tip.themeId=theme.themeId and userId=? order by time desc limit "+(startIndex-1)+","+(endIndex-startIndex+1));
			sql.setString(1, userId);
			rs=sql.executeQuery();
			while(rs.next()){
				json+="{\"themeId\":\""+rs.getString("theme.themeId")+"\","
						+"\"themeName\":\""+rs.getString("themeName")+"\","
						+"\"time\":\""+rs.getString("time")+"\","
						+"\"type\":\""+rs.getString("type")+"\"," 
						+"\"tipId\":\""+rs.getString("tipId")+"\"},";					
			}
			json=json.substring(0, json.length()-1);
			json+="]}";
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}
}
