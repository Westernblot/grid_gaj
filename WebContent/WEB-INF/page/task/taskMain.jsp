<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
	
});

//新增
function doAdd(){
	var url="mTaskUI.do?fId=0";
	location.href=url;
}

//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	
	var url="mTaskUI.do?fId="+fId;
	location.href=url;
}

//查询
function doSearch(){
	$('#formQuery').submit();
}

//导出Excel
function doExcel(){
	$('#formQuery').attr('action','taskExcel.do');
	$('#formQuery').submit();
	$('#formQuery').attr('action','mTaskMain.do');
	
}

</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>重点工作安排</span>
				</div>
				<div class="title">
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					 
					<a href="javascript:doDelete('mTaskDelete.do')" class="btn btn-red">删除</a> 
					
					<div style="float: right;">
						<form action="mTaskMain.do"  id="formQuery" method="post">
		                单位： 
		      <select name="fDept" id="fDept">
		      <option value="">-查询所有-</option>
		   <c:forEach items="${deptList}" var="dept">
		   <option value="${dept.fName }" <c:if test="${page.pd.fDept==dept.fName }">selected</c:if> >${dept.fName }</option>
		   </c:forEach>
		   </select>
		   
		   时间：
<input type="text" id="fDate1" name="fDate1" value="${page.pd.fDate1 }" class="Wdate"  onclick="WdatePicker()" >
至
<input type="text" id="fDate2" name="fDate2" value="${page.pd.fDate2 }" class="Wdate"  onclick="WdatePicker()" >
		 
		                <a href="javascript:doSearch()" class="btn btn-bule">查询</a> 
		                <a href="javascript:doExcel()" class="btn btn-bule">数据导出</a> 
                         </form>
					</div>
					
				</div>
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="50px" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="10%" >单位</th>
							<th width="70%" >重点工作内容</th>
							<%--
							<th width="15%" >附件</th>
							 --%>
							<th width="5%" >开始时间</th>
							<th width="5%" >完成时间</th>
							<%--
							<th width="5%" >进度情况</th>
							<th width="5%" >责任单位</th>
							<th width="200px" >配合单位</th>
							 --%>
							<th width="10%" >责任人</th>
							<th width="5%" >操作</th>
							<%--
							<th width="5%" >上级知晓</th>						
							 --%>
							
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty taskList}">
						 <c:forEach items="${taskList}" var="task">
						  <tr id="${task.fId }">
						  <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						  <td>${task.fDept }</td>
						  <td>
						  ${fn:length(task.fContent)<36?(task.fContent):(task.fContent.substring(0,36))}
						  </td>
						  <%--
						  <td>${task.fAttachment }</td>
						   --%>
						  <td>${task.fSdate }</td>
						  <td>${task.fEdate }</td>
						  <%--
						  <td>${task.fWork }</td>
						  <td>${task.fDutyDept }</td>
						  <td >${task.fFitDept }</td>
						   --%>
						  <td>${task.fDutyPerson }</td>
						  <td><a href="mTaskShow.do?fId=${task.fId}" >查看</a></td>
						  <%-- 
						  <td>${task.fWork }</td>
						  --%>
						
						  </tr>
						 </c:forEach>
				</c:when>
				<c:otherwise>
				<tr>
				<td colspan="20" align="center"><font color="red">暂无数据</font></td>
				</tr>
				</c:otherwise>
				</c:choose>
						</tbody>
					</table>
				</div>
				
		<!-- 底部分页 -->
	
	     <%@ include file="../system/pageBtm.jsp"%> 
	
</div>
</body>
</html>