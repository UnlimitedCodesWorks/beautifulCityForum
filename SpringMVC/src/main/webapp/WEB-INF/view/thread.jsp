<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="com.forum.login.LoginBean" scope="session"/>
<%
	boolean b=userBean==null||userBean.getUserId()==null||userBean.getUserId().length()==0;
	String mail="通知";
	String personal="个人中心";
	if(!b){
		mail=userBean.getUsername()+"的通知";
		personal=userBean.getUserId()+"的个人中心";
	}
 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>美丽乡村交流社区</title>
<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/font-awesome-4.7.0/css/font-awesome.min.css">
<link href="http://localhost:8080/SpringMVC/umeditor1.2.3-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/css/threadCss.css">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="http://localhost:8080/SpringMVC/umeditor1.2.3-utf8-jsp/third-party/template.min.js"></script>
<script type="text/javascript" charset="utf-8" src="http://localhost:8080/SpringMVC/umeditor1.2.3-utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="http://localhost:8080/SpringMVC/umeditor1.2.3-utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="http://localhost:8080/SpringMVC/umeditor1.2.3-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://localhost:8080/SpringMVC/js/threadJs.js"></script>
<div id="TopBanner">
    <div id="myCarousel" class="carousel slide ">
    <!-- 轮播（Carousel）指标 -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <!-- 轮播（Carousel）项目 -->
    <div class="carousel-inner">
        <div class="item active">
            <img src="http://localhost:8080/SpringMVC/indexImage/banner.jpg" alt="First slide" class="bannerImg">
        </div>
        <div class="item">
            <img src="http://localhost:8080/SpringMVC/indexImage/banner_1.jpg" alt="Second slide" class="bannerImg">
        </div>
        <div class="item">
            <img src="http://localhost:8080/SpringMVC/indexImage/banner_2.jpg" alt="Third slide" class="bannerImg">
        </div>
    </div>
    <!-- 轮播（Carousel）导航 -->
</div>
    <div id="bannerLeft">
        <i class="fa fa-envira"></i>&nbsp;&nbsp;美丽乡村交流社区 <a href="javascript:void(0)" class="chargeBtn_1" >管理版面</a>
    </div>
    <nav class="navbar navbar-default" role="navigation" id="bannerRight">
        <div class="container-fluid">
            <div>
                <ul class="nav navbar-nav" id="nav">
                    <li><a href="http://localhost:8080/beautifulCity/index"><i class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;首页</a></li>
                    <li><a href="http://localhost:8080/SpringMVC/login"><i class="glyphicon glyphicon-user"></i>&nbsp;&nbsp;登录</a></li>
                    <li><a href="http://localhost:8080/SpringMVC/sign"><i class="glyphicon glyphicon-edit"></i>&nbsp;&nbsp;注册</a></li>
                    <li><a href="http://localhost:8080/SpringMVC/mail"><i class="fa fa-commenting-o"></i>&nbsp;&nbsp;<%=mail%> <span class="badge unread" style="color:#38AA02; background-color:white;">10</span></a></li>
                    <li><a href="http://localhost:8080/SpringMVC/login"><i class="glyphicon glyphicon-cog"></i>&nbsp;&nbsp;<%=personal%></a></li>
                    <li style="display:none"><a href="http://localhost:8080/SpringMVC/exit"><i class="fa fa-sign-out"></i>&nbsp;&nbsp;注销</a>
                </ul>
            </div>
        </div>
    </nav>
    <div id="bannerBottom">
        Beautiful Country Forum
    </div>
    <div id="bannerSearch">
         <div class="input-group">
            <span class="input-group-addon" id="searchBtn"><i class="glyphicon glyphicon-search"></i></span>
            <input type="text" class="form-control searchInput" id="searchContent"  name="searchContent" placeholder="搜索你想要的内容">
            <input type="hidden" id="searchClass" name="searchClass" value="按主题搜索">
            <div class="input-group-btn themeDiv_1">
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
<a name="firstAnchor"></a>
<div class="container RecommendedColumn" >
    <div class="row">
        <div class="col-lg-6 col-md-6 col-md-offset-3 col-lg-offset-3 recommendColHead">
                版块推荐贴
        </div>
    </div>
    <div class="row">
        <div class="col-lg-4 col-md-4 recommendCol">
        <div class="boxBorder">
            <div class="greenCircle">
                <i class="fa fa-newspaper-o"></i>
            </div>
            <div class="contentHead">
                新闻推荐栏
            </div>
            <table class="table table-striped table-bordered" style="border-right: 0px;border-left: 0px;" >
                <tbody class="topTable">
                </tbody>
            </table>
        </div>
        </div>
        <div class="col-lg-4 col-md-4 recommendCol">
        <div class="boxBorder">
            <div class="greenCircle">
                <i class="fa fa-calendar "></i>
            </div>
            <div class="contentHead">
                活动推荐栏
            </div>
            <table class="table table-striped table-bordered" style="border-right: 0px;border-left: 0px;" >
                <tbody class="topTable">
                </tbody>
            </table>
        </div>
        </div>
        <div class="col-lg-4 col-md-4 recommendCol">
        <div class="boxBorder">
            <div class="greenCircle">
                <i class="fa fa-bus "></i>
            </div>
            <div class="contentHead">
                旅游推荐栏
            </div>
             <table class="table table-striped table-bordered" style="border-right: 0px;border-left: 0px;">
                <tbody class="topTable">
                </tbody>
            </table>
        </div>
        </div>
    </div>
