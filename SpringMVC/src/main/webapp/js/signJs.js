/*
* @Author: Marte
* @Date:   2017-08-12 14:54:55
* @Last Modified by:   Marte
* @Last Modified time: 2017-08-12 15:01:16
*/


$(document).ready(function(){
  $('#carousel-14093').carousel({
    interval: 10000
});


   $("#sign").fadeTo(2500,0.7);

});

function signing(){
	var userId=$("#userId").val();
	var userName=$("#useName").val();
	var password=$("#password").val();
	var repassword=$("#repassword").val();
	if(userId==""||userName==""||password==""||repassword=="")
		{
		$('#modal-container-575017').modal('show');
		$("#infocontext").html("请输入完整信息");
		}
	else{
		$.ajax({
		    type: "POST",
			url: "http://localhost:8080/SpringMVC/signAjax",
			data: {
				userId: $("#userId").val(),
				userName:$("#userName").val(),
				password:$("#password").val(),
				repassword:$("#repassword").val(),
			},
			dataType: "json",
			success: function(data){
				var result=data.result;
				if (result=="pass") {
					$('#modal-container-97693').modal('show');
					
				} 
				else if(result=="passfailed1"){
					
					$('#modal-container-575017').modal('show');
					$("#infocontext").html("账号已存在");
				}
				else if(result=="passfailed2"){
					$('#modal-container-575017').modal('show');
					$("#infocontext").html("两次密码输入不一致");
				}
			},
			error: function(jqXHR){
			   alert("发生错误：" + jqXHR.status);
			},
		});
	}
	
	
}