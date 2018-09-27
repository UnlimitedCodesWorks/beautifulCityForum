/*
* @Author: Marte
* @Date:   2017-07-24 15:27:38
* @Last Modified by:   Marte
* @Last Modified time: 2017-09-15 15:11:42
*/
var time;
$(document).ready(function(){
  $("#bannerSearch").mouseenter(function(){
    clearTimeout(time);
  $("#bannerSearch").animate({
        width:'28em'
  });
  $('.themeDiv_1').css('display','table-cell');
  $('.searchInput').css('width','17em');
});
  $("#bannerSearch").mouseleave(function(){
    time=setTimeout(function(){
       $("#bannerSearch").animate({
        width:'5em'
      });
    $('.themeDiv_1').css('display','none');
    $('.searchInput').css('width','2.2em');
    },2000);
});
  $('#myCarousel').carousel({
    interval: 10000
});
  var um = UM.getEditor('myEditor');
  UM.getEditor('myEditor').setWidth('100%');
  UM.getEditor('myEditor').setHeight(250);
  $('#themeSelect').click(function(e){
    $('#themeButton').html(e.target.textContent+' <span class="caret"></span>');
    $('#themeClass').val(e.target.textContent);
   });
   $('#themeSelect_1').click(function(e){
    $('#themeButton_1').html(e.target.textContent+' <span class="caret"></span>');
    $('#searchClass').val(e.target.textContent);
   });

   $(document).keypress(function(e){
    if(e.ctrlKey && e.which == 13 || e.which == 10) {
    $("form").submit();
    } else if (e.shiftKey && e.which==13 || e.which == 10) {
    $("form").submit();
    }
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
      $.ajax({
            url: basePath+"pageAjax",
            type: 'POST',
            dataType: 'json',
            data:{
            	pageIndex:$('#pageIndex').val(),
            	enlighten:pageEnlighten
            },
            success: function(data) {
            	var preHeight=$("#forumContentContainer").height();
            	for(var i=0;i<data.themes.length;i++){
               		var labelArray=new Array();
               		for(var j=0;j<data.themes[i].label.length;j++){
               			labelArray.push(data.themes[i].label[j]);
               		}
               		creatCol(data.themes[i].reply,labelArray,data.themes[i].themeName,data.themes[i].userName,data.themes[i].themeTime,data.themes[i].floorTime,data.themes[i].floorName,data.themes[i].enlighten,data.themes[i].userId,data.themes[i].floorId,data.themes[i].themeId,data.themes[i].accept,data.themes[i].recommend);
               	}
            	pageIndex++;
           		$('#pageIndex').val(pageIndex);
           		$('.forumPagination li:eq('+(pageIndex-2)+')').removeClass("focus");
           		$('.forumPagination li:eq('+(pageIndex-1)+')').addClass("focus");
           		if(pageIndex==parseInt(pageNum)){
           			$('#nextPage').hide();
           			$('.forumPagination li:last').hide();
           			$('.forumPagination').prepend('<li><a href="'+basePath+'forum/'+(pageIndex-1)+'">&larr; 上一页</a></li>');
           		}
           		var nowHeight=$("#forumContentContainer").height();
           		$("#forumContentContainer").css('overflow','hidden');
           		$("#forumContentContainer").height(preHeight);
           		$("#forumContentContainer").animate({
           			height:nowHeight
           		});
           		setTimeout(function(){
           			$("#forumContentContainer").css('overflow','visible');
           		},1000);
           		$("[data-toggle='tooltip']").tooltip({html:true});
           		$(".chargeDiv i").click(function(e){
           		   var value=$(this).attr("data-original-title");
           		   var parentNode=$(this).parent();
           		   $("#mymodal-body").html('您确认要<span style="color:red;font-weight:bold;" >'+value+'</span>该主题吗？');
           		   $("#modalClass").val(value);
           		   $("#modalId").val(parentNode.attr("title"));
           		   $('#myModal').modal('show');
           	   });
            },
            error: function(jqXHR){
               alert("发生错误：" + jqXHR.status);
            },
        });

   });

   $("form").submit(function(e){
	   var content=UM.getEditor('myEditor').getContent();
	   var reg=/"/g;
	   var themeClass=$('#themeClass').val();
	   var theme=$("#theme").val();
	   theme=theme.replace(reg,'&quot;');
	   $("#postContent").val(content);
	   if(content==""){
		   e.preventDefault();
		   UM.getEditor('myEditor').setContent('<span style="color:red;">请填写帖子内容</span>', true);
	   }
	   if(theme==""||themeClass==""){
		   e.preventDefault();
		   UM.getEditor('myEditor').setContent('<span style="color:red;">请填写帖子主题或类别</span>', true);
	   }

   });
   $("[data-toggle='tooltip']").tooltip({html:true});
   $(".chargeDiv i").click(function(e){
	   var value=$(this).attr("data-original-title");
	   var parentNode=$(this).parent();
	   $("#mymodal-body").html('您确认要<span style="color:red;font-weight:bold;" >'+value+'</span>该主题吗？');
	   $("#modalClass").val(value);
	   $("#modalId").val(parentNode.attr("title"));
	   $('#myModal').modal('show');
   });
   $("#chargeList").click(function(e){
	   var value=e.target.textContent;
	   $("#mymodal-body_1").html('您确认要批量<span style="color:red;font-weight:bold;" >'+value+'</span>选中的主题吗？');
	   $("#modalClass_1").val(value);
	   $('#myModal_1').modal('show');
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
   $('#modalSubmit').click(function(e){
	   var modalClass=$("#modalClass").val();
	   var modalId=$("#modalId").val();
	   $.ajax({
		    type: "POST",
			url: basePath+"editThemeAjax",
			data: {
				editClass:modalClass,
				themeId:modalId
			},
			dataType: "json",
			success: function(data){
				if (data.success) {
					window.location.reload();
				}else{
					alert("修改失败!");
				}
			},
			error: function(jqXHR){
			   alert("发生错误：" + jqXHR.status);
			},
		});
   });

   $('#modalSubmit_1').click(function(e){
	   var modalClass=$("#modalClass_1").val();
	   var nodes=$(".chargeBox:checked");

	   var themesId=new Array();
	   nodes.each(function(){
		   var themeId=$(this).prev().attr("title");
		   themesId.push(themeId);
	   });
	   $.ajax({
		    type: "POST",
			url: basePath+"editThemesAjax",
			data: {
				editClass:modalClass,
				themesId:themesId
			},
			dataType: "json",
			traditional: true,
			success: function(data){
				if (data.success) {
					window.location.reload();
				}else{
					alert("修改失败!");
				}
			},
			error: function(jqXHR){
			   alert("发生错误：" + jqXHR.status);
			},
		});
   });

});
function creatTopCol(labelName,themeName,themeId){
  var node='<tr><td class="topTableTd" style="border-right: 0px;border-left: 0px;" ><a href="javascript:void(0)" class="label_1" onclick="labelSearch(this)" >['+labelName+']</a><a href="'+basePath+'read?id='+themeId+'" class="label_2">'+themeName+'</a>';
  if(userIdentity=='1'){
	  node+='<div class="chargeDiv chargeDiv_1" style="top:7px;right:-50px;" title="'+themeId+'">';
	  node+='<i class="fa fa-arrow-down" data-toggle="tooltip" title="取消置顶" ></i>'
			+'<i class="fa fa-close" data-toggle="tooltip"  title="删除" ></i></div>';
  }
  node+='</td></tr>';
  if(labelName=="新闻推荐"){
	  $('.topTable:eq(0)').append(node);
  }else if(labelName=="活动推荐"){
	  $('.topTable:eq(1)').append(node);
  }else if(labelName=="旅游推荐"){
	  $('.topTable:eq(2)').append(node);
  }
}
function creatCol(reply,label,themeName,userName,userTime,floorTime,floorName,enlighten,userId,floorId,themeId,accept,recommend){
	var node='<div class="row forumContentRow"><div class="col-md-1 col-lg-1 forumContentCol"><div class="forumContentCol_1 btn btn-primary">'
		+reply+'</div></div><div class="col-md-7 col-lg-7 forumContentCol"><div class="forumContentCol_2">';
	 for(var i=0;i<label.length;i++){
		node+='<a href="javascript:void(0)" class="label_1" onclick="labelSearch(this)" >['+label[i]+']</a>';
	}
	node+='<a href="'+basePath+'read?id='+themeId+'"class="label_2">'+themeName+'</a>';
	if(parseInt(enlighten)==1){
		node+='<i class="enlighten">精</i>';
	}
	if(parseInt(recommend)>=100){
		node+='<i class="recommend">荐</i>';
	}
	if(accept=='1'){
		node+='<i class="accept">编辑采用</i><i class="fa fa-database" style="margin-left:10px;"></i><i class="point">+50</i>';
	}
	if(userIdentity=='1'){
		node+='<div class="chargeDiv" title="'+themeId+'">';
			if(parseInt(enlighten)==1){
				node+='<i class="fa fa-minus" data-toggle="tooltip" title="取消加精" ></i>';
			}else{
				node+='<i class="fa fa-plus" data-toggle="tooltip" title="加精" ></i>';
			}
			node+='<i class="fa fa-arrow-up" data-toggle="tooltip" title="置顶" ></i>'
			+'<i class="fa fa-close" data-toggle="tooltip"  title="删除" ></i></div><input type="checkbox" name="chargeBox" class="chargeBox" style="margin-left:5px" >';
	}
	node+='</div></div><div class="col-md-2 col-lg-2 forumContentCol"><div class="forumContentCol_3"><a href="'+basePath+'personal/'+userId+'">'
	+userName+'</a><div>'+userTime+'</div></div></div><div class="col-md-2 col-lg-2 forumContentCol"><div class="forumContentCol_4"><div>'
	+floorTime+'</div><a href="'+basePath+'personal/'+floorId+'">'+floorName+'</a></div></div></div>';
	$('#forumContentContainer').append(node);
}
function creatPageCol(pageNum,pageIndex){
	var node='';
	for(var i=0;i<pageNum;i++){
		node+='<li><a href="'+basePath+'forum/'+(i+1)+'?enlighten='+pageEnlighten+'">'+(i+1)+'</a></li>';
	}
	if(parseInt(pageIndex)!=1){
		location.href = "#firstAnchor";
	}
	if(parseInt(pageNum)!=1&&parseInt(pageIndex)!=parseInt(pageNum)){
		node+='<li><a href="'+basePath+'forum/'+(parseInt(pageIndex)+1)+'?enlighten='+pageEnlighten+'">下一页 &rarr;</a></li>';
	}
	$('.forumPagination').append(node);
	$('.forumPagination > li:eq('+(parseInt(pageIndex)-1)+')').addClass("focus");
	if(parseInt(pageIndex)!=1){
		$('.forumPagination').prepend('<li><a href="'+basePath+'forum/'+(parseInt(pageIndex)-1)+'?enlighten='+pageEnlighten+'">&larr; 上一页</a></li>');
	}
}
function turnSearch(){
	var url=basePath+"search?"+"searchContent="+$('#searchContent').val()+"&searchClass="+$('#searchClass').val();
    url=encodeURI(encodeURI(url));
    window.location.href=url;
}
function labelSearch_1(e){
	var str=$(e).text().substring(2,6);
	var url=basePath+"search?"+"searchContent="+str+"&searchClass=按标签搜索";
	url=encodeURI(encodeURI(url));
	window.location.href=url;
}
function labelSearch(e){
	var str=$(e).text().substring(1,5);
	var url=basePath+"search?"+"searchContent="+str+"&searchClass=按标签搜索";
	url=encodeURI(encodeURI(url));
	window.location.href=url;
}
