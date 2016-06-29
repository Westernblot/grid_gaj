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
<title>黄石市公安局治安户政支队</title>
<link href="css/ZAstyle.css" rel="stylesheet" type="text/css" />
<link href="css/ZAny.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/time.js" type="text/javascript"></script>
</head>

<body>
<div id="container">
  
       <!-- 底部-->
      <%@ include file="../website/public/head.jsp"%> 
 
  
  <div id="content">
      <div class="navbottom"><em></em>您当前的位置：<a href="home">首页</a> > 下载中心 </div>
  	 <div class="show">  
                  
              <table class="file02" >
              <tr>
                            <th width="5%" >序号</th>
                            <th width="20%" >标题</th>
							<th width="50%" >内容</th>
							<th width="30%" >说明</th>
							
              </tr>
              <c:forEach items="${fileList }" var="file" varStatus="vs">
              <tr>
                         <td>${vs.index+1}</td>
			            <td>${file.fSubject }</td>
						 <td>
			<c:forEach items="${file.fAttachmentUrl.split(',') }" var="url" varStatus="vs">
		       <span>
		       <a href="sDownload?fileName=${file.fAttachment.split(',')[vs.index]}&fileURL=${url}" id="attachment">${file.fAttachment.split(',')[vs.index] }</a>
		       ;
		       </span>
		    </c:forEach>
						 
						 </td>
						 <td>${file.fRemark}</td>
              </tr>
              </c:forEach>
              </table>
              
    </div>
                <!-- 底部分页 -->
              <form action="downlist"  id="formQuery" method="post"></form>
	          <%@ include file="../system/pageBtm.jsp"%>
</div>
  
      <!-- 底部-->
      <%@ include file="../website/public/foot.jsp"%> 
   
</div>
<div id="bgblock"></div>
 <script type="text/javascript" src="js/scrolltop.js"></script>
</body>

</html>