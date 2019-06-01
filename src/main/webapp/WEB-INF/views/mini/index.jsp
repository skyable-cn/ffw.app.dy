<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>重定向小程序</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
    <script type="text/javascript" src="https://s3.pstatp.com/toutiao/tmajssdk/jssdk-1.0.0.js"></script>
  </head>
  <body>
  </body>
  <%@ include file="../common/headjs.jsp"%>
  <script type="text/javascript">
  
  $.showPreloader('重定向小程序 . . . ');
  
   function goMini(){
	   tt.miniProgram.navigateTo({
            url: '/pages/index/index'
       })
   }
   
   goMini();
   </script>
</html>