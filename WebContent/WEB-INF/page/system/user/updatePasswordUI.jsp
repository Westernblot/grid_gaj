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
<title>个人密码修改</title>
<jsp:include page="../../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
});


//保存  AND 编辑
function doSave(){

	var checked = checkForm('#formSave');
	if(checked==false){
		return;
	}
	
	var id=$('#id').val();
	var url="";
    if(id==""){
    	url="mUserInsert.do";
    	//验证唯一性
    	var fUname=$('#fUname').val();
    	var flag=PublicAjax('mCheckuser.do?math='+Math.random(),{'fUname':fUname}); 
    	if(flag>0){
    		alert("账户已存在");
    	    return;
    	}
    }else{
    	url="mUserUpdate.do";
    }
    
	//验证两次输入密码是否一样
	var password=$('#fPassword').val();
	var verifyPwd=$('#verifyPwd').val();
	if(password!=verifyPwd){
		alert("两次输入的密码不一致");
		return;
	}
    
	$.ajax({
		url:url,
		data:$('#formSave').serialize(),
		dataType:'json',
		type:'post',
		success:function(data){
			if(data>0){
				alert("操作成功");
			    location.reload();
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
					<span>个人密码修改</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<%--
					<a href="javascript:self.location=document.referrer;" class="btn btn-default"  >返回</a>
					 --%>
				</div>
				
		<div class="develop">
		<form action=""  id="formSave">
		 <input type="hidden" id="fId" name="fId" value="${user.fId}">
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" width=30% >账户：</td>
		   <td width=70% >
		   <input type="text" id="fUname" name="fUname" value="${user.fUname }" want="yes" title="账户"
		   <c:if test="${user !=null}">readOnly</c:if> >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >密码：</td>
		   <td >
		   <input type="password" id="fPassword" name="fPassword" value="" want="yes" title="密码" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >确认密码：</td>
		   <td >
		   <input type="password" id="verifyPwd" name="verifyPwd" value="" want="yes" title="确认密码"  >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>