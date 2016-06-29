<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>涉密审核</title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
<script type="text/javascript">


//编辑
function doEdit(fId){
	location.href="mAuditUpdateUI.do?fId="+fId;
}

//涉密审核
function doAudit(fId,fStatus){
	var data=PublicAjax('mAuditUpdate.do',{'fId':fId,'fStatus':fStatus});
	if(data>0){
		alert('操作成功!');
		location.href="mNotAuditMain.do";
	}
}


</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>涉密审核</span>
				</div>
				<div class="title">
				<c:if test="${news.fStatus=='未审核' }">
					<a href="javascript:doEdit(${news.fId})"  class="btn btn-bule">修改</a> 
					<a href="javascript:doAudit(${news.fId},'审核通过')"  class="btn btn-green">审核通过</a> 
					<a href="javascript:doAudit(${news.fId},'审核未通过')"  class="btn btn-red">审核不通过</a> 
				</c:if>
					<a href="javascript:history.back()" class="btn btn-default" >返回</a>
				</div>
				
		<div class="develop">
		<form action="${news==null?'mNewsInsert.do':'mNewsUpdate.do'}"  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${news.fId}">
	
		   <table width="100%" border="0" class="mRead" >
		   <tr>
		   <td align="right" width="15%">主标题：</td>
		   <td colspan="3" >
		   ${news.fSubject }
		   </td>
		   </tr>
		   <tr>
		   <td align="right" width="15%">副标题：</td>
		   <td colspan="3" >
		  ${news.fSubhead }
		   </td>
		   </tr>
		   <tr>
		   <td align="right" width="15%">排序号：</td>
		   <td width="35%">
		   ${news.fSort }
		   </td>
		   <td align="right" width="15%">发布日期：</td>
		   <td width="35%">
		  ${news.fDate }
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >来源：</td>
		   <td >
		  ${news.fSource}
		   </td>
		   <td align="right" >查看范围：</td>
		   <td >
           ${news.fScope}
		   </td>
		   </tr>
		   <c:if test="${news.fGroup=='轮播图新闻' or news.fGroup=='最近新闻' or news.fGroup=='通知公告' or news.fGroup=='重要文件'}">
		   <tr>
		   <td align="right" width="15%">选项：</td>
		   <td colspan="3" >
		  <c:if test="${news.fAttention=='是'}">今日关注</c:if>
		  <c:if test="${news.fImportant=='是'}">要闻排行</c:if>
		  <c:if test="${news.fRecommend=='是'}">编辑推荐</c:if> 
		   </td>
		   </tr>
		   </c:if>
		   <tr>
		   <td align="right" width="15%">摘要：</td>
		   <td colspan="3" >
		   ${news.fSummary}
		   </td>
		   </tr>
		   <tr>
		   <td align="right">内容：</td>
		   <td colspan="3">
		   ${news.fContent}
		   <br>
		  
		   </td>
		   </tr>
		   <c:if test="${news.fGroup=='轮播图新闻'}">
		   <tr>
		   <td align="right">
		        轮播图片：
		   </td>
		   <td colspan="3">
		  
		    <div id="div_img">
		     <!-- 如果有轮播就显示 -->
		     <c:if test="${news.fImg!=null and news.fImg !=''}">
		     <span>
		       <a href="sDownload?fileName=${news.fImg}&fileURL=${news.fImgUrl}" id="img">${news.fImg}</a>
		       <input type="hidden" id="fImg" name="fImg" value="${news.fImg}" want="yes" title="轮播图" />
		       <input type="hidden" id="fImgUrl" name="fImgUrl" value="${news.fImgUrl}" />
		      
		     </span>
		     </c:if>
		    </div>
		   </td>
		   </tr>
		    </c:if>
		   <c:if test="${news.fGroup!='轮播图新闻'}">
		   <tr>
		   <td align="right">附件：</td>
		   <td colspan="3">
		   
		    <div id="div_attachment">
		    <c:if test="${news.fAttachment!=null and news.fAttachment !=''}">
		    <c:forEach items="${news.fAttachmentUrl.split(',') }" var="url" varStatus="vs">
		       <span>
		       <a href="sDownload?fileName=${news.fAttachment.split(',')[vs.index] }&fileURL=${url}" id="attachment">${news.fAttachment.split(',')[vs.index] }</a>
		       <input type="hidden" id="fAttachment" name="fAttachment" value="${news.fAttachment.split(',')[vs.index] }" />
		       <input type="hidden" id="fAttachmentUrl" name="fAttachmentUrl" value="${url}" />
		    
		       </span>
		    </c:forEach>
		    </c:if>
		    </div>
		   </td>
		   </tr>
		   </c:if>
		   <tr>
		   <td align="right">发布人：</td>
		   <td>${news.fAddName }</td>
		   <td align="right">发布部门：</td>
		   <td>${news.fAddDept}</td>
		   </tr>
		   </table>
		   <!-- 截取部分文章摘要 -->
		   <input type="hidden" id="fPart" name="fPart" value="" />
		</form>
		</div>
		
</div>
</body>
</html>