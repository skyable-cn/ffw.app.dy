<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>饭饭精选&nbsp;&nbsp;靠谱还实惠</title>
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
			<div class="row">
				<div class="col-100" style="position:relative;">
					<img class='card-cover' src="<%=request.getContextPath()%>/static/icon/active.gif" width="100%" height="160px"/>
					<div class="row" style="position:absolute;z-index:999;height:150px;top:5px;width:100%;">
					<div class="col-60" style="padding:20px;">
						<div class="row">
							<div class="col-100" style="margin-top:10px;">
							<span style="font-weight:bold;font-size:0.85rem;">${USER_SESSION.NICKNAME}</span>
							<c:if test="${USER_SESSION.MEMBERTYPE_ID eq 1 or USER_SESSION.MEMBERTYPE_ID eq 3}">
							<span onclick="javascript:location.href='<%=request.getContextPath()%>/member';" style="margin-left:15px;background:#ffffff;padding-top:2px;padding-bottom:2px;padding-left:7px;padding-right:7px;border-top-left-radius:5px;border-top-right-radius:5px;border-bottom-left-radius:5px;border-bottom-right-radius:5px;">未加入会员</span>
							</c:if>
							</div>
						</div>
						<div class="row" style="margin-top:15px;">
							<div class="col-50"><div style="font-size:0.85rem;">${ordersNum}</div><div>订单</div></div>
							<div class="col-50"><div style="font-size:0.85rem;">${cardsNum}</div><div>卡券</div></div>
						</div>
					</div>
					<div class="col-40" style="padding:20px;">
						<img align="middle" style="margin:10px; width:80px;border-radius:50%;" src="${USER_SESSION.PHOTO}"/>
					</div>
				</div>
				</div>
			</div>
			<div class="row module2" style="margin-top:10px;">
				<div class="col-33"><a class="external" href="<%=request.getContextPath()%>/discount"><img src="<%=request.getContextPath()%>/static/icon/home/wz.png"/><p>周四五折</p></a></div>
		        <div class="col-33"><a class="external" href="<%=request.getContextPath()%>/lottery"><img src="<%=request.getContextPath()%>/static/icon/home/cj.png"/><p>免费抽奖</p></a></div>
		        <div class="col-33"><a class="external" href="<%=request.getContextPath()%>/shop"><img src="<%=request.getContextPath()%>/static/icon/home/tj.png"/><p>好店推荐</p></a></div>
		        <!-- <div class="col-25"><a class="external" href="<%=request.getContextPath()%>/seller"><img src="<%=request.getContextPath()%>/static/icon/home/rz.png"/><p>商家入驻</p></a></div> -->
			</div>
			<div style="width:100%;height:10px;background:#dddddd;">&nbsp;</div>
			<div class="row" style="padding:5px;">
				<div class="col-50" style="font-size:1.0rem;font-weight:bold;">优惠活动</div>
				<div class="col-50 more_activity"><a class="external" href="<%=request.getContextPath()%>/stand" style="color:#FFCC01;font-size:0.85rem;line-height:45px;">查看更多</a></div>
			</div>
			<div class="row" style="padding:5px;padding-top:0px;">
				<div class="col-100">
					<div class="swiper-container">
					    <div class="swiper-wrapper">
						    <c:forEach var="var" items="${standData}">
						    	<div class="swiper-slide"><a class="external" href="<%=request.getContextPath()%>/goods/info?GOODS_ID=${var.GOODS_ID}"><img width="100%" src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}';"/></a></div>
						    </c:forEach>
					    </div>
					    <div class="swiper-pagination"></div>
					</div>
				</div>
			</div>
			<div class="row" style="padding:5px;">
				<div class="col-50"><div style="font-size:1.0rem;font-weight:bold;">今日热卖</div><div>好店爆款,人手一份</div></div>
				<div class="col-50">
				<div class="content-block" style="margin:0px;margin-top:10px;">
				    <div class="buttons-row">
				      <a href="#tab1" class="tab-link active button">推荐</a>
				      <a href="#tab2" class="tab-link button">最热</a>
				    </div>
				  </div>
			  </div>
			</div>
			<div class="row" style="padding:5px;">
				<div class="col-100">
		    <div class="tabs">
		      <div id="tab1" class="tab active">
		      	<div id="goods1">
		      	
				  </div>
		      </div>
		      <div id="tab2" class="tab">
		      <div id="goods2">
		        
				  </div>
		      </div>
		    </div>
				</div>
			</div>
		    <h5>&nbsp;</h5>
		    <div style="width:60px;position:fixed;right:0;top:70%;z-index:999;" onclick="goCustomer();"><img width="55" src="<%=request.getContextPath()%>/static/icon/weixin.png"/></div>
			</div>
			<%@ include file="../common/nav.jsp"%>
        </div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
  	var swiper = new Swiper('.swiper-container', {
      pagination: {
        el: '.swiper-pagination',
        dynamicBullets: true,
      },
      autoplay:true
    });	
  </script>
    <script type="text/javascript">

	   	search(true);
		     
    	var page_currentPage = 1;
    	
    	function search(flag){
    		$.ajax({
    			type: "POST",
    			url: '<%=request.getContextPath()%>/home/search',
    	    	data:{
  					"page_currentPage":page_currentPage
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
    				var list = data.page.data;
    				var html = "";
    				$.each(list,function(index,value){ 
    					var backmoney = 0;
    					if("${USER_SESSION.MEMBERTYPE_ID}"=="1"){
    						backmoney = value.MEMBERBACKMONEY;
    					}else if("${USER_SESSION.MEMBERTYPE_ID}"=="2"){
    						backmoney = value.VIPBACKMONEY;
    					}else{
    						backmoney = value.BACKMONEY0;
    					}
    					html += `
    					<div class="card demo-card-header-pic" style="position:relative;">
    				    <div valign="bottom" class="card-header color-white no-border no-padding">
    				      <a class="external" href="<%=request.getContextPath()%>/goods/info?GOODS_ID=`+value.GOODS_ID+`"><img class='card-cover' height="200" width="100%" src="<%=request.getContextPath()%>/file/image?FILENAME=`+value.FILEPATH+`" alt="" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=`+value.FILEPATH+`';"></a>
    				      <div id="goods_time_id_`+value.GOODS_ID+`_tj_left" class="suspend left">抢购中</div>
    				      <div id="goods_time_id_`+value.GOODS_ID+`_tj_right" class="suspend right">活动倒计时<div id="goods_time_id_`+value.GOODS_ID+`_tj"><span>0</span>天<span>0</span> <span>0</span> <span>0</span></div></div>
    				    </div>
    				    <div class="card-content">
    				      <div class="card-content-inner">
    				        <p><span style="color:#fff;background-color:#F40A0B;padding:3px;border-radius:5px;">爆</span>`+value.GOODSDESC+`</p>
    				      </div>
    				    </div>
    				    <div class="card-footer">
    				      <span>体验价: <font style="color:#F40A0B;">`+value.SELLMONEY+`</font></span>
    				      <span class="delete">¥ `+value.ORIGINALMONEY+`</span>
    				      <span class="return">返 `+backmoney+`</span>
    				      <span>已抢:`+value.BUYNUMBER+`</span>
    				    </div>
    				  </div>
    					`;
    					TimeDown("goods_time_id_"+value.GOODS_ID+"_tj",value.ENDTIME)
    				})
    				if(flag){
    					$("#goods1").html(html);
    				}else{
    					$("#goods1").append(html);
    				}
    				
    				var list = data.page1.data;
    				var html = "";
    				$.each(list,function(index,value){ 
    					var backmoney = 0;
    					if("${USER_SESSION.MEMBERTYPE_ID}"=="1"){
    						backmoney = value.MEMBERBACKMONEY;
    					}else if("${USER_SESSION.MEMBERTYPE_ID}"=="2"){
    						backmoney = value.VIPBACKMONEY;
    					}else{
    						backmoney = value.BACKMONEY0;
    					}
    					html += `
    					<div class="card demo-card-header-pic" style="position:relative;">
    				    <div valign="bottom" class="card-header color-white no-border no-padding">
    				      <a class="external" href="<%=request.getContextPath()%>/goods/info?GOODS_ID=`+value.GOODS_ID+`"><img class='card-cover' height="200" width="100%" src="<%=request.getContextPath()%>/file/image?FILENAME=`+value.FILEPATH+`" alt="" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=`+value.FILEPATH+`';"></a>
    				      <div id="goods_time_id_`+value.GOODS_ID+`_zr_left" class="suspend left">抢购中</div>
    				      <div id="goods_time_id_`+value.GOODS_ID+`_zr_right" class="suspend right">活动倒计时<div id="goods_time_id_`+value.GOODS_ID+`_zr"><span>0</span>天<span>0</span> <span>0</span> <span>0</span></div></div>
    				    </div>
    				    <div class="card-content">
    				      <div class="card-content-inner">
    				        <p><span style="color:#fff;background-color:#F40A0B;padding:3px;border-radius:5px;">爆</span>`+value.GOODSDESC+`</p>
    				      </div>
    				    </div>
    				    <div class="card-footer">
    				      <span>体验价: <font style="color:#F40A0B;">`+value.SELLMONEY+`</font></span>
    				      <span class="delete">¥ `+value.ORIGINALMONEY+`</span>
    				      <span class="return">返 `+backmoney+`</span>
    				      <span>已抢:`+value.BUYNUMBER+`</span>
    				    </div>
    				  </div>
    					`;
    					TimeDown("goods_time_id_"+value.GOODS_ID+"_zr",value.ENDTIME)
    				})
    				if(flag){
    					$("#goods2").html(html);
    				}else{
    					$("#goods2").append(html);
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
  function goCustomer(){
		wx.miniProgram.navigateTo({
          url: '/pages/customer/customer'
     })
	}
  </script>
</html>