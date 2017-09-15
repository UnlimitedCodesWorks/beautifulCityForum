<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="com.forum.login.LoginBean" scope="session"/>
<%
	boolean b=userBean==null||userBean.getUserId()==null||userBean.getUserId().length()==0;
 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>我的消息</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/font-awesome-4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/css/mailCss.css">
    <script src="http://localhost:8080/SpringMVC/js/mailJs.js"></script>
</head>
<body>
     <div id="TopBanner">
        <img src="http://localhost:8080/SpringMVC/indexImage/banner_3.jpg" alt="美丽乡村">
        <ul id="BannerLeft">
            <li><a href="http://localhost:8080/SpringMVC/forum/1"><i class="fa fa-envira"></i> 美丽乡村论坛</a></li>
            <li><a href="#"><i class="fa fa-envelope"></i> 消息提醒</a></li>
        </ul>
        <ul id="BannerRight">
            <li><a href="#" class="personalHref" >你好<br><%=userBean.getUsername() %></a></li>
            <li><a href="#">首页</a></li>
            <li><a href="#" class="personalHref" >我的</a></li>
            <li><a href="http://localhost:8080/SpringMVC/mail">消息</a></li>
            <li><a href="http://localhost:8080/SpringMVC/exit">退出</a></li>
            <li><a href='#' class="personalHref"><img src="http://localhost:8080/SpringMVC/indexImage/indexImg.jpg" alt="用户头像"></a></li>
        </ul>
        <div id="bannerBottom">
        Beautiful Country Forum
        </div>
        <div id="bannerSearch">
         <div class="input-group">
            <span class="input-group-addon" id="searchBtn"><i class="glyphicon glyphicon-search"></i></span>
            <input type="text" class="form-control" id="searchContent"  name="searchContent" placeholder="搜索你想要的内容">
            <input type="hidden" id="searchClass" name="searchClass" value='按主题搜索'>
            <div class="input-group-btn">
                        <button type="button" class="btn btn-default
                        dropdown-toggle" data-toggle="dropdown" id="themeButton_1">按主题搜索
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" id="themeSelect_1">
                            <li>
                                <a href="javascript:void(0)">按主题搜索</a>
                            </li>
                            <li>
                                <a href="javascript:void(0)">按用户搜索</a>
                            </li>
                        </ul>
            </div><!-- /btn-group -->
        </div>
        </div>
    </div>
    <div id="mailBody">
            <div id="mailBodyTop">
                ::消息提醒::
            </div>
            <div id="mailBodyContent" class="container">
            </div>
            <ul class="pagination forumPagination ">
    		</ul>
    </div>
</body>
<script>
	var b="<%=b%>";
   	var userId_1="<%=userBean.getUserId()%>";
   	if(b!="true"){
   		$(".personalHref").attr("href","http://localhost:8080/SpringMVC/personal/"+userId_1);
   		var ImgObj=new Image();
		ImgObj.src="http://localhost:8080/SpringMVC/personalIcon/"+userId_1+".jpg";
		 if(ImgObj.fileSize > 0 || (ImgObj.width > 0 && ImgObj.height > 0)){
		 	$(".personalHref img").attr("src","http://localhost:8080/SpringMVC/personalIcon/"+userId_1+".jpg");
		 }
   	}	
   	var json='${json}';
   	var pageNum='${pageNum}';
   	var pageIndex=1;
   	var themeArray=JSON.parse(json);
   	var node_1='<div class="row mailContentRow"><div class="col-md-4" style="color:#767474; font-weight: 600;"><i class="fa fa-home"></i> 主题</div><div class="col-md-4" style="color:#767474; font-weight: 600;"><i class="fa fa-envelope-open"></i> 回复内容</div><div class="col-md-2" style="color:#767474; font-weight: 600;"><i class="fa fa-user"></i> 回复者</div><div class="col-md-2" style="color:#767474; font-weight: 600;"><i class="fa fa-clock-o"></i> 回复时间</div></div>';
	$("#mailBodyContent").append(node_1);
   	for(var i=0;i<themeArray.themes.length;i++){
   		var labelArray=new Array();
   		for(var j=0;j<themeArray.themes[i].label.length;j++){
   			labelArray.push(themeArray.themes[i].label[j]);
   		}
   		creatCol(labelArray,themeArray.themes[i].themeName,themeArray.themes[i].content,themeArray.themes[i].userId,themeArray.themes[i].userName,themeArray.themes[i].themeTime,themeArray.themes[i].themeId,themeArray.themes[i].responseId);
   	}
   	creatPageCol(pageNum,pageIndex);
</script>
</html>