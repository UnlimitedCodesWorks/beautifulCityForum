<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="com.forum.login.LoginBean" scope="session"/>
<%
	boolean b=userBean==null||userBean.getUserId()==null||userBean.getUserId().length()==0;
 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>个人信息</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/font-awesome-4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/cropper/dist/cropper.css">
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/css/personal.css">
    <script src="http://localhost:8080/SpringMVC/cropper/dist/cropper.js"></script>
    <script src="http://localhost:8080/SpringMVC/jQueryYzm/js/gVerify.js"></script>
    <script src="http://localhost:8080/SpringMVC/js/personal.js"></script>
</head>
<body>
    <div id="TopBanner">
        <img src="http://localhost:8080/SpringMVC/indexImage/banner_3.jpg" alt="美丽乡村">
        <ul id="BannerLeft">
            <li><a href="http://localhost:8080/SpringMVC/forum/1"><i class="fa fa-envira"></i> 美丽乡村交流社区</a></li>
            <li><a href="#" class="personalHref" ><i class="glyphicon glyphicon-user"></i> 个人信息</a></li>
        </ul>
        <ul id="BannerRight">
            <li><a href="#" class="personalHref" >你好<br><%=userBean.getUsername() %></a></li>
            <li><a href="http://localhost:8080/beautifulCity/index">首页</a></li>
            <li><a href="#" class="personalHref" >我的</a></li>
            <li><a href="http://localhost:8080/SpringMVC/mail">消息 <span class="badge unread" style="color:#38AA02; background-color:white;">10</span></a></li>
            <li><a href="http://localhost:8080/SpringMVC/exit">退出</a></li>
            <li><a href='#' class="personalHref"><img src="#" alt="用户头像" onerror="javascript:this.src='http://localhost:8080/SpringMVC/indexImage/indexImg.jpg'" ></a></li>
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
    <div id="personalBody">
        <div id="BodyTop">
            ::${userName}的个人空间::
        </div>
        <div class="container" style="width:100%;">
            <div class='row'>
                <div class="col-lg-6 col-md-6">
                    <div class="personalBodyTop" style="background-color:rgb(17,66,87);">
                        基础信息 <i class="fa fa-address-book-o"></i>
                        <button type="button" class="btn btn-danger change visiable">修改资料</button>
                        <button type="button" class="btn btn-danger change disable" onclick="changePersonal()" >提交</button>
                    </div>
                    <div class="personalContent">
                        <table class="table personalTable ">
                            <tbody>
                                <tr>
                                    <td>用户ID：<span >${userId}<a href="http://localhost:8080/SpringMVC/exit" id="exit" >[退出]</a> <a href="javascript:changePassword();" id="editPassword" >[修改密码]</a></span>
                                    </td>
                                    <td>用户名：<span class="visiable">${userName}</span>
                                    <span class="disable"><input type="text" name="userName" id="userName"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>用户组：${userPoints}</td>
                                    <td>积分：${userPoint}</td>
                                </tr>
                                <tr>
                                    <td colspan="2">注册日期：${birth}</td>
                                </tr>
                                <tr>
                                    <td colspan="2">个人签名： <textarea name="personalSignature" id="personalSignature" placeholder="该用户什么都没有写...." class="visiable" readonly></textarea>
                                    <textarea name="personalSignature" id="personalSignature_1" class="disable" ></textarea>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="personalBodyTop" style="background-color:#3A3838;">
                        用户头像 <i class="fa fa-camera"></i>
                        <button type="button" class="btn btn-danger changeImg" id="changeIcon">修改头像</button>
                    </div>
                    <div class="imgContent" style="position: relative;">
                        <div class="imgShow" >
                            <img src="#" alt="用户头像" onerror="javascript:this.src='http://localhost:8080/SpringMVC/indexImage/indexImg.jpg'" style="width:198px;height:198px;display:inline-block;">
                        </div>
                        <div class="imgContainer" style="display:none">
                            <img src="http://localhost:8080/SpringMVC/indexImage/indexImg.jpg" alt="用户头像" onerror="javascript:this.src='http://localhost:8080/SpringMVC/indexImage/indexImg.jpg'" >
                        </div>
                        <label  class="importDiv" style="display:none" for="inputImage" title="Upload image file">
                        <input  id="inputImage" name="file" type="file" accept="image/*">
                        <span class="importImage">上传图片&nbsp;&nbsp;&nbsp;<i class="fa fa-cloud-upload"></i></span>
                        </label>
                        <div class="imgConfirm" style="display:none">
                            确认&nbsp;&nbsp;&nbsp;<i class="fa fa-check-circle-o"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6 tip">
                    <div class="personalBodyTop" style="background-color:rgb(198,26,22);margin-top: 50px;">
                        ${userName}的提醒消息 <i class="fa fa-bell"></i>
                        <button type="button" class="btn btn-default tipBtn" id="tipDeleteArray" >批量删除</button>
                    </div>
                    <div class="personalContent" style="position: relative;">
                    <div class="tipContainer" style="width:100%;">
                        	<div class="emailIndex">暂无提醒消息</div>
                     </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 email">
                    <div class="personalBodyTop" style="background-color:#1F5F01;margin-top: 50px;">
                        ${userName}的短消息 <i class="fa fa-envelope"></i>
                        <button type="button" class="btn btn-danger send" id="sendEmail" >发送消息</button>
                    </div>
                    <div class="personalContent" style="position: relative;">
                        <div class="emailContainer" style="width:100%;">
                        	<div class="emailIndex">暂无短消息</div>
                        </div>
                        <div class="sendEmailContainer" style="display:none;">
                                <div class="sendEmailCol">
                                    <input type="text" name="emailTarget" id="emailTarget" placeholder="请填写收件人的id或名字"><label>填写收件人</label><br>
                                    <span class="emailError" >您填写的收件人id或姓名不存在或重复 </span>
                                </div>
                                <div class="sendEmailCol">
                                    <label>邮件内容</label><br>
                                    <textarea name="emailContent" id="emailContent" placeholder="消息内容"></textarea><br>
                                    <span class="emailError" >请填写邮件内容</span>
                                    <input type="hidden" id="error" value="0" >
                                </div>
                                <div class="sendEmailCol">
                                    <button type="button" class="btn btn-primary" id="emailBtn" >发送</button>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="personalBodyTop" style="background-color:#BA9F08; margin-top: 50px;">
                        ${userId}发布的帖子 <i class="fa fa-edit"></i>
                    </div>
                     <div class="personalContent">
                      <a href="#" class="personalLink" >[搜索${userName}发布的主题]</a> <a href="#" class="personalLink" >[搜索${userName}发布的回复]</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="blackFog">
    </div>
    <div class="changePassword">
            <div class="passwordTitle">
                修改密码 <i class="fa fa-close" id="close"></i>
            </div>
            <div class="passwordBody">
                	<input type="hidden" name="userId" id="userId">
                    <div class="passwordRow">
                    <label>原密码</label><br> <input type="password" name="password" class="inputCss" >
                    <div class="passwordWarn">输入的原密码不正确</div>
                    </div>
                    <div class="passwordRow">
                    <label>新密码</label><br> <input type="password" name="newPassword" class="inputCss" >
                    <div class="passwordWarn">只能输入6-20个字母、数字、下划线</div>
                    </div>
                    <div class="passwordRow">
                    <label>再次输入密码</label><br> <input type="password" name="reNewPassword" class="inputCss">
                    <div class="passwordWarn">密码与新密码格式不一致</div>
                    </div>
                    <div class="passwordRow">
                    <label>验证码</label> <br> <div id="verifyDiv"><input type="text" name="verificationCode" class="inputCss" style="width:60%; "> <div id="Verify" style="display:inline-block; width:35%; height:40px; margin-left: 10px; "></div></div>
                    <div class="passwordWarn">验证码错误!</div>
                    </div>
                    <div class="passwordRow">
                        <input type="submit" name="submit" value="提交" class="passwordBtn" onclick="password()" >
                    </div>
            </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"  aria-hidden="true" aria-labelledby="myModalLabel" data-keyboard="false" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="window.location.reload();" >&times;</button>
                 <h4 class="modal-title" id="myModalLabel">消息提醒</h4>
            </div>
            <div class="modal-body" style="text-align:center;" >
                <div class="success">
                    <i class="fa fa-check-circle fa-5x" ></i>
                </div>
                <h3>修改成功！</h3>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="window.location.reload();" >关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
    </div>
    <div class="modal fade" id="myModal_1" tabindex="-1" role="dialog"  aria-hidden="true" aria-labelledby="myModalLabel" data-keyboard="false" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="window.location.reload();" >&times;</button>
                 <h4 class="modal-title" id="myModalLabel">消息提醒</h4>
            </div>
            <div class="modal-body" style="text-align:center;" >
                <div class="success">
                    <i class="fa fa-check-circle fa-5x" ></i>
                </div>
                <h3>上传成功！</h3>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="window.location.reload();" >关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
    </div>
    <div class="modal fade" id="myModal_2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
                <input type="hidden" name="modalId" id="modalId" >
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
    <div id="showImage" style="display:none">
    </div>
