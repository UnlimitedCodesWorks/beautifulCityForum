/*
* @Author: Marte
* @Date:   2017-08-14 12:00:28
* @Last Modified by:   Marte
* @Last Modified time: 2017-08-28 13:56:10
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
	 
	   $('#nextPage').click(function(event) {
		     /* Act on the event */
		   	 pageIndex++;
		   	$('#pageIndex').val(pageIndex);
		   	var url=basePath+"searchAjax?pageIndex="+$('#pageIndex').val()+"&searchContent="+$("#searchContent_1").val()+"&searchClass="+$("#preSearchClass").val();
		   	url=encodeURI(encodeURI(url));
		      $.ajax({
		            url: url,
		            type: 'GET',
		            dataType: 'json',
		            success: function(data) {
		            	var preHeight=$("#searchCon").height();
		            	if(json==''){
		            		for(var i=0;i<data.themes.length;i++){
		               			creatCol_1(data.themes[i].reply,data.themes[i].content,data.themes[i].userName,data.themes[i].themeTime,data.themes[i].floorTime,data.themes[i].floorName,data.themes[i].postUserId,data.themes[i].floorId,data.themes[i].replyId);
		               		}
		            	}else{
		            		for(var i=0;i<data.themes.length;i++){
			               		var labelArray=new Array();
			               		for(var j=0;j<data.themes[i].label.length;j++){
			               			labelArray.push(data.themes[i].label[j]);
			               		}
			               		creatCol(data.themes[i].reply,labelArray,data.themes[i].themeName,data.themes[i].userName,data.themes[i].themeTime,data.themes[i].floorTime,data.themes[i].floorName,data.themes[i].enlighten,data.themes[i].userId,data.themes[i].floorId,data.themes[i].themeId,data.themes[i].accept,data.themes[i].recommend);
			               	}
		            	}
		           		if(pageIndex==parseInt(pageNum)){
		           			$('#nextPage').hide();
		           		}
		           		var nowHeight=$("#searchCon").height();
		           		$("#searchCon").css('overflow','hidden');
		           		$("#searchCon").height(preHeight);
		           		$("#searchCon").animate({
		           			height:nowHeight
		           		});
		           		setTimeout(function(){
		           			$("#searchCon").css('overflow','visible');
		           		},1000);
		            },
		            error: function(jqXHR){
		               alert("发生错误：" + jqXHR.status);
		            },
		        });

		   });
});
function turnSearch(){
	var url=basePath+"search?"+"searchContent="+$('#searchContent').val()+"&searchClass="+$('#searchClass').val();
    url=encodeURI(encodeURI(url));
    window.location.href=url;
}
function creatCol(reply,label,themeName,userName,userTime,floorTime,floorName,enlighten,userId,floorId,themeId,accept,recommend){
	var node='<div class="row searchContentRow"><div class="col-md-1 col-lg-1 searchContentCol"><div class="searchContentCol_1 btn btn-primary">'
		+reply+'</div></div><div class="col-md-7 col-lg-7 searchContentCol"><div class="searchContentCol_2">';
	 for(var i=0;i<label.length;i++){
		node+='<a href="javascript:void(0)" class="label_1" onclick="labelSearch(this)" >['+label[i]+']</a>';
	}
	node+='<a href="'+basePath+'read?id='+themeId+'" class="label_2">'+themeName+'</a>';
	if(parseInt(enlighten)==1){
		node+='<i class="enlighten">精</i>';
	}
	if(parseInt(recommend)>=100){
		node+='<i class="recommend">荐</i>';
	}
	if(accept=='1'){
		node+='<i class="accept">编辑采用</i><i class="fa fa-database" style="margin-left:10px;"></i><i class="point">+50</i>';
	}
	node+='</div></div><div class="col-md-2 col-lg-2 searchContentCol"><div class="searchContentCol_3"><a href="'+basePath+'personal/'+userId+'">'
	+userName+'</a><div>'+userTime+'</div></div></div><div class="col-md-2 col-lg-2 searchContentCol"><div class="searchContentCol_4"><div>'
	+floorTime+'</div><a href="'+basePath+'personal/'+floorId+'">'+floorName+'</a></div></div></div>';
	$('#searchCon').append(node);
}
function creatCol_1(reply,content,userName,themeTime,floorTime,floorName,postUserId,floorId,themeId){
	var node='<div class="row searchContentRow"><div class="col-md-1 col-lg-1 searchContentCol"><div class="searchContentCol_1 btn btn-primary">'
		+reply+'</div></div><div class="col-md-7 col-lg-7 searchContentCol"><div class="searchContentCol_2">';
	node+='<a href="'+basePath+'read?id='+themeId+'" class="label_2">'+content+'</a>';
	node+='</div></div><div class="col-md-2 col-lg-2 searchContentCol"><div class="searchContentCol_3"><a href="'+basePath+'personal/'+postUserId+'">'
	+userName+'</a><div>'+themeTime+'</div></div></div><div class="col-md-2 col-lg-2 searchContentCol"><div class="searchContentCol_4"><div>'
	+floorTime+'</div><a href="'+basePath+'personal/'+floorId+'">'+floorName+'</a></div></div></div>';
	$('#searchCon').append(node);
}
function labelSearch(e){
	var str=$(e).text().substring(1,5);
	var url=basePath+"search?"+"searchContent="+str+"&searchClass=按标签搜索";
	url=encodeURI(encodeURI(url));
	window.location.href=url;
}