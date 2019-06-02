<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>

<script type="text/javascript">
$("nav a.tab-item").click(function(){
	if($(this).hasClass("active")){
		event.preventDefault();
		return;
	}
	var img = $(this).find("span img");
	var src=img.attr("src");
	if(src.indexOf("_sel")==-1){
		src = src.replace(".","_sel.");
		img.attr("src",window.location.protocol+"//"+window.location.host+src);
	}
	var lable = $(this).find("span.tab-label");
	lable.css("color","#FFCC01");
});
</script>

