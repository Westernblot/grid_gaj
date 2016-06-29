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
	
	var fYear=$('#fYear').val();
	if(fYear==''){
		alert('请选择考核年份');
		return ;
	}
	
	var url="mExamUI.do?fId=0&fYear="+fYear;
	location.href=url;
}

//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	
	var url="mExamUpdateUI.do?fId="+fId;
	location.href=url;
}

//查询
function doSearch(){
	$('#formQuery').submit();
}

//导出Excel
function doExcel(){
	$('#formQuery').attr('action','examExcel.do');
	$('#formQuery').submit();
	$('#formQuery').attr('action','mExamMain.do');
	
}

</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>考核打分</span>
				</div>
				<div class="title">
				年份：<input type="text"  id="fYear" name="fYear" value="" class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy'})" >
				
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					 
					<a href="javascript:doDelete('mExamDelete.do')" class="btn btn-red">删除</a> 
					
					<div style="float: right;">
						<form action="mExamMain.do"  id="formQuery" method="post">
		                单位： 
		      <select name="fName" id="fName">
		      <option value="">-查询所有-</option>
		   <c:forEach items="${deptList}" var="dept">
		   <option value="${dept.fName }" <c:if test="${page.pd.fName==dept.fName }">selected</c:if> >${dept.fName }</option>
		   </c:forEach>
		   </select>
		   
		   考核时间：<input type="text" id="fMonth" name="fMonth" value="${page.pd.fMonth }" class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM'})" >
		               至<input type="text" id="fEndMonth" name="fEndMonth" value="${page.pd.fEndMonth }" class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM'})" >
		  
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
							<th width="5%" >考核年份</th>
							<th width="5%" >考核开始月份</th>
							<th width="5%" >考核结束月份</th>
							<th width="15%" >单位</th>
							<th width="60%" >项目</th>
							<th width="5%" >加分</th>
							<th width="5%" >减分</th>
							<%--
							<th width="20%" >说明</th>
							 --%>
							<th width="20%" >添加时间</th>
							
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty pdList}">
						 <c:forEach items="${pdList}" var="pData">
						  <tr id="${pData.F_ID }">
						  <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						  <td>${pData.F_YEAR }</td>
						  <td>${pData.F_MONTH }</td>
						  <td>${pData.F_END_MONTH }</td>
						  <td>${pData.F_NAME }</td>
						  <td>${pData.F_ITEM }</td>
						  <td>${pData.F_ADD }</td>
						  <td>${pData.F_SUB }</td>
						  <%--
						  <td>${pData.F_REMARK }</td>
						   --%>
						  <td>${pData.F_DATE }</td>
					
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