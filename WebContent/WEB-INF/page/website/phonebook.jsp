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
      <div class="navbottom"><em></em>您当前的位置：<a href="home">首页</a> > 全市治安系统通讯录 </div>
  	 <div class="show">  
                  
              <table width="100%" border="1px" class="file02" >
              <tr>
                            <th width="20%" >序号</th>
                            <th width="20%" >姓名</th>
							<th width="20%" >部门</th>
							<th width="20%" >职务</th>
							<th width="20%" >电话</th>
              </tr>
              <c:forEach items="${userList }" var="user" varStatus="vs">
              <tr>
                         <td>${(page.pageNo-1)*20+(vs.index+1)}</td>
                         <td>${user.fCname }</td>
			             <td>${user.fDept }</td>
						 <td>${user.fPosition }</td>
						 <td>${user.fPhone }</td>
              </tr>
              </c:forEach>
              </table>
    </div>
             <!-- 底部分页 -->
             <form action="phonebook" style="display:none"  id="formQuery" method="post"></form>
	          <%@ include file="../system/pageBtm.jsp"%>
</div>
  
  <!-- 底部-->
      <%@ include file="../website/public/foot.jsp"%> 
</div>
<div id="bgblock"></div>
 <script type="text/javascript" src="js/scrolltop.js"></script>
</body>

</html>