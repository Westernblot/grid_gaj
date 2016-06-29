<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单管理</title>
<jsp:include page="../../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
});


//保存  AND 编辑
function doSave(){

	var fId=$('#fId').val();
	var url="";
    if(fId==""){
    	url="mMenuInsert.do";
    }else{
    	url="mMenuUpdate.do";
    }
    
	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}
	
	$.ajax({
		url:url,
		data:$('#form1').serialize(),
		dataType:'json',
		type:'post',
		success:function(data){
			if(data>0){
				  alert("操作成功");
				  window.opener.location.reload();
			      window.close();
			}else{
				alert("操作失败");
			}
		},
		error:function(){
			alert("系统错误");
		}
	});
}


</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>菜单管理</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:window.close();" class="btn btn-default"  >关闭</a>
				</div>
				
		<div class="develop">
		<form action=""  id="form1">
		 <input type="hidden" id="fId" name="fId" value="${menu.fId}">
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" >所属菜单：</td>
		   <td >
		   <select id="fPid" name="fPid">
		     <option value="0"  <c:if test="${menu.fPid==0 }">selected</c:if> >根菜单</option>
		    <c:forEach items="${fMenuList}" var="fm">
		     <option value="${fm.fId}"  
		        <c:if test="${menu.fPid==fm.fId }">selected</c:if>
		      >${fm.fName}</option>
		    </c:forEach>
		   </select>
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >名称：</td>
		   <td >
		   <input type="text" id="fName" name="fName" value="${menu.fName }" want="yes" title="名称" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >方法：</td>
		   <td >
		   <input type="text" id="fAction" name="fAction" value="${menu.fAction }"  >
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >排序：</td>
		   <td >
		   <input type="text" id="fSort" name="fSort" value="${menu.fSort }"  >
		   </td>
		   </tr>
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>