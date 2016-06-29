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

<script type="text/javascript">



	
</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>重点工作安排</span>
				</div>
				<div class="title">
                   <%--
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
                    --%>
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
				</div>
				
		<div class="develop">
		<form action=""  id="form1" >
		   
		   <table width="100%" border="0" class="mRead" >
		   <caption>
		      <h2>   
		   ${task.fDept } 重点工作安排</h2>
		   </caption>
		   <tr>
		   <td ></td>
		   
		   <td>开始时间：
		   ${task.fSdate }
		   </td>
		   <td>完成时间：
		    ${task.fEdate }
		   </td>
		   <td>上级知晓：${task.fLeadKnow=='是'?'是':'否' }</td>
		   </tr>
		   
		   <tr>
		  
		   <td width="10%"><b>重点工作内容:</b></td>
		   <td colspan="4">
		  ${task.fContent }
		   </td>
		   
		   </tr>
		   
		    <tr>
		   <td >附件：</td>
		   <td colspan="3">
		  
		    <div id="div_attachment">
		    <c:if test="${task.fAttachment!=null and task.fAttachment !=''}">
		    <c:forEach items="${task.fAttachmentUrl.split(',') }" var="url" varStatus="vs">
		       <span>
		       <a href="sDownload?fileName=${task.fAttachment.split(',')[vs.index] }&fileURL=${url}" id="attachment">${task.fAttachment.split(',')[vs.index] }</a>
		      ;
		       </span>
		    </c:forEach>
		    </c:if>
		    </div>
		   </td>
		   </tr>
		   
		   <tr>
		  
		   <td width="10%"><b>工作情况：</b></td>
		   <td colspan="4">
		 ${task.fWork }
		   </td>
		   
		   </tr>
		   
		    
		      
		      <tr>
		      <td>责任单位：</td>
		      <td colspan="4">
		     ${task.fDutyDept }
		     </td>
		      </tr>
		      
		      <tr>
		      <td>配合单位：</td>
		      <td colspan="4">
		    ${task.fFitDept }
		     </td>
		      </tr>
		 
		      <tr>
		      <td>责任人：</td>
		      <td colspan="4">
		     ${task.fDutyPerson }
		     </td>
		      </tr>
		 
		      
		   </table>
		</form>
		</div>
				
		
</div>
</body>
</html>