<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<nav class="bar bar-tab">
  <a class="tab-item external<c:if test="${nav eq 'home'}"> active</c:if>" href="<%=request.getContextPath()%>/home">
    <span class="icon"><img src="<%=request.getContextPath()%>/static/icon/index<c:if test="${nav eq 'home'}">_sel</c:if>.png"/></span>
    <span class="tab-label">首页</span>
  </a>
  <a class="tab-item external<c:if test="${nav eq 'my'}"> active</c:if>" href="<%=request.getContextPath()%>/my">
    <span class="icon"><img src="<%=request.getContextPath()%>/static/icon/my<c:if test="${nav eq 'my'}">_sel</c:if>.png"/></span>
    <span class="tab-label">我的</span>
  </a>
</nav>