</div>
<div id="mainBanner">
    综合讨论区 <i class="fa fa-group"></i>
    <a href="http://localhost:8080/SpringMVC/forum/1?enlighten=true" class="btn btn-danger fineBtn" >精华区 <i class="fa fa-arrow-right"></i></a>
    <a href="http://localhost:8080/SpringMVC/forum/1?enlighten=false" class="btn btn-success fineBtn" ><i class="fa fa-arrow-left"></i> 返回 </a>
</div>
<div id="forumTop">
    <a href="javascript:void(0)" class="btn btn-default forumTopBtn" onclick="labelSearch_1(this)" > <i class="fa fa-tag"></i> 新闻推荐 <span class="badge" style="background-color:#A1A1A1;">${newsNum}</span></a>
    <a href="javascript:void(0)" class="btn btn-default forumTopBtn" onclick="labelSearch_1(this)" > <i class="fa fa-tag"></i> 旅游推荐 <span class="badge" style="background-color:#A1A1A1;">${activeNum}</span></a>
    <a href="javascript:void(0)" class="btn btn-default forumTopBtn" onclick="labelSearch_1(this)" > <i class="fa fa-tag"></i> 活动推荐 <span class="badge" style="background-color:#A1A1A1;">${tourNum}</span></a>
    <a href="javascript:void(0)" class="btn btn-default forumTopBtn" onclick="labelSearch_1(this)" > <i class="fa fa-tag"></i> 吐槽灌水 <span class="badge" style="background-color:#A1A1A1;">${nobNum}</span></a>
    <a href="javascript:void(0)" class="btn btn-default forumTopBtn" onclick="labelSearch_1(this)" > <i class="fa fa-tag"></i> 热门帖子 <span class="badge" style="background-color:#A1A1A1;">${hotNum}</span></a>
</div>
<div class="container forumContent">
    <div id="forumContentContainer"></div>
    <div id="nextPage">
        <a href="javascript:void(0)">更多</a>
        <input type="hidden" name="pageIndex" id="pageIndex">
    </div>
    <ul class="pagination forumPagination ">
    </ul>
    <ul id="post">
        <li><a href="http://localhost:8080/SpringMVC/edit">发表新帖&nbsp;<i class="fa fa-print"></i></a></li>
        <li><div class="btn-group">
        <button type="button" class="chargeBtn dropdown-toggle" data-toggle="dropdown" >批量操作&nbsp;<i class="fa fa-key"></i><span class="caret"></span></button>
        <ul class="dropdown-menu" role="menu" id="chargeList" >
        <li>
            <a href="javascript:void(0)">加精</a>
        </li>
        <li>
            <a href="javascript:void(0)">置顶</a>
        </li>
        <li>
            <a href="javascript:void(0)" >删除</a>
        </li>
        <li>
            <a href="javascript:void(0)">取消加精</a>
         </li>
        </ul>
        </div>
        </li>
    </ul>
