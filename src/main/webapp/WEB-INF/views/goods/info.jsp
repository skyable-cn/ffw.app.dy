<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>商品详情</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
    <%@ include file="../common/utiljs.jsp"%>
    <script type="text/javascript" src="https://s3.pstatp.com/toutiao/tmajssdk/jssdk-1.0.0.js"></script>
  </head>
  <body>
    <div class="page-group">
        <div class="page page-current">
			<div class="content">
			<div class="row" style="padding:5px;">
				<div class="col-100">
				<div class="card demo-card-header-pic">
				    <div valign="bottom" class="card-header color-white no-border no-padding">
				      <img class='card-cover' height="200" width="100%" src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" alt="" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=${pd.FILEPATH}';">
				    </div>
				    <div class="card-footer" style="margin-top:10px;">
				      <span>
				      	<h4 style="margin:0px;"><font style="color:#F40A0B;">${pd.SELLMONEY}元</font></h4>
				      	<h4 style="margin:0px;margin-top:10px;"class="delete">原价 ${pd.ORIGINALMONEY}元</h4>
				      </span>
				      <span>
				      	<div id="goods_time_id_${pd.GOODS_ID}_tj_right" class="suspend right">活动结束倒计时<div id="goods_time_id_${pd.GOODS_ID}_tj"><span>0</span>天<span>0</span> <span>0</span> <span>0</span></div></div>
				      </span>
				    </div>
				    <div class="card-content">
				      <div class="card-content-inner">
				        <p><span style="margin-right:10px;padding:3px 10px;background:#FFCC01;">[${pd.PROVIDE}]提供</span>${pd.GOODSDESC}</p>
				      </div>
				    </div>
				    <div class="card-footer">
				      <span>已售${pd.BUYNUMBER}份</span>
				      <span>库存${pd.STORE}份</span>
				    </div>
				  </div>
				  <script type="text/javascript">TimeDown("goods_time_id_${pd.GOODS_ID}_tj","${pd.ENDTIME}")</script>
				</div>
			</div>
			<div style="width:100%;height:5px;background:#dddddd;">&nbsp;</div>
			<div class="row" style="padding:5px;">
				<div class="col-100" style="font-size:0.85rem;">已抢购用户</div>
			</div>
        	<div class="row" style="padding:5px;">
				
					<c:if test="${fn:length(peopleDataList) eq 0}">
						<div class="col-20"><img style="width:50px;border-radius:50%;border:1px #AAAAAA solid;" src="<%=request.getContextPath()%>/static/icon/add.jpg"/></div>
					</c:if>
					<c:forEach var="var" items="${peopleDataList}">
						<div class="col-20"><img align="middle" style="width:90%;border-radius:50%;margin-bottom:5px;" src="${var.PHOTO}"/></div>
					</c:forEach>
			</div>
			<div style="width:100%;height:5px;background:#dddddd;">&nbsp;</div>
			<div class="row" style="padding:10px;">
				<div class="col-60">
					<p style="margin:0px;font-size:0.85rem;">${shop.SHOPNAME}</p>
					<p style="margin:0px;margin-top:10px;">${shop.SHOPADDRESS}</p>
				</div>
		        <div class="col-40" style="text-align:right;line-height:60px;"><img onclick="phone()" width="20" style="margin-right:15px;" src="<%=request.getContextPath()%>/static/icon/phone.png"/> | <img  onclick="position()" style="margin-left:15px;" width="20" src="<%=request.getContextPath()%>/static/icon/send.png"/></div>
			</div>
			<div style="width:100%;height:5px;background:#dddddd;">&nbsp;</div>
			<div class="row" style="padding:5px;">
				<div class="col-100">
				<div class="buttons-tab">
			    <a href="#tab1" class="tab-link active button">商品详情</a>
			    <a href="#tab2" class="tab-link button">购买须知</a>
			</div>
		    <div class="tabs">
		      <div id="tab1" class="tab active">
		        <c:forEach var="var" items="${fileDataList}" varStatus="index">
		        <div style="text-align:center;padding:5px;">${index.index+1}产品图片</div>
				<div class="row" style="padding:5px;">
				<div class="col-100">
					<img style="border-top-left-radius:5px;border-top-right-radius:5px;border-bottom-left-radius:5px;border-bottom-right-radius:5px;" height="200" width="100%" src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" alt="">
				</div>
		      </div>
		      </c:forEach>
		    </div>
		      <div id="tab2" class="tab">
		        <div class="row" style="padding:5px;">
				<div class="col-100">
					<div style="min-height:180px;padding:10px;border:1px #dddddd solid;word-wrap: break-word;word-break: break-all;overflow: hidden;">${pd.BUYNOTICE}</div>
				</div>
			</div>
		      </div>
				</div>
			</div>
        </div>
        <h5>&nbsp;</h5>
        </div>
        <nav class="bar bar-tab">
		  <div class="row">
		  	<a class="tab-item external" href="<%=request.getContextPath()%>/home" style="border-right:1px #aaaaaa solid;">
		     <span class="icon"><img src="<%=request.getContextPath()%>/static/icon/index.png"/></span>
		     <span class="tab-label">首页</span>
		    </a>
		    <a class="tab-item external" href="javascript:shareGoods();">分享抖音</a>
		    <a class="tab-item external" style="background:#FFCC01;color:#000000;" href="<%=request.getContextPath()%>/goBuy?GOODS_ID=${pd.GOODS_ID}&FROMWXOPEN_ID=${FROMWXOPEN_ID}">立即购买</a>
		  </div>
		</nav>
        </div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
  	function phone(){
  		tt.miniProgram.navigateTo({
            url: '/pages/phone/phone?phone=${shop.CONTRACTPHONE}'
       })
  	}
  	function position(){
  		tt.miniProgram.navigateTo({
            url: '/pages/position/position?latitude=${shop.LATITUDE}&longitude=${shop.LONGITUDE}&address=${shop.SHOPADDRESS}'
       })
  	}
  	function shareGoods(){
 		 tt.miniProgram.navigateTo({
            url: '/pages/share/share?type=goods&fromopenid=${USER_SESSION.WXOPEN_ID}&image=${pd.FILEPATH1}&datakey=${pd.GOODS_ID}&title=产品推广宣传'
       })
 	}
  </script>
</html>