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
			

			int floorNumber;		
		sql=con.prepareStatement(sqlStm);
		sql.setString(1,themeId);
		rs=sql.executeQuery();
		if(rs.next()){
			rs.beforeFirst();
		while(rs.next()){
			floorNumber=Integer.parseInt(rs.getString("floorId").substring(rs.getString("floorId").indexOf(",")+1));
			int userPoints=rs.getInt("userPoints");
			PointChange point=new PointChange();
			String userTitle=point.handle(userPoints);
			String floorTime=rs.getString("floorTime");
			floorTime=FloorTime.handle(floorTime);
			LevelHandle level=new LevelHandle();
			int userLevel=level.handle(userPoints);
			
			sql=con.prepareStatement("select contentId from userresponse where floorId=?");
			sql.setString(1,rs.getString("floorId"));
			ResultSet rs1 = sql.executeQuery();
			rs1.last();
			int responseNumber=rs1.getRow();
			System.out.println("response"+responseNumber);
			json+="{\"floorUserId\":\""+rs.getString("floorUserId")+"\","
					+"\"floorId\":\""+rs.getString("floorId")+"\","
					+"\"userName\":\""+rs.getString("userName")+"\","
					+"\"floorNumber\":\""+floorNumber+"\","
					+"\"responseNumber\":\""+responseNumber+"\","
					+"\"userTitle\":\""+userTitle+"\","
					+"\"userLevel\":\""+userLevel+"\","
					+"\"floorContent\":\""+rs.getString("floorContent")+"\","
					+"\"floorTime\":\""+floorTime+"\"";
			

			json+="},";
		}
		json=json.substring(0, json.length()-1);
		json+="]}";}
		
		else{
			json="blank";
		}
		con.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		return json;
	}
}


