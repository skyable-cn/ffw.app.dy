<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>我的 - 待评价</title>
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
				<c:if test="${ordersData!=null|| fn:length(ordersData) > 0}">
			<c:forEach var="var" items="${ordersData}">
			<div class="card">
			    <div class="card-header">下单时间:${var.CDT}</div>
			    <div class="card-content">
			      <div class="list-block media-list">
			        <ul>
			          <li class="item-content">
			            <div class="item-media">
			              <img src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" width="100">
			            </div>
			            <div class="item-inner">
			              <div class="item-title-row">
			                <div class="item-title">${var.GOODSDESC}</div>
			              </div>
			              <div class="item-subtitle">总价:${var.MONEY}<span style="float:right;">数量:${var.NUMBER}</span></div>
			            </div>
			          </li>
			        </ul>
			      </div>
			    </div>
			    <div class="card-footer">
			      <span></span>
			      <span><button onclick="goRate('${var.ORDER_ID}');" class="button" style="background:#FFCC01;color:#000000;display:inline;margin-right:10px;">立即评价</button><button onclick="goInfo('${var.ORDER_ID}');" class="button" style="background:#FFCC01;color:#000000;display:inline;">查看详情</button></span>
			    </div>
			  </div>
			</c:forEach>
				</c:if>
				<c:if test="${ordersData==null || fn:length(ordersData) == 0}">
			<div class="noOrdersBox">暂时没有待评价的订单！</div>
				</c:if>
			</div>	
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
  function goInfo(id){
		 location.href="<%=request.getContextPath()%>/orders/info?ORDER_ID="+id
	}
  
  function goRate(id){
		 location.href="<%=request.getContextPath()%>/orders/rate?ORDER_ID="+id
	}
  </script>
</html>