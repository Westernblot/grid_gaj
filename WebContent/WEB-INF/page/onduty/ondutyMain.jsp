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
	var url="mOndutyUI.do?fId=0";
	location.href=url;
}

//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	
	var url="mOndutyUI.do?fId="+fId;
	location.href=url;
}


</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>支队值班表</span>
				</div>
				<div class="title">
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					<a href="javascript:doDelete('mOndutyDelete.do')" class="btn btn-red">删除</a> 
					
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="mOndutyImportUI.do" class="btn btn-bule">数据导入</a> 
					
					
					<form action="mOndutyMain.do" style="display:none"  id="formQuery" method="post">
					   
                    </form>
				</div>
				
		<div class="develop">
					<table width="60%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="40%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="60%" >月份</th>
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty ondutyList}">
						 <c:forEach items="${ondutyList}" var="onduty">
						  <tr id="${onduty.fId }">
						  <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						  <td>${onduty.fMonth }</td>
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