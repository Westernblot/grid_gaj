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
<title>涉密审核</title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
</head>
<script type="text/javascript">
$(function(){
	$("input[type='checkbox']").removeAttr("checked");  
});

//编辑
function doSee(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	
	var url="mAuditSeeUI.do?fId="+fId;
	location.href=url;
}

</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>涉密审核</span>
				</div>
				<div class="title">
					<a href="javascript:doSee()" class="btn btn-bule">审核</a> 

					<form action="mNotAuditMain.do" style="display:none"  id="formQuery" method="post">
					   
                    </form>
				</div>
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="3%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="22%" >标题</th>
							<th width="35%" >来源</th>
							<th width="20%" >发布人</th>
							<th width="20%" >发布时间</th>
							<th width="20%" >审核状态</th>
							<th width="20%" >排序号</th>
							<th width="20%" >组别</th>
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty newsList}">
						 <c:forEach items="${newsList}" var="news">
						  <tr id="${news.fId }">
						  <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						  <td>${news.fSubject }</td>
						  <td>${news.fSource }</td>
						  <td>${news.fAddName }</td>
						  <td>${news.fDate }</td>
						  <td><font color="red">${news.fStatus==''?'未审核':news.fStatus }</font></td>
						  <td>${news.fSort }</td>
						  <td>${news.fGroup }</td>
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