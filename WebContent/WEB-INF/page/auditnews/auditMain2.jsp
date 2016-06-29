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


//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	
	var fGroup='${page.pd.fGroup}';
	var url="mNewsUI.do?fId="+fId+"&fGroup="+fGroup;
	location.href=url;
}

//审核操作
function doAudit(fStatus){
	var fId = getId('delete'); 
	//alert(fId);
	if(fId==false){
		return;
	}
	
	var data=PublicAjax('mBatchAuditUpdate.do',{'fIds':fId,'fStatus':fStatus});
	if(data>0){
		alert('操作成功!');
		location.href="mAuditMain2.do";
	}
}

</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>领导审核</span>
				</div>
				<div class="title">
				<%--
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
				 --%>
					<a href="javascript:doAudit('审核通过')" class="btn btn-green">批量审核通过</a> 
					<a href="javascript:doAudit('审核未通过')" class="btn btn-red">批量审核不通过</a> 
					
					<form action="mAuditMain2.do" style="display:none"  id="formQuery" method="post">
					       
                          
                    </form>
				</div>
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="3%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="50%" >标题</th>
							<th width="10%" >发布人</th>
							<th width="10%" >发布时间</th>
							<th width="10%" >审核状态</th>
							<th width="10%" >排序号</th>
							<th width="10%" >组别</th>
							<th width="10%" >操作</th>
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty newsList}">
						 <c:forEach items="${newsList}" var="news">
						  <tr id="${news.fId }">
						  <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						  <td>${news.fSubject }</td>
						  <td>${news.fAddName }</td>
						  <td>${news.fDate }</td>
						  <td><font color="red">${news.fStatus==''?'未审核':news.fStatus }</font></td>
						  <td>${news.fSort }</td>
						  <td>${news.fGroup }</td>
						  <td><a href="auditUI2.do?fId=${news.fId}">审核</a></td>
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