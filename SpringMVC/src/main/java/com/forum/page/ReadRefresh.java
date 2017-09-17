package com.forum.page;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ReadRefresh extends Refresh {
	public ReadRefresh(){
		super();
	}
	public String refresh(int startIndex,int endIndex,String themeId){
		String json="{\"post\":[";
		
			sqlStm="select floorUserId,floor.floorId,floorTime,floorContent,userName,userPoints from floor,themefloor,user where themeId=? and themefloor.floorId=floor.floorId and floor.floorUserId=userId order by floor.floorTime limit "+(startIndex-1)+","+(endIndex-startIndex+1);
		
		try{
		sql=con.prepareStatement(sqlStm);
		sql.setString(1,themeId);
		rs=sql.executeQuery();
		while(rs.next()){
			String floorTime=rs.getString("floorTime");
			floorTime=time.handle(floorTime);
			json+="{\"floorUserId\":\""+rs.getString("floorUserId")+"\","
					+"\"floorId\":\""+rs.getString("floorId")+"\","
					+"\"floorTime\":\""+rs.getString("floorTime")+"\","
					+"\"userName\":\""+rs.getString("userName")+"\","
					+"\"userPoints\":\""+rs.getString("userPoints")+"\","
					+"\"floorContent\":\""+rs.getString("floorContent")+"\","
					+"\"floorTime\":\""+floorTime+"\",";

			json=json.substring(0, json.length()-1);
			json+="},";
		}
		json=json.substring(0, json.length()-1);
		json+="]}";
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		return json;
	}
}


