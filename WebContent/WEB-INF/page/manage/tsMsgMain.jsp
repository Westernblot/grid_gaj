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
<title>涉密提醒消息</title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
</head>
<script type="text/javascript">
$(function(){
	//changeTbody(1,10);
});


//新增
function doAdd(){
	var url="mTsMsgUI.do?fId=0";
	location.href=url;
}

//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	var url="mTsMsgUI.do?fId="+fId;
	location.href=url;
}


</script>
<body>
<div id="div_right">

	<div class="right_top">
					<span>涉密提醒消息</span>
				</div>
				<div class="title">
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					<a href="javascript:doDelete('mTsMsgDelete.do')" class="btn btn-red">删除</a> 
				</div>
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="3%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="20%" >排序</th>
							<th width="80%" >内容</th>
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty msgList}">
						<c:forEach items="${msgList }" var="msg">
						<tr id="${msg.fId }">
						 <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						 <td>${msg.fSort }</td>
						 <td>${msg.fContent }</td>
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
	 
</div>
</body>
</html>