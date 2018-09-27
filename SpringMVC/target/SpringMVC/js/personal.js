/*
* @Author: Marte
* @Date:   2017-08-07 13:18:42
* @Last Modified by:   Marte
* @Last Modified time: 2017-09-07 13:55:18
*/
var time;
$(function(){
  $("#bannerSearch").mouseenter(function(){
    clearTimeout(time);
  $("#bannerSearch").animate({
        width:'28em'
  });
  $('.input-group-btn').css('display','table-cell');
});
  $("#bannerSearch").mouseleave(function(){
    time=setTimeout(function(){
       $("#bannerSearch").animate({
        width:'6.6em'
      });
    $('.input-group-btn').css('display','none');
    },2000);
});
  $('.change').click(function(){
        var visiable=$('.visiable');
        var disable=$('.disable');
        visiable.toggleClass("disable",true);
        visiable.toggleClass("visiable",false);
        disable.toggleClass("visiable",true);
        disable.toggleClass("disable",false);
  });
  $('#close').click(function(event) {
      $('.blackFog').css('display','none');
      $('.changePassword').slideUp("fast");
  });
  var $image=$('.imgContainer > img');
  var form = document.forms.namedItem("fileinfo");
  $image.cropper({
    aspectRatio: 1 / 1,
    guides: false
  });
  var $inputImage = $('#inputImage'),
        URL = window.URL || window.webkitURL,
        blobURL;

    if (URL) {
      $inputImage.change(function () {
        var files = this.files,
            file;

        if (files && files.length) {
          file = files[0];

          if (/^image\/\w+$/.test(file.type)) {
            blobURL = URL.createObjectURL(file);
            $image.one('built.cropper', function () {
              URL.revokeObjectURL(blobURL); // Revoke when load complete
            }).cropper('reset', true).cropper('replace', blobURL);
            $inputImage.val('');
          } else {
            showMessage('Please choose an image file.');
          }
        }
      });
    } else {
      $inputImage.parent().remove();
    }

    $("#changeIcon").click(function(event) {
      var content=event.target.textContent;
      if(content=='修改头像'){
    	  $('.imgShow > img').fadeOut();
          $('.imgShow').css('display','none');
          $('.imgContent').animate({
            height:'+=110px'
          });
          $('.imgContainer').fadeIn();
          $('.importDiv').fadeIn();
          $('.imgConfirm').fadeIn();
          event.target.textContent='取消';
      }else if(content=="取消"){
    	  $("#changeIcon").css('display','inline-block');
	      $('.imgShow > img').fadeIn();
	      $('.imgShow').css('display','block');
	      $('.imgContent').animate({
	        height:'-=110px'
	      });
	      $('.imgContainer').fadeOut();
	      $('.importDiv').fadeOut();
	      $('.imgConfirm').fadeOut();
	      event.target.textContent='修改头像';
      }
    });

    $('.imgConfirm').click(function(event) {
      var result=$image.cropper('getCroppedCanvas');
      $("#showImage").html(result);
      var carvans=document.getElementById("showImage");
      carvans=carvans.getElementsByTagName("canvas")[0];
      var data=carvans.toDataURL();
       $.ajax({
    	  url: basePath+"iconAjax",
    	  type: "POST",
    	  data: {"image":data.toString()},
    	  dataType:'json',
    	  success: function(data){
    		  	  if(data.success){
    		  		$('#myModal').modal('show');
    		  	  }else{
    		  		  alert("发生错误");
    		  	  }
  		},
  		error: function(jqXHR){
  		   alert("发生错误：" + jqXHR.status);
  		},
      });
    });
    $('#themeSelect_1').click(function(e){
    $('#themeButton_1').html(e.target.textContent+' <span class="caret"></span>');
    $('#searchClass').val(e.target.textContent);
   });
    $('#bannerSearch').keypress(function(e){
	      if(e.which == 13 || e.which == 10){
	          turnSearch();
	      }
	   });
	   $('#searchBtn').click(function(e){
		   turnSearch();
	   });
	$(".inputCss:eq(0)").blur(function(e){
		var password=$(".inputCss:eq(0)").val();
		if(password!=userPassword){
			$(".passwordWarn:eq(0)").show();
			$("#bol").val("0");
		}else{
			$(".passwordWarn:eq(0)").hide();
			$("#bol").val("1");

		}

	});
	$(".inputCss:eq(1)").blur(function(e){
		var partern=/^(\w){6,20}$/;
		var value=$(".inputCss:eq(1)").val();
		if(!partern.exec(value)){
			$(".passwordWarn:eq(1)").show();
		}else{
			$(".passwordWarn:eq(1)").hide();
		}
	});
	$(".inputCss:eq(2)").blur(function(e){
		var value_1=$(".inputCss:eq(1)").val();
		var value_2=$(".inputCss:eq(2)").val();
		if(value_2!=value_1){
			$(".passwordWarn:eq(2)").show();
		}else{
			$(".passwordWarn:eq(2)").hide();
		}
	});
	$(".inputCss:eq(3)").blur(function(e){
		var res = verifyCode.validate($(".inputCss:eq(3)").val());
		if(!res){
			$(".passwordWarn:eq(3)").show();
		}else{
			$(".passwordWarn:eq(3)").hide();
		}
	});

  $("#sendEmail").click(function(event) {
    /* Act on the event */
    var value=event.target.textContent;
    if(value=='发送消息'){
      $(".emailContainer").hide();
      $(".sendEmailContainer").show();
      $(this).html('返回');
    }else if(value=='返回'){
      $(".emailContainer").show();
      $(".sendEmailContainer").hide();
      $(this).html('发送消息');
    }

  });
  
  $("#tipDeleteArray").click(function(e){
	  var value=e.target.textContent;
	  if(value=='批量删除'){
		  $(".tipDelete").show();
		  $(this).html('确认');
	  }else if(value=='确认'){
		  var node=$(".tipDelete:checked");
		  node=node.parent().prev();
		  var data=new Array();
		  for(var i=0;i<node.length;i++){
			  data.push(node[i].getAttribute("data"));
		  }
		 
		  $.ajax({ 
			    type: "POST", 	
				url: basePath+"tipDeleteAjax",
				data: {
					tipsId:data.toString()
				},
				dataType: "json",
				success: function(data){
					if (data.success) { 
						$('#myModal').modal('show');
					} 
				},
				error: function(jqXHR){     
				   alert("发生错误：" + jqXHR.status);  
				},     
			});
	  }
  });
  $("#emailTarget").blur(function(){
	  $.ajax({ 
		    type: "POST", 	
			url: basePath+"emailVaAjax",
			data: {
				user:$("#emailTarget").val()
			},
			dataType: "json",
			success: function(data){
				if (data.success) { 
					$(".emailError:eq(0)").hide();
					$("#error").val("1");
				} else{
					$(".emailError:eq(0)").show();
					$("#error").val("0");
				}
			},
			error: function(jqXHR){     
			   alert("发生错误：" + jqXHR.status);  
			},     
		});
  });
  
  $("#emailBtn").click(function(){
	  var value=$("#error").val();
	  if($("#emailContent").val().length==0){
		  $(".emailError:eq(1)").show();
	  }else{
		  $(".emailError:eq(1)").hide();
	  }
	  if(value=='0'){
		  $(".emailError:eq(0)").show();
		  $("#error").val("0");
	  }
	  if(value!='0'&&$("#emailContent").val().length>0){
		   $.ajax({ 
			    type: "POST", 	
				url: basePath+"emailAjax",
				data: {
					senderId:userId_1,
					recipient:$("#emailTarget").val(),
					content:$("#emailContent").val()
				},
				dataType: "json",
				success: function(data){
					if (data.success) { 
						$('#myModal_1').modal('show');
					} else {
						alert("发送消息出错！");
					}  
				},
				error: function(jqXHR){     
				   alert("发生错误：" + jqXHR.status);  
				},     
			}); 
	  }
  });
  $('#myModal').on('show.bs.modal', function (e) {  
      // 关键代码，如没将modal设置为 block，则$modala_dialog.height() 为零  
      $(this).css('display', 'block');  
      var modalHeight=$(window).height() / 2 - $('#myModal .modal-dialog').height() / 2;  
      $(this).find('.modal-dialog').css({  
          'margin-top': modalHeight  
      });  
  });
  $('#myModal_1').on('show.bs.modal', function (e) {  
      // 关键代码，如没将modal设置为 block，则$modala_dialog.height() 为零  
      $(this).css('display', 'block');  
      var modalHeight=$(window).height() / 2 - $('#myModal_1 .modal-dialog').height() / 2;  
      $(this).find('.modal-dialog').css({  
          'margin-top': modalHeight  
      });  
  });
  
  $('#myModal_2').on('show.bs.modal', function (e) {  
      // 关键代码，如没将modal设置为 block，则$modala_dialog.height() 为零  
      $(this).css('display', 'block');  
      var modalHeight=$(window).height() / 2 - $('#myModal_2 .modal-dialog').height() / 2;  
      $(this).find('.modal-dialog').css({  
          'margin-top': modalHeight  
      });  
  });
  
  $("#modalSubmit").click(function(){
	  $.ajax({ 
		    type: "POST", 	
			url: basePath+"emailDeleteAjax",
			data: {
				emailId:$("#modalId").val()
			},
			dataType: "json",
			success: function(data){
				if (data.success) { 
					$('#myModal').modal('show');
					$("#myModal_2").modal('hide');
				} else {
					alert("修改失败");
				}  
			},
			error: function(jqXHR){     
			   alert("发生错误：" + jqXHR.status);  
			},     
		}); 
  });
});

