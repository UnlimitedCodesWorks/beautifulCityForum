/*
* @Author: Marte
* @Date:   2017-08-07 13:18:56
* @Last Modified by:   Marte
* @Last Modified time: 2017-08-11 16:03:11
*/
$(document).ready(function(){
  $('#carousel-14093').carousel({
    interval: 10000
});


   $("#login").fadeTo(2500,0.7);

});

function loging(){
	$.ajax({
	    type: "POST",
		url: "http://localhost:8080/SpringMVC/loginAjax",
		data: {
			userId: $("#userId").val(),
			password:$("#password").val(),
		},
		dataType: "json",
		success: function(data){
			var result=data.result;
			if (result=="pass") {
				$('#modal-container-925069').modal('show');
				
			} 
			else if(result=="passfailed1"){
				
				$('#modal-container-835836').modal('show');
				$("#infocontext").html("密码错误");
			}
			else if(result=="passfailed2"){
				$('#modal-container-835836').modal('show');
				$("#infocontext").html("请输入完整信息");
			}
			else if(result=="passfailed3"){
				$('#modal-container-835836').modal('show');
				$("#infocontext").html("账号不存在");
			}
		},
		error: function(jqXHR){
		   alert("发生错误：" + jqXHR.status);
		},
	});
}
