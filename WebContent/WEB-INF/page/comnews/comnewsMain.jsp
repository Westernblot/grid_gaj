<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib uri="http://www.xxx.com/" prefix="xx"%>
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
	var fGroup='${xx:encode(page.pd.fGroup,"utf-8")}';//解决IE6 不能UTF-8编码问题
	var url="mComNewsUI.do?fId=0&fGroup="+fGroup;
	location.href=url;
}

//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	
	var fGroup='${xx:encode(page.pd.fGroup,"utf-8")}';//解决IE6 不能UTF-8编码问题
	var url="mComNewsUI.do?fId="+fId+"&fGroup="+fGroup;
	location.href=url;
}

</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>${page.pd.fGroup}</span>
				</div>
				<div class="title">
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					<a href="javascript:doDelete('mNewsDelete.do')" class="btn btn-red">删除</a> 
					
					<form action="mNewsMain.do" style="display:none"  id="formQuery" method="post">
					       <!-- 文章分类 -->
                           <input type="hidden" name="fGroup" value="${page.pd.fGroup}" >
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
							<th width="5%" >是否置顶</th>
							<th width="10%" >组别</th>
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
						  <td><font color="red">${news.fTop }</font></td>
						  <td>${news.fGroup }</td>
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