<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.sun.rowset.*" %>
<jsp:useBean id="userBean" class="com.forum.login.LoginBean" scope="session"/>
<%	 
	boolean b=userBean==null||userBean.getUserId()==null||userBean.getUserId().length()==0;
	String mail="通知";
	String personal="个人中心";
	if(!b){
		mail=userBean.getUsername()+"的通知";
		personal=userBean.getUserId()+"的个人中心";
	}
      String path = request.getContextPath();
      String basePath = request.getScheme() + "://"
                  + request.getServerName() + ":" + request.getServerPort()
                  + path + "/";
%>
<%
	String themeId=request.getParameter("id");
	Connection con=null;
	PreparedStatement sql;
	ResultSet rs;
	String driver="com.mysql.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/countryforum?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		String user="root";
		String password="13750984796";
		try {
			Class.forName(driver);
			con=DriverManager.getConnection(url,user,password);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		sql=con.prepareStatement("select themeId,themeName,postUserId,themeTime,content from theme where themeId=?");
		sql.setString(1,themeId);
		rs=sql.executeQuery();
		rs.next();
		String themeName=rs.getString("themeName");
		String themeTime=rs.getString("themeTime");
		String postUserId=rs.getString("postUserId");
		String content=rs.getString("content");
		
		
		
		String lastFloorId="1";
		sql=con.prepareStatement("select floor.floorId from floor,themefloor where themeId=? and themefloor.floorId=floor.floorId order by  floor.floorTime  desc");
		sql.setString(1,themeId);
		rs=sql.executeQuery();
		if(rs.next()){
		lastFloorId=rs.getString("floorId");}
		System.out.println(lastFloorId);
		
		
		
		sql=con.prepareStatement("select userName,userPoints from user where userId=?");
		sql.setString(1,postUserId);
		rs=sql.executeQuery();
		rs.next();
		String userName=rs.getString("userName");
		int userPoints1=rs.getInt("userPoints");
		String title1 = null;
		if(userPoints1<5){
			title1="山清水秀";
		}else if(userPoints1>=5&&userPoints1<15){
			title1="湖光山色";
		}else if(userPoints1>=15&&userPoints1<30){
			title1="沂水春风";
		}else if(userPoints1>=30&&userPoints1<50){
			title1="渊渟岳峙";
		}else if(userPoints1>=50&&userPoints1<100){
			title1="钟灵毓秀";
		}else if(userPoints1>=100&&userPoints1<200){
			title1="高山流水";
		}else if(userPoints1>=200&&userPoints1<500){
			title1="空谷幽兰";
		}else if(userPoints1>=500&&userPoints1<1000){
			title1="高山仰止";
		}else if(userPoints1>=1000){
			title1="陌上花开";
		}
		
		
		
		CachedRowSetImpl rowSet1=new CachedRowSetImpl();
		sql=con.prepareStatement("select labelName from label,themelabel where themeId=? and themelabel.labelId=label.labelId");
		sql.setString(1,themeId);
		rs=sql.executeQuery();
		rowSet1.populate(rs);
		rowSet1.last();
		int labelNumber=rowSet1.getRow();
		
		

 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>帖子</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/css/postCss.css">
    <link href="http://localhost:8080/SpringMVC/umeditor1.2.3-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://localhost:8080/SpringMVC/js/postJs.js"></script>
    <script type="text/javascript" src="http://localhost:8080/SpringMVC/umeditor1.2.3-utf8-jsp/third-party/template.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="http://localhost:8080/SpringMVC/umeditor1.2.3-utf8-jsp/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="http://localhost:8080/SpringMVC/umeditor1.2.3-utf8-jsp/umeditor.min.js"></script>
    <script type="text/javascript" src="http://localhost:8080/SpringMVC/umeditor1.2.3-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column" id="top">
            <ul class="nav nav-tabs" id="nav">

                <li >
                     <a href="http://localhost:8080/SpringMVC/forum/1"><i class="glyphicon glyphicon-home"></i>首页</a>
                </li>
                <li class="active">
                     <a href="#"><i class="glyphicon glyphicon-globe"></i>论坛</a>
                </li>
                <li >
                     <a href="http://localhost:8080/SpringMVC/login"><i class="glyphicon glyphicon-user"></i>登录</a>
                </li>
                <li >
                     <a href="http://localhost:8080/SpringMVC/sign"><i class="glyphicon glyphicon-edit"></i>注册</a>
                </li>
                <li >
                     <a href="http://localhost:8080/SpringMVC/mail"><i class="fa fa-commenting-o"></i><%=mail%></a>
                </li>
                <li >
                     <a href="http://localhost:8080/SpringMVC/login"><i class="glyphicon glyphicon-cog"></i><%=personal%></a>
                </li>
                <li style="display:none">
                	<a href="http://localhost:8080/SpringMVC/exit1?id=<%=themeId %>&pageIndex=${pageIndex}"><i class="fa fa-sign-out"></i>&nbsp;&nbsp;注销</a>
				</li>
            </ul>
            <ul class="breadcrumb" id="path">
                <li id="labelName">
                </li>
                <li class="active">
                    <%=themeName %>
                </li>
            </ul>
            <ul class="pagination forumPagination">
                
            </ul>
            <span id="accept" ><i class="glyphicon glyphicon-thumbs-up"></i>编辑采纳</span>
        </div>
    </div>
    
    
    
    	<div class="floor1" id="firstFloor">
    		<div class="left">
    			<div class="head"><img alt="140x140" src="http://localhost:8080/SpringMVC/personalIcon/<%=postUserId %>.jpg" onerror="javascript:this.src='http://localhost:8080/SpringMVC/indexImage/indexImg.jpg'" /></div>
    			<div class="name"><a href="http://localhost:8080/SpringMVC/personal/<%=postUserId %>"><%=userName %></a><a  class="ban" onclick="ban(<%=postUserId %>,this)" >&nbsp[<i class="glyphicon glyphicon-ban-circle"></i>禁言]</a></div>
    			<div class="level">用户组：<%=title1 %></div>
    		</div>
    		<div class="right">
    			<span id="title"><%=themeName %></span>
    			
    			<div class="content"><%=content %></div>
    			<div class="time">1楼&nbsp<%=themeTime.substring(0,16) %>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</div>
    		</div>
    	</div>
    <div id="floor"">	
    	
    	
    </div>
    
    
    
    <div class="row clearfix">
        <div class="col-md-12 column">
            <ul class="pagination forumPagination">
                
            </ul>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-12 column">
        </div>
    </div>
</div>
<div id="footer" class="container">
    <div id="postQuickHead">
    发表回复
    </div>
    <div id="postQuickBody">
        <form action="#" method="post" accept-charset="utf-8">
            
            <script type="text/plain" id="myEditor" ></script>
            <div id="postQuickFooter">
                <button type="button" class="btn btn-primary" onclick="response()" >回复(Ctrl+Enter)</button>
            </div>
        </form>
    </div>
</div>
<div class="modal fade" id="modal-container-362503" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header" >
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="modal-title" id="myModalLabel" >
								提示
							</h4>
						</div>
						<div class="modal-body" id="infocontext">
							
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-warning" data-dismiss="modal" >取消</button> 
							 <button type="button" class="btn btn-primary" id="confirm">确定</button>
						</div>
					</div>
					
				</div>
				
			</div>
			
			
			<div class="modal fade" id="modal-container-538356" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header" >
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="modal-title" id="myModalLabel" >
								提示
							</h4>
						</div>
						<div class="modal-body" id="infocontext1">
							
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-warning" data-dismiss="modal" >取消</button> 
							 <button type="button" class="btn btn-primary" id="confirm1">确定</button>
						</div>
					</div>
					
				</div>
				
			</div>
			
			
			<div class="modal fade" id="modal-container-972740" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header" >
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="modal-title" id="myModalLabel" >
								提示
							</h4>
						</div>
						<div class="modal-body" id="infocontext2">
							
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-warning" data-dismiss="modal" >取消</button> 
							 <button type="button" class="btn btn-primary" id="confirm2">确定</button>
						</div>
					</div>
					
				</div>
				
			</div>
			
			
			<div class="modal fade" id="modal-container-118152" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header" >
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="modal-title" id="myModalLabel" >
								提示
							</h4>
						</div>
						<div class="modal-body" id="infocontext3" >
							请先登录账号
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-warning" data-dismiss="modal" >确定</button> 
							 
						</div>
					</div>
					
				</div>
				
			</div>


</body>
<script>
	
	
	
	
	var json='${postPage}';
	var pageIndex='${pageIndex}';
	var pageNum='${pageNum}';
	var themeId="<%=themeId%>";
	
if(json!='blank'){
	var postJson=JSON.parse(json);
	
for(var i=0;i<postJson.post.length;i++){
			var reg=/"/g;
            postJson.post[i].floorContent=postJson.post[i].floorContent.replace(reg,' ');
   		createFloor(postJson.post[i].userName,postJson.post[i].floorUserId,postJson.post[i].floorContent,postJson.post[i].floorTime,postJson.post[i].floorNumber,postJson.post[i].userTitle,postJson.post[i].floorId,postJson.post[i].responseNumber);
   	}
   	creatPageCol(pageNum,pageIndex,themeId);
}
else{
	creatPageCol(1,1,themeId);
}

     if(pageIndex!=1){
    	$("#firstFloor").hide();
    }
    
    
    
     <%
		rowSet1.absolute(1);
		boolean boo1=true;
		for(int i=1;i<=labelNumber&&boo1;i++){
				String labelName=rowSet1.getString("labelName");   

	%>
				var labelName="<%=labelName%>";
				var labelNames=$('<a></a>');
				labelNames.html("["+labelName+"]");
				$('#labelName').append(labelNames)
				labelNames.attr("href","#");

	<%
			boo1=rowSet1.next();
		}

    %>
    
    var blockForBidden="<%=userBean.getBlockForbidden()%>";
    
    
    function response(){
	var content=UM.getEditor('myEditor').getContent();
	var userId="<%=userBean.getUserId()%>";
	var lastFloorId="<%=lastFloorId%>";
	var floorNumber;
	if(lastFloorId==1){
		floorNumber=1;
	}else{ floorNumber=lastFloorId.substring(lastFloorId.indexOf(",")+1);}
	var themeId="<%=themeId%>";
	if(blockForBidden=='1'){
		$("#modal-container-118152").modal('show');
		$("#infocontext3").html("您已被禁言，请等待禁言解除方可回复");
	}
	else{
	$.ajax({
	    type: "POST",
		url: "http://localhost:8080/SpringMVC/responseAjax",
		data: {
			userId: userId,
			themeId:themeId,
			content:content,
			floorNumber:floorNumber,
		},
		dataType: "json",
		success: function(data){
			var userName=data.userName;
			var userId=data.userId;
			var content=data.content;
			var reg=/"/g;
            content=content.replace(reg,' ');
			var floorNumber=data.floorNumber;
			var time=data.time;
			var userTitle=data.userTitle;
			var floorId=data.floorId;
		createFloor(userName,userId,content,time,floorNumber,userTitle,floorId,0);
		window.location.reload();
			
		},
		error: function(jqXHR){
		   alert("发生错误：" + jqXHR.status);
		},
	});}
}


function responseFloor(floorId,i){
	var b="<%=b%>";
	var content=$("#text"+i).val();
	var userId="<%=userBean.getUserId()%>";
	if(b=="false"){
	if(blockForBidden=='1'){
		$("#modal-container-118152").modal('show');
		$("#infocontext3").html("您已被禁言，请等待禁言解除方可回复");
	}else{
	$.ajax({
	    type: "POST",
		url: "http://localhost:8080/SpringMVC/responseInputAjax",
		data: {
			userId: userId,
			floorId:floorId,
			content:content,
			floorNumber:i
		},
		dataType: "json",
		success: function(data){
			var userName=data.userName;
			var userId=data.userId;
			var content=data.content;
			var reg=/"/g;
            content=content.replace(reg,' ');
			var time=data.time;
			var floorId=data.floorId;
			var contentId=data.contentId;
			var floorNumber1=data.floorNumber;
		createResponse(userName,userId,content,time,floorId,contentId,floorNumber1);
			
		},
		error: function(jqXHR){
		   alert("发生错误：" + jqXHR.status);
		},
	});}}
	
	else{
		$("#modal-container-118152").modal('show');
		$("#infocontext3").html("请先登录账号");
	}
	
}
	
function creatPageCol(pageNum,pageIndex,themeId){

	var node='';
	for(var i=0;i<pageNum;i++){
		node+='<li><a href="http://localhost:8080/SpringMVC/read?id='+themeId+'&pageIndex='+(i+1)+'">'+(i+1)+'</a></li>';
	}
	if(parseInt(pageIndex)!=1){
		location.href = "#firstAnchor";
	}
	if(parseInt(pageNum)!=1&&parseInt(pageIndex)!=parseInt(pageNum)){
		node+='<li><a href="http://localhost:8080/SpringMVC/read?id='+themeId+'&pageIndex='+(parseInt(pageIndex)+1)+'">下一页 &rarr;</a></li>';
	}
	$('.forumPagination').append(node);
	$('.forumPagination > li:eq('+(parseInt(pageIndex)-1)+')').addClass("focus");
	if(parseInt(pageIndex)!=1){
		$('.forumPagination').prepend('<li><a href="http://localhost:8080/SpringMVC/read?id='+themeId+'&pageIndex='+(parseInt(pageIndex)-1)+'">&larr; 上一页</a></li>');
	}
}


	var b="<%=b%>";
	var userId="<%=userBean.getUserId()%>";
	var userIdentity="<%=userBean.getUserIdentity()%>";
	var postUserId="<%=postUserId%>";
	if(b=="false"){
		$("#nav li:eq(2)").hide();
		$("#nav li:eq(3)").hide();
		$("#nav li:eq(5)").css("width","auto");
		$("#nav li:eq(4)").css("width","auto");
		$("#nav li:eq(6)").show();
		$("#footer").show();
		$("#nav li:eq(5) a").attr("href","http://localhost:8080/SpringMVC/personal/"+userId);
		$(".input").show();
		if(userIdentity==1){
		$(".ban").show();
		}
		else{$(".ban").hide();
		}
		
		
		if(userId==postUserId||userIdentity==1){
		$(".bandelete").show();
		$(".delete1").show();}
		else{$(".bandelete").hide();
		$(".delete1").hide();
		}
		

	}else{

		$("#footer").hide();
		$(".ban").hide();
		$(".bandelete").hide();
		$(".delete1").hide();
	}

</script>
</html>