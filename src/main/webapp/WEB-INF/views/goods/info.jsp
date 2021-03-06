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
	<style>
		* { touch-action: pan-y; }
		.positionBox{
			position:fixed;
			top: 0;
			width: 104%;
			/*border-bottom: solid 1px #F2F2F2;*/
			box-shadow: 1px 1px 5px #F0F0F0;
		}
		.fenxiangBox{
			text-align: left;
			padding: 10px 0px 0px 0px;
		}
		.fenxiangBox>span{
			background: #FECB17;
			padding: 5px 8px;
			border-radius: 3px;
		}
		.active{
			background: #FDE01A;
		}
		.buttons-tab .button.active{
			color: #474747;
			font-weight: normal;
		}
		.infoBox img{
			width: 100%;
		}
		.scrollBox{
			width: 100%;
			height: 200px;
			border-radius: 5px;
			overflow-x: hidden;
		}
		.swipslider{
			width: 100%;
			height: 100%;
			margin: 0;
		}
		.sw-bullet>li{
			width: 50px;
			border-radius: 0;
			height: 3px;
		}
		.sw-bullet li.active{
			background: rgba(253,227,49,0.8);
		}
		.sw-bullet{
			bottom: 8%;
		}
		.sw-next-prev{
			display: none;
		}
	</style>
  </head>
  <body>
    <div class="page-group">
        <div class="page page-current">
			<div class="content">
			<div class="row" style="padding:5px;">
				<div class="col-100">
				<div class="card demo-card-header-pic inFoBox" style="margin-bottom: 0">
						<div valign="bottom" class="card-header color-white no-border no-padding">
                            <figure id="full_feature" class="swipslider">
                                <ul class="sw-slides">
                                    <c:forEach var="var" items="${fileDataList}" varStatus="xh">
                                        <li class="sw-slide">
                                            <img class='card-cover' height="200" style="border-radius: 10px;float:right;" src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}"  myIndex = ${xh.index}  alt="" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}';">
                                        </li>
                                    </c:forEach>
                                </ul>
                            </figure>
						</div>
				    <div class="card-footer infoproContentBox" style="margin-top:10px;">
				      <span>
				      	<h4 style="margin:0px;"><font style="color:#F40A0B;" class="bigFontSize">${pd.SELLMONEY}元</font></h4>
				      	<h4 style="margin:0px;margin-top:10px;font-weight: normal" class="delete deleteColor">原价 ${pd.ORIGINALMONEY}元</h4>
				      </span>
				      <span>
				      	<div id="goods_time_id_${pd.GOODS_ID}_tj_right" class="suspend right" style="background: #FEE101;font-size: 0.7rem;text-align: center;padding:10px">活动结束倒计时<div id="goods_time_id_${pd.GOODS_ID}_tj"><span>0</span>天<span>0</span> <span>0</span> <span>0</span></div></div>
				      </span>
				    </div>
				    <div class="card-content infoproContentBox">
				      <div class="card-content-inner" style="padding:10px 0 0px 0">
				        <p><span style="margin-right:10px;padding:3px 10px;" class="myColor smFontSize">[${pd.PROVIDE}]提供</span>${pd.GOODSDESC}</p>
				      </div>
				    </div>
				    <div class="card-footer infoproContentBox">
				      <span>已售${pd.VIRTUALSELLED}份</span>
				      <span>库存${pd.STORE}份</span>
				    </div>
					<div  style="width: 90%;margin: 0 auto;background: #F2F2F2; height: 1px"></div>
				  </div>
				  <script type="text/javascript">TimeDown("goods_time_id_${pd.GOODS_ID}_tj","${pd.ENDTIME}")</script>
				</div>
			</div>
			<div class="row" style="padding:5px">
				<div class="col-100" style="font-size: 0.7rem;">已抢购用户</div>
			</div>
        	<div class="row" style="padding:5px;">
				<div class="col-80 touxiangImage">
					<img src="<%=request.getContextPath()%>/static/icon/tx1.jpg"/>
					<img src="<%=request.getContextPath()%>/static/icon/tx2.jpg"/>
					<img src="<%=request.getContextPath()%>/static/icon/tx3.jpg"/>
					<img src="<%=request.getContextPath()%>/static/icon/tx4.jpg"/>
					<img src="<%=request.getContextPath()%>/static/icon/tx5.jpg"/>
					<img src="<%=request.getContextPath()%>/static/icon/tx6.jpg"/>
					<c:if test="${fn:length(peopleDataList) eq 0}">
						<img src="<%=request.getContextPath()%>/static/icon/add.jpg"/>
					</c:if>
						<%--<c:forEach var="var" items="${peopleDataList}">
							<img src="${var.PHOTO}"/>
						</c:forEach>--%>
					<c:if test="${fn:length(peopleDataList) > 6}">
						<img src="${peopleDataList[0].PHOTO}"/>
						<img src="${peopleDataList[1].PHOTO}"/>
						<img src="${peopleDataList[2].PHOTO}"/>
						<img src="${peopleDataList[3].PHOTO}"/>
						<img src="${peopleDataList[4].PHOTO}"/>
						<img src="${peopleDataList[5].PHOTO}"/>
						...
					</c:if>
					<c:if test="${fn:length(peopleDataList)<=5}">
						<c:forEach var="var" items="${peopleDataList}">
							<img src="${var.PHOTO}"/>
						</c:forEach>
					</c:if>

				</div>
			</div>
			<div style="width:100%;height:5px;margin: 10px 0" class="grayBox">&nbsp;</div>
			<div class="row" style="padding:10px;">
				<div class="col-60">
					<p style="margin:0px;" class="bigFontSize">${shop.SHOPNAME}</p>
					<p style="margin:0px;margin-top:10px;">${shop.SHOPADDRESS}</p>
				</div>
		        <div class="col-40" style="text-align:right;line-height:60px;"><img onclick="phone()" width="20" style="margin-right:15px;vertical-align: middle" src="<%=request.getContextPath()%>/static/icon/phone.png"/> | <img  onclick="position()" style="margin-left:15px;vertical-align: middle" width="20" src="<%=request.getContextPath()%>/static/icon/send.png"/></div>
			</div>
			<div style="width:100%;height:5px;margin: 10px 0 0 0;padding-bottom: 0" class="grayBox">&nbsp;</div>
			<div class="row" style="padding:0 5px 5px 5px;" id="proInfoBox">
				<div class="col-100" style="width: 104%;margin-left: 0">

					<div class="buttons-tab" id="bignav" style="border-bottom: solid 1px #F2F2F2" onscroll="myFunction()">

						<%--<button id="roll1">商家信息</button>
                        <button id="roll2">购买须知</button>
                        <button id="roll3">商品详情</button>--%>
						<a href="" class=" tab-link active button " id="roll1" style="font-size: 0.8rem;">购买须知</a>
						<a href="" class=" button" id="roll2" style="font-size: 0.8rem;">商品详情</a>
					</div>
				<%--<div class="buttons-tab">
			    <a href="#tab1" class="tab-link active button">商品详情</a>
			    <a href="#tab2" class="tab-link button">购买须知</a>
			</div>--%>


		    <div >
		      <div id="roll_top" >
				  <div class="row" style="padding:5px;">
					  <div class="col-100">
						  <div style="min-height:180px;padding:10px;word-wrap: break-word;word-break: break-all;overflow: hidden;">${pd.BUYNOTICE}</div>
					  </div>
				  </div>
		    </div>
		      <div id="roll_top1">
				  <div class="row" style="padding:5px;">
					  <div class="col-100">
						  <%--
                                              <img style="border-top-left-radius:5px;border-top-right-radius:5px;border-bottom-left-radius:5px;border-bottom-right-radius:5px;" height="200" width="100%" src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" alt="">
                          --%>
						  <div class="infoBox" style="min-height:180px;padding:10px;word-wrap: break-word;word-break: break-all;overflow: hidden;">${pd.GOODSDETIAL}</div>

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
		  	<a class="tab-item external" href="<%=request.getContextPath()%>/home" style="border-right:1px #dddddd solid;">
		     <span class="icon"><img src="<%=request.getContextPath()%>/static/icon/index.png"/></span>
		     <span class="tab-label">首页</span>
		    </a>
		    <!-- <a class="tab-item external" href="javascript:;" onclick="shareGoods()">分享抖音</a> -->
		    <a class="tab-item external" style="background:#FEE101;color:#000000;" href="<%=request.getContextPath()%>/goBuy?GOODS_ID=${pd.GOODS_ID}&FROMWXOPEN_ID=${FROMWXOPEN_ID}">立即购买</a>
		  </div>
		</nav>
        </div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
	  JQ$(window).on('load',function(){
		  JQ$('#full_feature').swipeslider();
	  });
	  window.onload=function(){
		  fenxiang();
	  }
	  function fenxiang(){
		  tt.miniProgram.navigateTo({
			  url: '/pages/webview/webview?shopid=${shop.SHOP_ID}&shopname=${shop.SHOPNAME}&goodsid=${goodsid}'
		  })
	  }
	  var startx, starty;
	  //获得角度
	  function getAngle(angx, angy) {
		  return Math.atan2(angy, angx) * 180 / Math.PI;
	  };
	  //根据起点终点返回方向 1向上 2向下 3向左 4向右 0未滑动
	  function getDirection(startx, starty, endx, endy) {
		  var angx = endx - startx;
		  var angy = endy - starty;
		  var result = 0;
		  //如果滑动距离太短
		  if (Math.abs(angx) < 2 && Math.abs(angy) < 2) {
			  return result;
		  }
		  var angle = getAngle(angx, angy);
		  if (angle >= -135 && angle <= -45) {
			  result = 1;
		  } else if (angle > 45 && angle < 135) {
			  result = 2;
		  } else if ((angle >= 135 && angle <= 180) || (angle >= -180 && angle < -135)) {
			  result = 3;
		  } else if (angle >= -45 && angle <= 45) {
			  result = 4;
		  }
		  return result;
	  }
	  $(".content").scroll(function (evt) {
		  var ss3=$("#proInfoBox").offset().top;
		  if(ss3<-1){
			  $("#bignav").addClass("positionBox");
		  }else{
			  $("#bignav").removeClass("positionBox");
		  }
	  });
	  //手指接触屏幕
	  document.addEventListener("touchstart", function(e) {
		  startx = e.touches[0].pageX;
		  starty = e.touches[0].pageY;
	  }, false);
	  //手指离开屏幕
	  document.addEventListener("touchend", function(e) {
		  var endx, endy;
		  endx = e.changedTouches[0].pageX;
		  endy = e.changedTouches[0].pageY;
		  var direction = getDirection(startx, starty, endx, endy);
		  var ss=$("#roll_top").offset().top;
		  var ss1=$("#roll_top1").offset().top;

		  switch (direction) {
			  case 0:
				  break;
			  case 1:
				  if(ss<=199&&ss1>=120){
					  // 向上滑动，图1高亮
					  $("#roll2").removeClass("active");
					  $("#roll1").addClass("tab-link active button");
				  }
				  if(ss1<=199){
					  // 向上滑动，图2高亮
					  $("#roll1").removeClass("active");
					  $("#roll2").addClass("tab-link active button");
				  }

				  break;
			  case 2:
				  if(ss<=199&&ss1>=120){
					  // 向上滑动，图1高亮
					  $("#roll2").removeClass("active");
					  $("#roll1").addClass("tab-link active button");
				  }
				  if(ss1<=199){
					  // 向上滑动，图2高亮
					  $("#roll1").removeClass("active");
					  $("#roll2").addClass("tab-link active button");
				  }

				  break;
			  default:
		  }
	  }, false);
	  $(document).ready(function() {
		  document.querySelector("#roll1").onclick = function(){
			  document.querySelector("#roll_top").scrollIntoView(true);
			  // document.querySelector("#roll_top1").scrollIntoView(false);
			  // document.querySelector("#roll_top2").scrollIntoView(false);
			  $("#roll2").removeClass("active");
			  $("#roll1").addClass("tab-link active button");

		  }
		  document.querySelector("#roll2").onclick = function(){
			  // document.querySelector("#roll_top").scrollIntoView(false);
			  /*	  $("#roll1").addClass("tab-link button");
			   $("#roll3").addClass("tab-link  button");*/
			  $("#roll1").removeClass("active");
			  $("#roll2").addClass("tab-link active button");
			  document.querySelector("#roll_top1").scrollIntoView(true);
			  // document.querySelector("#roll_top2").scrollIntoView(false);
		  }

	  });
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