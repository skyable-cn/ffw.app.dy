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
			<div class="content">
				<div class="row">
				<div class="col-100" style="position:relative;height:280px;">
				 <div><img class='card-cover div_height1' height="200" width="100%" src="<%=request.getContextPath()%>/static/icon/me.png" alt=""></div>
				 <div style="height:150px;position:absolute;top:20px;z-index:999;left:5%;right:5%;font-size:0.85rem;">
				 	<img align="middle" style="margin:10px; width:80px;border-radius:50%;" src="${USER_SESSION.PHOTO}"/>${USER_SESSION.NICKNAME}
				 </div>
				 <div class="div_height2" style="background:#ffffff;height:140px;position:absolute;top:130px;z-index:999;left:10px;right:10px;-webkit-box-shadow: 3px 3px 12px #CCCCCC;-moz-box-shadow: 3px 3px 12px #CCCCCC;box-shadow: 3px 3px 12px #CCCCCC; -moz-border-radius: 5px;-webkit-border-radius: 5px;border-radius: 5px;">
					 <a class="external" href="<%=request.getContextPath()%>/orders/all"><div class="row">
					 	<div class="col-50" style="text-align:left;padding:20px 15px;">
					 		我的订单
					 	</div>
					 	<div class="col-50" style="text-align: right;padding:20px 15px;">
					 		全部订单&nbsp;&gt;
					 	</div>
					 </div>
					 </a>
					 <div class="row">
					 	<div class="col-100" style="padding:0 10px;">
					 		<div style="width:100%;height:1px;background:#EEEEEE;">&nbsp;</div>
					 	</div>
					 </div>
					 <div class="row" style="margin-top:10px;">
					 	<div class="col-25" style="text-align: center;"><a class="external" href="<%=request.getContextPath()%>/orders/waitpay"><img width="40%" src="<%=request.getContextPath()%>/static/icon/dfk.png"/><br/>待付款</a></div>
						<div class="col-25" style="text-align: center;"><a class="external" href="<%=request.getContextPath()%>/orders/waituse"><img width="40%" src="<%=request.getContextPath()%>/static/icon/dsy.png"/><br/>待使用</a></div>
						<div class="col-25" style="text-align: center;"><a class="external" href="<%=request.getContextPath()%>/orders/waitrecive"><img width="40%" src="<%=request.getContextPath()%>/static/icon/dsh.png"/><br/>待收货</a></div>
						<div class="col-25" style="text-align: center;"><a class="external" href="<%=request.getContextPath()%>/orders/waitrate"><img width="40%" src="<%=request.getContextPath()%>/static/icon/dpj.png"/><br/>待评价</a></div>
					 </div>
				 </div>
				</div>
			</div>
			<div class="row">
				<div class="col-100" style="padding:10px;">
			<div class="div_height2" style="background:#ffffff;left:10px;right:10px;border-radius: 5px;border:1px #EEEEEE solid;-webkit-box-shadow: 3px 3px 12px #CCCCCC;-moz-box-shadow: 3px 3px 12px #CCCCCC;box-shadow: 3px 3px 12px #CCCCCC; -moz-border-radius: 5px;-webkit-border-radius: 5px;">
					 <a class="external" href="<%=request.getContextPath()%>/my/account">
					 <div class="row">
					 	<div class="col-50" style="text-align:left;padding:20px 15px;">
					 		我的钱包
					 	</div>
					 	<div class="col-50" style="text-align:right;padding:20px 15px;">
					 		&gt;
					 	</div>
					 </div>
					 </a>
					 	 <div class="row">
					 	<div class="col-100" style="padding:0 10px;">
					 		<div style="width:100%;height:1px;background:#EEEEEE;">&nbsp;</div>
					 	</div>
					 </div>
					 <a class="external" href="<%=request.getContextPath()%>/seller/list">
					 <div class="row">
					 	<div class="col-50" style="text-align:left;padding:20px 15px;">
					 		商家后台
					 	</div>
					 	<div class="col-50" style="text-align:right;padding:20px 15px;">
					 		&gt;
					 	</div>
					 </div></a>
				 </div>
				 </div>
				 </div>
        	</div>
        	<%@ include file="../common/nav.jsp"%>
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
</html>