</body>
<script>
	var userRemark='${userRemark}';
	var userId='${userId}';
	var userId_1="<%=userBean.getUserId()%>";
	var userPassword="<%=userBean.getPassword()%>";
	var verifyCode = new GVerify("Verify");
	var json='${json}';
	var tipJson='${tipJson}';
	var pageNum='${pageNum}';
	var tipNum='${tipNum}';
	pageNum=parseInt(pageNum);
	tipNum=parseInt(tipNum);
	var pageIndex=1;
	var tipIndex=1;
	$("#userId").val(userId);
	$("#personalSignature").val(userRemark);
	var url_1="http://localhost:8080/SpringMVC/search?searchContent="+userId+"&searchClass=按用户主题搜索";
	var url_2="http://localhost:8080/SpringMVC/search?searchContent="+userId+"&searchClass=按用户回复搜索";
	url_1=encodeURI(url_1);
	url_2=encodeURI(url_2);
	$(".personalLink:eq(0)").attr("href",url_1);
	$(".personalLink:eq(1)").attr("href",url_2);
	var b="<%=b%>";
	$(".imgShow img").attr("src","http://localhost:8080/SpringMVC/personalIcon/"+userId+".jpg");
	$(".imgContainer img").attr("src","http://localhost:8080/SpringMVC/personalIcon/"+userId+".jpg");
	if(b=="true"){
		$("#BannerRight").hide();
		$(".change:eq(0)").hide();
		$("#changeIcon").hide();
		$("#exit").hide();
		$("#editPassword").hide();
		$(".email").hide();
		$(".tip").hide();
		$('#personalBody').css("height","560px");
	}else{
		$(".personalHref").attr("href","http://localhost:8080/SpringMVC/personal/"+userId_1);
		$(".personalHref img").attr("src","http://localhost:8080/SpringMVC/personalIcon/"+userId_1+".jpg");
		if(userId_1!=userId){
			$(".change:eq(0)").hide();
			$("#changeIcon").hide();
			$("#exit").hide();
			$("#editPassword").hide();
			$(".email").hide();
			$(".tip").hide();
			$('#personalBody').css("height","560px");
		}

	}
	if(json!='{"emails":]}'&&json!=''){
		var mailArray=JSON.parse(json);
		$(".emailContainer:eq(0)").html("");
		for(var i=0;i<mailArray.emails.length;i++){
			creatCol(mailArray.emails[i].emailId,mailArray.emails[i].senderId,mailArray.emails[i].senderName,mailArray.emails[i].content,mailArray.emails[i].time);
		}
		creatPageCol(pageNum,pageIndex);
	}
	if(tipJson!='{"tips":]}'&&tipJson!=''){
		var tipArray=JSON.parse(tipJson);
		$(".tipContainer:eq(0)").html("");
		for(var i=0;i<tipArray.tips.length;i++){
			creatTipCol(tipArray.tips[i].themeId,tipArray.tips[i].themeName,tipArray.tips[i].time,tipArray.tips[i].type,tipArray.tips[i].tipId);
		}
		creatTipPageCol(tipNum,tipIndex);
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