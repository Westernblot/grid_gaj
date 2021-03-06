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
<title>IP访问设置</title>
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
	
	var url="mScopeUI.do?fId=0";
	location.href=url;
}

//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	
	var url="mScopeUI.do?fId="+fId;
	location.href=url;
}


</script>
<body>
<div id="div_right">

	<div class="right_top">
					<span>IP访问设置</span>
				</div>
				<div class="title">
				    <!-- 设置管理员新增、删除权限 -->
					<a href="javascript:doAdd()"  class="btn btn-green"
					<c:if test="${sessionScope.user.fUname!='admin' }">style="display:none"</c:if>
					>新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					<a href="javascript:doDelete('mScopeDelete.do')" class="btn btn-red"
					<c:if test="${sessionScope.user.fUname!='admin' }">style="display:none"</c:if>
					>删除</a> 
				</div>
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="3%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="20%" >名称</th>
							<th width="30%" >开始ip</th>
							<th width="30%" >结束ip</th>
							<th width="20%" >排序</th>
						</tr>
						<tbody id="goaler">
						<c:forEach items="${scopeList }" var="scope">
						<tr id="${scope.fId }">
						 <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						 <td>${scope.fName }</td>
						 <td>${scope.fStartip }</td>
						 <td>${scope.fEndip }</td>
						 <td>${scope.fSort }</td>
						</tr>
						</c:forEach>
						
						</tbody>
					</table>
				</div>
	 
</div>
</body>
</html>