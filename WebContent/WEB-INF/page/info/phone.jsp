<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
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
<script type="text/javascript" src="<%=basePath%>publicjs/ajaxfileupload.js"></script>

<script type="text/javascript">


//保存  AND 编辑
function doSave(){
	
	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}
	
	var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		location.reload();
	}
	
}

</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>${fName}</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<%--
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
					 --%>
				</div>
				
		<div class="develop">
		<form action="${info==null?'mInfoInsert.do':'mInfoUpdate.do'}"  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${info.fId}">
		   <input type="hidden" id="fName" name="fName" value="${fName}">
		   
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" width=20%>内容:</td>
		   <td width=80%>
		   <input type="text" size="80" id="fContent" name="fContent" value="${info.fContent}"  want="yes" title="内容">
		   </td>
		   </tr>
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>