package com.forum.page;

import java.sql.SQLException;

public class ReadRefresh extends Refresh {
	public ReadRefresh(){
		super();
	}
	public String refresh(int startIndex,int endIndex,String themeId){
		String json="{\"post\":[";
		
			sqlStm="select floorUserId,floor.floorId,floorTime,floorContent,userName,userPoints from floor,themefloor,user where themeId=? and themefloor.floorId=floor.floorId and floor.floorUserId=userId order by floor.floorTime limit "+(startIndex-1)+","+(endIndex-startIndex+1);
		
		try{
			

			sql=con.prepareStatement("select floor.floorId from floor,themefloor where themeId=? and themefloor.floorId=floor.floorId order by  floor.floorTime  desc");
			sql.setString(1,themeId);
			rs=sql.executeQuery();

			int floorNumber;		
			System.out.println("start"+startIndex);
			System.out.println("end"+endIndex);
		sql=con.prepareStatement(sqlStm);
		sql.setString(1,themeId);
		rs=sql.executeQuery();
		while(rs.next()){
			floorNumber=Integer.parseInt(rs.getString("floorId").substring(rs.getString("floorId").indexOf(",")+1));
			int userPoints=rs.getInt("userPoints");
			PointChange point=new PointChange();
			String userTitle=point.handle(userPoints);
			String floorTime=rs.getString("floorTime");
			floorTime=FloorTime.handle(floorTime);
			json+="{\"floorUserId\":\""+rs.getString("floorUserId")+"\","
					+"\"floorId\":\""+rs.getString("floorId")+"\","
					+"\"userName\":\""+rs.getString("userName")+"\","
					+"\"floorNumber\":\""+floorNumber+"\","
					+"\"userTitle\":\""+userTitle+"\","
					+"\"floorContent\":\""+rs.getString("floorContent")+"\","
					+"\"floorTime\":\""+floorTime+"\"";
			

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


