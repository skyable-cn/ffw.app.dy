<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>核销订单</title>
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
		<div class="list-block" style="margin-top:0px;">
    <ul>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">订单编号</div>
            <div class="item-input">
              <input id="SHOPNAME" name="SHOPNAME" type="text" placeholder="" value="${order.ORDERSN}" disabled="disabled">
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">核销码</div>
            <div class="item-input">
              <input id="USEKEY" name="USEKEY" type="text" placeholder="" value="${order.USEKEY}" disabled="disabled">
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">商品名称</div>
            <div class="item-input">
              <input id="SHOPNAME" name="SHOPNAME" type="text" placeholder="" value="${order.GOODSNAME}" disabled="disabled">
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">商品单价</div>
            <div class="item-input">
              <input id="SHOPNAME" name="SHOPNAME" type="text" placeholder="" value="${order.SELLMONEY}" disabled="disabled">
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">商品数量</div>
            <div class="item-input">
              <input id="SHOPNAME" name="SHOPNAME" type="text" placeholder="" value="${order.NUMBER}" disabled="disabled">
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">总价</div>
            <div class="item-input">
              <input id="SHOPNAME" name="SHOPNAME" type="text" placeholder="" value="${order.MONEY}" disabled="disabled">
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">姓名</div>
            <div class="item-input">
              <input id="SHOPNAME" name="SHOPNAME" type="text" placeholder="" value="${order.USEPERSON}" disabled="disabled">
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">电话</div>
            <div class="item-input">
              <input id="SHOPNAME" name="SHOPNAME" type="text" placeholder="" value="${order.PERSONPHONE}" disabled="disabled">
            </div>
          </div>
        </div>
      </li>
       <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">下单时间</div>
            <div class="item-input">
              <input id="SHOPNAME" name="SHOPNAME" type="text" placeholder="" value="${order.CDT}" disabled="disabled">
            </div>
          </div>
        </div>
      </li>
      <c:if test="${order.STATE eq 3}">
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">核销时间</div>
            <div class="item-input">
              <input id="SHOPNAME" name="SHOPNAME" type="text" placeholder="" value="${order.UDT}" disabled="disabled">
            </div>
          </div>
        </div>
      </li>
      </c:if>
      </ul>
      </div>
      <c:if test="${order.STATE eq 2}">
  <div class="content-block">
    <div class="row">
      	<div class="col-100"><a href="javascript:;" onclick="save()" class="button button-big button-fill button-success" style="background:#FFCC01;color:#000000;">确认核销</a></div>
    </div>
  </div>
  </c:if>
        	</div>
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
  if(!"${order}"){
	  $.toast("参数错误/商户不匹配");
  }
  
  if("${order.STATE}" == "3"){
	  $.toast("该订单已核销");
  }
  function save(){
	  if("${useTimeFlag}"=="false"){
		  $.alert("核销规则","该订单已过期,现已无法核销"); 
		  return;
	  }
	  $.ajax({
			type: "POST",
			url: '<%=request.getContextPath()%>/orders/verification/save',
	    	data:{
	    		"ORDER_ID":"${order.ORDER_ID}"
	    	},
	    	async: false,
			dataType:'json',
			cache: false,
			beforeSend:function(){
				
			},
			success: function(data){
				if(data.flag){
					$.alert("确认订单核销成功",function(){
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