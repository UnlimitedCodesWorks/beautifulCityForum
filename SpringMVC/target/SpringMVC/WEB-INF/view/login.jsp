<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:useBean id="userBean" class="com.forum.login.LoginBean" scope="session"/>
<%
	boolean b=userBean==null||userBean.getUserId()==null||userBean.getUserId().length()==0;
	String loginResult =(String)request.getAttribute( "loginResult");
 %>
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
    <title>登录</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/SpringMVC/css/logincss.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://localhost:8080/SpringMVC/js/loginJs.js"></script>
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
                    绿遍山原白满川，子规声里雨如烟。   乡村四月闲人少，才了蚕桑又插田。
                </p> <small>宋·翁卷  <cite>《乡村四月》</cite></small>
            </blockquote>
        </div>
        <div class="col-md-3 column">
            <ul class="nav nav-tabs">
                <li >
                     <a href="http://localhost:8080/SpringMVC/forum/1"><i class="glyphicon glyphicon-home"></i>首页</a>
                </li>
                <li class="active">
                     <a href="#"><i class="glyphicon glyphicon-user"></i>登录</a>
                </li>
                <li >
                     <a href="http://localhost:8080/SpringMVC/sign"><i class="glyphicon glyphicon-edit"></i>注册</a>
                </li>
            </ul>
            <br>
            <div class="panel panel-info" id="login">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        Beautiful Country Forum
                    </h3>
                </div>
                <div class="panel-body">
                    <img alt="100*100" src="images/head.jpg" class="img-circle" />
                    <form class="bs-example bs-example-form" role="form" >
                    <br>
                        <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-user" ></span>
                        <input type="text" class="form-control" placeholder="账号" data-toggle="tooltip"
                            data-placement="right" title="请输入账号，由字母和数字组成" id="userId">
                        </div>
                        <br>
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-lock"></span>
                        <input type="password" class="form-control" placeholder="密码" data-toggle="tooltip"
                            data-placement="right" title="请输入密码" id="password">
                        </div>
                    <br>
                    
                    </form>
                    <button type="button" class="btn btn-primary btn-2g btn-block" onclick="loging()">登录</button>
                </div>
                <div class="panel-footer">
                    <span id="remember"><input type="checkbox" name="">记住密码</span>
                    <a href="#"  data-toggle="tooltip" data-placement="right" title="点击找回密码" id="find">忘记密码？</a>

                </div>
            </div>
        </div>
    </div>
</div>
			<div class="modal fade" id="modal-container-835836" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
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
			<div class="modal fade" id="modal-container-925069" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							 
							<h4 class="modal-title" id="myModalLabel" >
								提示
							</h4>
						</div>
						<div class="modal-body">
							登录成功
						</div>
						<div class="modal-footer">
							<a href="http://localhost:8080/SpringMVC/forum/1"> <button type="button" class="btn btn-success">回到论坛</button> </a>
						</div>
					</div>
					
				</div>
				
			</div>

</body>



