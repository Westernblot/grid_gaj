<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib uri="http://www.xxx.com/" prefix="xx"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>微美网站后台管理系统</title>
<link href="css/frame.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/menu.js"></script>
</head>
<body style="background:url(images/sys/left_bg.png) repeat-x center top #417EB7;overflow-x:hidden">
	<div id="div_left">
				<div class="left_top">
					<a href="mRight.do" target="mainFrame">功能菜单栏</a>
				</div>
				<div class="menu" >
					<ul>
									
				<c:forEach items="${fMenu}" var="f" varStatus="status">
						
						 <c:if test="${status.index==0}">
						  <li>
							<div class="acc_trigger active" id="sub_${f.fId}">
								<img src="images/sys/star_1.png" /> ${f.fName}
							</div>
							
							<ul class="child_sub_${f.fId}" style="display: block;">		
							   
							<c:forEach items="${sMenu}" var="s">
							   <c:if test="${f.fId==s.fPid }">
							   <li>
							   <%--
							   <a href="${s.fAction }" target="mainFrame">${s.fName}</a>
							    --%>
							    
							     <!-- 为兼容IE6 做数据转码 -->
							   <c:choose>
							   <c:when test="${fn:contains(s.fAction,'=') }">
							    <c:set var="str" value="${s.fName}"></c:set>
							   <a href="${s.fAction.substring(0,fn:indexOf(s.fAction,'='))}=${xx:encode(s.fAction.substring(fn:indexOf(s.fAction,'=')+1,fn:length(s.fAction)),'utf-8')}" target="mainFrame">${s.fName}</a>
							   </c:when>
							   <c:otherwise>
							    <a href="${s.fAction }" target="mainFrame">${s.fName}</a>
							   </c:otherwise>
							   </c:choose>
							   
							   </li>
							    
							   </c:if>
							</c:forEach>
							
							</ul>						
						</li>
						</c:if>
						
						 <c:if test="${status.index!=0}">
						  <li>
							<div class="acc_trigger" id="sub_${f.fId}">
								<img src="images/sys/star_1.png" /> ${f.fName}
							</div>
							
							<ul class="child_sub_${f.fId}">		
							   
							<c:forEach items="${sMenu}" var="s">
							   <c:if test="${f.fId==s.fPid }">
							   <li>
							   <%--
							   <a href="${fn:indexOf(s.fAction,'=')}" target="mainFrame">${s.fName}</a>
							    ${s.fAction.substring(0,fn:indexOf(s.fAction,'='))}=
							    --%>
							    
							  <!-- 为兼容IE6 做数据转码 -->
							   <c:choose>
							   <c:when test="${fn:contains(s.fAction,'=') }">
							    <c:set var="str" value="${s.fName}"></c:set>
							   <a href="${s.fAction.substring(0,fn:indexOf(s.fAction,'='))}=${xx:encode(s.fAction.substring(fn:indexOf(s.fAction,'=')+1,fn:length(s.fAction)),'utf-8')}" target="mainFrame">${s.fName}</a>
							   </c:when>
							   <c:otherwise>
							    <a href="${s.fAction }" target="mainFrame">${s.fName}</a>
							   </c:otherwise>
							   </c:choose>
							  
							   </li>
							   </c:if>
							</c:forEach>
							
							</ul>						
						</li>
						</c:if>

				</c:forEach>
						
					</ul>
				</div>

			</div>
</body>
</html>