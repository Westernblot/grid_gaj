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
<title></title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
</head>
<script type="text/javascript">
$(function(){
	
});

//转发
function tranMail(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}

	var url="mTranMail.do?fId="+fId;
	location.href=url;
}

//删除
function reservedDelete(){
	var fIds = getId('delete'); 
	if(fIds==false){
		return;
	}
	
	var data=PublicAjax('mReservedDelete.do',{'fIds':fIds});
	if(data>0){
		alert('操作成功!');
		location.reload();
	}
}


//彻底删除
function completeDelete(){
	var fIds = getId('delete'); 
	if(fIds==false){
		return;
	}
	
	var data=PublicAjax('mCompleteDelete.do',{'fIds':fIds});
	if(data>0){
		alert('操作成功!');
		location.reload();
	}
}

</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>已发送</span>
				</div>
				<div class="title">
					<a href="javascript:reservedDelete()" class="btn btn-red">删除</a> 
					<a href="javascript:completeDelete()" class="btn btn-red">彻底删除</a> 
					<a href="javascript:tranMail()" class="btn btn-bule">转发</a> 
					
					<form action="mRecMail.do" style="display:none"  id="formQuery" method="post">
					       
                    </form>
				</div>
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="3%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="5%" >状态</th>
							<th width="10%" >发件人</th>
							<th width="70%" >主题</th>
							<th width="10%" >时间</th>
							<th width="10%" >操作</th>
						</tr>
						<tbody id="goaler">
				<c:choose>
				<c:when test="${not empty pdList}">
						 <c:forEach items="${pdList}" var="pd">
						  <tr id="${pd.F_ID }">
						  <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						  <td>已阅</td>
						  <td><a href=mSeeRecMail.do?fId=${pd.F_ID}>${pd.F_SEND }</a></td>
						  <td>${pd.F_SUBJECT }</td>
						  <td>${pd.F_SEND_TIME }</td>
						  <td><a href=mSeeRecMail.do?fId=${pd.F_ID}>查看</a></td>
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