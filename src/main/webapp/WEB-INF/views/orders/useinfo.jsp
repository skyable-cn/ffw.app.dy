<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>订单 - 确认信息</title>
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
			<div class="row" style="padding:50px;">
				<div class="col-33">&nbsp;</div>
				<div class="col-33" style="text-align:center;"><img align="middle" width="60" style="border-radius:50%;" src="<%=request.getContextPath()%>/static/image/payok.png"/><br/><br/>支付成功</div>
				<div class="col-33">&nbsp;</div>
			</div>
			<div style="margin-top:5px;margin-bottom:5px;margin-left:30px;">完善以下信息,确保订单正常使用</div>
			<div class="list-block" style="margin-top:5px;">
		    <ul>
		      <!-- Text inputs -->
		      <li>
		        <div class="item-content">
		          <div class="item-media"><i class="icon icon-form-name"></i></div>
		          <div class="item-inner">
		            <div class="item-title label">姓名</div>
		            <div class="item-input">
		              <input id="USEPERSON" name="USEPERSON" type="text" placeholder="您的姓名">
		            </div>
		          </div>
		        </div>
		      </li>
		      <li>
		        <div class="item-content">
		          <div class="item-media"><i class="icon icon-form-email"></i></div>
		          <div class="item-inner">
		            <div class="item-title label">手机</div>
		            <div class="item-input">
		              <input id="PERSONPHONE" name="PERSONPHONE" type="text" placeholder="联系方式">
		            </div>
		          </div>
		        </div>
		      </li>
		    </ul>
		  </div>
		  <div class="content-block">
		    <div class="row">
		      <div class="col-100"><button onclick="saveInfo()" type="button" class="button button-big button-fill button-success" style="background:#FFCC01;color:#000000;width:100%;">提交</button></div>
		    </div>
		  </div>
			</div>	
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
  function saveInfo(){
	  if($("#USEPERSON").val()==''){
		   $.toast("姓名不许为空");
		   return;
	   }
	  if($("#PERSONPHONE").val()==''){
		   $.toast("手机不许为空");
		   return;
	   }
	  $.ajax({
			type: "POST",
			url: '<%=request.getContextPath()%>/orders/useinfo/save',
	    	data:{
	    		"ORDER_ID":"${pd.ORDER_ID}",
	    		"USEPERSON":$("#USEPERSON").val(),
	    		"PERSONPHONE":$("#PERSONPHONE").val()
	    	},
	    	async: false,
			dataType:'json',
			cache: false,
			beforeSend:function(){
				
			},
			success: function(data){
				if(data.flag){
					$.alert("确认订单信息成功",function(){
						location.href='<%=request.getContextPath()%>/my'
					})
					
				}
			},
			error:function(){
				
			}
		});
	   
  } 
  </script>
</html>