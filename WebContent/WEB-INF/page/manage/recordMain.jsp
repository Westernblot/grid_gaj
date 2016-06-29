<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统记录</title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
</head>
<script type="text/javascript">
$(function(){
	
});


</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>系统记录</span>
				</div>
				<div class="title">
					
					<form action="mRecordMain.do" style="display:none"  id="formQuery" method="post">
					     
                    </form>
				</div>
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
						<tr>
							
							<th width="10%" >用户</th>
							<th width="10%" >登陆IP</th>
							<th width="15%" >记录时间</th>
							<th width="60%" >操作内容</th>
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty recordList}">
						 <c:forEach items="${recordList}" var="record">
						  <tr id="${record.fId }">
						
						  <td>${record.fName }</td>
						  <td>${record.fIp }</td>
						  <td>${record.fDate }</td>
						  <td>${record.fContent }</td>
						  </tr>
						 </c:forEach>
				</c:when>
				<c:otherwise>
				<tr>
				<td colspan="10" align="center"><font color="red">暂无数据</font></td>
				</tr>
				</c:otherwise>
				</c:choose>
						</tbody>
					</table>
				</div>
				
		<!-- 底部分页 -->
	     <%@ include file="../system/pageBtm.jsp"%> 
	
</div>
</body>
</html>