<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>我的 - 全部订单</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
    <script type="text/javascript" src="https://res.wx.qq.com/open/js/jweixin-1.3.2.js"></script>
  </head>
  <body>
    <div class="page-group">
        <div class="page page-current">
			<div class="content">
			
			<div class="row" style="padding:5px;">
				<div class="col-100">
				<div class="buttons-tab">
			    <a href="#tab1" class="tab-link active button">全部</a>
			    <a href="#tab2" class="tab-link button">待付款</a>
			    <a href="#tab3" class="tab-link button">待使用</a>
			    <a href="#tab4" class="tab-link button">已核销</a>
			</div>
		    <div class="tabs">
		      <div id="tab1" class="tab active">
		      			<c:forEach var="var" items="${ordersData}">
			<div class="card">
			    <div class="card-header">下单时间:${var.CDT}<span style="float:right;border:1px #444444 solid;border-radius: 5px;padding:2px;">
			    <c:choose>
			    	<c:when test="${var.STATE eq 0}">待付款</c:when>
			    	<c:when test="${var.STATE eq 1}">已支付</c:when>
			    	<c:when test="${var.STATE eq 2}">待使用</c:when>
			    	<c:when test="${var.STATE eq 3}">已使用</c:when>
			    	<c:when test="${var.STATE eq 5}">已退款</c:when>
			    	<c:otherwise>未知</c:otherwise>
			    </c:choose>
			    </span></div>
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
			      <span>
			      <c:choose>
			      	<c:when test="${var.STATE eq 0 }">
			      	<button onclick="goPay('${var.ORDER_ID}','${var.ORDERSN}','${var.ORIGINAL}','${var.DERATE}','${var.MONEY}');;" class="button button-fill button-warning" style="background:#FFCC01;color:#000000;">立即支付</button>
			      	</c:when>
			      	<c:when test="${var.STATE eq 1 }">
			      	<button onclick="goUseInfo('${var.ORDER_ID}');" class="button button-fill button-warning" style="background:#FFCC01;color:#000000;">确认信息</button>
			      	</c:when>
			      	<c:otherwise>
			      	<button onclick="goInfo('${var.ORDER_ID}');" class="button button-fill button-warning" style="background:#FFCC01;color:#000000;">查看详情</button>
			      	</c:otherwise>
			      </c:choose>
			      </span>
			    </div>
			  </div>
			</c:forEach>
		      </div>
		      <div id="tab2" class="tab">
				<c:forEach var="var" items="${ordersData}">
				<c:if test="${var.STATE eq 0}">
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
			      <span>
			      <button onclick="goPay('${var.ORDER_ID}','${var.ORDERSN}','${var.ORIGINAL}','${var.DERATE}','${var.MONEY}');;" class="button button-fill button-warning" style="background:#FFCC01;color:#000000;">立即支付</button>
			      </span>
			    </div>
			  </div>
			  </c:if>
			</c:forEach>
		      </div>
		      <div id="tab3" class="tab">
				<c:forEach var="var" items="${ordersData}">
				<c:if test="${var.STATE eq 1 or var.STATE eq 2 }">
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
			      <span>
			      <button onclick="goInfo('${var.ORDER_ID}');" class="button button-fill button-warning" style="background:#FFCC01;color:#000000;">查看详情</button>
			      </span>
			    </div>
			  </div>
			  </c:if>
			</c:forEach>
		      </div>
		      <div id="tab4" class="tab">
				<c:forEach var="var" items="${ordersData}">
				<c:if test="${var.STATE eq 3}">
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
			      <span>
			      <button onclick="goInfo('${var.ORDER_ID}');" class="button button-fill button-warning" style="background:#FFCC01;color:#000000;">查看详情</button>
			      </span>
			    </div>
			  </div>
			  </c:if>
			</c:forEach>
		      </div>
		    </div>
				</div>
			</div>
			</div>	
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
    <script type="text/javascript">
  	function goInfo(id){
		 location.href="<%=request.getContextPath()%>/orders/info?ORDER_ID="+id
	}
  	function goPay(id,sn,original,derate,money){
  		 wx.miniProgram.navigateTo({
           url: '/pages/pay/pay?type=goods&id='+id+'&sn='+sn+'&original='+original+'&derate='+derate+'&money='+money
      	})
  	}
  	function goUseInfo(id){
		 location.href="<%=request.getContextPath()%>/orders/useinfo?ORDER_ID="+id
	}
  </script>
</html>