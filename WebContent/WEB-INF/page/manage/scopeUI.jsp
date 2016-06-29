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
<title>IP访问设置</title>
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
	
	var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		location.href="mScopeMain.do";
	}else{
		alert('操作失败!');
	}

}

</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>IP访问设置</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:history.back();" class="btn btn-default"  >返回</a>
				</div>
				
		<div class="develop">
		<form action="${scope==null?'mScopeInsert.do':'mScopeUpdate.do' }"  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${scope.fId }">
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" width="30%">名称：</td>
		   <td width="70%">
		   <!-- 设置管理员修改权限 -->
		   <input type="text" id="fName" name="fName" value="${scope.fName }" 
		   <c:if test="${sessionScope.user.fUname!='admin' }">readOnly</c:if>
		    want="yes" title="名称">
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >访问开始IP：</td>
		   <td >
		   <input type="text" id="fStartip" name="fStartip" value="${scope.fStartip }"  want="yes" title="访问开始ip">
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >访问结束IP：</td>
		   <td >
		   <input type="text" id="fEndip" name="fEndip" value="${scope.fEndip }"  want="yes" title="访问结束ip">
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >排序号：</td>
		   <td >
		   <input type="text" id="fSort" name="fSort" value="${scope.fSort }" >
		   </td>
		   </tr>
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>