package com.forum.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.forum.login.LoginBean;
import com.forum.page.EmailRefresh;
import com.forum.page.FloorTimeHandle;
import com.forum.page.MailRefresh;
import com.forum.page.PageRefresh;
import com.forum.page.PointChange;
import com.forum.page.ReadRefresh;
import com.forum.page.SearchRefresh;
import com.forum.page.TimeHandle;
import com.forum.page.UnreadNews;

@Controller
@Scope("session")
public class forumController {
		private String driver;
		private String url;
		private String user;
		private String password;
		private Connection con=null;
		@PostConstruct
		public void init() {
			driver="com.mysql.jdbc.Driver";
			url="jdbc:mysql://localhost:3306/countryforum?useUnicode=true&characterEncoding=utf-8&useSSL=false";
			user="root";
			password="13750984796"; 
			try {
				Class.forName(driver);
				con=DriverManager.getConnection(url,user,password);
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	
		@RequestMapping(value="/forum/{pageIndex}",method=RequestMethod.GET)
		public String threadServlet(@PathVariable("pageIndex") int pageIndex,ModelMap model,@RequestParam(value="enlighten",required=false) boolean enlighten,HttpServletRequest request){
			String json="{\"news\":[";
			PreparedStatement sql;
			if(request.getParameter("enlighten")==null){
				enlighten=false;
			}
			model.addAttribute("pageEnlighten", enlighten);
			try {
				sql=con.prepareStatement("select theme.themeId,themeName from theme,themelabel,label where theme.themeId=themelabel.themeId and label.labelId=themelabel.labelId and stick=1 and hide=1 and labelName='新闻推荐' order by themeTime desc");
				ResultSet rs=sql.executeQuery();
				while(rs.next()){
					json+="{\"themeId\":\""+rs.getString("themeId")+"\","+"\"themeName\":\""+rs.getString("themeName")+"\"},";
				}
				json=json.substring(0, json.length()-1);
				json+="]}";
				model.addAttribute("newsRecommend",json);
				json="{\"activities\":[";
				sql=con.prepareStatement("select theme.themeId,themeName from theme,themelabel,label where theme.themeId=themelabel.themeId and label.labelId=themelabel.labelId and stick=1 and hide=1 and labelName='活动推荐' order by themeTime desc");
				rs=sql.executeQuery();
				while(rs.next()){
					json+="{\"themeId\":\""+rs.getString("themeId")+"\","+"\"themeName\":\""+rs.getString("themeName")+"\"},";
				}
				json=json.substring(0, json.length()-1);
				json+="]}";
				model.addAttribute("activityRecommend",json);
				json="{\"tours\":[";
				sql=con.prepareStatement("select theme.themeId,themeName from theme,themelabel,label where theme.themeId=themelabel.themeId and label.labelId=themelabel.labelId and stick=1 and hide=1 and labelName='旅游推荐' order by themeTime desc");
				rs=sql.executeQuery();
				while(rs.next()){
					json+="{\"themeId\":\""+rs.getString("themeId")+"\","+"\"themeName\":\""+rs.getString("themeName")+"\"},";
				}
				json=json.substring(0, json.length()-1);
				json+="]}";
				model.addAttribute("tourRecommend",json);
				if(enlighten==false){
					sql=con.prepareStatement("select count(*) from theme where stick=0 and hide=1 ");
					rs=sql.executeQuery();
				}else{
					sql=con.prepareStatement("select count(*) from theme where enlighten=1 and hide=1 ");
					rs=sql.executeQuery();
				}
				if(rs.next()){
					int pageNum=0;
					if(rs.getInt(1)%4==0){
						pageNum=rs.getInt(1)/4;
					}else{
						pageNum=rs.getInt(1)/4+1;
					}
					model.addAttribute("pageNum",pageNum);
				}else{
					model.addAttribute("pageNum",1);
				}
				rs.close();
				sql.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int startIndex=4*pageIndex-3;
			int endIndex=4*pageIndex;
			PageRefresh page=new PageRefresh();
			json=page.refresh(startIndex, endIndex,enlighten);
			model.addAttribute("themeInfo",json);
			model.addAttribute("pageIndex",pageIndex);
			return "thread";
			
		}
		@RequestMapping(value="/pageContent",method=RequestMethod.POST)
		 public void pageContent(HttpServletRequest request,HttpServletResponse response){
			try {
				ResultSet rs;
				PreparedStatement sql;
				request.setCharacterEncoding("UTF-8");
				HttpSession session=request.getSession();
				LoginBean login=(LoginBean)session.getAttribute("userBean");
				UUID uuid=UUID.randomUUID();
				String theme=request.getParameter("theme");
				String themeClass=request.getParameter("themeClass");
				String themeContent=request.getParameter("postContent");
				Date now=new Date();
				SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String nowTime=dateFormat.format(now);
				String userId=login.getUserId();
				String themeId=uuid.toString().replace("-", "");
				if(theme!=null&&themeClass!=null&&themeContent!=null){
					sql=con.prepareStatement("insert into theme values (?,?,?,?,?,0,0,1)");
					sql.setString(1,themeId);
					sql.setString(2,theme);
					sql.setString(3,userId);
					sql.setString(4,themeContent);
					sql.setString(5,nowTime);
					sql.executeUpdate();
					sql=con.prepareStatement("select labelId from label where labelName=?");
					sql.setString(1, themeClass);
					rs=sql.executeQuery();
					if(rs.next()){
						themeClass=rs.getString("labelId");
					}
					sql=con.prepareStatement("insert into themelabel values(?,?)");
					sql.setString(1, themeId);
					sql.setString(2, themeClass);
					sql.executeUpdate();
					response.sendRedirect("http://localhost:8080/SpringMVC/forum/1");
					rs.close();
					sql.close();
				}
			} catch (SQLException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		@RequestMapping(value="/search",method=RequestMethod.GET)
			public String searchServlet(HttpServletRequest request,HttpServletResponse response,ModelMap model){
			ResultSet rs;
			PreparedStatement sql = null;
			SearchRefresh search=new SearchRefresh();
			String json=null;
			try{
			String searchContent=URLDecoder.decode(URLDecoder.decode(request.getParameter("searchContent"),"UTF-8"),"UTF-8");
			String searchClass=URLDecoder.decode(URLDecoder.decode(request.getParameter("searchClass"),"UTF-8"),"UTF-8");
			if(searchClass.equals("按用户搜索")){
				sql=con.prepareStatement("select * from user where userName=? or userId=?");
				sql.setString(1, searchContent);
				sql.setString(2, searchContent);
				rs=sql.executeQuery();
				if(rs.next()){
					response.sendRedirect("http://localhost:8080/SpringMVC/personal/"+rs.getString("userId"));
				}else{
					response.sendRedirect("http://localhost:8080/SpringMVC/hello");
				}
			}else{
				json=search.refresh(1, 10, searchContent, searchClass);
			}
			if(!searchClass.equals("按用户回复搜索")){
				if(searchClass.equals("按主题搜索")){
					sql=con.prepareStatement("select count(*) from theme,user where postUserId=userId and hide=1 and themeName like ?");
					sql.setString(1,"%"+searchContent+"%");
				}else if(searchClass.equals("按标签搜索")){
					sql=con.prepareStatement("select count(*) from theme,label,themelabel,user where theme.themeId=themelabel.themeId and label.labelId=themelabel.labelId and postUserId=userId and hide=1 and labelName=?");
					sql.setString(1, searchContent);
				}else if(searchClass.equals("按用户主题搜索")){
					sql=con.prepareStatement("select count(*) from theme,user where postUserId=userId and hide=1 and userId=? ");
					sql.setString(1, searchContent);
				}
				rs=sql.executeQuery();
				if(rs.next()){
					int pageNum=0;
					if(rs.getInt(1)%10==0){
						pageNum=rs.getInt(1)/10;
					}else{
						pageNum=rs.getInt(1)/10+1;
					}
					model.addAttribute("pageNum",pageNum);
				}
				model.addAttribute("themeInfo",json);
			}else{
				sql=con.prepareStatement("select count(*) from floor,user,themefloor,theme where floorUserId=userId and themefloor.floorId=floor.floorId and themefloor.themeId=theme.themeId and hide=1 and floorUserId=? UNION select count(*) from userresponse,themefloor,theme  where userresponse.floorId=themefloor.floorId and theme.themeId=themefloor.themeId and hide=1 and responseId=? ");
				sql.setString(1, searchContent);
				sql.setString(2, searchContent);
				rs=sql.executeQuery();
				int num=0;
				int pageNum=0;
				while(rs.next()){
					num+=rs.getInt(1);
				}
				if(num%10==0){
					pageNum=num/10;
				}else{
					pageNum=num/10+1;
				}
				model.addAttribute("pageNum",pageNum);
				model.addAttribute("themeInfo_1",json);
			}
			if(searchContent.equals("")){
				searchContent="全部主题";
			}
			model.addAttribute("searchContent",searchContent);
			model.addAttribute("searchClass",searchClass);
			rs.close();
			sql.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			return "search";
		}
		@RequestMapping(value="/edit",method=RequestMethod.GET)
			public String editServlet(HttpServletRequest request,HttpServletResponse response){
			HttpSession session=request.getSession();
			LoginBean login=(LoginBean)session.getAttribute("userBean");
			boolean b=login==null||login.getUserId()==null||login.getUserId().length()==0;
			try{
				if(b){
					response.sendRedirect("http://localhost:8080/SpringMVC/login");
				}else{
					UnreadNews unread=new UnreadNews();
					unread.find(login.getUserId(), session);
				}
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			return "edit";
		}
		@RequestMapping(value="/personal/{userId}",method=RequestMethod.GET)
		    public String personalServlet(@PathVariable("userId") String userId,HttpServletRequest request,HttpServletResponse response,ModelMap model){
			ResultSet rs=null;
			PreparedStatement sql = null;
			HttpSession session=request.getSession();
			LoginBean login=(LoginBean)session.getAttribute("userBean");
			boolean b=login==null||login.getUserId()==null||login.getUserId().length()==0;
			try {
				sql=con.prepareStatement("select * from user where userId=?");
				sql.setString(1, userId);
				rs=sql.executeQuery();
				if(!rs.next()){
					response.sendRedirect("http://localhost:8080/SpringMVC/hello");
				}
				rs.close();
				sql.close();
			} catch (SQLException | IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			if(userId.equals("")||userId==null){
				try {
					response.sendRedirect("http://localhost:8080/SpringMVC/login");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			try {
				sql=con.prepareStatement("select * from user where userId=?");
				sql.setString(1, userId);
				rs=sql.executeQuery();
				if(rs.next()){
					String userName="默认";
					int userPoint=0;
					String userPoints = null;
					String userRemark="";
					PointChange point=new PointChange();
					userRemark=rs.getString("userRemark");
					userName=rs.getString("userName");
					userPoint=rs.getInt("userPoints");
					userPoints=point.handle(userPoint);
					model.addAttribute("userName",userName);
					model.addAttribute("userId",userId);
					model.addAttribute("userPoint",userPoint);
					model.addAttribute("userPoints",userPoints);
					model.addAttribute("userRemark",userRemark);
					model.addAttribute("birth",rs.getString("userBirth"));
					model.addAttribute("userId",userId);
				}
				rs.close();
				sql.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(!b){
				String json;
				EmailRefresh email=new EmailRefresh();
				json=email.refresh(1, 4, login.getUserId());
				model.addAttribute("json", json);
				int num=0;
				int pageNum=0;
				try {
					sql=con.prepareStatement("select count(*) from email,user where senderId=userId and recipientId=?");
					sql.setString(1, login.getUserId());
					rs=sql.executeQuery();
					if(rs.next()){
						num=rs.getInt(1);
					}
					if(num%4==0){
						pageNum=num/4;
					}else{
						pageNum=num/4+1;
					}
					model.addAttribute("pageNum", pageNum);
					rs.close();
					sql.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				UnreadNews unread=new UnreadNews();
				unread.find(login.getUserId(), session);
			}
			return "personal";
		}
		@RequestMapping(value="/mail",method=RequestMethod.GET)
		 	public String mailServlet(HttpServletRequest request,HttpServletResponse response,ModelMap model){
			ResultSet rs;
			PreparedStatement sql = null;
			HttpSession session=request.getSession();
			LoginBean login=(LoginBean)session.getAttribute("userBean");
			boolean b=login==null||login.getUserId()==null||login.getUserId().length()==0;
			try{
				if(b){
					response.sendRedirect("http://localhost:8080/SpringMVC/login");
				}
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			String userId=login.getUserId();
			MailRefresh page=new MailRefresh();
			String json=page.refresh(1, 10, userId);
			try {
				sql=con.prepareStatement("select count(*) from theme,themefloor,floor,user where themefloor.themeId=theme.themeId and themefloor.floorId=floor.floorId and floorUserId=user.userId and hide=1 and postUserId=? UNION select count(*) from userresponse,floor,themefloor,theme,user where userresponse.floorId=floor.floorId and floor.floorId=themefloor.floorId and themefloor.themeId=theme.themeId and responseId=user.userId and hide=1 and floorUserId=?");
				sql.setString(1, userId);
				sql.setString(2, userId);
				rs=sql.executeQuery();
				int num=0;
				int pageNum=0;
				while(rs.next()){
					num+=rs.getInt(1);
				}
				if(num%10==0){
					pageNum=num/10;
				}else{
					pageNum=num/10+1;
				}
				String sqlStm="select theme.themeId,themeName,floorContent as content,floorTime as time,userName,floor.floorId as responseId,userId from theme,themefloor,floor,user where themefloor.themeId=theme.themeId and themefloor.floorId=floor.floorId and floorUserId=user.userId and hide=1 and postUserId=? "
						+ "UNION select theme.themeId,themeName,responseContent as content,responseTime as time,userName,contentId as responseId,userId from userresponse,floor,themefloor,theme,user where userresponse.floorId=floor.floorId and floor.floorId=themefloor.floorId and themefloor.themeId=theme.themeId and responseId=user.userId and hide=1 and floorUserId=? order by time desc limit 1";
				sql=con.prepareStatement(sqlStm);
				sql.setString(1, userId);
				sql.setString(2, userId);
				rs=sql.executeQuery();
				if(rs.next()){
					String unReadTime=rs.getString("time");
					sql=con.prepareStatement("update user set userReadTime = ? where userId=? ");
					sql.setString(1, unReadTime);
					sql.setString(2, userId);
					sql.executeUpdate();
				}
				UnreadNews unread=new UnreadNews();
				unread.find(userId, session);
				model.addAttribute("pageNum",pageNum);
				rs.close();
				sql.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			model.addAttribute("json", json);
			return "mail";
		}
		@RequestMapping(value="/hello",method=RequestMethod.GET)
		    public String helloServlet(){
			return "hello";
		}
		@RequestMapping(value="/read",method=RequestMethod.GET)
			public String readServlet(@RequestParam(value="id",required=true) String id,@RequestParam(value="pageIndex",required=false) String pageIndex,ModelMap model,HttpServletRequest request) throws SQLException{
			
			try {
				ResultSet rs;
				PreparedStatement sql;
				if(pageIndex==null){
					pageIndex="1";
				}
				int pageIndex1=Integer.parseInt(pageIndex);
				String themeId=id;	
			 	String json;
			 	System.out.println(pageIndex1);
			 	System.out.println(themeId);
						
			 	sql=con.prepareStatement("select floor.floorId from floor,themefloor where themeId=? and themefloor.floorId=floor.floorId order by  floor.floorTime  desc");
						sql.setString(1,themeId);
						rs=sql.executeQuery();
						rs.last();
						int totalRecoder=rs.getRow();
						rs.first();
						int pageNum=0;
						
						if(totalRecoder%5==0){
							pageNum=totalRecoder/5;
						}else{
							pageNum=totalRecoder/5+1;
						}
					
						int startIndex=5*pageIndex1-4;
						int endIndex=5*pageIndex1;
						ReadRefresh read=new ReadRefresh();
						json=read.refresh(startIndex, endIndex,themeId);
						model.addAttribute("postPage",json);
						model.addAttribute("pageIndex",pageIndex1);
						model.addAttribute("pageNum",pageNum);
					
						rs.close();
						sql.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			return "post";
		}
		@RequestMapping(value="/login",method=RequestMethod.GET)
	    public String loginServlet(){
		return "login";
	}
		@RequestMapping(value="/loginAjax",method=RequestMethod.POST)
		 public void loginAjax(HttpServletRequest request,HttpServletResponse response) throws SQLException{
			try {
				ResultSet rs = null;
				PreparedStatement sql = null;
				request.setCharacterEncoding("UTF-8");
				String password=request.getParameter("password");
				String userId=request.getParameter("userId");
				PrintWriter out = response.getWriter();
			 	StringBuffer json=new StringBuffer();
			 	String result;
				if(password!=null&&userId!=null&&password!=""&&userId!=""){
					sql=con.prepareStatement("select user.userId from user where user.userId=?");					
					sql.setString(1,userId);
					rs=sql.executeQuery();
					if(rs.next()){
					
					sql=con.prepareStatement("select user.userId,user.userName,user.userIdentity,user.userPassword,blockForbidden from user where user.userId=? and user.userPassword=?");					
					sql.setString(1,userId);
					sql.setString(2,password);
					rs=sql.executeQuery();
					if(rs.next()){
						String userName=rs.getString("userName");
						int userIdentity=rs.getInt("userIdentity");
						int blockForbidden=rs.getInt("blockForbidden");
						LoginBean login=new LoginBean();
					 	login.setUserId(userId);
					 	login.setUsername(userName);
					 	login.setPassword(password);
					 	login.setUserIdentity(userIdentity);
					 	login.setBlockForbidden(blockForbidden);
					 	HttpSession session=request.getSession();
					 	UnreadNews unread=new UnreadNews();
					 	session.setAttribute("userBean",login);
					 	unread.find(userId, session);
					 	response.setCharacterEncoding("UTF-8");	
					 	result="pass";
						json.append("{\"result\":\""+result+"\"}");
						out.print(json.toString());
						out.flush();
						out.close();
					}
					else{
						result="passfailed1";
						json.append("{\"result\":\""+result+"\"}");
						out.print(json.toString());
						out.flush();
						out.close();
					}
					
					}else{
						result="passfailed3";
						json.append("{\"result\":\""+result+"\"}");
						out.print(json.toString());
						out.flush();
						out.close();
					}

				}else{
					result="passfailed2";
					json.append("{\"result\":\""+result+"\"}");
					out.print(json.toString());
					out.flush();
					out.close();
				}
				rs.close();
				sql.close();
	
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
		@RequestMapping(value="/sign",method=RequestMethod.GET)
	    public String signServlet(){
		return "sign";
	}
		@RequestMapping(value="/signAjax",method=RequestMethod.POST)
		 public void signAjax(HttpServletRequest request,HttpServletResponse response) throws SQLException{
			try {
				ResultSet rs;
				PreparedStatement sql;
				request.setCharacterEncoding("UTF-8");
				String userId=request.getParameter("userId");
				String userName=request.getParameter("userName");
				String password=request.getParameter("password");
				String repassword=request.getParameter("repassword");
				System.out.println(userId);
				System.out.println(userName);
				System.out.println(password);
				System.out.println(repassword);
				PrintWriter out = response.getWriter();
			 	StringBuffer json=new StringBuffer();
			 	String result;
					sql=con.prepareStatement("select user.userId from user where user.userId=?");					
					sql.setString(1,userId);
					rs=sql.executeQuery();
					if(!rs.next()){		 	
						if(password.equals(repassword)){
							sql=con.prepareStatement("insert into user(userId,userName,userPassword,userIdentity,userPoints,blockForbidden) values(?,?,?,?,?,?)");
							sql.setString(1,userId);
							sql.setString(2,userName);
							sql.setString(3,password);
							sql.setInt(4,0);
							sql.setInt(5, 0);
							sql.setInt(6, 0);
							sql.executeUpdate();
							response.setCharacterEncoding("UTF-8");	
						 	result="pass";
							json.append("{\"result\":\""+result+"\"}");
							out.print(json.toString());
							out.flush();
							out.close();
						}
						else{
							result="passfailed2";
							json.append("{\"result\":\""+result+"\"}");
							out.print(json.toString());
							out.flush();
							out.close();
						}
					}
					else{
						result="passfailed1";
						json.append("{\"result\":\""+result+"\"}");
						out.print(json.toString());
						out.flush();
						out.close();
					}

					rs.close();
					sql.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
		
		
		@RequestMapping(value="/removeResponseAjax",method=RequestMethod.POST)
		 public void removeResponseAjax(HttpServletRequest request,HttpServletResponse response) throws SQLException{
			try {
				ResultSet rs = null;
				PreparedStatement sql;
				request.setCharacterEncoding("UTF-8");
				String contentId=request.getParameter("contentId");


				PrintWriter out = response.getWriter();

				sql=con.prepareStatement("delete from userresponse where contentId=?");
				sql.setString(1,contentId);
				sql.executeUpdate();
					
											
					out.print("{\"success\":true}");
					out.flush();  
					out.close(); 
						
					
					

	
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
		
		@RequestMapping(value="/removeAjax",method=RequestMethod.POST)
		 public void removeAjax(HttpServletRequest request,HttpServletResponse response) throws SQLException{
			try {
				ResultSet rs = null;
				PreparedStatement sql;
				request.setCharacterEncoding("UTF-8");
				String floorId=request.getParameter("floorId");


				PrintWriter out = response.getWriter();

				sql=con.prepareStatement("delete from themefloor where floorId=?");
				sql.setString(1,floorId);
				sql.executeUpdate();
				
				sql=con.prepareStatement("delete from userresponse where floorId=?");					
				sql.setString(1,floorId);
				sql.executeUpdate();
						
				sql=con.prepareStatement("delete from floor where floorId=?");
				sql.setString(1,floorId);
				sql.executeUpdate();
											
					out.print("{\"success\":true}");
					out.flush();  
					out.close(); 
						
					
					

	
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
		
		
		@RequestMapping(value="/banAjax",method=RequestMethod.POST)
		 public void banAjax(HttpServletRequest request,HttpServletResponse response) throws SQLException{
			try {
				ResultSet rs = null;
				PreparedStatement sql;
				request.setCharacterEncoding("UTF-8");
				String userId=request.getParameter("userId");
				PrintWriter out = response.getWriter();

				sql=con.prepareStatement("update user set blockForbidden='1' where userId=?");
				sql.setString(1,userId);
				sql.executeUpdate();
				
				rs.close();
				sql.close();
						
											
					out.print("{\"success\":true}");
					out.flush();  
					out.close(); 
						
					
					

	
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
		
		
		@RequestMapping(value="/responseInputAjax",method=RequestMethod.POST)
		 public void responseInputAjax(HttpServletRequest request,HttpServletResponse response) throws SQLException{
			try {
				ResultSet rs;
				PreparedStatement sql;
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=utf-8");
				String userId=request.getParameter("userId");
				String floorId=request.getParameter("floorId");
				String content=request.getParameter("content");
				String floorNumber=request.getParameter("floorNumber");
				
				Date now=new Date();
				SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String datetime=dateFormat.format(now);
				FloorTimeHandle floorTime=new FloorTimeHandle();
				String datetime1=floorTime.handle(datetime);

				PrintWriter out = response.getWriter();
			 	StringBuffer json=new StringBuffer();
					if(content!=""||content!=null){	
						
						sql=con.prepareStatement("select contentId from userresponse where floorId=? order by responseTime desc ");
						sql.setString(1,floorId);
						rs=sql.executeQuery();
						String number="0";
						if(rs.next()){
						String lastcontentId=rs.getString("contentId");
						number=lastcontentId.substring(lastcontentId.indexOf(",",lastcontentId.indexOf(",")+1) + 1);
						System.out.println(lastcontentId);
						}
						int number1=Integer.parseInt(number)+1;
						String contentId=floorId+","+number1;
						
						
						sql=con.prepareStatement("select userName,userPoints from user where userId=?");
						sql.setString(1,userId);
						rs=sql.executeQuery();
						rs.next();
						String userName=rs.getString("userName");
						int userPoints1=rs.getInt("userPoints")+2;
						sql=con.prepareStatement("update user set userPoints=? where userId=?");
						sql.setInt(1,userPoints1);
						sql.setString(2,userId);
						sql.executeUpdate();
						
						

						
						sql=con.prepareStatement("insert into userresponse values(?,?,?,?,?)");
						sql.setString(1,contentId);
						sql.setString(2,floorId);
						sql.setString(3,userId);
						sql.setString(4,content);
						sql.setString(5,datetime);
						sql.executeUpdate();	
						rs.close();
						sql.close();
						
						
						json.append("{\"userName\":\""+userName+"\",");
						json.append("\"userId\":\""+userId+"\",");
						json.append("\"floorId\":\""+floorId+"\",");
						json.append("\"floorNumber\":\""+floorNumber+"\",");
						json.append("\"contentId\":\""+contentId+"\",");
						json.append("\"content\":\""+content+"\",");
						json.append("\"time\":\""+datetime1+"\"}");
					out.print(json.toString());
					out.flush();  
					out.close(); 
						
					}
					

	
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
		
		
		
		@RequestMapping(value="/responseAjax",method=RequestMethod.POST)
		 public void responseAjax(HttpServletRequest request,HttpServletResponse response) throws SQLException{
			try {
				ResultSet rs;
				PreparedStatement sql;
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=utf-8");
				String userId=request.getParameter("userId");
				String themeId=request.getParameter("themeId");
				String content=request.getParameter("content");
				String floorNumber=request.getParameter("floorNumber");
				int floorNumber1=Integer.parseInt(floorNumber)+1;
				String floorNumber2 = Integer.toString(floorNumber1);
				String floorId=themeId+","+floorNumber2;
				Date now=new Date();
				SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String datetime=dateFormat.format(now);
				FloorTimeHandle floorTime=new FloorTimeHandle();
				String datetime1=floorTime.handle(datetime);
		

				PrintWriter out = response.getWriter();
			 	StringBuffer json=new StringBuffer();
					if(content!=""||content!=null){	
						
						sql=con.prepareStatement("select userName,userPoints from user where userId=?");
						sql.setString(1,userId);
						rs=sql.executeQuery();
						rs.next();
						String userName=rs.getString("userName");
						int userPoints=rs.getInt("userPoints");
						PointChange point=new PointChange();
						String userTitle=point.handle(userPoints);
						
						
						int userPoints1=userPoints+2;
						sql=con.prepareStatement("update user set userPoints=? where userId=?");
						sql.setInt(1,userPoints1);
						sql.setString(2,userId);
						sql.executeUpdate();

						
						sql=con.prepareStatement("insert into floor values(?,?,?,?)");
						sql.setString(1,floorId);
						sql.setString(2,userId);
						sql.setString(3,datetime);
						sql.setString(4,content);
						sql.executeUpdate();
						
						sql=con.prepareStatement("insert into themefloor values(?,?)");					
						sql.setString(1,themeId);
						sql.setString(2,floorId);
						sql.executeUpdate();		
						
						rs.close();
						sql.close();
						
						json.append("{\"userName\":\""+userName+"\",");
						json.append("\"userId\":\""+userId+"\",");
						json.append("\"floorNumber\":\""+floorNumber1+"\",");
						json.append("\"userTitle\":\""+userTitle+"\",");
						json.append("\"floorId\":\""+floorId+"\",");
						json.append("\"content\":\""+content+"\",");
						json.append("\"time\":\""+datetime1+"\"}");
					out.print(json.toString());
					out.flush();  
					out.close(); 
						
					}
					

	
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
		
		
		@RequestMapping(value="/responseFloorAjax",method=RequestMethod.POST)
		 public void responseFloorAjax(HttpServletRequest request,HttpServletResponse response) throws SQLException{
			try {
				ResultSet rs;
				PreparedStatement sql;
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				String floorId=request.getParameter("floorId");
				String floorNumber=request.getParameter("floorNumber");
				boolean boo=true;		
			 	StringBuffer json=new StringBuffer();
						
						sql=con.prepareStatement("select contentId,userName,responseId,responseContent,responseTime from user,userresponse where floorId=? and userresponse.responseId=user.userId order by responseTime");
						sql.setString(1,floorId);
						rs=sql.executeQuery();
						rs.last();
						int number=rs.getRow();
						rs.first();
						json.append("{\"response\":[");
						for(int i=1;i<=number&&boo;i++){
							String userName=rs.getString("userName");
							String contentId=rs.getString("contentId");
							String responseContent=rs.getString("responseContent");
							String responseId=rs.getString("responseId");
							String responseTime=rs.getString("responseTime");
							FloorTimeHandle floorTime=new FloorTimeHandle();
							String responseTime1=floorTime.handle(responseTime);
							json.append("{\"responseId\":\""+responseId+"\",");							
							json.append("\"userName\":\""+userName+"\",");
							json.append("\"contentId\":\""+contentId+"\",");
							json.append("\"responseNumber\":\""+number+"\",");
							json.append("\"floorId\":\""+floorId+"\",");
							json.append("\"floorNumber\":\""+floorNumber+"\",");
							json.append("\"responseContent\":\""+responseContent+"\",");
							json.append("\"responseTime\":\""+responseTime1+"\"},");
							
							boo=rs.next();
						}
						json.deleteCharAt(json.length() - 1);
						json.append("]}");	
						rs.close();
						sql.close();
					out.print(json.toString());
					out.flush();  
					out.close(); 
					
	
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
		
		@RequestMapping(value="/exit",method=RequestMethod.GET)
		  	public void exitServlet(HttpServletRequest request,HttpServletResponse response){
			HttpSession session=request.getSession();
			session.removeAttribute("userBean");
			session.invalidate();
			try {
				response.sendRedirect("http://localhost:8080/SpringMVC/forum/1");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		@RequestMapping(value="/exit1",method=RequestMethod.GET)
	  	public void exit1Servlet(@RequestParam(value="id",required=true) String id,@RequestParam(value="pageIndex",required=false) String pageIndex,HttpServletRequest request,HttpServletResponse response){
		HttpSession session=request.getSession();
		session.removeAttribute("userBean");
		session.invalidate();
		if(pageIndex==null){
			pageIndex="1";
		}
		int pageIndex1=Integer.parseInt(pageIndex);
		String themeId=id;
		try {
			response.sendRedirect("http://localhost:8080/SpringMVC/read?id="+themeId+"&pageIndex="+pageIndex1);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		@RequestMapping(value="/pageAjax",method=RequestMethod.POST)
		public void pageAjax(HttpServletRequest request, HttpServletResponse response){
			int pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
			String bol=request.getParameter("enlighten");
			boolean enlighten;
			if(bol.equals("true")){
				enlighten=true;
			}else{
				enlighten=false;
			}
			String json;
			int startIndex=4*(pageIndex+1)-3;
			int endIndex=4*(pageIndex+1);
			PageRefresh page=new PageRefresh();
			json=page.refresh(startIndex, endIndex,enlighten);
			response.setCharacterEncoding("UTF-8");
			try {
				PrintWriter out = response.getWriter();
				out.print(json);
				out.flush();
				out.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
		@RequestMapping(value="/searchAjax",method=RequestMethod.GET)
		public void searchAjax(HttpServletRequest request, HttpServletResponse response){
			int pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
			try {
			String searchContent=URLDecoder.decode(URLDecoder.decode(request.getParameter("searchContent"),"UTF-8"),"UTF-8");
			String searchClass=URLDecoder.decode(URLDecoder.decode(request.getParameter("searchClass"),"UTF-8"),"UTF-8");
			String json;
			int startIndex=10*(pageIndex-1)+1;
			int endIndex=10*pageIndex;
			SearchRefresh search=new SearchRefresh();
			json=search.refresh(startIndex, endIndex,searchContent,searchClass);
			response.setCharacterEncoding("UTF-8");
				PrintWriter out = response.getWriter();
				out.print(json);
				out.flush();
				out.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
	}
		@RequestMapping(value="/personalAjax",method=RequestMethod.POST)
		public void personalAjax(HttpServletRequest request, HttpServletResponse response){
			try {
				String userName=request.getParameter("userName");
				String userRemark=request.getParameter("userRemark");
				String userId=request.getParameter("userId");
				PreparedStatement sql = null;
				if(!(userName==null||userName.equals(""))){
					sql=con.prepareStatement("update user set userName=? where userId=?");
					sql.setString(1,userName);
					sql.setString(2,userId);
					sql.executeUpdate();
				}
				if(!(userRemark==null||userRemark.equals(""))){
					sql=con.prepareStatement("update user set userRemark=? where userId=?");
					sql.setString(1,userRemark);
					sql.setString(2,userId);
					sql.executeUpdate();
				}
			
				sql.close();
				response.setCharacterEncoding("UTF-8");
				PrintWriter out = response.getWriter();
				out.print("{\"success\":true}");
				out.flush();
				out.close();
			} catch (SQLException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		@RequestMapping(value="/passwordAjax",method=RequestMethod.POST)
		public void passwordAjax(HttpServletRequest request, HttpServletResponse response){
			String password=request.getParameter("newPassword");
			String userId=request.getParameter("userId");
			PreparedStatement sql = null;
			try {
				sql=con.prepareStatement("update user set userPassword=? where userId=?");
				sql.setString(1,password);
				sql.setString(2,userId);
				sql.executeUpdate();
			
				sql.close();
				response.setCharacterEncoding("UTF-8");
				PrintWriter out = response.getWriter();
				out.print("{\"success\":true}");
				out.flush();
				out.close();
			} catch (SQLException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		@RequestMapping(value="/iconAjax",method=RequestMethod.POST)
		public void iconAjax(HttpServletRequest request,HttpServletResponse response){
			HttpSession session=request.getSession();
			LoginBean login=(LoginBean)session.getAttribute("userBean");
			String userId=login.getUserId();
			String image=request.getParameter("image");
			String filePath=request.getSession().getServletContext().getRealPath("/")+"/personalIcon/"; 
		    String fileName=userId+".jpg";
			String imgFilePath = filePath+fileName;
			 // 只允许image  
	        String header ="data:image";  
	        String[] imageArr=image.split(",");  
	        if(imageArr[0].contains(header)){//是img的  
	      
	      // 去掉头部  
	        image=imageArr[1]; 
			try {
				Base64  decoder = new Base64();  
				byte[] decodedBytes = decoder.decode(image);
				File targetFile = new File(filePath);  
                if(!targetFile.exists()){    
                    targetFile.mkdirs();    
                }  
				FileOutputStream out = new FileOutputStream(imgFilePath);
				out.write(decodedBytes);
				out.close(); 
				response.setCharacterEncoding("UTF-8");
				PrintWriter out_1 = response.getWriter();
				out_1.print("{\"success\":true}");
				out_1.flush();
				out_1.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	       }
	    }
		@RequestMapping(value="/mailPageAjax",method=RequestMethod.POST)
		public void mailPageAjax(HttpServletRequest request, HttpServletResponse response){
			int pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
			String json;
			int startIndex=10*(pageIndex-1)+1;
			int endIndex=10*pageIndex;
			MailRefresh mail=new MailRefresh();
			HttpSession session=request.getSession();
			LoginBean login=(LoginBean)session.getAttribute("userBean");
			String userId=login.getUserId();
			json=mail.refresh(startIndex, endIndex, userId);
			response.setCharacterEncoding("UTF-8");
			PrintWriter out;
			try {
				out = response.getWriter();
				out.print(json);
				out.flush();
				out.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		@RequestMapping(value="/editThemeAjax",method=RequestMethod.POST)
		public void editThemeAjax(HttpServletRequest request, HttpServletResponse response){
			String editClass=request.getParameter("editClass");
			String themeId=request.getParameter("themeId");
			PreparedStatement sql = null;
			String sqlStm=null;
			if(editClass.equals("加精")){
				sqlStm="update theme set enlighten=1 where themeId=?";
			}else if(editClass.equals("置顶")){
				sqlStm="update theme set stick=1 where themeId=?";
			}else if(editClass.equals("删除")){
				sqlStm="update theme set hide=0 where themeId=?";
			}else if(editClass.equals("取消加精")){
				sqlStm="update theme set enlighten=0 where themeId=?";
			}else if(editClass.equals("取消置顶")){
				sqlStm="update theme set stick=0 where themeId=?";
			}
			try{
				sql=con.prepareStatement(sqlStm);
				sql.setString(1, themeId);
				sql.executeUpdate();
			
				sql.close();
				response.setCharacterEncoding("UTF-8");
				PrintWriter out_1 = response.getWriter();
				out_1.print("{\"success\":true}");
				out_1.flush();
				out_1.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		@RequestMapping(value="/editThemesAjax",method=RequestMethod.POST)
		public void editThemesAjax(HttpServletRequest request, HttpServletResponse response){
			String editClass=request.getParameter("editClass");
			String[] themesId=request.getParameterValues("themesId");
			PreparedStatement sql = null;
			try{
				for(int i=0;i<themesId.length;i++){
					if(editClass.equals("加精")){
						sql=con.prepareStatement("update theme set enlighten=1 where themeId=?");
						sql.setString(1, themesId[i]);
						sql.executeUpdate();
					}else if(editClass.equals("置顶")){
						sql=con.prepareStatement("update theme set stick=1 where themeId=?");
						sql.setString(1, themesId[i]);
						sql.executeUpdate();
					}else if(editClass.equals("删除")){
						sql=con.prepareStatement("update theme set hide=0 where themeId=?");
						sql.setString(1, themesId[i]);
						sql.executeUpdate();
					}else if(editClass.equals("取消加精")){
						sql=con.prepareStatement("update theme set enlighten=0 where themeId=?");
						sql.setString(1, themesId[i]);
						sql.executeUpdate();
					}
				}
			
				sql.close();
				response.setCharacterEncoding("UTF-8");
				PrintWriter out_1 = response.getWriter();
				out_1.print("{\"success\":true}");
				out_1.flush();
				out_1.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		@RequestMapping(value="/emailVaAjax",method=RequestMethod.POST)
		public void emailVaAjax(HttpServletRequest request, HttpServletResponse response){
			String user=request.getParameter("user");
			HttpSession session=request.getSession();
			LoginBean login=(LoginBean)session.getAttribute("userBean");
			String id=login.getUserId();
			String name=login.getUsername();
			ResultSet rs=null;
			PreparedStatement sql = null;
			response.setCharacterEncoding("UTF-8");
			PrintWriter out_1 = null;
			try {
				out_1 = response.getWriter();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			if(user!=null&&!(user.equals(id))&&!(user.equals(name))){
				try {
					sql=con.prepareStatement("select * from user where userId=? or userName=?");
					sql.setString(1, user);
					sql.setString(2, user);
					rs=sql.executeQuery();
					if(rs.next()){
						out_1.print("{\"success\":true}");
						out_1.flush();
						out_1.close();
					}else{
						out_1.print("{\"success\":false}");
						out_1.flush();
						out_1.close();
					}
					rs.close();
					sql.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else{
				out_1.print("{\"success\":false}");
				out_1.flush();
				out_1.close();
			}
			
			
		}
		@RequestMapping(value="/emailAjax",method=RequestMethod.POST)
		public void emailAjax(HttpServletRequest request, HttpServletResponse response){
			String senderId=request.getParameter("senderId");
			String recipient=request.getParameter("recipient");
			String content=request.getParameter("content");
			Date now=new Date();
			SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowTime=dateFormat.format(now);
			ResultSet rs=null;
			PreparedStatement sql = null;
			UUID uuid=UUID.randomUUID();
			String emailId=uuid.toString().replace("-", "");
			try {
				sql=con.prepareStatement("select * from user where userName=?");
				sql.setString(1, recipient);
				rs=sql.executeQuery();
				if(rs.next()){
					recipient=rs.getString("userId");
				}
				sql=con.prepareStatement("insert into email values (?,?,?,?,?)");
				sql.setString(1, emailId);
				sql.setString(2, senderId);
				sql.setString(3, recipient);
				sql.setString(4, content);
				sql.setString(5, nowTime);
				sql.executeUpdate();
				rs.close();
				sql.close();
				response.setCharacterEncoding("UTF-8");
				PrintWriter out_1 = response.getWriter();
				out_1.print("{\"success\":true}");
				out_1.flush();
				out_1.close();
			} catch (SQLException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		@RequestMapping(value="/emailPageAjax",method=RequestMethod.POST)
		public void emailPageAjax(HttpServletRequest request, HttpServletResponse response){
			int pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
			HttpSession session=request.getSession();
			LoginBean login=(LoginBean) session.getAttribute("userBean");
			String json;
			int startIndex=4*pageIndex-3;
			int endIndex=4*pageIndex;
			EmailRefresh email=new EmailRefresh();
			json=email.refresh(startIndex, endIndex, login.getUserId());
			response.setCharacterEncoding("UTF-8");
			try {
				PrintWriter out = response.getWriter();
				out.print(json);
				out.flush();
				out.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
		@RequestMapping(value="/emailDeleteAjax",method=RequestMethod.POST)
		public void emailDeleteAjax(HttpServletRequest request, HttpServletResponse response){
			String emailId=request.getParameter("emailId");
			PreparedStatement sql;
			try {
				sql=con.prepareStatement("delete from email where emailId=?");
				sql.setString(1, emailId);
				sql.executeUpdate();
			
				sql.close();
				response.setCharacterEncoding("UTF-8");
				PrintWriter out_1 = response.getWriter();
				out_1.print("{\"success\":true}");
				out_1.flush();
				out_1.close();
			} catch (SQLException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
}
