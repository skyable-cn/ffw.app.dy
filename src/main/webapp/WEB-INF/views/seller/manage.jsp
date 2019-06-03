<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>商户后台</title>
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
			<div class="content infinite-scroll" data-distance="30">
						<div class="row" style="padding:5px;">
				<div class="col-100">
				
		      <div class="row">
		      	<div class="col-100">
				    <div class="search-input"  style="width:calc(100% - 40px);float:left;margin-top:2px;hei">
				      <label class="icon icon-search" for="search"></label>
				      <input type="search" id='search' placeholder='输入关键字...'/>
				    </div>
				<div onclick="scanEWM()" style="width:40px;float:right;text-align:center;"><img align="middle" width="30" src="<%=request.getContextPath()%>/static/icon/scan.png"/></div>
				</div>
		      </div>
		      <div id="orders">
		      
		      </div>

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
	      		'scanQRCode' 
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
  	
  	function scanEWM(){
  		wx.scanQRCode({
  			needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
  			scanType: ["qrCode","barCode"], // 可以指定扫二维码还是一维码，默认二者都有
  			success: function (res) {
  				var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
  				var orderJson = null;
  				try{
  					orderJson = JSON.parse(result);
  				}catch(e){
  					$.alert("对不起,请检查二维码数据来源",function(){})
  					return;
  				}
  				
  				if(!orderJson.USEID || !orderJson.USEKEY){
  					$.alert("核销码无法识别,数据信息异常缺失",function(){})
  					return;
  				}
  				
  				$.ajax({
  					type: "POST",
  					url: '<%=request.getContextPath()%>/orders/verification/info',
  			    	data:{
  			    		"USEID":orderJson.USEID
  			    	},
  			    	async: false,
  					dataType:'json',
  					cache: false,
  					beforeSend:function(){
  						
  					},
  					success: function(data){
  						var ORDERSTATE = data.data.STATE;
  						if(data.flag && ORDERSTATE){
  							if(ORDERSTATE == "0"){
  			  					$.alert("该订单待付款,请先付款",function(){})
  			  					return;
  			  				}
  			  				//if(ORDERSTATE == "1"){
  			  				//	$.alert("该订单待确认,请先确认信息",function(){})
  			  				//	return;
  			  				//}
  			  				if(ORDERSTATE == "5"){
  			  					$.alert("对不起,该订单已退款",function(){})
  			  					return;
  			  				}
  			  				location.href='<%=request.getContextPath()%>/orders/verification?USEID='+orderJson.USEID+'&USEKEY='+orderJson.USEKEY+"&FROM=BAR&SHOP_ID=${shop.SHOP_ID}";
  						}else{
  							$.alert("对不起,订单参数信息非法",function(){})
  						}
  					},
  					error:function(){
  						
  					}
  				});
  			}
  		});
  	}
  </script>
  <script type="text/javascript">
  
  	$("#search").blur(function(){
	  page_currentPage = 1;
		search(true);
	});
  		
  		search(true);
		     
    	var page_currentPage = 1;
    	
    	function search(flag){
    		$.ajax({
    			type: "POST",
    			url: '<%=request.getContextPath()%>/orders/search',
    	    	data:{
    	    		"keywords":$("#search").val(),
    	    		"SHOP_ID":"${shop.SHOP_ID}",
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
    				if(list.length == 0){
    					$("#orders").html('');
    					$.hidePreloader();
    					$.toast("该条件暂无数据");
    					loading = false;
    					return;
    				}
    				var html = "";
    				$.each(list,function(index,value){ 
    					var state = '';
    					if(value.STATE == '2'){
    						state = '待核销'
    					}else if(value.STATE == '3'){
    						state = '已核销'
    					}else{
    						
    					}
    					html += `
    					<div class="card">
    				    <div class="card-header">订单:`+value.ORDERSN+`<span style="float:right;border:1px #444444 solid;border-radius: 5px;padding: 5px;font-size: 14px;">`+state+`</span></div>
    				    <div class="card-content">
    				      <div class="list-block media-list">
    				        <ul>
    				          <li class="item-content">
    				            <div class="item-media">
    				              <img src="<%=request.getContextPath()%>/file/image?FILENAME=`+value.FILEPATH+`" width="100">
    				            </div>
    				            <div class="item-inner">
    				              <div class="item-title-row">
    				                <div class="item-title">${var.GOODSDESC}</div>
    				              </div>
    				              <div class="item-subtitle">总价:`+value.MONEY+`<span style="float:right;">数量:`+value.NUMBER+`</span></div>
    				            </div>
    				          </li>
    				        </ul>
    				      </div>
    				    </div>
    				    <div class="card-footer">
    				      <span>下单时间:`+value.CDT+`</span>
    				      <span>`+value.USEPERSON+` / `+value.PERSONPHONE+`</span>
    				    </div>`;
    				    if($("#search").val() == value.USEKEY && value.STATE == '2'){
    				    	html+=`<div class="card-footer">
	  				      <span></span>
	  				      <span><button onclick="goConfirm('`+value.USEID+`','`+value.USEKEY+`')" class="button button-fill button-success" style="background:#FFCC01;color:#000000;width:100%;">立即核销</button></span>
	  				    </div>`;
    				    }
    				    
    				    if(value.STATE == '3'){
    						html+=`<div class="card-footer">
    	  				      <span>核销时间:`+value.UDT+`</span>
    	  				      <span></span>
    	  				    </div>`;
    					}
    				    
    				    html+=`
    				    	</div>
    					`;
    				})
    				if(flag){
    					$("#orders").html(html);
    				}else{
    					$("#orders").append(html);
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
  		
  		if($("a.active").text()!="核销"){
  			return;
  		}
  		
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
  	
  	function goConfirm(id,key){
  		location.href='<%=request.getContextPath()%>/orders/verification?USEID='+id+'&USEKEY='+key+"&FROM=CODE&SHOP_ID=${shop.SHOP_ID}";
  	}
  </script>
</html>