</div>
<div id="footer" class="container">
    <div id="postQuickHead">
        快速发帖
    </div>
    <div id="postQuickBody">
        <form action="http://localhost:8080/SpringMVC/pageContent" method="post" accept-charset="utf-8">
            <div id="postQuickTheme">
                <div class="input-group">
                    <input type="text" class="form-control" name="theme" id="theme" placeholder="你能输入80个字符">
                    <input type="hidden" name="themeClass" id="themeClass"  >
                    <input type="hidden" name="postContent" id="postContent">
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-default
                        dropdown-toggle" data-toggle="dropdown" id="themeButton">主题分类
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" id="themeSelect">
                            <li>
                                <a href="javascript:void(0)">新闻推荐</a>
                            </li>
                            <li>
                                <a href="javascript:void(0)">旅游推荐</a>
                            </li>
                            <li>
                                <a href="javascript:void(0)">活动推荐</a>
                            </li>
                            <li>
                                <a href="javascript:void(0)">吐槽灌水</a>
                            </li>
                        </ul>
                    </div><!-- /btn-group -->
                </div><!-- /input-group -->
            </div>
            <script type="text/plain" id="myEditor" ></script>
            <div id="postQuickFooter">
                <input type="submit" class="btn btn-primary" value="发表新帖(Ctrl+Enter)">
                <a href="http://localhost:8080/SpringMVC/edit">高级模式</a>
            </div>
        </form>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">管理操作</h4>
            </div>
            <div class="modal-body" id="mymodal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="modalSubmit" >提交更改</button>
                <input type="hidden" name="modalClass" id="modalClass" >
                <input type="hidden" name="modalId" id="modalId" >
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="myModal_1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">管理操作</h4>
            </div>
            <div class="modal-body" id="mymodal-body_1"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="modalSubmit_1" >提交更改</button>
                <input type="hidden" name="modalClass" id="modalClass_1" >
                <input type="hidden" name="modalId" id="modalId_1" >
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
<script>
	var json='${newsRecommend}';
	var json_1='${activityRecommend}';
	var json_2='${tourRecommend}';
	var json_3='${themeInfo}';
	var pageNum='${pageNum}';
	var pageIndex='${pageIndex}';
	var pageEnlighten='${pageEnlighten}';
	pageIndex=parseInt(pageIndex);
   	var newsArray=JSON.parse(json);
   	var activityArray=JSON.parse(json_1);
   	var tourArray=JSON.parse(json_2);
   	var themeArray=JSON.parse(json_3);
   	var userIdentity="<%=userBean.getUserIdentity()%>";
    $('#pageIndex').val(pageIndex);
    if(pageIndex==parseInt(pageNum)){
           $('#nextPage').hide();
       }
    if(pageEnlighten=="true"){
    	$(".fineBtn:eq(0)").hide();
    }else{
    	$(".fineBtn:eq(1)").hide();
    }
   	for(var i=0;i<newsArray.news.length;i++){
   		creatTopCol('新闻推荐',newsArray.news[i].themeName,newsArray.news[i].themeId);
   	}
   	for(var i=0;i<activityArray.activities.length;i++){
   		creatTopCol('活动推荐',activityArray.activities[i].themeName,activityArray.activities[i].themeId);
   	}
   	for(var i=0;i<tourArray.tours.length;i++){
   		creatTopCol('旅游推荐',tourArray.tours[i].themeName,tourArray.tours[i].themeId);
   	}
   	for(var i=0;i<themeArray.themes.length;i++){
   		var labelArray=new Array();
   		for(var j=0;j<themeArray.themes[i].label.length;j++){
   			labelArray.push(themeArray.themes[i].label[j]);
   		}
   		creatCol(themeArray.themes[i].reply,labelArray,themeArray.themes[i].themeName,themeArray.themes[i].userName,themeArray.themes[i].themeTime,themeArray.themes[i].floorTime,themeArray.themes[i].floorName,themeArray.themes[i].enlighten,themeArray.themes[i].userId,themeArray.themes[i].floorId,themeArray.themes[i].themeId,themeArray.themes[i].accept,themeArray.themes[i].recommend);
   	}
   	creatPageCol(pageNum,pageIndex);
	var b="<%=b%>";
	var userId="<%=userBean.getUserId()%>";
	if(b=="false"){
		$("#nav li:eq(1)").hide();
		$("#nav li:eq(2)").hide();
		$("#nav li:eq(3)").css("width","auto");
		$("#nav li:eq(4)").css("width","auto");
		$("#nav li:eq(5)").show();
		$("#post").show();
		$("#footer").show();
		$("#nav li:eq(4) a").attr("href","http://localhost:8080/SpringMVC/personal/"+userId);
		$("#bannerRight").width("50em");
		if(userIdentity=='0'){
			$(".chargeBtn").hide();
			$(".chargeBtn_1").hide();
		}
	}else{
		$("#post").hide();
		$("#footer").hide();
		$(".chargeBtn").hide();
		$(".chargeBtn_1").hide();
	}
	var blockForBidden="<%=userBean.getBlockForbidden()%>";
	if(blockForBidden=='1'){
		UM.getEditor('myEditor').setDisabled('fullscreen');
        $("#postQuickFooter input").val("你被禁言了");
        $("#postQuickFooter input").attr("disabled","disabled");
        $("#postQuickTheme .input-group .form-control").attr("disabled","disabled");
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
