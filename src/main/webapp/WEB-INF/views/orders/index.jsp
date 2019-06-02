<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>确认订单</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
    <script type="text/javascript" src="https://res.wx.qq.com/open/js/jweixin-1.3.2.js"></script>
  </head>
  <body>
    <div class="page-group">
        <div class="page page-current" id="page1">
			<div class="content">
				<div class="row" style="padding:10px;">
					<div class="col-40">
					<img width="100%" style="border-top-left-radius:5px;border-top-right-radius:5px;border-bottom-left-radius:5px;border-bottom-right-radius:5px;" src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" alt="" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=${pd.FILEPATH}';">
					</div>
					<div class="col-60">
					<div style="font-size:0.85rem;">${pd.GOODSNAME}</div>
					<div>${pd.GOODSDESC}</div>
					</div>
				</div>
				<div style="width:100%;height:5px;background:#dddddd;">&nbsp;</div>
				<div class="row" style="padding:10px;padding-top:10px;padding-bottom:10px;">
					<div class="col-50" style="line-height:50px;">购买数量</div>
					<div class="col-50"><div style="margin-right:20px;float:right;"><button style="width:35px;margin-right:1px;height:35px;" onclick="computer('-1')">-</button><button style="width:40px;background:#FFFFFF;height:35px;" id="numberButton">1</button><button style="width:35px;margin-left:1px;height:35px;" onclick="computer('1')">+</button></div></div>
				</div>
				<div style="width:100%;height:1px;background:#dddddd;">&nbsp;</div>
				<div class="row" style="padding:10px;padding-top:15px;padding-bottom:15px;">
					<div class="col-50">小计</div>
					<div class="col-50"><div style="margin-right:20px;float:right;"><span id="XJ" style="font-size:0.7rem;">${pd.SELLMONEY}</span>元</div></div>
				</div>
				<c:if test="${fn:length(cardsData) > 0}">
				<div style="width:100%;height:1px;background:#dddddd;">&nbsp;</div>
				<div class="row" style="padding:10px;padding-top:15px;padding-bottom:15px;">
					<div class="col-40">卡券抵扣</div>
					<div class="col-60"><div style="margin-right:20px;float:right;">
						<font id="JMTS" style="color:#F40A0B;display:none;">(抵扣0.00元)</font><a href="#page2" style="color:#3d4145;font-size:0.7rem;font-weight:normal;">${fn:length(cardsData)}张可用&nbsp;&nbsp;<img width="10" height="10" src="<%=request.getContextPath()%>/static/icon/right.png"/></a>
						<!-- <select onchange="changeMoney()" id="KQID" style="border:none;background:#eee;">
							<option value="">${fn:length(cardsData)}个卡券可用</option>
							<c:forEach var="var" items="${cardsData}">
								<option value="${var.MONEY}">${var.DESCRIPTION}</option>
							</c:forEach>
							<option value="0">不使用卡券</option>
						</select>
						 -->
					</div></div>
				</div>
				</c:if>
				<div style="width:100%;height:1px;background:#dddddd;">&nbsp;</div>
				<div class="row" style="padding:10px;padding-top:15px;padding-bottom:15px;">
					<div class="col-50">实付金额</div>
					<div class="col-50"><div style="margin-right:20px;float:right;"><span id="SF" style="font-size:0.7rem;">${pd.SELLMONEY}</span>元</div></div>
				</div>
				<c:if test="${vipinfo ne null}">
				<div style="width:100%;height:1px;background:#dddddd;">&nbsp;</div>
				</c:if>
				<c:if test="${vipinfo eq null}">
				<div style="width:100%;height:20px;background:#dddddd;">&nbsp;</div>
				<div class="row" style="padding:10px;padding-top:15px;padding-bottom:15px;height:100px;position:relative;">
	        	<div class="col-50" style="padding-top:30px;font-size:1.2rem;color:#666666;">
	        	${product.PRODUCTDESC}
	        	</div>
	        	<div class="col-25" style="line-height:60px;text-align:right;">
	        	¥ ${product.PRODUCTMONEY}
	        	</div>
	        	<div class="col-25" style="line-height:60px;text-align:right;">
	        	<div class="item-input">
              <label class="label-switch">
                <input type="checkbox" id="vip" name="vip">
                <div class="checkbox"  value="1"></div>
              </label>
            </div>
	        	</div>
	        	<div style="background:#FFCC01;position:absolute;top:0px;color:#333333;padding:5px;padding-left:15px;border-bottom-right-radius:10px;">开通会员,周四立享五折优惠</div>
        	  </div>
        	  <div style="width:100%;height:5px;background:#dddddd;">&nbsp;</div>
        	  </c:if>
        	</div>
        	
        	<nav class="bar bar-tab">
  <div class="row">
  	<a class="tab-item external" href="javascript:;" style="color:#000000;">实付款: ¥ <span id="SFC">${pd.SELLMONEY}</span>元</a>
    <a class="tab-item external" onclick="orderSave()" style="background:#FFCC01;color:#000000;" href="javascript:;">立即购买</a>
  </div>
