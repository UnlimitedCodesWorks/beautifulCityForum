/*
* @Author: Marte
* @Date:   2017-08-16 14:13:53
* @Last Modified by:   Marte
* @Last Modified time: 2017-08-16 15:28:55
*/

$(document).ready(function(){

  var um = UM.getEditor('myEditor');
  UM.getEditor('myEditor').setWidth('100%');
  UM.getEditor('myEditor').setHeight(200);
  
  

});




function createFloor(userName,userId,floorContent,floorTime,floorNumber,title,floorId){
	
	var floor1=$('<div></div>');
	var left=$('<div></div>');
	var right=$('<div></div>');
	floor1.append(left);
	floor1.append(right);
	$("#floor").append(floor1);
	floor1.addClass("floor1");
	left.addClass("left");
	right.addClass("right");
	
	var head=$('<div></div>');
	var headpic=$('<image src=images/head.jpg/>');
	var name=$('<div></div>');
	var level=$('<div></div>');
	left.append(head);
	left.append(name);
	left.append(level);
	head.append(headpic);
	head.addClass("head");
	name.addClass("name");
	level.addClass("level");
	
	
	var bandelete=$('<span></span>');
	bandelete.addClass("bandelete");
	var content=$('<div></div>');
	content.addClass("content");
	var time=$('<div></div>');
	time.addClass("time");
	right.append(bandelete);
	right.append(content);
	right.append(time);
	
	

	time.html(floorNumber+"楼"+"&nbsp"+floorTime+"&nbsp");
	level.html("用户组："+title);
	content.html(floorContent);
	
	var response=$('<a></a>');
	response.html("查看回复");
	time.append(response);
	response.addClass("responseFloor");
	response.attr("id","responseFloor"+floorNumber);
	response.attr("onclick","Floor(\""+floorNumber+"\")");
	
	var floorIn=$('<div></div>');
	floorIn.addClass("floorIn");
	floorIn.attr("id","floorIn"+floorNumber);
	time.append(floorIn);
	floorIn.css('display','none');
	
	var userName1=$('<a></a>');
	userName1.html(userName);
	userName1.attr("href","http://localhost:8080/SpringMVC/personal/"+userId);
	name.append(userName1);
	
	
	bandelete.addClass("bandelete");
	
	var ban=$('<a></a>');
	var banNode='&nbsp[<i class="glyphicon glyphicon-ban-circle"></i>禁言]';
	ban.html(banNode);
	bandelete.append(ban);
	var delete1=$('<a></a>');
	var deleteNode='<i class="glyphicon glyphicon-trash"></i>删除';
	delete1.html(deleteNode);
	bandelete.append(delete1);
	ban.addClass("ban");
	name.append(ban);
	
	delete1.attr("href","javascript:void(0)");
	delete1.attr("onclick","deleteFloor(\""+floorId+"\",this)");
	
	ban.attr("onclick","ban(\""+floorId+"\",\""+userId+"\",this)");
	
	
	
	
	var response1=$('<div></div>');
	var responseHead=$('<div></div>');
	var responseName=$('<div></div>');
	var responseContent=$('<div></div>');
	var responseContent1=$('<div></div>');
	var responseTime=$('<span></span>');
	response1.append(responseHead);
	response1.append(responseName);
	response1.append(responseContent);
	response1.addClass("response1");
	responseHead.addClass("responseHead");
	responseName.addClass("responseName");
	responseContent.addClass("responseContent");
	responseContent1.addClass("responseContent1");
	responseContent.append(responseContent1);
	responseContent.append(responseTime);
	responseTime.html("2017-09-12 13:50&nbsp")
	floorIn.append(response1);
	
	var responseHeadPic=$('<image src=images/head.jpg style="width:60%;"/>');
	responseHead.append(responseHeadPic);
	
	
	
		
}


function Floor(i){ 

  
	if($('#floorIn'+i).is(':hidden')){//如果当前隐藏  
            $('#floorIn'+i).css('display','block');
            $('#responseFloor'+i).html("收起回复") ;
            }else{//否则  
            $('#floorIn'+i).css('display','none');
            $('#responseFloor'+i).html("查看回复") ;
            }

};


function deleteFloor(floorId,val){
	$("#modal-container-362503").modal('show');
	$("#infocontext").html("确定要删除此层吗？");
	
	$("#confirm").click(function(){
		$.ajax({ 
		    type: 'POST', 	
			url: 'http://localhost:8080/SpringMVC/removeAjax',
			data: {
				floorId:floorId,
			},
			dataType: 'json',
			success: function(data){
				if(data.success){
					var fNode =val.parentNode.parentNode.parentNode;
					fNode.remove();
					$("#modal-container-362503").modal('hide');
					}
			},
			error: function(jqXHR){     
			   alert("发生错误：" + jqXHR.status);  
			},     
		});
	});
	
}

function ban(floorId,userId,val){
	$("#modal-container-538356").modal('show');
	$("#infocontext1").html("确定禁言此用户吗？");
	
	$("#confirm1").click(function(){
		$.ajax({ 
		    type: 'POST', 	
			url: 'http://localhost:8080/SpringMVC/banAjax',
			data: {
				floorId:floorId,
				userId:userId
			},
			dataType: 'json',
			success: function(data){
				if(data.success){
					$("#modal-container-538356").modal('hide');
					}
			},
			error: function(jqXHR){     
			   alert("发生错误：" + jqXHR.status);  
			},     
		});
	});
	
}


function createResponse(userName,responseId,responseContent,responseTime,floorId,contentId){

	
	var floor1=$('<div></div>');
	var left=$('<div></div>');
	var right=$('<div></div>');
	floor1.append(left);
	floor1.append(right);
	$("#floor").append(floor1);
	floor1.addClass("floor1");
	left.addClass("left");
	right.addClass("right");
	
	var head=$('<div></div>');
	var headpic=$('<image src=images/head.jpg/>');
	var name=$('<div></div>');
	left.append(head);
	left.append(name);
	head.append(headpic);
	head.addClass("head");
	name.addClass("name");
	
	
	var bandelete=$('<span></span>');
	bandelete.addClass("bandelete");
	var content=$('<div></div>');
	content.addClass("content");
	var time=$('<div></div>');
	time.addClass("time");
	right.append(bandelete);
	right.append(content);
	right.append(time);
	
	

	time.html("&nbsp"+responseTime+"&nbsp");
	content.html(responseContent);
	
	
	var userName1=$('<a></a>');
	userName1.html(userName);
	userName1.attr("href","http://localhost:8080/SpringMVC/personal/"+responseId);
	name.append(userName1);
	
	
	bandelete.addClass("bandelete");
	
	var delete1=$('<a></a>');
	var deleteNode='<i class="glyphicon glyphicon-trash"></i>删除';
	delete1.html(deleteNode);
	bandelete.append(delete1);
	
	delete1.attr("href","javascript:void(0)");
	delete1.attr("onclick","deleteFloor(\""+floorId+"\",this)");
	
		
}