function changePassword(){
      $('.blackFog').css('display','block');
      var logindiv_width = $(".changePassword").css("width").replace("px", ""); //css("width")这样获取的是 数字加px, 
      var logindiv_height = $(".changePassword").css("height").replace("px", ""); //css("height")这样获取的是 数字加px 
      var scrollTop = $(document).scrollTop();   
      var scrollLeft = $(document).scrollLeft();   
      $(".changePassword").css({ 
          "margin-left": ($(window).width() - logindiv_width) / 2+scrollLeft, 
          "margin-top": ($(window).height() - logindiv_height) / 2+scrollTop 
      }); 
      $('.changePassword').show("1000");
  }

function turnSearch(){
	var url=basePath+"search?"+"searchContent="+$('#searchContent').val()+"&searchClass="+$('#searchClass').val();
    url=encodeURI(encodeURI(url));
    window.location.href=url;
}
function changePersonal(){
	$.ajax({
	    type: "POST",
		url: basePath+"personalAjax",
		data: {
			userName: $("#userName").val(),
			userRemark:$("#personalSignature_1").val(),
			userId:userId
		},
		dataType: "json",
		success: function(data){
			if (data.success) {
				$('#myModal').modal('show');
			} else {
				alert("出现错误!");
			}
		},
		error: function(jqXHR){
		   alert("发生错误：" + jqXHR.status);
		},
	});
}
function password(){
	var password=$(".inputCss:eq(0)").val();
	var partern=/^(\w){6,20}$/;
	var value=$(".inputCss:eq(1)").val();
	var value_1=$(".inputCss:eq(1)").val();
	var value_2=$(".inputCss:eq(2)").val();
	var res = verifyCode.validate($(".inputCss:eq(3)").val());
	if(password==userPassword&&partern.exec(value)&&value_2==value_1&&res){
		$.ajax({
		    type: "POST",
			url: basePath+"passwordAjax",
			data: {
				userId:userId,
				newPassword:value_2
			},
			dataType: "json",
			success: function(data){
				if (data.success) {
					$('#myModal').modal('show');
				} else {
					alert("出现错误!");
				}
			},
			error: function(jqXHR){
			   alert("发生错误：" + jqXHR.status);
			},
		});
	}
}

