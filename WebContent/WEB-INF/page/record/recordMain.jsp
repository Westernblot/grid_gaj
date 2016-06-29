<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>..</title>
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
					<span>消息记录查看</span>
				</div>
				<div class="title">
				<%--
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					<a href="javascript:doDelete('mOndutyDelete.do')" class="btn btn-red">删除</a> 
				 --%>
					
					<form action="mRecordMain.do"   id="formQuery" method="post">
					   
                    </form>
				</div>
				
		<div class="develop">
					<table width="60%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="10%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="20%" >接收人</th>
							<th width="30%" >内容</th>
							<th width="20%" >发送人</th>
							<th width="20%" >时间</th>
							<th width="20%" >类别</th>
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty recordList}">
						 <c:forEach items="${recordList}" var="record">
						  <tr id="${record.fId }">
						  <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						  <td>${record.fSubject }</td>
						  <td>${record.fContent }</td>
						  <td>${record.fAddName }</td>
						  <td>${record.fAddDate }</td>
						  <td>${record.fType }</td>
						  </tr>
						 </c:forEach>
				</c:when>
				<c:otherwise>
				<tr>
				<td colspan="20" align="center"><font color="red">暂无数据</font></td>
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