<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>订单 - 申请退款</title>
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
			<div class="list-block" style="margin-top:5px;">
		    <ul>
		    <c:forEach var="var" items="${refundTypeData}">
		    <li class="item-content">
        <div class="item-inner">
          <div class="item-title">${var.REFUNDTYPENAME}</div>
          <div class="item-after"><input type="radio" name="REFUNDDESC" value="${var.REFUNDTYPENAME}"/></div>
        </div>
      </li>
      </c:forEach>
		    </ul>
		    </div>
		    <div class="content-block">
		    <div class="row">
		      <div class="col-100"><button onclick="refund()" class="button button-big button-fill button-success" style="background:#FFCC01;color:#000000;width:100%;">确认退款</button></div>
		    </div>
		  </div>
			</div>	
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
  function refund(){
	  if(!$("input[name='REFUNDDESC']:checked").val()){
		   $.toast("请选择一种退款原因");
		   return;
	   }
	  $.ajax({
			type: "POST",
			url: '<%=request.getContextPath()%>/orders/refund/save',
	    	data:{
	    		"ORDER_ID":"${pd.ORDER_ID}",
	    		"REFUNDDESC":$("input[name='REFUNDDESC']:checked").val()
	    	},
	    	async: false,
			dataType:'json',
			cache: false,
			beforeSend:function(){
				
			},
			success: function(data){
				if(data.result_code=="SUCCESS"){
					$.alert("退款成功",function(){
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