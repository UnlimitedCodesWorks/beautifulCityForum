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
	var headpic=$('<image src="http://localhost:8080/SpringMVC/personalIcon/'+userId+'.jpg" onerror="javascript:this.src=\'http://localhost:8080/SpringMVC/indexImage/indexImg.jpg\'" >');
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
	response.attr("onclick","Floor(\""+floorNumber+"\",\""+floorId+"\")");
	
	var floorIn=$('<div></div>');
	floorIn.addClass("floorIn");
	floorIn.attr("id","floorIn"+floorNumber);
	time.append(floorIn);
	floorIn.css('display','none');
	
	var response1=$('<div></div>');
	response1.attr("id","response1"+floorNumber);
	floorIn.append(response1);
	
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
	
	ban.attr("onclick","ban(\""+userId+"\",this)");
	
	input(floorId,floorNumber);
	
}


function Floor(i,floorId){ 

  
	if($('#floorIn'+i).is(':hidden')){//如果当前隐藏  
            $('#floorIn'+i).css('display','block');
            $('#responseFloor'+i).html("收起回复") ;
            }else{//否则  
            $('#floorIn'+i).css('display','none');
            $('#responseFloor'+i).html("查看回复") ;
            }
	
	$('#response1'+i).html("");
	$.ajax({
	    type: "POST",
		url: "http://localhost:8080/SpringMVC/responseFloorAjax",
		data: {
			floorId:floorId,
			floorNumber:i
		},
		dataType: "json",
		success: function(data){

			for(var i=0;i<data.response.length;i++){
			var userName=data.response[i].userName;
			var contentId=data.response[i].contentId;
			var responseContent=data.response[i].responseContent;
			var floorId=data.response[i].floorId;
			var floorNumber=data.response[i].floorNumber;
			var responseTime=data.response[i].responseTime;
			var responseId=data.response[i].responseId;
			createResponse(userName,responseId,responseContent,responseTime,floorId,contentId,floorNumber);}
		},
		error: function(jqXHR){
			$('#response1'+i).html("");
		},
	});
	
	
	

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

function ban(userId,val){
	$("#modal-container-538356").modal('show');
	$("#infocontext1").html("确定禁言此用户吗？禁言后该用户将不可再发言");
	
	$("#confirm1").click(function(){
		$.ajax({ 
		    type: 'POST', 

			url: 'http://localhost:8080/SpringMVC/banAjax',
			data: {
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


function createResponse(userName,responseId,content,time,floorId,contentId,floorNumber){

	var response2=$('<div></div>');
	var responseHead=$('<div></div>');
	var responseName=$('<div></div>');
	var responseContent=$('<div></div>');
	var responseContent1=$('<div></div>');
	var responseTime=$('<span></span>');
	var delete1=$('<span></span>');
	var delete_a1=$('<a></a>');
	var deleteNode='<i class="glyphicon glyphicon-trash"></i>删除';
	delete_a1.html(deleteNode);
	delete1.append(delete_a1);
	delete1.addClass("delete1");
	response2.append(responseHead);
	response2.append(responseName);
	response2.append(responseContent);
	response2.addClass("response2");
	responseHead.addClass("responseHead");
	responseName.addClass("responseName");
	responseContent.addClass("responseContent");
	responseContent1.addClass("responseContent1");
	responseContent1.html(content);
	responseContent.append(delete1);
	responseContent.append(responseContent1);
	responseContent.append(responseTime);
	responseName.html(userName+":");
	responseTime.html(time)
	$('#response1'+floorNumber).append(response2);
	
	var responseHeadPic=$('<image src="http://localhost:8080/SpringMVC/personalIcon/'+responseId+'.jpg" onerror="javascript:this.src=\'http://localhost:8080/SpringMVC/indexImage/indexImg.jpg\'" style="width:60%;"/>');
	responseHead.append(responseHeadPic);
	
	delete_a1.attr("onclick","deleteResponse(\""+contentId+"\",this)");
	
		
}

function input(floorId,i){
	var input=$('<div></div>');
	var text=$('<textarea></textarea>');
	var submit=$('<span></span>');
	input.addClass("input");
	input.append(text);
	input.append(submit);
	text.css("resize","none");
	text.addClass("text");
	submit.addClass("submit");
	$('#floorIn'+i).append(input);
	submit.html("我也说一句");
	submit.attr("id","submit"+i);
	text.attr("id","text"+i);
	submit.attr("onclick","responseFloor(\""+floorId+"\",\""+i+"\")");
}




function deleteResponse(contentId,val){
	$("#modal-container-972740").modal('show');
	$("#infocontext2").html("确定要删除此层吗？");
	
	$("#confirm2").click(function(){
		$.ajax({ 
		    type: 'POST', 	
			url: 'http://localhost:8080/SpringMVC/removeResponseAjax',
			data: {
				contentId:contentId,
			},
			dataType: 'json',
			success: function(data){
				if(data.success){
					var fNode =val.parentNode.parentNode.parentNode;
					fNode.remove();
					$("#modal-container-972740").modal('hide');
					}
			},
			error: function(jqXHR){     
			   alert("发生错误：" + jqXHR.status);  
			},     
		});
	});
	
}






