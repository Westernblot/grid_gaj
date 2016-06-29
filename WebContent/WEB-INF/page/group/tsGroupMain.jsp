<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.xxx.com/" prefix="xx"%>
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
	//changeTbody(1,10);
});


//新增
function doAdd(){
	var fType='${xx:encode(fType,"utf-8")}';  //解决IE6下 utf-8 编码问题
	var url="mTsGroupUI.do?fId=0&fType="+fType;
	location.href=url;
}

//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	
	var fType='${xx:encode(fType,"utf-8")}';  //解决IE6下 utf-8 编码问题
	var url="mTsGroupUI.do?fId="+fId+"&fType="+fType;
	location.href=url;
}


</script>
<body>
<div id="div_right">

	<div class="right_top">
					<span>专题栏目</span>
				</div>
				<div class="title">
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					<a href="javascript:doDelete('mTsGroupDelete.do')" class="btn btn-red">删除</a> 
				</div>
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="3%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="40%" >名称</th>
							<th width="20%" >排序</th>
							<th width="40%" >类型</th>
						</tr>
						<tbody id="goaler">
						<c:forEach items="${groups }" var="group">
						<tr id="${group.fId }">
						 <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						 <td>${group.fName }</td>
						 <td>${group.fSort }</td>
						 <td>${group.fType }</td>
						</tr>
						</c:forEach>
						
						</tbody>
					</table>
				</div>
	 
</div>
</body>
</html>