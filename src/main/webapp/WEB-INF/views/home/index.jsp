<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>西安美食推荐</title>
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
			<input type="button" onclick="goPay()" value="支付"/>
			</div>
			<%@ include file="../common/nav.jsp"%>
        </div>
    </div>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
  function goPay(){
		tt.miniProgram.navigateTo({
          url: '/pages/pay/pay'
     })
	}
  </script>
</html>