</nav>
    	</div>
    	<div class="page" id="page2">
			<div class="content">
			<c:forEach var="var" items="${cardsData}">
			  <div class="row" style="padding:5px;">
				<div class="col-100">
					<a href="#page1"><div class="card" style="background:#efeff4;" onclick="changeMoney('${var.CARD_ID}','${var.MONEY}')">
				    <div class="card-content">
				      <div class="card-content-inner" style="border-top-left-radius:5px;border-top-right-radius:5px;height:80px;background:#FE0100;color:#FFFFFF;font-weight:normal;">
				      <div class="row">
				      	<div class="col-30" style="padding-left:15px;line-height:2.5rem;font-size:1.5rem;">${var.MONEY}元</div>
				      	<div class="col-60">
				      	<div style="font-size:0.85rem;">代金券</div>
				      	<div>全场通用</div>
				      	</div>
				      </div>
				      </div>
				    </div>
				    <div class="card-footer" style="border-bottom-left-radius:5px;border-bottom-right-radius:5px;text-align:right;background:#FFCC01;font-weight:normal;"><span></span><span>有效期:${var.STARTTIME} / ${var.ENDTIME}</span></div>
				  </div>
				  </a>
			  </div>
			  </div>
			</c:forEach>
			<div class="row" style="padding:5px;">
				<div class="col-100"><a class="button button-big button-fill" onclick="changeMoney('0','0')" href="#page1" style="background:#FFCC01;color:#000000;">不使用现金券</a></div>
			</div>
			</div>
			

		</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
  	function computer(opt){
  		var num = parseInt(opt);
  		var count = parseInt($("#numberButton").text());
  		if(count <= 1 && num < 0){
  			return;
  		}
  		
  		var lastNum = count+num;
  		$("#numberButton").text(lastNum);
  		
  		$("#XJ").html(lastNum * parseFloat('${pd.SELLMONEY}'));
  		$("#SF").html(lastNum * parseFloat('${pd.SELLMONEY}') - parseFloat(MONEY) + parseFloat(VIPMONEY));
  		$("#SFC").html((lastNum * parseFloat('${pd.SELLMONEY}') - parseFloat(MONEY) + parseFloat(VIPMONEY))*PERCENT);
  		
  		if(parseFloat($("#SF").text()) < 0){
  			$("#SF").html("0.00");
  			$("#SFC").html("0.00");
  		}
  	}
  	
  	var PERCENT = "${ZSFLAG}"=="1" && "${vipinfo}"!="" ? "0.5":"1.0";
  	$("#SFC").text(parseFloat('${pd.SELLMONEY}')*parseFloat(PERCENT));
  	
  	var CARD_ID = '0';
  	
  	var MONEY = '0';
  	
  	var VIPMONEY = '0';
  	
  	function changeMoney(id,money){
  		if(money != "0"){
  			$("#JMTS").html("(抵消"+money+")");
  			$("#JMTS").css("display","");
  		}else{
  			$("#JMTS").html("(抵消0.00元)");
  			$("#JMTS").css("display","none");
  		}
  		
  		
  		CARD_ID = id;
  		MONEY = money;
  		
  		var count = parseInt($("#numberButton").text());
  		$("#XJ").html(count * parseFloat('${pd.SELLMONEY}'));
  		$("#SF").html(count * parseFloat('${pd.SELLMONEY}') - parseFloat(MONEY) + parseFloat(VIPMONEY));
  		$("#SFC").html((count * parseFloat('${pd.SELLMONEY}') - parseFloat(MONEY) + parseFloat(VIPMONEY))*PERCENT);
  		
  		if(parseFloat($("#SF").text()) < 0){
  			$("#SF").html("0.00");
  			$("#SFC").html("0.00");
  		}
  	}
  	
  	function orderSave(){
  		$.ajax({
			type: "POST",
			url: '<%=request.getContextPath()%>/orders/save',
	    	data:{
	    		"ORIGINAL":$("#XJ").text(),
	    		"MONEY":$("#SFC").text(),
	    		"VIPMONEY":VIPMONEY,
	    		"DERATE":MONEY,
	    		"CARD_ID":CARD_ID,
	    		"GOODS_ID":'${pd.GOODS_ID}',
	    		"NUMBER":$("#numberButton").text(),
	    		"FROMWXOPEN_ID":'${FROMWXOPEN_ID}',
	    		"NEEDMONEY":$("#SF").text(),
	    		"PERCENT":PERCENT
	    	},
	    	async: false,
			dataType:'json',
			cache: false,
			beforeSend:function(){
				
			},
			success: function(data){
				if(data.flag ){
					if(parseFloat(data.data.MONEY)>0){
						goPay(data.data);
					}else{
						$.alert('本次实付金额为0元,系统已为你免单.',function(){
							location.href='<%=request.getContextPath()%>/my'
						})
						
					}
				}
			},
			error:function(){
				
			}
		});
  	}
  	
  	function goPay(data){
 		 wx.miniProgram.navigateTo({
            url: '/pages/pay/pay?type=goods&id='+data.ORDER_ID+'&sn='+data.ORDERSN+'&original='+data.ORIGINAL+'&derate='+data.DERATE+'&money='+data.MONEY
       })
 	}
  	
  	$("#vip").change(function(){
  		if(VIPMONEY == '0'){
  			VIPMONEY = "${product.PRODUCTMONEY}";
  		}else{
  			VIPMONEY = "0";
  		}
  		
  		var count = parseInt($("#numberButton").text());
  		$("#XJ").html(count * parseFloat('${pd.SELLMONEY}'));
  		$("#SF").html(count * parseFloat('${pd.SELLMONEY}') - parseFloat(MONEY) + parseFloat(VIPMONEY));
  		$("#SFC").html((count * parseFloat('${pd.SELLMONEY}') - parseFloat(MONEY) + parseFloat(VIPMONEY))*PERCENT);
  		
  		if(parseFloat($("#SF").text()) < 0){
  			$("#SF").html("0.00");
  			$("#SFC").html("0.00");
  		}
  		
  	})
  </script>
</html>