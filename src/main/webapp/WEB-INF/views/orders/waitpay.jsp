<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>我的 - 待支付</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
    <script type="text/javascript" src="https://s3.pstatp.com/toutiao/tmajssdk/jssdk-1.0.0.js"></script>
  </head>
  <body>
    <div class="page-group">
        <div class="page page-current">
			<div class="content">
			<c:if test="${ordersData!=null|| fn:length(ordersData) > 0}">
			<c:forEach var="var" items="${ordersData}">
			<div class="card proBox">
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
			      <span><button onclick="goPay('${var.ORDER_ID}','${var.ORDERSN}','${var.ORIGINAL}','${var.DERATE}','${var.MONEY}');" class="button button-fill button-warning" style="background:#FFCC01;color:#000000;">立即支付</button></span>
			    </div>
			  </div>
			</c:forEach>
			</c:if>
			<c:if test="${ordersData==null || fn:length(ordersData) == 0}">
			<div class="noOrdersBox">暂时没有待支付的订单！</div>
			</c:if>
			</div>	
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
 	function goPay(id,sn,original,derate,money){
   		 tt.miniProgram.navigateTo({
            url: '/pages/pay/pay?type=goods&id='+id+'&sn='+sn+'&original='+original+'&derate='+derate+'&money='+money
       	})
   	}
  </script>
</html>