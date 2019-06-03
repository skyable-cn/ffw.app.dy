<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>商户列表</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
  </head>
  <body>
    <div class="page-group">
        <div class="page page-current">
			<div class="content">
			<div class="list-block" style="margin-top:0px;margin-bottom:0px;">
			 <ul>
			 <c:forEach var="var" items="${shopData}">
		      <li class="item-content item-link" onclick="goShop('${var.SHOP_ID}','${var.SHOPSTATENAME}')">
		        <div class="item-inner">
		          <div class="item-title">${var.SHOPNAME}</div>
		          <div class="item-after">${var.SHOPSTATENAME}</div>
		        </div>
		      </li>
		      </c:forEach>
		      </ul>
		      </div>
		      <!-- 
		      <div class="row" style="padding:5px;">
   					<div class="col-100">
   					<a href="<%=request.getContextPath()%>/seller"  class="external button button-big button-fill button-success" style="background:#FFCC01;color:#000000;">新增商户</a>
   					</div>
   				</div>
   			 -->
			</div>
        </div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
  	function goShop(id,state){
  		if(state != '已通过'){
  			$.alert('该商户审核状态处于'+state,function(){});
  		}else{
  			location.href='<%=request.getContextPath()%>/seller/manage?SHOP_ID='+id
  		}
  	}
  </script>
</html>