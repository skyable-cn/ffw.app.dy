<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>西安美食推荐</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
    <%@ include file="../common/utiljs.jsp"%>
  </head>
  <body>
    <div class="page-group">
        <div class="page page-current">
			<div class="content infinite-scroll" data-distance="30">
			<div class="row" style="padding:5px;">
    					<div class="col-100">
				  <div class="searchbar">
				    <div class="search-input">
				      <label class="icon icon-search" for="search"></label>
				      <input type="search" id='search' name="keywords" placeholder='输入关键字...'/>
				    </div>
				  </div>
				</div>
			</div>
				<div id="goods">
				
				</div>
				<h5>&nbsp;</h5>
        	</div>
        	<%@ include file="../common/nav.jsp"%>
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
      <script type="text/javascript">

	   	search(true);
		     
    	var page_currentPage = 1;
    	
    	function search(flag){
    		$.ajax({
    			type: "POST",
    			url: '<%=request.getContextPath()%>/home/search',
    	    	data:{
  					"page_currentPage":page_currentPage,
  					"keywords":$("#search").val()
    	    	},
    	    	async: false,
    			dataType:'json',
    			cache: false,
    			beforeSend:function(){
    				$.showPreloader();
    				//$("#shops").html('');
    			},
    			success: function(data){
    				pageData = data.page;
    				console.log(pageData)
    				var list = data.page.data;
    				var html = "";
    				$.each(list,function(index,value){ 
    					html += `
    					<div class="row" style="padding:5px;">
    					<div class="col-100">
    				<div class="card demo-card-header-pic">
    				    <a class="external" href="<%=request.getContextPath()%>/goods/info?GOODS_ID=`+value.GOODS_ID+`"><div valign="bottom" class="card-header color-white no-border no-padding">
    				      <img class='card-cover' style="width:100%;" height="200" src="<%=request.getContextPath()%>/file/image?FILENAME=`+value.FILEPATH+`" alt="">
    				    </div></a>
    				    <div class="card-footer">
	  				      <span>`+value.SHOPNAME+`</span>
	  				      <span>`+value.SHOPADDRESS+`</span>
	  				    </div>
    				    <div class="card-content">
    				      <div class="card-content-inner">
    				        <p><span style="margin-right:10px;padding:3px 10px;background:#FFCC01;">[`+value.PROVIDE+`]提供</span>`+value.GOODSDESC+`</p>
    				      </div>
    				    </div>
    				    
    				    <div class="card-footer">
  				      <span><font style="color:#F40A0B;">`+value.SELLMONEY+`元</font></span>
  				      <span><a href="<%=request.getContextPath()%>/goBuy?GOODS_ID=`+value.GOODS_ID+`" class="external button button-fill">立即购买</a></span>
  				    </div>
  				  <div class="card-footer">
			      <span class="delete">原价 `+value.ORIGINALMONEY+`元</span>
			      <span>已售`+value.BUYNUMBER+`份</span>
			    </div>
    				  </div>
    				  </div>
    				  </div>
    					`;
    				})
    				if(flag){
    					$("#goods").html(html);
    				}else{
    					$("#goods").append(html);
    				}
    				
    				setTimeout(function(){$.hidePreloader();},1000);
    				
    	             loading = false;
    			},
    			error:function(){
    				
    			}
    		});
    	}
    	
    </script>
  <script type="text/javascript">
  
 	var loading = false;
     
     $.init();
     
  	$(document).on('infinite',function(){
  		
  		if(parseInt(pageData.currentPage) >= parseInt(pageData.totalPage)){
  			$.toast("数据已经到底了");
  			return;
  		}
  		
  		page_currentPage++;

         // 如果正在加载，则退出
         if (loading) return;

         // 设置flag
         loading = true;

         // 模拟1s的加载过程
         setTimeout(function() {
             // 重置加载flag

             search(false);
             
             //容器发生改变,如果是js滚动，需要刷新滚动
             $.refreshScroller();
         }, 500);
  	});
  </script>
  
  <script type="text/javascript">
  	$("#search").blur(function(){
  		
  		page_currentPage = 1;
  		
  		search(true);
    	
  	});
  </script>
</html>