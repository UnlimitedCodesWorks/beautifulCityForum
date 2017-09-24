package com.forum.page;

public class EmailRefresh extends Refresh {
	public EmailRefresh(){
		super();
	}
	
	public String refresh(int startIndex,int endIndex,String userId){
		String json="{\"emails\":[";
		String sqlStm="select * from email,user where senderId=userId and recipientId=? order by time desc limit "+(startIndex-1)+","+(endIndex-startIndex+1);
		try{
			sql=con.prepareStatement(sqlStm);
			sql.setString(1, userId);
			rs=sql.executeQuery();
			while(rs.next()){
				json+="{\"senderId\":\""+rs.getString("senderId")+"\","
						+"\"emailId\":\""+rs.getString("emailId")+"\","
						+"\"senderName\":\""+rs.getString("userName")+"\","
						+"\"content\":\""+rs.getString("content")+"\","
						+"\"time\":\""+time.handle(rs.getString("time"))+"\"},";		
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
