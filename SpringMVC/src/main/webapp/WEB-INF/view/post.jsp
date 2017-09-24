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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>帖子</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=basePath %>font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/postCss.css">
    <link href="<%=basePath %>umeditor1.2.3-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="<%=basePath %>js/postJs.js"></script>
    <script type="text/javascript" src="<%=basePath %>umeditor1.2.3-utf8-jsp/third-party/template.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>umeditor1.2.3-utf8-jsp/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>umeditor1.2.3-utf8-jsp/umeditor.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>umeditor1.2.3-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column" id="top">
            <ul class="nav nav-tabs" id="nav">

                <li >
                     <a href="<%=basePath %>forum/1"><i class="glyphicon glyphicon-home"></i>首页</a>
                </li>
                <li class="active">
                     <a href="#"><i class="glyphicon glyphicon-globe"></i>论坛</a>
                </li>
                <li >
                     <a href="<%=basePath %>login"><i class="glyphicon glyphicon-user"></i>登录</a>
                </li>
                <li >
                     <a href="<%=basePath %>sign"><i class="glyphicon glyphicon-edit"></i>注册</a>
                </li>
                <li >
                     <a href="<%=basePath %>mail"><i class="fa fa-commenting-o"></i><%=mail%></a>
                </li>
                <li >
                     <a href="<%=basePath %>login"><i class="glyphicon glyphicon-cog"></i><%=personal%></a>
                </li>
                <li style="display:none">
                	<a href="<%=basePath %>exit"><i class="fa fa-sign-out"></i>&nbsp;&nbsp;注销</a>
				</li>
            </ul>
            <ul class="breadcrumb" id="path">
                <li id="labelName">
                </li>
                <li class="active">
                    ${themeName}
                </li>
            </ul>
            <ul class="pagination forumPagination">
                
            </ul>
        </div>
    </div>
    
    
    
    	<div class="floor1" id="firstFloor">
    		<div class="left">
    			<div class="head"><img alt="140x140" src="<%=basePath %>personalIcon/${postUserId }.jpg" onerror='javascript:this.src="<%=basePath %>indexImage/indexImg.jpg"' /></div>
    			<div class="name"><a href="<%=basePath %>personal/${postUserId}">${userName}</a><a  class="ban ban${postUserId}" onclick="ban(${postUserId},this)" >&nbsp[<i class="glyphicon glyphicon-ban-circle"></i>禁言]</a><a  class="removeBan removeBan${postUserId}" onclick="removeBan(${postUserId},this)" >&nbsp[<i class="glyphicon glyphicon-ban-circle"></i>已禁言]</a></div>
    			<div class="level"><span style="margin-right:10px;">${title1}</span><i class="levelNum">${level1}</i><span class="fa fa-star fa-2x"></span></div>
    		</div>
    		<div class="right">
    			<div id="title">
    				<span>${themeName}</span>
    				<button type="button" class="btn btn-default" id="lookOwner"><i class="fa fa-user-o"></i> 只看楼主</button>
    				<button type="button" class="btn btn-default" id="accept"><i class="glyphicon glyphicon-thumbs-up"></i> 采纳</button>
    				<button type="button" class="btn btn-dangers" id="removeAccept" style="color:white;"><i class="glyphicon glyphicon-thumbs-up"></i> 已采纳</button>
    			</div> 
    			<div class="content">${content}</div>
    			<div class="time">1楼&nbsp${themeTime}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</div>
    		</div>
    	</div>
    <div id="floor"">	
    	
    	
    </div>
    <div class="row clearfix" id="userRecommend">
		<div class="col-md-12 column">
			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title">
						
					</h3>
				</div>
				<div class="panel-body">
					<button type="button" class="btn btn-info" style="margin-left:55%;margin-top:10px;"><i class="fa fa-heart-o"></i> 如果您觉得这篇帖子对您有帮助的话，就点一下右边的推荐吧</button>
					<span >
    				<span class="fa-stack fa-2x" id="recommend">
  						<i class="fa fa-circle-thin fa-stack-2x "></i>
  						<i class="fa fa-thumbs-up fa-stack-1x "></i>
					</span>
					
					<span class="fa-stack fa-2x" id="removeRecommend" >
  						<i class="fa fa-circle fa-stack-2x  " style="color:red"></i>
  						<i class="fa fa-thumbs-up fa-stack-1x  " style="color:white"></i>
					</span>
					</span>
					<div id="usergreat"><i class="fa fa-star " style="color:#31b0d5;"></i>已有${recommend}人点了赞</div>
				</div>

			</div>
		</div>
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
						<div class="modal-body" >
							请先登录账号
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-warning" data-dismiss="modal" >确定</button> 
							 
						</div>
					</div>
					
				</div>
				
			</div>



			
			<div class="modal fade" id="modal-container-351315" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header" >
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="modal-title" id="myModalLabel" >
								提示
							</h4>
						</div>
						<div class="modal-body" id="infocontext4">
							
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-warning" data-dismiss="modal" >取消</button> 
							 <button type="button" class="btn btn-primary" id="confirm4">确定</button>
						</div>
					</div>
					
				</div>
				
			</div>
			
			<div class="modal fade" id="modal-container-469862" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header" >
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="modal-title" id="myModalLabel" >
								提示
							</h4>
						</div>
						<div class="modal-body" id="infocontext5">
							
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-warning" data-dismiss="modal" >取消</button> 
							 <button type="button" class="btn btn-primary" id="confirm5">确定</button>
						</div>
					</div>
					
				</div>
				
			</div>


			<div class="modal fade" id="modal-container-449471" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header" >
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="modal-title" id="myModalLabel" >
								提示
							</h4>
						</div>
						<div class="modal-body" id="infocontext6">
							
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-warning" data-dismiss="modal" >取消</button> 
							 <button type="button" class="btn btn-primary" id="confirm6">确定</button>
						</div>
					</div>
					
				</div>
				
			</div>
