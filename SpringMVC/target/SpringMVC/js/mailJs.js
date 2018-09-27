/*
* @Author: Marte
* @Date:   2017-08-15 13:16:13
* @Last Modified by:   Marte
* @Last Modified time: 2017-08-16 11:29:31
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
});

function turnSearch(){
	var url=basePath+"search?"+"searchContent="+$('#searchContent').val()+"&searchClass="+$('#searchClass').val();
    url=encodeURI(encodeURI(url));
    window.location.href=url;
}
function creatCol(label,themeName,content,userId,userName,time,themeId,responseId){
	var node='<div class="row mailContentRow"><div class="col-md-4 mailContentCol_1">';
	 for(var i=0;i<label.length;i++){
			node+='<a href="javascript:void(0)" class="label_1" onclick="labelSearch(this)" >['+label[i]+']</a>';
		}
	 node+='<a href="'+basePath+'read?id='+themeId+'">'+themeName+'</a>';
	 node+='</div><div class="col-md-4 mailContentCol_2"><a href="'+basePath+'read?id='+responseId+'">'+content+'</a></div><div class="col-md-2 mailContentCol_3">'
	 +'<a href="'+basePath+'personal/'+userId+'">'+userName+'</a></div><div class="col-md-2 mailContentCol_4">'
	 +time+'</div></div>';
	 $("#mailBodyContent").append(node);
}
function labelSearch(e){
	var str=$(e).text().substring(1,5);
	var url=basePath+"search?"+"searchContent="+str+"&searchClass=按标签搜索";
	url=encodeURI(encodeURI(url));
	window.location.href=url;
}
function creatPageCol(pageNum,pageIndex){
	var node="";
	for(var i=0;i<pageNum;i++){
		node+='<li><a href="javascript:void(0)" onclick="turnPage(this)" >'+(i+1)+'</a></li>';
	}
	if(pageNum!=1&&pageIndex!=pageNum){
		node+='<li><a href="javascript:void(0)" onclick="nextPage()" >下一页 &rarr;</a></li>';
	}
	$('.forumPagination').append(node);
	$('.forumPagination > li:eq('+(pageIndex-1)+')').addClass("focus");
	if(pageIndex!=1){
		$('.forumPagination').prepend('<li><a href="javascript:void(0)" onclick="beforePage()" >&larr; 上一页</a></li>');
	}
}
function turnPage(e){
	var page=$(e).text();
	$.ajax({ 
	    type: "POST", 	
		url: basePath+"mailPageAjax",
		data: {
			pageIndex:page
		},
		dataType: "json",
		success: function(data){
			$("#mailBodyContent").html("");
			$(".forumPagination:eq(0)").html("");
			pageIndex=parseInt(page);
			 var node_1='<div class="row mailContentRow"><div class="col-md-4" style="color:#767474; font-weight: 600;"><i class="fa fa-home"></i> 主题</div><div class="col-md-4" style="color:#767474; font-weight: 600;"><i class="fa fa-envelope-open"></i> 回复内容</div><div class="col-md-2" style="color:#767474; font-weight: 600;"><i class="fa fa-user"></i> 回复者</div><div class="col-md-2" style="color:#767474; font-weight: 600;"><i class="fa fa-clock-o"></i> 回复时间</div></div>';
			 $("#mailBodyContent").append(node_1);
			for(var i=0;i<data.themes.length;i++){
		   		var labelArray=new Array();
		   		for(var j=0;j<data.themes[i].label.length;j++){
		   			labelArray.push(data.themes[i].label[j]);
		   		}
		   		creatCol(labelArray,data.themes[i].themeName,data.themes[i].content,data.themes[i].userId,data.themes[i].userName,data.themes[i].themeTime,data.themes[i].themeId,data.themes[i].responseId);
		   	}
			creatPageCol(pageNum,pageIndex);
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		},     
	});
}
function nextPage(){
	var page=++pageIndex;
	$.ajax({ 
	    type: "POST", 	
		url: basePath+"mailPageAjax",
		data: {
			pageIndex:page
		},
		dataType: "json",
		success: function(data){
			$("#mailBodyContent").html("");
			$(".forumPagination:eq(0)").html("");
			 var node_1='<div class="row mailContentRow"><div class="col-md-4" style="color:#767474; font-weight: 600;"><i class="fa fa-home"></i> 主题</div><div class="col-md-4" style="color:#767474; font-weight: 600;"><i class="fa fa-envelope-open"></i> 回复内容</div><div class="col-md-2" style="color:#767474; font-weight: 600;"><i class="fa fa-user"></i> 回复者</div><div class="col-md-2" style="color:#767474; font-weight: 600;"><i class="fa fa-clock-o"></i> 回复时间</div></div>';
			 $("#mailBodyContent").append(node_1);
			for(var i=0;i<data.themes.length;i++){
		   		var labelArray=new Array();
		   		for(var j=0;j<data.themes[i].label.length;j++){
		   			labelArray.push(data.themes[i].label[j]);
		   		}
		   		creatCol(labelArray,data.themes[i].themeName,data.themes[i].content,data.themes[i].userId,data.themes[i].userName,data.themes[i].themeTime,data.themes[i].themeId,data.themes[i].responseId);
		   	}
			creatPageCol(pageNum,pageIndex);
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		   pageIndex--;
		},     
	});
}
function beforePage(){
	var page=--pageIndex;
	$.ajax({ 
	    type: "POST", 	
		url: basePath+"mailPageAjax",
		data: {
			pageIndex:page
		},
		dataType: "json",
		success: function(data){
			$("#mailBodyContent").html("");
			$(".forumPagination:eq(0)").html("");
			 var node_1='<div class="row mailContentRow"><div class="col-md-4" style="color:#767474; font-weight: 600;"><i class="fa fa-home"></i> 主题</div><div class="col-md-4" style="color:#767474; font-weight: 600;"><i class="fa fa-envelope-open"></i> 回复内容</div><div class="col-md-2" style="color:#767474; font-weight: 600;"><i class="fa fa-user"></i> 回复者</div><div class="col-md-2" style="color:#767474; font-weight: 600;"><i class="fa fa-clock-o"></i> 回复时间</div></div>';
			 $("#mailBodyContent").append(node_1);
			for(var i=0;i<data.themes.length;i++){
		   		var labelArray=new Array();
		   		for(var j=0;j<data.themes[i].label.length;j++){
		   			labelArray.push(data.themes[i].label[j]);
		   		}
		   		creatCol(labelArray,data.themes[i].themeName,data.themes[i].content,data.themes[i].userId,data.themes[i].userName,data.themes[i].themeTime,data.themes[i].themeId,data.themes[i].responseId);
		   	}
			creatPageCol(pageNum,pageIndex);
		},
		error: function(jqXHR){     
		   alert("发生错误：" + jqXHR.status);  
		   pageIndex++;
		},     
	});
}