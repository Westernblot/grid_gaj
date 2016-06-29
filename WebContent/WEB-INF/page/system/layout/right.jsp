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
<title>Insert title here</title>

<jsp:include page="../../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>


<link href="float/floatDiv.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="float/jquery.js"></script>
<script type="text/javascript" src="float/jquery.floatDiv.js"></script>


<script type="text/javascript">
$(function(){
    //打开关闭框
    $(window).load(function() {
    //初始定位
       
      $(".msg").floatdiv({bottom:"5px",right:"5px"});;
   
    //打开关闭
      
 $(".msg").slideToggle(30);
    });
    $(".btn").click(function () {
       
       $(".msg").slideToggle(300);
      
    });
});

</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>首页</span>
				</div>
				
				
		<div class="develop">
		<img src="images/sys/home_text.png" style="position: fixed; top:28%; left:0; z-index: 0;" />
        <img src="images/sys/home_bg.jpg" width="100%" height="100%" style="position: fixed; bottom:0; right:0; z-index: -1;" />
		</div>
		
</div>

<div class="msg">
  <div class="msgTitle"><h4>消息通知</h4><a class="btn" href="javascript:void(0);">x</a></div>
    <div class="msgCon">
           <p>
               您有<font color="red">${mailNum}</font>条未读邮件，请注意查收！
        <c:if test="${mSize > 1}">
        <br><b>您的个人邮箱存储空间已经达到1G，请及时清理。以免影响收发邮件！</b>
        </c:if>
        
          </p>
        
    </div> 
</div>


</body>
</html>