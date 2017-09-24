package com.forum.page;

import java.sql.ResultSet;

public class MailRefresh extends Refresh {
	public MailRefresh(){
		super();
	}
	public String refresh(int startIndex,int endIndex,String userId){
		ResultSet rs_1;
		String json="{\"themes\":[";
		String sqlStm="select theme.themeId,themeName,floorContent as content,floorTime as time,userName,floor.floorId as responseId,userId from theme,themefloor,floor,user where themefloor.themeId=theme.themeId and themefloor.floorId=floor.floorId and floorUserId=user.userId and hide=1 and postUserId=? "
				+ "UNION select theme.themeId,themeName,responseContent as content,responseTime as time,userName,contentId as responseId,userId from userresponse,floor,themefloor,theme,user where userresponse.floorId=floor.floorId and floor.floorId=themefloor.floorId and themefloor.themeId=theme.themeId and responseId=user.userId and hide=1 and floorUserId=? order by time desc limit "+(startIndex-1)+","+(endIndex-startIndex+1);
		try{
			sql=con.prepareStatement(sqlStm);
			sql.setString(1, userId);
			sql.setString(2, userId);
			rs=sql.executeQuery();
			while(rs.next()){
				String themeTime=rs.getString("time");
				themeTime=time.handle(themeTime);
				json+="{\"themeId\":\""+rs.getString("themeId")+"\","
						+"\"themeName\":\""+rs.getString("themeName")+"\","
						+"\"userId\":\""+rs.getString("userId")+"\","
						+"\"userName\":\""+rs.getString("userName")+"\","
						+"\"themeTime\":\""+themeTime+"\","
						+"\"content\":\""+rs.getString("content")+"\","
						+"\"responseId\":\""+rs.getString("responseId")+"\",";
				sql=con.prepareStatement("select labelName from theme,themelabel,label where theme.themeId=themelabel.themeId and label.labelId=themelabel.labelId and hide=1 and theme.themeId=?");
				sql.setString(1, rs.getString("themeId"));
				rs_1=sql.executeQuery();
				json+="\"label\":[";
				while(rs_1.next()){
					json+="\"";
					json+=rs_1.getString("labelName");
					json+="\",";
				}
				json=json.substring(0, json.length()-1);
				json+="]},";
			}
			json=json.substring(0, json.length()-1);
			json+="]}";
			con.close();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return json;
	}
}