</body>
<script>
	
	
	
	
	var json='${postPage}';
	var pageIndex='${pageIndex}';
	var pageNum='${pageNum}';
	var themeId='${themeId}';
	var basePath='<%=basePath%>'
if(json!='blank'){
	var postJson=JSON.parse(json);
	
for(var i=0;i<postJson.post.length;i++){
			var reg=/"/g;
            postJson.post[i].floorContent=postJson.post[i].floorContent.replace(reg,' ');
   		createFloor(postJson.post[i].userName,postJson.post[i].floorUserId,postJson.post[i].floorContent,postJson.post[i].floorTime,postJson.post[i].floorNumber,postJson.post[i].userTitle,postJson.post[i].floorId,postJson.post[i].responseNumber,postJson.post[i].userLevel);
   	}
   	creatPageCol(pageNum,pageIndex,themeId);
}
else{
	creatPageCol(1,1,themeId);
}

     if(pageIndex!=1){
    	$("#firstFloor").hide();
    }
    
    
var label='${label}';
var labelName;


	
	labelName=label.substring(1,label.length-1).split(",");

for(var i=0;i<labelName.length;i++){
				var labelName_1=labelName[i];
				var labelNames=$('<a></a>');
				labelNames.html("["+labelName_1+"]");
				$('#labelName').append(labelNames)
				labelNames.attr("href","#");
}

    
    var blockForBidden="<%=userBean.getBlockForbidden()%>";
    
    function response(){
	var content=UM.getEditor('myEditor').getContent();
	var reg=/"/g;
    content=content.replace(reg,' ');
	var userId="<%=userBean.getUserId()%>";
	var lastFloorId='${lastFloorId}';
	var floorNumber;
	if(lastFloorId==1){
		floorNumber=1;
	}else{ floorNumber=lastFloorId.substring(lastFloorId.indexOf(",")+1);}
	var themeId='${themeId}';
	if(blockForBidden=='1'){
		$("#modal-container-118152").modal('show');
		$("#infocontext3").html("您已被禁言，请等待禁言解除方可回复");
	}
	else{
	$.ajax({
	    type: "POST",
		url: basePath+"responseAjax",
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
			var userLevel=data.userLevel;
			var floorNumber=data.floorNumber;
			var time=data.time;
			var userTitle=data.userTitle;
			var floorId=data.floorId;
		createFloor(userName,userId,content,time,floorNumber,userTitle,floorId,0,userLevel);
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
		url: basePath+"responseInputAjax",
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
		node+='<li><a href="'+basePath+'read?id='+themeId+'&pageIndex='+(i+1)+'">'+(i+1)+'</a></li>';
	}

	if(parseInt(pageNum)!=1&&parseInt(pageIndex)!=parseInt(pageNum)){
		node+='<li><a href="'+basePath+'read?id='+themeId+'&pageIndex='+(parseInt(pageIndex)+1)+'">下一页 &rarr;</a></li>';
	}
	$('.forumPagination').append(node);
	$('.forumPagination > li:eq('+(parseInt(pageIndex)-1)+')').addClass("focus");
	if(parseInt(pageIndex)!=1){
		$('.forumPagination').prepend('<li><a href="'+basePath+'read?id='+themeId+'&pageIndex='+(parseInt(pageIndex)-1)+'">&larr; 上一页</a></li>');
	}
}


$("#accept").click(function(){
	$("#modal-container-351315").modal('show');
	$("#infocontext4").html("确定采纳本帖吗？");
	var postUserId='${postUserId}';
	var themeId='${themeId}';
	
	$("#confirm4").click(function(){
		$.ajax({ 
		    type: 'POST', 	
			url: basePath+'acceptAjax',
			data: {
				postUserId:postUserId,
				themeId:themeId
			},
			dataType: 'json',
			success: function(data){
				if(data.success){
					
					$("#modal-container-351315").modal('hide');
					$("#accept").hide();
					$("#removeAccept").show();
					
					}
			},
			error: function(jqXHR){     
			   alert("发生错误：" + jqXHR.status);  
			},     
		});
	});
	
})


$("#removeAccept").click(function(){
	$("#modal-container-469862").modal('show');
	$("#infocontext5").html("是否取消对本贴的采纳？");
	var postUserId='${postUserId}';
	var themeId='${themeId}';
	
	$("#confirm5").click(function(){
		$.ajax({ 
		    type: 'POST', 	
			url: basePath+'removeAcceptAjax',
			data: {
				postUserId:postUserId,
				themeId:themeId
			},
			dataType: 'json',
			success: function(data){
				if(data.success){
					
					$("#modal-container-469862").modal('hide');
					$("#accept").show();
					$("#removeAccept").hide();
					
					}
			},
			error: function(jqXHR){     
			   alert("发生错误：" + jqXHR.status);  
			},     
		});
	});
	
})


$("#recommend").click(function(){

	$.ajax({ 
	    type: 'POST', 	
		url: basePath+'recommendAjax',
		data: {
			themeId:'${themeId}',
			userId:"<%=userBean.getUserId()%>"
		},
		dataType: 'json',
		success: function(data){
			var usergreat=data.success;
				$("#removeRecommend").show();
				$("#recommend").hide();
				$("#usergreat").html("已有"+usergreat+"人点了赞");
				
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		},     
	});

})

$("#removeRecommend").click(function(){

	$.ajax({ 
	    type: 'POST', 	
		url: basePath+'removeRecommendAjax',
		data: {
			themeId:'${themeId}',
			userId:"<%=userBean.getUserId()%>"
		},
		dataType: 'json',
		success: function(data){
			var usergreat=data.success;

				$("#removeRecommend").hide();
				$("#recommend").show();
				$("#usergreat").html("已有"+usergreat+"人点了赞");
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		},     
	});

})


	var locate=window.location.hash;
	var located=locate.substring(locate.indexOf("n")+1);

	if(locate!=null&&locate!=""){

		$("#content"+located).css('font-weight','bold');
	}



	var accept='${accept}';
	var great='${great}';
	var b="<%=b%>";
	var userId="<%=userBean.getUserId()%>";
	var userIdentity="<%=userBean.getUserIdentity()%>";
	var postUserId='${postUserId}';
	if(b=="false"){
		$("#nav li:eq(2)").hide();
		$("#nav li:eq(3)").hide();
		$("#nav li:eq(5)").css("width","auto");
		$("#nav li:eq(4)").css("width","auto");
		$("#nav li:eq(6)").show();
		$("#footer").show();
		$("#nav li:eq(5) a").attr("href",basePath+"personal/"+userId);
		$(".input").show();
		$("#userRecommend").show();
		if(userIdentity==1){
		$(".ban").show();
		$(".removeBan").hide();
		if(accept==1){
			$("#accept").hide();
			$("#removeAccept").show();
			}
		else{
			$("#accept").show();
			$("#removeAccept").hide();
			}
		}
		else{$(".ban").hide();
			$("#accept").hide();
			$("#removeAccept").hide();
			$(".removeBan").hide();
		}
		
		
		if(userId==postUserId||userIdentity==1){
		$(".bandelete").show();
		$(".delete1").show();}
		else{$(".bandelete").hide();
		$(".delete1").hide();
		}
		
		if(great=="true"){
			$("#removeRecommend").show();
				$("#recommend").hide();
		}
		else{
			$("#removeRecommend").hide();
				$("#recommend").show();
		}
		

	}else{

		$("#footer").hide();
		$(".ban").hide();
		$(".bandelete").hide();
		$(".delete1").hide();
		$("#accept").hide();
		$("#removeAccept").hide();
		$("#userRecommend").hide();
		$(".removeBan").hide();
	}
	

	var forbidden='${forbidden}';

	var forbiddenId=forbidden.substring(1,forbidden.length-1).split(",");
	<%
	if(!b){
	if(userBean.getUserIdentity()==1){
  				
	%>
	for(var n=0;n<forbiddenId.length;n++){
				var userId=forbiddenId[n];
				$(".ban"+userId).hide();
				$(".removeBan"+userId).show();}
	<%
	}}
    %>
	


</script>
</html>