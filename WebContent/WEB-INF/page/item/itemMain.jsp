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

//新增
function doAdd(){
	var url="mItemUI.do?fId=0";
	location.href=url;
}

//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	
	var url="mItemUI.do?fId="+fId;
	location.href=url;
}

</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>治安系统考核内容</span>
				</div>
				<div class="title">
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					<a href="javascript:doDelete('mItemDelete.do')" class="btn btn-red">删除</a> 
					
				</div>
				
		<div class="develop">
					<table width="60%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="50px" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="30%" >序号</th>
							<th width="40%" >项目</th>
							<th width="30%" >年份</th>
							
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty itemList}">
						 <c:forEach items="${itemList}" var="item">
						  <tr id="${item.fId }">
						  <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						  <td>${item.fCode }</td>
						  <td>${item.fItem }</td>
						  <td>${item.fYear }</td>
						  
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
		<form action="mItemMain.do"  id="formQuery" method="post">
					   
         </form>
	     <%@ include file="../system/pageBtm.jsp"%> 
	
</div>
</body>
</html>