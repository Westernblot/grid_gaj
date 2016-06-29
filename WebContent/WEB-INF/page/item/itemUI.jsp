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
		location.href="mItemMain.do";
	}
	
}

//==========================动态表格添加/删除==================================
function addLine(obj){
	var tr=$(obj).parent().parent();
	var trHtml='<tr>'+$(tr).html()+'</tr>';
	$(tr).after(trHtml);
}

function delLine(obj){
	var tr = $(obj).parent().parent();
	$(tr).remove();
}
//===============================================================================

</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>考核条目</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
				</div>
				
		<div class="develop">
		<form action="${item==null?'mItemInsert.do':'mItemUpdate.do'}"  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${item.fId}">
		   
		   <table width="100%" border="0" class="mtable" >
		   <caption>
		  <input type="text"  id="fYear" name="fYear" value="${item==null?nowYear:item.fYear}"
		   class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy'})" >
		  年全市治安系统重点工作考核
		   </caption>
		   <tr>
		   <td><b>序号</b></td>
		   <td><b>项目<font color="red">*</font></b></td>
		   </tr>
		   <tr>
		   <td><input type="text" id="fCode" name="fCode" value="${item.fCode }" want="yes" dataType ="int" title="序号" ></td>
		   <td><input type="text" size="100" id="fItem" name="fItem" value="${item.fItem }"></td>
		   </tr>
		   <%--
		   <c:forEach items="${item==null?' ':item.fItem.split(',') }" var="fItem"  varStatus="vs">
		     <tr>
		      <td><input type="text" size="100px" name="fItem" value="${item.fItem.split(',')[vs.index]}" want="yes" title="项目"></td>
		      <td>
		      <a href="javascript:#" onclick="addLine(this)">添加一行</a>
		      <a href="javascript:#" onclick="delLine(this)">删除一行</a>
		      </td>
		      </tr>
		   </c:forEach>
		    --%>
		      
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>