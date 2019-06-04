<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>订单评价</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
    <script type="text/javascript" src="https://s3.pstatp.com/toutiao/tmajssdk/jssdk-1.0.0.js"></script>
  </head>
  <body>
    <div class="page-group">
        <div class="page page-current" style="background:#FFFFFF;">
			<div class="content">
				<div class="card" style="margin:5px;">
			    <div class="card-content">
			      <div class="list-block media-list">
			        <ul>
			          <li class="item-content">
			            <div class="item-media">
			              <img src="<%=request.getContextPath()%>/file/image?FILENAME=${order.FILEPATH}" width="100" height="100">
			            </div>
			            <div class="item-inner">
			              <div class="item-title-row">
			                <div class="item-title">${order.GOODSDESC}</div>
			              </div>
			            </div>
			          </li>
			        </ul>
			      </div>
			    </div>
			  </div>
			  <div style="width:100%;height:7px;background:#dddddd;">&nbsp;</div>
			  <div class="row" style="height:calc(60% - 70px);">
				<div class="col-100" style="padding:5px;height:100%;padding-bottom:0px;">
				<textarea id="RATECONTENT" name="RATECONTENT" placeholder="购买评价 . . ." style="width:100%;height:100%;"></textarea>
				</div>
			</div>
		    <div class="row">
		      <div class="col-100" style="padding:5px;"><button onclick="saveInfo()" type="button" class="button button-big button-fill button-success" style="background:#FFCC01;color:#000000;width:100%;">提交</button></div>
		    </div>
			</div>
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
    <script type="text/javascript">
  function saveInfo(){
	  if($("#RATECONTENT").val()==''){
		   $.toast("评价内容不许为空");
		   return;
	   }
	  $.ajax({
			type: "POST",
			url: '<%=request.getContextPath()%>/orders/rate/save',
	    	data:{
	    		"ORDER_ID":"${order.ORDER_ID}",
	    		"RATECONTENT":$("#RATECONTENT").val()
	    	},
	    	async: false,
			dataType:'json',
			cache: false,
			beforeSend:function(){
				
			},
			success: function(data){
				if(data.flag){
					$.alert("订单评价成功",function(){
						location.href='<%=request.getContextPath()%>/my'
					})
					
				}
			},
			error:function(){
				
			}
		});
	   
  } 
  </script>
</html>