package com.forum.page;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PageRefresh extends Refresh {
	public PageRefresh(){
		super();
	}
	public String refresh(int startIndex,int endIndex,boolean bol){
		String json="{\"themes\":[";
		if(bol==false){
			sqlStm="select * from theme,user where postUserId=userId and stick=0 and hide=1 order by themeTime desc limit "+(startIndex-1)+","+(endIndex-startIndex+1);
		}else{
			sqlStm="select * from theme,user where postUserId=userId and enlighten=1 and hide=1 order by themeTime desc limit "+(startIndex-1)+","+(endIndex-startIndex+1);
		}
		
		try{
		sql=con.prepareStatement(sqlStm);
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
		return json;
	}
}


