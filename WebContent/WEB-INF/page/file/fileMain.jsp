<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.xxx.com/" prefix="xx"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>...</title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
</head>
<script type="text/javascript">
$(function(){
	//changeTbody(1,10);
});


//新增
function doAdd(){
	var fType='${xx:encode(page.pd.fType,"utf-8")}';//解决IE6 不能UTF-8编码问题
	var url="mTsFileUI.do?fId=0&fType="+fType;
	location.href=url;
}

//编辑
function doEdit(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}

	var fType='${xx:encode(page.pd.fType,"utf-8")}';//解决IE6 不能UTF-8编码问题
	var url="mTsFileUI.do?fId="+fId+"&fType="+fType;
	location.href=url;
}


</script>
<body>
<div id="div_right">

	<div class="right_top">
					<span>文件下载</span>
				</div>
				<div class="title">
				    <!-- 设置管理员新增、删除权限 -->
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					<a href="javascript:doDelete('mFileDelete.do')" class="btn btn-red">删除</a> 
				</div>
				
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="3%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="30%" >标题</th>
							<th width="50%" >文件</th>
							<th width="20%" >类别</th>
						</tr>
						<tbody id="goaler">
						<c:forEach items="${fileList }" var="file">
						<tr id="${file.fId }">
						 <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						 <td>${file.fSubject }</td>
						 <td>
			<c:if test="${file.fAttachment !=null and file.fAttachment !='' }">
			<c:forEach items="${file.fAttachmentUrl.split(',') }" var="url" varStatus="vs">
		       <span>
		       <a href="sDownload?fileName=${file.fAttachment.split(',')[vs.index] }&fileURL=${url}" id="attachment">${file.fAttachment.split(',')[vs.index] }</a>
		       ;
		       </span>
		    </c:forEach>
			</c:if>
						 
						 </td>
						 <td>${file.fType }</td>
						</tr>
						</c:forEach>
						
						</tbody>
					</table>
				</div>
				
				<!-- 底部分页 -->
		  <form action="mTsFileMain.do"   id="formQuery" method="post">
			<input type="hidden" name="fType" value="${page.pd.fType}">		     
          </form>
	     <%@ include file="../system/pageBtm.jsp"%> 
	 
</div>
</body>
</html>