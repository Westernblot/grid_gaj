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
<title>系统菜单设置</title>
<jsp:include page="../../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
</head>
<script type="text/javascript">
$(function(){
	
});

//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	var url="mMenuUI.do?fId="+fId;
	window.showModalDialog(url);
}

//新增菜单
function doAdd(){
	var url="mMenuUI.do";
	window.showModalDialog(url);
}

//删除
function menuDelete(url){
		trId = getId('delete');
		if(trId==false){
			return;
		}
    //执行删除操作
	if(confirm("确定删除吗？")){
		$.ajax({
		url:url,
		data:{'fIds':trId},
		dataType:'json',
		type:'post',
		success:function(data){
			if(data>0){
				alert('删除成功！');
				location.reload();
			}else{
				alert('删除失败！');
			}
		},
		error:function(){
			alert('系统错误！');
		}
	    });
    }
}

</script>
<body>
<div id="div_right">
<form action="" style="display:none"  id="formQuery">
   <input type="text" name="status" value="2" >
</form>
	<div class="right_top">
					<span>系统菜单设置</span>
				</div>
				<div class="title">
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a>  
					<a href="javascript:doEdit()"  class="btn btn-bule">修改</a>  
					<a href="javascript:menuDelete('mMenuDelete.do')"  class="btn btn-red">删除</a>  
				</div>
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="3%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="32%" >名称</th>
							<th width="30%" >方法</th>
							<th width="20%" >排序</th>
							<th width="15%" >类型</th>
						</tr>
						<tbody id="goaler">
						
				<c:forEach items="${fMenu}" var="f" varStatus="status">
						<tr id="${f.fId }">
						 <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						  <td>${f.fName }</td>
					      <td>${f.fAction }</td>
					      <td>${f.fSort }</td>
					      <td>${f.fType }</td>
						</tr>
						   <c:forEach items="${sMenu}" var="s">
							   <c:if test="${f.fId==s.fPid }">
							   <tr id="${s.fId }">
						          <td class="thcheckbox"></td>
						          <td><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" >${s.fName }</td>
					              <td>${s.fAction }</td>
					              <td>${s.fSort }</td>
					              <td>${s.fType }</td>
						       </tr>
							   </c:if>
							</c:forEach>
				</c:forEach>
						</tbody>
					</table>
				</div>
						
</div>
</body>
</html>