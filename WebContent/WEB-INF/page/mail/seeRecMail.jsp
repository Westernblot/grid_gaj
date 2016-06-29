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


</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span>收件箱</span>
				</div>
				<div class="title">
					<a href="mReplyMail.do?fId=${pData.F_ID}"  class="btn btn-green">回复</a> 
					<a href="mTranMail.do?fId=${pData.F_ID}" class="btn btn-bule">转发</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
					
					<form action="mRecMail.do" style="display:none"  id="formQuery" method="post">
					       
                    </form>
				</div>
				
		<div class="develop">
					<table width="100%" border="0" class="mtable">
					<tr>
					<td><H4>${pData.F_SUBJECT}</H4></td>
					</tr>
					<tr>
					<td>发件人：${pData.F_SEND }</td>
					</tr>
					<tr>
					<td>时间：${pData.F_SEND_TIME }</td>
					</tr>
					<tr>
					<td>收件人：${pData.F_RECEIVED}</td>
					</tr>
					<tr>
					<td>
	               ${pData.F_CONTENT}
					</td>
					</tr>
					<tr>
					<td>
	                        附件：
	        <div id="div_attachment">
		     <c:if test="${pData.F_ATTACHMENT !=null and pData.F_ATTACHMENT !=''}">
		    <c:forEach items="${pData.F_ATTACHMENT.split(',') }" var="name" varStatus="vs">
		       <span>
		       <a href="blobDowload?tableName=personmail_${sessionScope.user.fId}&fId=${pData.F_ATTACHMENT_ID.split(',')[vs.index] }" id="attachment">${name}</a>
		      ;
		       </span>
		    </c:forEach>
		    </c:if>
		    </div>
					</td>
					</tr>
				</table> 
	             
        </div>
</div>
</body>
</html>