function creatCol(emailId,senderId,senderName,content,time){
	var node='<div class="row emailRow" style="height:50px"><div class="col-lg-1 col-md-1 emailCol">';
     node+='<img src="'+basePath+'personalIcon/'+senderId+'.jpg" onerror="javascript:this.src=\''+basePath+'indexImage/indexImg.jpg\'" style="width:50px;height:50px" >';
	 node+='</div><div class="col-lg-7 col-md-7 emailCol">';
	 node+='<a href="'+basePath+'personal/'+senderId+'">'+senderName+':</a>'+content;
	 node+='</div><div class="col-lg-2 col-md-2 emailCol">'+time+'</div> <div class="col-lg-2 col-md-2 emailCol" emailData="'+emailId+'" ><a href="javascript:void(0)" onclick="mailDelete(this)" >删除</a>';
	 node+='</div></div>';
	$(".emailContainer:eq(0)").append(node);
}
function creatPageCol(pageNum,pageIndex){
	var node='<div class="emailFooter">';
	for(var i=0;i<pageNum;i++){
		node+='<a href="javascript:void(0)" onclick="email(this)">'+(i+1)+'</a>';
	}
	if(pageIndex==1&&pageIndex!=pageNum){
		node+='<a href="javascript:void(0)" onclick="emailAfter()" >下一页</a>';
	}
	node+='</div>';
	$(".emailContainer:eq(0)").append(node);
	$(".emailFooter a:eq("+(pageIndex-1)+")").addClass("focus");
	if(pageIndex!=1){
		$(".emailFooter").prepend('<a href="javascript:void(0)" onclick="emailBefore()" >上一页</a>');
	}
}

