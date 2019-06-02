<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>订单详情</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
    <script type="text/javascript" src="https://res.wx.qq.com/open/js/jweixin-1.3.2.js"></script>
  </head>
  <body>
    <div class="page-group">
        <div class="page page-current" style="background:#FFFFFF;">
			<div class="content">
				<div class="row" style="padding:5px;">
					<div class="col-100" style="text-align:right;">
					<c:choose>
				    	<c:when test="${order.STATE eq 0}">待付款</c:when>
				    	<c:when test="${order.STATE eq 1}">已支付</c:when>
				    	<c:when test="${order.STATE eq 2}">待使用</c:when>
				    	<c:when test="${order.STATE eq 3}">已使用</c:when>
				    	<c:when test="${order.STATE eq 5}">已退款</c:when>
				    	<c:otherwise>未知</c:otherwise>
				    </c:choose>
			    </div>
				</div>
				<div style="width:100%;height:7px;background:#dddddd;">&nbsp;</div>
			  	<div class="row" style="padding:5px;">
					<div class="col-25">&nbsp;</div>
					<div class="col-50"><img onclick="preview()" alt="" src="<%=request.getContextPath()%>/orders/barcode?USEID=${order.USEID}" width="100%"></div>
					<div class="col-25">&nbsp;</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-100">
						<div style="text-align:center;">有效期 ${order.STARTTIME}~${order.ENDTIME}</div>
					</div>
				</div>
				<div style="margin:10px;border:1px #CCCCCC solid;height:100px;">
					<div class="row">
						<div class="col-50" style="padding:7px;padding-top:15px;">核销码</div>
						<div class="col-50" style="padding:7px;padding-top:15px;text-align:right;"><button onclick="goRefund('${order.ORDER_ID}','${order.WEIXINSN}','${order.MONEY}','${order.STATE}');" class="button button-fill button-warning" style="background:#FFCC01;color:#000000;float:right;">申请退款</button></div>
					</div>
					<div class="row">
						<div class="col-50" style="padding:7px;padding-top:7px;">核销码:${order.USEKEY}</div>
						<div class="col-50" style="padding:7px;padding-top:7px;text-align:right;"><c:choose>
				    	<c:when test="${order.STATE eq 0}">待付款</c:when>
				    	<c:when test="${order.STATE eq 1}">已支付</c:when>
				    	<c:when test="${order.STATE eq 2}">待使用</c:when>
				    	<c:when test="${order.STATE eq 3}">已使用</c:when>
				    	<c:when test="${order.STATE eq 5}">已退款</c:when>
				    	<c:otherwise>未知</c:otherwise>
				    </c:choose></div>
					</div>
				</div>
				<div class="content-block" style="margin-left:15%;margin-right:15%;margin-top:15px;margin-bottom:15px;">
				    <a href="javascript:;" onclick="goGive('${order.ORDER_ID}','${order.STATE}');" class="button button-round button-big button-fill" style="background:#FFCC01;color:#000000;">转赠好友</a>
				</div>
				<div class="row" style="padding:5px;padding-top:0px;">
					<div class="col-100">
						<div style="text-align:center;">好友接收成功后,订单无法退款,你将不能再核销</div>
					</div>
				</div>
				<div class="row" style="padding:5px;padding-top:30px;">
					<div class="col-100">
						<div style="text-align:center;font-size:0.85rem;">使用方法</div>
					</div>
				</div>
				<div class="row" style="padding:5px;margin-bottom:20px;">
					<div class="col-100">
						<div style="text-align:center;">向商家出示二维码或核销码,扫码后核销成功,不支持截图</div>
					</div>
				</div>
				<div style="width:100%;height:7px;background:#dddddd;">&nbsp;</div>
				<div class="card">
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
			              <div class="item-subtitle">总价:${order.MONEY}<span style="float:right;">数量:${order.NUMBER}</span></div>
			            </div>
			          </li>
			        </ul>
			      </div>
			    </div>
			  </div>
			  <div style="width:100%;height:7px;background:#dddddd;">&nbsp;</div>
			  <div class="row" style="padding:5px;margin-top:20px;">
					<div class="col-100">
						<div style="text-align:left;padding-left:5px;border-left:8px #FFCC01 solid;font-size:0.85rem;">核销记录</div>
					</div>
				</div>
				<c:if test="${fn:length(useData) eq 0}">
				<div class="content-block" style="margin-left:2%;margin-right:2%;margin-top:15px;margin-bottom:15px;">
				    <a href="#" class="button button-big button-fill" style="background:#FFCC01;color:#000000;">暂无核销记录</a>
				</div>
				</c:if>
				<c:if test="${fn:length(useData) ne 0}">
				<c:forEach var="var" items="${useData}">
				<div class="row" style="padding:5px;">
					<div class="col-50">
						<div style="text-align:left;padding:5px;">${var.SHOPNAME}</div>
					</div>
					<div class="col-50" style="text-align:right;">
						${var.CDT}
					</div>
				</div>
				</c:forEach>
				</c:if>
				<div class="row" style="padding:5px;margin-top:20px;">
					<div class="col-100">
						<div style="text-align:left;padding-left:5px;border-left:8px #FFCC01 solid;font-size:0.85rem;">注意事项</div>
					</div>
				</div>
				<div style="padding:5px;margin:10px;border:1px #CCCCCC solid;min-height:250px;word-wrap: break-word;word-break: break-all;overflow: hidden;">${order.BUYNOTICE}
				</div>
				<div style="width:100%;height:7px;background:#dddddd;margin-top:20px;margin-bottom: 20px;">&nbsp;</div>
				<div class="row" style="padding:5px;margin-top:20px;">
					<div class="col-100">
						<div style="text-align:left;padding-left:5px;border-left:8px #FFCC01 solid;font-size:0.85rem;">商家信息</div>
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-100">
						<div style="text-align:left;padding:5px;">${order.SHOPNAME}</div>
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-100">
						<div style="text-align:left;padding:5px;">营业时间:8:00:00~21:00:00</div>
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-50">
						<div style="text-align:left;padding:5px;">商家电话:${order.CONTRACTPHONE}</div>
					</div>
					<div class="col-50" style="text-align:right;">
					<img onclick="phone()" width="20" style="margin-right:5px;" src="<%=request.getContextPath()%>/static/icon/phone.png"/>
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-50">
						<div style="text-align:left;padding:5px;">${order.SHOPADDRESS}</div>
					</div>
					<div class="col-50" style="text-align:right;">
					<img onclick="position()" width="20" style="margin-right:5px;" src="<%=request.getContextPath()%>/static/icon/send.png"/>
					</div>
				</div>
				
				<div class="row" style="padding:5px;margin-top:20px;">
					<div class="col-100">
						<div style="text-align:left;padding-left:5px;border-left:8px #FFCC01 solid;font-size:0.85rem;">订单信息</div>
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-50">
						<div style="text-align:left;padding:5px;">订单编号</div>
					</div>
					<div class="col-50" style="text-align:right;padding:5px;">
						${order.ORDERSN}
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-50">
						<div style="text-align:left;padding:5px;">购买日期</div>
					</div>
					<div class="col-50" style="text-align:right;padding:5px;">
						${order.CDT}
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-50">
						<div style="text-align:left;padding:5px;">购买数量</div>
					</div>
					<div class="col-50" style="text-align:right;padding:5px;">
						${order.NUMBER}
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-50">
						<div style="text-align:left;padding:5px;">商品总价</div>
					</div>
					<div class="col-50" style="text-align:right;padding:5px;">
						${order.ORIGINAL}元
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-50">
						<div style="text-align:left;padding:5px;">实付金额</div>
					</div>
					<div class="col-50" style="text-align:right;padding:5px;">
						${order.MONEY}元
					</div>
				</div>
				
				<div class="row" style="padding:5px;margin-top:20px;">
					<div class="col-100">
						<div style="text-align:left;padding-left:5px;border-left:8px #FFCC01 solid;font-size:0.85rem;">用户信息</div>
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-50">
						<div style="text-align:left;padding:5px;">用户姓名</div>
					</div>
					<div class="col-50" style="text-align:right;padding:5px;">
						${order.USEPERSON}
					</div>
				</div>
				<div class="row" style="padding:5px;">
					<div class="col-50">
						<div style="text-align:left;padding:5px;">用户电话</div>
					</div>
					<div class="col-50" style="text-align:right;padding:5px;">
						${order.PERSONPHONE}
					</div>
				</div>
			</div>
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
    <script type="text/javascript">
    
    	wx.config({  
    	    debug: false,
    	    appId: "${config.appId}", 
    	    timestamp: "${config.timestamp}",
    	    nonceStr: "${config.noncestr}",
    	    signature: "${config.signature}",  
    	    jsApiList: [  
    	        'previewImage'
    	    ]  
    	}); 
    	
    	wx.ready(
    		function(){
    			
    		}
    	);
    	
    	wx.error(
    		function(res){
    			console.log(res);
    		}
    	);
    	
    	function preview(){
    		wx.previewImage({
	   			current: 'https://fanfan.skyable.cn<%=request.getContextPath()%>/orders/barcode?ORDER_ID=${order.ORDER_ID}', // 当前显示图片的http链接
	   			urls: ['https://fanfan.skyable.cn<%=request.getContextPath()%>/orders/barcode?ORDER_ID=${order.ORDER_ID}'] // 需要预览的图片http链接列表
   			});
    	}

    	function goRefund(id,sn,mn,state){
    		if(state == '0'){
    			$.alert("对不起,无法发起退款",function(){})
    			return;
    		}
    		if(state == '3'){
    			$.alert("对不起,该订单已使用",function(){})
    			return;
    		}
    		if(state == '5'){
    			$.alert("对不起,该订单已退款",function(){})
    			return;
    		}
    		
    		if(sn == ''){
    			$.alert("对不起,该订单使用优惠券无法退款",function(){})
    			return;
    		}
    		
    		if(parseFloat(mn) == 0.0){
    			$.alert("对不起,该订单包含会员产品暂无法退款",function(){})
    			return;
    		}
    		
      		location.href="<%=request.getContextPath()%>/orders/refund?ORDER_ID="+id
      	}
    	
    	function goGive(id,state){
    		if(state == '0'){
    			$.alert("对不起,无法发起赠送",function(){})
    			return;
    		}
    		if(state == '3'){
    			$.alert("对不起,该订单已使用",function(){})
    			return;
    		}
    		if(state == '5'){
    			$.alert("对不起,该订单已退款",function(){})
    			return;
    		}
    		
    		wx.miniProgram.navigateTo({
                url: '/pages/share/share?type=orders&fromopenid=${USER_SESSION.WXOPEN_ID}&image=orders.jpg&datakey=${order.ORDER_ID}&title=转赠好友订单'
           })
    		
      	}
    	
    	function phone(){
      		wx.miniProgram.navigateTo({
                url: '/pages/phone/phone?phone=${order.CONTRACTPHONE}'
           })
      	}
      	function position(){
      		wx.miniProgram.navigateTo({
                url: '/pages/position/position?latitude=${order.LATITUDE}&longitude=${order.LONGITUDE}&address=${order.SHOPADDRESS}'
           })
      	}
    	
    </script>
</html>