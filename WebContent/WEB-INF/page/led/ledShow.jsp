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
<title>Insert title here</title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
});


//保存  AND 编辑
function doSave(){

	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}
	
	var fType='${fType}';
	var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		location.href="mTsGroupMain.do?fType="+fType;
	}

}


function doLed(flag){
	
	var msg=$('#fLed'+flag).val();
	$.post("mWriteLed.do", { "flag":flag,"msg":msg} );
	alert("执行完成");
}

function doCmd(){
	var flag=$('#fFlag').val();
	var fMsg=$('#fMsg').val();
	
	 $.post("mWriteLed.do", { "flag":flag,"msg":fMsg} );
	 alert("执行完成");
}


</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>LED屏幕设置</span>
				</div>
				<div class="title">
					
				</div>
				
		<div class="develop">
		<form  id="form1">
		  
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" width=20% >第一屏幕设置：</td>
		   <td width=70%>
		   <input type="text" size="100" id="fLed1" name="fLed1" value="" >
		   </td>
		   <td width=10%>
		   <input type="button" value="发布" onclick="doLed(1)">
		   </td>
		   </tr>
		   
		   <tr>
		   <td align="right" >第四屏幕设置：</td>
		   <td >
		   <input type="text" size="100" id="fLed4" name="fLed4" >
		   </td>
		   <td>
		   <input type="button" value="发布" onclick="doLed(4)">
		   </td>
		   </tr>
		   
		   <%--
		   <tr>
		   <td align="right" >通用设置：</td>
		   <td >
		   标识号：<input type="text" size="100" id="fFlag" name="fFlag" >
		   <br>
		   消    息：<input type="text" size="100" id="fMsg" name="fMsg" >
		   <br>
		   <font color="red">通用设置，请勿随意操作。以免造成LED屏幕显示错误！</font>
		   </td>
		   <td>
		   <input type="button" value="执行" onclick="doCmd()">
		   </td>
		   </tr>
		    --%>
		   
		   
		   
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>