function email(e){
	var page=$(e).text();
	$.ajax({ 
	    type: "POST", 	
		url: basePath+"emailPageAjax",
		data: {
			pageIndex:page
		},
		dataType: "json",
		success: function(data){
			pageIndex=parseInt(page);
			$(".emailContainer:eq(0)").html("");
			for(var i=0;i<data.emails.length;i++){
				creatCol(data.emails[i].emailId,data.emails[i].senderId,data.emails[i].senderName,data.emails[i].content,data.emails[i].time);
			}
			creatPageCol(pageNum,pageIndex);
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		},     
	});
}
function emailBefore(){
	var page=pageIndex-1;
	$.ajax({ 
	    type: "POST", 	
		url: basePath+"emailPageAjax",
		data: {
			pageIndex:page
		},
		dataType: "json",
		success: function(data){
			pageIndex--;
			$(".emailContainer:eq(0)").html("");
			for(var i=0;i<data.emails.length;i++){
				creatCol(data.emails[i].emailId,data.emails[i].senderId,data.emails[i].senderName,data.emails[i].content,data.emails[i].time);
			}
			creatPageCol(pageNum,pageIndex);
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		},     
	});
}
function emailAfter(){
	var page=pageIndex+1;
	$.ajax({ 
	    type: "POST", 	
		url: basePath+"emailPageAjax",
		data: {
			pageIndex:page
		},
		dataType: "json",
		success: function(data){
			pageIndex++;
			$(".emailContainer:eq(0)").html("");
			for(var i=0;i<data.emails.length;i++){
				creatCol(data.emails[i].emailId,data.emails[i].senderId,data.emails[i].senderName,data.emails[i].content,data.emails[i].time);
			}
			creatPageCol(pageNum,pageIndex);
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		},     
	});
}
function mailDelete(e){
	var node=$(e).parent();
	var emailId=node.attr("emaildata");
	$("#mymodal-body").html('您确定要<span style="color:red;font-weight:bold">删除</span>该消息吗？');
	$("#modalId").val(emailId);
	$("#myModal_2").modal('show');
}
function creatTipCol(themeId,themeName,time,type,tipId){
	var node='<div class="row"><div class="col-md-11 col-lg-11 tipRow" data="'+tipId+'">';
	node+=' <i class="fa fa-bookmark"></i> 您的主题 <a href="'+basePath+'read?id='+themeId+'">'
	+themeName+'</a>于<span style="color:#929191;">'+time+'</span> 被';
	node+='<span style="color:rgb(217,83,79); font-weight: bold;"> '+type+' </span></div><div class="col-md-1 col-lg-1 tipRow"><input type="checkbox" class="tipDelete"></div></div>';
	$(".tipContainer:eq(0)").append(node);
}
function creatTipPageCol(pageNum,pageIndex){
	var node='<div class="tipFooter">';
	for(var i=0;i<pageNum;i++){
		node+='<a href="javascript:void(0)" onclick="tip(this)">'+(i+1)+'</a>';
	}
	if(pageIndex==1&&pageIndex!=pageNum){
		node+='<a href="javascript:void(0)" onclick="tipAfter()" >下一页</a>';
	}
	node+='</div>';
	$(".tipContainer:eq(0)").append(node);
	$(".tipFooter a:eq("+(pageIndex-1)+")").addClass("focus");
	if(pageIndex!=1){
		$(".tipFooter").prepend('<a href="javascript:void(0)" onclick="tipBefore()" >上一页</a>');
	}
	var value=$("#tipDeleteArray").html();
	if(value=='确认'){
		$(".tipDelete").show();
	}
}

function tip(e){
	var page=$(e).text();
	$.ajax({ 
	    type: "POST", 	
		url: basePath+"tipPageAjax",
		data: {
			pageIndex:page
		},
		dataType: "json",
		success: function(data){
			tipIndex=parseInt(page);
			$(".tipContainer:eq(0)").html("");
			for(var i=0;i<data.tips.length;i++){
				creatTipCol(data.tips[i].themeId,data.tips[i].themeName,data.tips[i].time,data.tips[i].type,data.tips[i].tipId);
			}
			creatTipPageCol(tipNum,tipIndex);
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		},     
	});
}
function tipBefore(){
	var page=tipIndex-1;
	$.ajax({ 
	    type: "POST", 	
		url: basePath+"tipPageAjax",
		data: {
			pageIndex:page
		},
		dataType: "json",
		success: function(data){
			tipIndex--;
			$(".tipContainer:eq(0)").html("");
			for(var i=0;i<data.tips.length;i++){
				creatTipCol(data.tips[i].themeId,data.tips[i].themeName,data.tips[i].time,data.tips[i].type,data.tips[i].tipId);
			}
			creatTipPageCol(tipNum,tipIndex);
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		},     
	});
}
function tipAfter(){
	var page=tipIndex+1;
	$.ajax({ 
	    type: "POST", 	
		url: basePath+"tipPageAjax",
		data: {
			pageIndex:page
		},
		dataType: "json",
		success: function(data){
			tipIndex++;
			$(".tipContainer:eq(0)").html("");
			for(var i=0;i<data.tips.length;i++){
				creatTipCol(data.tips[i].themeId,data.tips[i].themeName,data.tips[i].time,data.tips[i].type,data.tips[i].tipId);
			}
			creatTipPageCol(tipNum,tipIndex);
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		},     
	});
}
