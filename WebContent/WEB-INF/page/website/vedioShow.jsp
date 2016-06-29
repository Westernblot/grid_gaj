<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>黄石市公安局治安户政支队</title>
<link href="css/ZAstyle.css" rel="stylesheet" type="text/css" />
<link href="css/ZAny.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/time.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	doLoad();
});



function doLoad(){
	
var s1 = new SWFObject("flvplayer.swf","single","600","400","7");

s1.addParam("allowfullscreen","true");
s1.addVariable("file","video.flv");
s1.addVariable("image","preview1.jpg");
s1.addVariable("width","600");
s1.addVariable("height","400");

s1.write("player1");
}

</script>
</head>

<body>
<div id="container">
 
      
      <!-- 底部-->
      <%@ include file="../website/public/head.jsp"%> 
 
  
  <div id="content">
      <div class="navbottom"><em></em>您当前的位置：<a href="home">首页</a> > <a href="vedioList">视频资料</a></div>
  	 	<div class="video" align="center">  
  	 	
  	 	<%--
            <div class="show_title">${vedio.fSubject }</div>
  	 	 --%>
            
            <object width="600" height="400"
							classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">

							<param name="movie"
								value="flvplayer.swf?file=${vedio.fVedioUrl }&image=${vedio.fImgUrl }" />
							
							<embed
								src="flvplayer.swf?file=${vedio.fVedioUrl }&image=${vedio.fImgUrl }"
								width="600" height="400" allowfullscreen="true"  ></embed>
			</object>
            
            
      	</div>
        
      
   </div>

  
   <!-- 底部-->
      <%@ include file="../website/public/foot.jsp"%> 
</div>
<div id="bgblock"></div>
 <script type="text/javascript" src="js/scrolltop.js"></script>
</body>

</html>
