/*
* @Author: Marte
* @Date:   2017-08-04 13:38:23
* @Last Modified by:   Marte
* @Last Modified time: 2017-08-16 11:29:27
*/
var time;
$(document).ready(function(){
  $("#bannerSearch").mouseenter(function(){
    clearTimeout(time);
  $("#bannerSearch").animate({
        width:'28em'
  });
  $('.themeDiv_1').css('display','table-cell');
});
  $("#bannerSearch").mouseleave(function(){
    time=setTimeout(function(){
       $("#bannerSearch").animate({
        width:'6.6em'
      });
    $('.themeDiv_1').css('display','none');
    },2000);
});
   UE.getEditor('editor',{
        initialFrameWidth : '100%',
        initialFrameHeight: 450
    });
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
   
   $("form").submit(function(e){
	   var content=UE.getEditor('editor').getContent();
	   var reg=/"/g;
	   var themeClass=$('#themeClass').val();
	   var theme=$("#theme").val();
	   theme=theme.replace(reg,'&quot;');
	   $("#postContent").val(content);
	   if(content==""){
		   e.preventDefault();
		   UE.getEditor('editor').setContent('<span style="color:red;">请填写帖子内容</span>', true);
	   }
	   if(theme==""||themeClass==""){
		   e.preventDefault();
		   UE.getEditor('editor').setContent('<span style="color:red;">请填写帖子主题或类别</span>', true);
	   }
	   
   });
});

function turnSearch(){
	var url=basePath+"search?"+"searchContent="+$('#searchContent').val()+"&searchClass="+$('#searchClass').val();
    url=encodeURI(encodeURI(url));
    window.location.href=url;
}