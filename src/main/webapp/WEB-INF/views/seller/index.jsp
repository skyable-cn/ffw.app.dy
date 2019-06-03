<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>商家入驻</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
    <script type="text/javascript" src="https://res.wx.qq.com/open/js/jweixin-1.3.2.js"></script>
  </head>
  <body>
    <div class="page-group">
        <div class="page page-current"  id="route1">
			<div class="content">
			<input id="LATITUDE" name="LATITUDE" type="hidden" value="${pd.LATITUDE}"/>
			<input id="LONGITUDE" name="LONGITUDE" type="hidden" value="${pd.LONGITUDE}"/>
			<input id="SHOPADDRESS" name="SHOPADDRESS" type="hidden" value="${pd.ADDRESS}"/>
				<div class="list-block" style="margin-top:0px;">
    <ul>
      <!-- Text inputs -->
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">商家名称</div>
            <div class="item-input">
              <input id="SHOPNAME" name="SHOPNAME" type="text" placeholder="您的店名称" value="${pd.SHOPNAME}">
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-gender"></i></div>
          <div class="item-inner">
            <div class="item-title label">所属行业</div>
            <div class="item-input">
              <select name="SHOPTYPE_ID" id="SHOPTYPE_ID">
              	<c:forEach var="var" items="${typeData}">
                	<option value="${var.SHOPTYPE_ID}"  <c:if test="${var.SHOPTYPE_ID eq pd.SHOPTYPE_ID}">selected="selected"</c:if>>${var.SHOPTYPENAME}</option>
                </c:forEach>
              </select>
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">商家位置</div>
            <div class="item-input position">
			<a class="external" onclick="position()" href="javascript:;"><img align="middle" alt="" src="<%=request.getContextPath()%>/static/icon/position.png"/>${pd.ADDRESS}</a>
            </div>
          </div>
        </div>
      </li>
      </ul>
      </div>
   <div class="list-block">
    <ul>
     <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">联系人</div>
            <div class="item-input">
              <input id="CONTRACTPERSON" name="CONTRACTPERSON" type="text" placeholder="联系人" value="${pd.CONTRACTPEOPLE}">
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">联系电话</div>
            <div class="item-input">
              <input id="CONTRACTPHONE" name="CONTRACTPHONE" type="text" placeholder="联系电话" value="${pd.CONTRACTPHONE}">
            </div>
          </div>
        </div>
      </li> 
      <li class="align-top">
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-comment"></i></div>
          <div class="item-inner">
            <div class="item-title label">商家详细介绍</div>
            <div class="item-input">
              <textarea id="SHOPDESC" name="SHOPDESC" placeholder="商家详细介绍 . . .">${pd.SHOPDESC}</textarea>
            </div>
          </div>
        </div>
      </li>
    </ul>
  </div>
  <div class="content-block">
    <div class="row">
      	<div class="col-100"><a href="javascript:;" onclick="save()" class="button button-big button-fill button-success" style="background:#FFCC01;color:#000000;">入驻</a></div>
    </div>
  </div>
        	</div>
    	</div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script>
   function position(){
	   //var data = "SHOPNAME="+$("#SHOPNAME").val()+"&CONTRACTPEOPLE="+$("#CONTRACTPEOPLE").val()+"&CONTRACTPHONE="+$("#CONTRACTPHONE").val()+"&SHOPDESC="+$("#SHOPDESC").val();
	   //location.href='https://apis.map.qq.com/tools/locpicker?search=1&type=0&backurl=http://192.168.0.4:8081/app/sellerInit?'+encodeURIComponent(data)+'&key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp';
	   
	   wx.miniProgram.navigateTo({
            url: '/pages/address/address?SHOPNAME='+encodeURI($("#SHOPNAME").val())+'&SHOPTYPE_ID='+$("#SHOPTYPE_ID").val()
       })
   }
   
   function save(){
	   
	   if($("#SHOPNAME").val()==''){
		   $.toast("商户名称不许为空");
		   return;
	   }
	   
	   if($("#SHOPTYPE_ID").val()==''){
		   $.toast("请选择商户行业");
		   return;
	   }
	   
	   if($("#SHOPADDRESS").val()==''){
		   $.toast("请标记商户位置");
		   return;
	   }
	   
	   if($("#CONTRACTPERSON").val()==''){
		   $.toast("联系人不许为空");
		   return;
	   }
	   
	   if($("#CONTRACTPHONE").val()==''){
		   $.toast("联系电话不许为空");
		   return;
	   }
	   
	   if($("#SHOPDESC").val()==''){
		   $.toast("请简单描述商铺信息");
		   return;
	   }
	   
	   $.ajax({
			type: "POST",
			url: '<%=request.getContextPath()%>/seller/save',
	    	data:{
	    		"LATITUDE":$("#LATITUDE").val(),
	    		"LONGITUDE":$("#LONGITUDE").val(),
	    		"SHOPADDRESS":$("#SHOPADDRESS").val(),
	    		"SHOPNAME":$("#SHOPNAME").val(),
	    		"SHOPTYPE_ID":$("#SHOPTYPE_ID").val(),
	    		"CONTRACTPERSON":$("#CONTRACTPERSON").val(),
	    		"CONTRACTPHONE":$("#CONTRACTPHONE").val(),
	    		"SHOPDESC":$("#SHOPDESC").val()
	    	},
	    	async: false,
			dataType:'json',
			cache: false,
			beforeSend:function(){
				
			},
			success: function(data){
				if(data.flag ){
					$.alert(data.message,function(){
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