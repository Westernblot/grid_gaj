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
<jsp:include page="../include.jsp"></jsp:include>
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/time.js" type="text/javascript"></script>
</head>

<body>
<div id="container">
  
      
      <!-- 底部-->
      <%@ include file="../website/public/head.jsp"%> 
    
  
  
  
  <div id="content">
      <div class="navbottom"><em></em>您当前的位置：<a href="home">首页</a> > <a href="vedioList">视频资料</a></div>
  	 	<div class="video">  
            <ul>  
            
            <c:forEach items="${vedioList}" var="vedio">
                <li>
                    <a href="vedioShow?fId=${vedio.fId}" class="videoImg"><img src="${vedio.fImgUrl }" /></a>
                    <div class="videoText"><a href="vedioShow?fId=${vedio.fId}">${vedio.fSubject}</a></div>
                </li>
            </c:forEach>
            
            <%--
                <li>
                    <a href="show.html" class="videoImg"><img src="images/1.jpg" /></a>
                    <div class="videoText"><a href="show.html">我市举行处置突发暴恐事件实战演练</a></div>
                </li>
                <li>
                    <a href="show.html" class="videoImg"><img src="images/1.jpg" /></a>
                    <div class="videoText"><a href="show.html">我市举行处置突发暴恐事件实战演练</a></div>
                </li>
                <li>
                    <a href="show.html" class="videoImg"><img src="images/1.jpg" /></a>
                    <div class="videoText"><a href="show.html">我市举行处置突发暴恐事件实战演练</a></div>
                </li>
                <li>
                    <a href="show.html" class="videoImg"><img src="images/3.jpg" /></a><em>2015.01.20</em>
                    <div class="videoText"><a href="show.html">我市举行处置突发暴恐事件实战</a></div>
                </li>
                <li>
                    <a href="show.html" class="videoImg"><img src="images/1.jpg" /></a>
                    <div class="videoText"><a href="show.html">我市举行处置突发暴恐事件实战演练</a></div>
                </li>
                <li>
                    <a href="show.html" class="videoImg"><img src="images/1.jpg" /></a>
                    <div class="videoText"><a href="show.html">我市举行处置突发暴恐事件实战演练</a></div>
                </li>
                <li>
                    <a href="show.html" class="videoImg"><img src="images/3.jpg" /></a>
                    <div class="videoText"><a href="show.html">我市举行处置突发暴恐事件练</a></div>
                </li>
                <li>
                    <a href="show.html" class="videoImg"><img src="images/1.jpg" /></a>
                    <div class="videoText"><a href="show.html">我市举行处置突发暴恐事件实战演件实战演练……</a></div>
                </li>
                <li>
                    <a href="show.html" class="videoImg"><img src="images/1.jpg" /></a>
                    <div class="videoText"><a href="show.html">我市举行处置突发暴恐事件实</a></div>
                </li>
             --%>
            </ul>
            
              <!-- 底部分页 -->
               <form action="vedioList" style="display:none"  id="formQuery" method="post"></form>
	          <%@ include file="../system/pageBtm.jsp"%> 
      	</div>
        
      
   </div>

  
   <!-- 底部-->
      <%@ include file="../website/public/foot.jsp"%> 
</div>
<div id="bgblock"></div>
 <script type="text/javascript" src="js/scrolltop.js"></script>
</body>

</html>