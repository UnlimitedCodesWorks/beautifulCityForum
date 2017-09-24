package com.forum.page;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SearchRefresh extends Refresh{
	public SearchRefresh(){
		super();
	}
	public String refresh(int startIndex,int endIndex,String searchContent,String searchClass){
		if(!searchClass.equals("按用户回复搜索")){
			try{
			json="{\"themes\":[";
			if(searchClass.equals("按主题搜索")){
				sqlStm="select * from theme,user where postUserId=userId and hide=1 and themeName like ? order by themeTime desc limit "+(startIndex-1)+","+(endIndex-startIndex+1);
				sql=con.prepareStatement(sqlStm);
				sql.setString(1,"%"+searchContent+"%");
			}else if(searchClass.equals("按标签搜索")){
				sqlStm="select theme.themeId,themeTime,themeName,userName,enlighten,userId,accept,recommend from theme,label,themelabel,user where theme.themeId=themelabel.themeId and label.labelId=themelabel.labelId and postUserId=userId and hide=1 and labelName=? order by themeTime desc limit "+(startIndex-1)+","+(endIndex-startIndex+1);
				sql=con.prepareStatement(sqlStm);
				sql.setString(1,searchContent);
			}else if(searchClass.equals("按用户主题搜索")){
				sqlStm="select * from theme,user where postUserId=userId and hide=1 and userId=? order by themeTime desc limit "+(startIndex-1)+","+(endIndex-startIndex+1);
				sql=con.prepareStatement(sqlStm);
				sql.setString(1,searchContent);
			}
			rs=sql.executeQuery();
			while(rs.next()){
				String themeTime=rs.getString("themeTime");
				themeTime=time.handle(themeTime);
				json+="{\"themeId\":\""+rs.getString("themeId")+"\","
						+"\"themeName\":\""+rs.getString("themeName")+"\","
						+"\"userId\":\""+rs.getString("userId")+"\","
						+"\"userName\":\""+rs.getString("userName")+"\","
						+"\"themeTime\":\""+themeTime+"\","
						+"\"enlighten\":\""+rs.getInt("enlighten")+"\","
						+"\"accept\":\""+rs.getInt("accept")+"\","
						+"\"recommend\":\""+rs.getInt("recommend")+"\",";
				sql=con.prepareStatement("select count(*) as reply from themefloor where themeId=?");
				sql.setString(1, rs.getString("themeId"));
				ResultSet rs_1=sql.executeQuery();
				if(rs_1.next()){
					json+="\"reply\":\""+rs_1.getInt(1)+"\",";
				}else{
					json+="\"reply\":\"0\",";
				}
				sql=con.prepareStatement("select floorTime,userName,user.userId from themefloor,theme,floor,user where theme.themeId=themefloor.themeId and floor.floorId=themefloor.floorId and floorUserId=user.userId and themefloor.themeId=? order by floorTime desc");
				sql.setString(1, rs.getString("themeId"));
				rs_1=sql.executeQuery();
				if(rs_1.next()){
					String floorTime=rs_1.getString("floorTime");
					floorTime=time.handle(floorTime);
					json+="\"floorTime\":\""+floorTime+"\",";
					json+="\"floorId\":\""+rs_1.getString("userId")+"\",";
					json+="\"floorName\":\""+rs_1.getString("userName")+"\",";
				}else{
					json+="\"floorTime\":\""+themeTime+"\",";
					json+="\"floorId\":\""+rs.getString("userId")+"\",";
					json+="\"floorName\":\""+rs.getString("userName")+"\",";
				}
				sql=con.prepareStatement("select labelName from theme,themelabel,label where theme.themeId=themelabel.themeId and label.labelId=themelabel.labelId and theme.themeId=?");
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
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}else{
			try{
				json="{\"themes\":[";
				sqlStm="select floor.floorId as replyId,floorContent as content,floorTime as time,theme.themeId,themeTime,postUserId from floor,user,themefloor,theme where floorUserId=userId and themefloor.floorId=floor.floorId and themefloor.themeId=theme.themeId and hide=1 and floorUserId=? "
						+"UNION "+"select contentId as replyId,responseContent as content,responseTime as time,theme.themeId,themeTime,postUserId from userresponse,themefloor,theme  where userresponse.floorId=themefloor.floorId and theme.themeId=themefloor.themeId and hide=1 and responseId=? order by time desc limit "+(startIndex-1)+","+(endIndex-startIndex+1);
				sql=con.prepareStatement(sqlStm);
				sql.setString(1, searchContent);
				sql.setString(2, searchContent);
				rs=sql.executeQuery();
				while(rs.next()){
					String themeTime=rs.getString("themeTime");
					themeTime=time.handle(themeTime);
					String userName_1 = null;
					json+="{\"themeId\":\""+rs.getString("themeId")+"\","
							+"\"content\":\""+rs.getString("content")+"\","
							+"\"replyId\":\""+rs.getString("replyId")+"\","
							+"\"postUserId\":\""+rs.getString("postUserId")+"\","
							+"\"themeTime\":\""+themeTime+"\",";
					sql=con.prepareStatement("select * from user where userId=?");
					sql.setString(1, rs.getString("postUserId"));
					ResultSet rs_1=sql.executeQuery();
					if(rs_1.next()){
						json+="\"userName\":\""+rs_1.getString("userName")+"\",";
						userName_1=rs_1.getString("userName");
					}
					sql=con.prepareStatement("select count(*) as reply from themefloor where themeId=?");
					sql.setString(1, rs.getString("themeId"));
					rs_1=sql.executeQuery();
					if(rs_1.next()){
						json+="\"reply\":\""+rs_1.getInt(1)+"\",";
					}else{
						json+="\"reply\":\"0\",";
					}
					sql=con.prepareStatement("select floorTime,userName,user.userId from themefloor,theme,floor,user where theme.themeId=themefloor.themeId and floor.floorId=themefloor.floorId and floorUserId=user.userId and themefloor.themeId=? order by floorTime desc");
					sql.setString(1, rs.getString("themeId"));
					rs_1=sql.executeQuery();
					if(rs_1.next()){
						String floorTime=rs_1.getString("floorTime");
						floorTime=time.handle(floorTime);
						json+="\"floorTime\":\""+floorTime+"\",";
						json+="\"floorId\":\""+rs_1.getString("userId")+"\",";
						json+="\"floorName\":\""+rs_1.getString("userName")+"\"},";
					}else{
						json+="\"floorTime\":\""+themeTime+"\",";
						json+="\"floorId\":\""+rs.getString("postUserId")+"\",";
						json+="\"floorName\":\""+userName_1+"\"},";
					}
				}
				json=json.substring(0, json.length()-1);
				json+="]}";
				con.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		return json;
	}
}


