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
<title>黄石联创室内环境治理有限公司</title>
<link href="<%=basePath %>css/main.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/stringUtils.js"></script>
<script type="text/javascript" src="<%=basePath %>js/numberUtils.js"></script>
<script type="text/javascript" src="<%=basePath %>js/swfobject.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//doLoad();
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
  
  <div id="content">

	
      <div id="nylist">
          <div class="ny_left"> 
              <div class="index02">
                <div class="r_Top"><h4>行业新闻</h4></div>
                <ul class="list">
                 <c:forEach items="${newsList}" var="TsArticle" > 
                         
                  <li><a href=newsShow?fId=${TsArticle.id }>${TsArticle.title }</a></li>
                 
                </c:forEach>
                </ul>
              </div>
              
              <div class="index02">
                <div class="r_Top"><h4>环保小课堂</h4></div>
                
                <ul class="list">
                <c:forEach items="${greenList}" var="TsArticle" >    
               
                  <li><a href=greenClassRoomShow?fId=${TsArticle.id }>${TsArticle.title }</a></li>
                  
                </c:forEach>
                </ul>
              </div>
              
            </div>
            
          <div class="ny_right"  id="ny_right">
                <ul class="ny_right_top">
                    <li class="none"><a href="homePage">首页</a> </li> 
                    <li><a href="vedio">专题视频</a></li>
                    <li>视频</li>
                </ul>
                <div class="ny_right_con show"> 
                 
            <!-- 
         <video src="${lcVedio.fVedioURL }" controls="controls" autoplay="autoplay" width=800px height=450px></video>
             -->

<!-- 
                           <embed
								src="flvplayer.swf?file=${lcVedio.fVedioURL }&image=${lcVedio.fImgeURL }"
								width="600" height="400" allowfullscreen="true"  >
						   </embed>
 -->
						<object width="600" height="400"
							classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">

							<param name="movie"
								value="flvplayer.swf?file=${lcVedio.fVedioURL }&image=${lcVedio.fImgeURL }" />
							
							<embed
								src="flvplayer.swf?file=${lcVedio.fVedioURL }&image=${lcVedio.fImgeURL }"
								width="600" height="400" allowfullscreen="true"  ></embed>
						</object>
					</div>
  </div>

  
     
</div>


	</body>
</html>
