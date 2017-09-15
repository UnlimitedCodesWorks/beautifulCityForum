<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
      String path = request.getContextPath();
      String basePath = request.getScheme() + "://"
                  + request.getServerName() + ":" + request.getServerPort()
                  + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>注册</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://localhost:8080/SpringMVC/css/slide-unlock.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/css/signCss.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://localhost:8080/SpringMVC/js/signJs.js"></script>
    <script src="http://localhost:8080/SpringMVC/js/jquery.slideunlock.js"></script>
    <script src="http://localhost:8080/SpringMVC/jQueryYzm/js/gVerify.js"></script>
</head>
<body>
<div class="container">
    <div class="row clearfix" >

        <div class="col-md-9 column" id="picture">
        <i class="fa fa-gear fa-spin fa-2x fa-inverse" id="pic"></i>
            <div class="carousel slide" id="carousel-14093">
                <ol class="carousel-indicators">
                    <li class="active" data-slide-to="0" data-target="#carousel-14093">
                    </li>
                    <li data-slide-to="1" data-target="#carousel-14093">
                    </li>
                    <li data-slide-to="2" data-target="#carousel-14093">
                    </li>
                </ol>
                <div class="carousel-inner">
                    <div class="item active">
                        <img alt="" src="images/1.jpg" class="img-rounded"/>
                        <div class="carousel-caption">

                        </div>
                    </div>
                    <div class="item">
                        <img alt="" src="images/2.jpg" class="img-rounded"/>
                        <div class="carousel-caption">

                        </div>
                    </div>
                    <div class="item">
                        <img alt="" src="images/3.jpg"  class="img-rounded" />
                        <div class="carousel-caption">

                        </div>
                    </div>
                </div>
            </div>
            <blockquote>
                <p>
                    空山不见人， 但闻人语响。 返景入深林， 复照青苔上。
                </p> <small>唐·王维  <cite>《鹿柴》</cite></small>
            </blockquote>
        </div>
        <div class="col-md-3 column">
            <ul class="nav nav-tabs">
                <li >
                     <a href="http://localhost:8080/SpringMVC/forum/1"><i class="glyphicon glyphicon-home"></i>首页</a>
                </li>
                <li >
                     <a href="http://localhost:8080/SpringMVC/login"><i class="glyphicon glyphicon-user"></i>登录</a>
                </li>
                <li class="active">
                     <a href="#"><i class="glyphicon glyphicon-edit"></i>注册</a>
                </li>
            </ul>
            <br>
            <div class="panel panel-info" id="sign">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        Beautiful Country Forum
                    </h3>
                </div>
                <div class="panel-body">
                    <form class="bs-example bs-example-form" role="form">
                    <br>
                        <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-user" ></span>
                        <input type="text" class="form-control" placeholder="邮箱/手机" data-toggle="tooltip"
                            data-placement="right" title="请输入账号，由字母和数字组成" id="userId">
                        </div>
                        <br>
                        <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-edit" ></span>
                        <input type="text" class="form-control" placeholder="昵称" data-toggle="tooltip"
                            data-placement="right" title="请输入用户昵称" id="userName">
                        </div>
                        <br>
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-lock"></span>
                        <input type="password" class="form-control" placeholder="密码" data-toggle="tooltip"
                            data-placement="right" title="请输入密码" id="password">
                        </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-lock" ></span>
                        <input type="password" class="form-control" placeholder="确认密码" data-toggle="tooltip"
                            data-placement="right" title="请再次输入密码" id="repassword">
                        </div>
                        <br>
                    </form>
                    
                    
                     
                
            </div>
            <div class="panel-footer">
                    <button type="button" class="btn btn-primary btn-2g btn-block" onclick="signing()">注册</button>

                </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-container-575017" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
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
							 <button type="button" class="btn btn-warning" data-dismiss="modal" >关闭</button> 
						</div>
					</div>
					
				</div>
				
			</div>
			<div class="modal fade" id="modal-container-97693" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							 
							<h4 class="modal-title" id="myModalLabel" >
								提示
							</h4>
						</div>
						<div class="modal-body">
							注册成功
						</div>
						<div class="modal-footer">
							<a href="http://localhost:8080/SpringMVC/login"> <button type="button" class="btn btn-success">转至登录</button> </a>
						</div>
					</div>
					
				</div>
				
			</div>

</body>
<script>
        var verifyCode = new GVerify("v_container");
        document.getElementById("my_button").onclick = function(){
            var res = verifyCode.validate(document.getElementById("code_input").value);
            if(res){
                alert("验证正确");
            }else{
                alert("验证码错误");
            }
        }
    </script>
</html>