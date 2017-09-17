<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="com.forum.login.LoginBean" scope="session"/>
<%
	boolean b=userBean==null||userBean.getUserId()==null||userBean.getUserId().length()==0;
 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>搜索结果</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/font-awesome-4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/css/searchCss.css">
    <script src="http://localhost:8080/SpringMVC/js/searchJs.js"></script>
</head>
<body>
     <div id="TopBanner">
        <img src="http://localhost:8080/SpringMVC/indexImage/banner_3.jpg" alt="美丽乡村">
        <ul id="BannerLeft">
            <li><a href="http://localhost:8080/SpringMVC/forum/1"><i class="fa fa-envira"></i> 美丽乡村论坛</a></li>
            <li><a href=""><i class="fa fa-search"></i> 搜索结果</a></li>
        </ul>
        <ul id="BannerRight">
            <li><a href="#" class="personalHref" >你好<br><%=userBean.getUsername() %></a></li>
            <li><a href="http://localhost/8080/beautifulCity/index">首页</a></li>
            <li><a href="#" class="personalHref" >我的</a></li>
            <li><a href="http://localhost:8080/SpringMVC/mail">消息 <span class="badge unread" style="color:#38AA02; background-color:white;">10</span></a></li>
            <li><a href="http://localhost:8080/SpringMVC/exit">退出</a></li>
            <li><a href='#' class="personalHref"><img src="#" alt="用户头像" onerror="javascript:this.src='http://localhost:8080/SpringMVC/indexImage/indexImg.jpg'" alt="用户头像"></a></li>
        </ul>
        <div id="bannerBottom">
        Beautiful Country Forum
        </div>
        <div id="bannerSearch">
         <div class="input-group">
            <span class="input-group-addon" id="searchBtn"><i class="glyphicon glyphicon-search"></i></span>
            <input type="text" class="form-control" id="searchContent"  name="searchContent" placeholder="搜索你想要的内容">
            <input type="hidden" id="searchClass" name="searchClass" value='按主题搜索'>
            <input type="hidden" id="preSearchClass" name="preSearchClass" >
            <input type="hidden" id="pageIndex" name="pageIndex" value="1">
            <input type="hidden" id="searchContent_1" name="searchContent_1" >
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
    <div id="searchBody">
        <div id="searchTitle">
            ::${searchContent}::
        </div>
        <div class="container searchContent" id="searchCon" >
        	<h2 class="text-center">未找到符合条件的主题或回复</h2>
        </div>
        <div id="nextPage">
        <a href="javascript:void(0)">更多</a>
        <input type="hidden" name="pageIndex" id="pageIndex">
    	</div>
    </div>
</body>
<script>
	var json='${themeInfo}';
	var json_1='${themeInfo_1}';
	var searchClass='${searchClass}';
	var searchContent='${searchContent}';
	var pageIndex=1;
	var pageNum='${pageNum}';
	if(searchContent=="全部主题"){
		searchContent="";
	}
	if(pageNum==""||pageNum==null||pageNum=='0'||pageNum=='1'){
		$('#nextPage').hide();
	}
	$('#preSearchClass').val(searchClass);
	$('#searchContent_1').val(searchContent);
	if(json==''){
		var themeArray_1=JSON.parse(json_1);
   		for(var i=0;i<themeArray_1.themes.length;i++){
   			$(".text-center").hide();
   			creatCol_1(themeArray_1.themes[i].reply,themeArray_1.themes[i].content,themeArray_1.themes[i].userName,themeArray_1.themes[i].themeTime,themeArray_1.themes[i].floorTime,themeArray_1.themes[i].floorName,themeArray_1.themes[i].postUserId,themeArray_1.themes[i].floorId,themeArray_1.themes[i].replyId);
   		}
	}else{
		var themeArray=JSON.parse(json);
		for(var i=0;i<themeArray.themes.length;i++){
		$(".text-center").hide();
   		var labelArray=new Array();
   		for(var j=0;j<themeArray.themes[i].label.length;j++){
   			labelArray.push(themeArray.themes[i].label[j]);
   		}
   		creatCol(themeArray.themes[i].reply,labelArray,themeArray.themes[i].themeName,themeArray.themes[i].userName,themeArray.themes[i].themeTime,themeArray.themes[i].floorTime,themeArray.themes[i].floorName,themeArray.themes[i].enlighten,themeArray.themes[i].userId,themeArray.themes[i].floorId,themeArray.themes[i].themeId);
   		}
	}
   	var b="<%=b%>";
   	var userId_1="<%=userBean.getUserId()%>";
   	if(b!="true"){
   		$(".personalHref").attr("href","http://localhost:8080/SpringMVC/personal/"+userId_1);
		$(".personalHref img").attr("src","http://localhost:8080/SpringMVC/personalIcon/"+userId_1+".jpg");
		 
   	}else{
   		$("#BannerRight").hide();
   	}	
   	var unReadNum="<%=userBean.getUnreadNews()%>";
	if(unReadNum=='0'){
		$(".unread").hide();	
	}else{
		$(".unread").show();
		$(".unread").text(unReadNum);
	}
</script>
</html>