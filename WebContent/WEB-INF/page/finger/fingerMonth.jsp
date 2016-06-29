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

//查询
function doSearch(){
	var fTime=$('#fTime').val();
	if(fTime==''){
		alert("月份不能为空");
		return;
	}
	
	$('#formQuery').attr('action','mTsFingerMonth.do');
	$('#formQuery').submit();
}


//数据导出
function doExcel(){
	
	var fTime=$('#fTime').val();
	if(fTime==''){
		alert("月份不能为空");
		return;
	}
	
	$('#formQuery').attr('action','fingerExcel.do');
	$('#formQuery').submit();
}

</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>每月考勤表</span>
				</div>
				<div class="title">
				<%--
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					<a href="javascript:doDelete('mOndutyDelete.do')" class="btn btn-red">删除</a> 
				 --%>
					
					<form action="mTsFingerMonth.do"   id="formQuery" method="post">
					   月份：<input type="text" id="fTime" name="fTime" value="${(page.pd.fTime==null or page.pd.fTime=='')?nowMonth:(page.pd.fTime)}" class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM'})">
					   <a href="javascript:doSearch()"  class="btn btn-green">查询</a> 
					   <a href="javascript:doExcel()"  class="btn btn-green">数据导出</a> 
                    </form>
				</div>
				
		<div class="develop">
					<table width="60%" border="0" class="mtable">
						<tr>
						<%--
							<th class="thcheckbox" width="10%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
						 --%>
							<th width="20%" >工号</th>
							<th width="30%" >姓名</th>
							<th width="20%" >打卡时间</th>
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty pdList}">
						 <c:forEach items="${pdList}" var="pData">
						  <tr id="${pData.F_ID }">
						  <%--
						  <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						   --%>
						  <td>${pData.F_CODE }</td>
						  <td>${pData.F_CNAME }</td>
						  <td>${pData.F_TIME }</td>
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