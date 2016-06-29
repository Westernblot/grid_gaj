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
     <div class="navbottom"><em></em>您当前的位置：<a href="home">首页</a> > <a href="search">全文搜索</a></div>
  	 <div class="nymain_search">
    	<div class="contentbox_search">
    	<form action="search"  id="formQuery" method="post">
            <input type="text" id="fSubject" name="fSubject" style="width:400px; height:28px;" value="${page.pd.fSubject}" />
            <input name="btnSearch" type="submit" value="搜索" class="button" />
    	</form>
        </div>
        <%--
    <div class="contentbox_b">搜索 null  每页显示7条记录    共搜索到100个结果   耗时0.0070秒</div>
         --%>
    <ul class="contentbox_c">
    
    <c:choose>
    <c:when test="${not empty newsList }">
    <c:forEach items="${newsList}" var="news">
    
        <li>
           <div class="medium"><a href="show?fId=${news.fId}&fRed=${news.fRed}">${news.fSubject}</a><em>-首页</em></div>
            <div class="c-abstract">
            ${news.fSummary }
            <%--
            欢迎<em>黄石市国土资源局</em>信息网!综合信息 图片新闻 本地新闻 黄石市建立"三多三少"节地管理模式 黄石人均耕地0.68亩,仅占全省人均水平的52%,人口资源环境承载力567...
             --%>
            </div>
            <div class="g"><%=basePath%>&nbsp;${news.fDate}&nbsp;</div>
        </li>
        
    </c:forEach>
    
    </c:when>
    <c:otherwise>
        <li>
           <div class="medium"><font color="red">暂无数据</font></div>
        </li>
    </c:otherwise>
    </c:choose>
    
    <%--
        <li>
           <div class="medium"><a href="show.html">关于召开矿产资源储量报告评审会的公告</a><em>-通知公告</em></div>
            <div class="c-abstract">关于召开矿产资源储量报告评审会的公告　　&nbsp;　　根据《矿产资源储量评审认定办法》（国土资发[1999]205号）有关规定，我中心决定召开矿产资源储量报告评审会议，现将有关事项公告如下：　　</div>
            <div class="g">http://www.hsgtj.gov.cn/wzlm/zwdt/tzgg/32138.htm&nbsp;2014-08-07&nbsp;</div>
        </li>
        <li>
           <div class="medium"><a href="show.html">黄石市公安局治安户政支队</a><em>-首页</em></div>
            <div class="c-abstract">欢迎<em>黄石市国土资源局</em>信息网!综合信息 图片新闻 本地新闻 黄石市建立"三多三少"节地管理模式 黄石人均耕地0.68亩,仅占全省人均水平的52%,人口资源环境承载力567...</div>
            <div class="g">http://www.hsgtj.gov.cn/&nbsp;2014-07-31&nbsp;</div>
        </li>
        <li>
           <div class="medium"><a href="show.html">关于召开矿产资源储量报告评审会的公告</a><em>-通知公告</em></div>
            <div class="c-abstract">关于召开矿产资源储量报告评审会的公告　　&nbsp;　　根据《矿产资源储量评审认定办法》（国土资发[1999]205号）有关规定，我中心决定召开矿产资源储量报告评审会议，现将有关事项公告如下：　　</div>
            <div class="g">http://www.hsgtj.gov.cn/wzlm/zwdt/tzgg/32138.htm&nbsp;2014-08-07&nbsp;</div>
        </li>
        <li>
           <div class="medium"><a href="show.html">黄石市公安局治安户政支队</a><em>-首页</em></div>
            <div class="c-abstract">欢迎<em>黄石市国土资源局</em>信息网!综合信息 图片新闻 本地新闻 黄石市建立"三多三少"节地管理模式 黄石人均耕地0.68亩,仅占全省人均水平的52%,人口资源环境承载力567...</div>
            <div class="g">http://www.hsgtj.gov.cn/&nbsp;2014-07-31&nbsp;</div>
        </li>
        <li>
           <div class="medium"><a href="show.html">关于召开矿产资源储量报告评审会的公告</a><em>-通知公告</em></div>
            <div class="c-abstract">...</div>
            <div class="g">http://www.hsgtj.gov.cn/wzlm/zwdt/tzgg/32138.htm&nbsp;2014-08-07&nbsp;</div>
        </li>
        <li>
           <div class="medium"><a href="show.html">关于召开矿产资源储量报告评审会的公告</a><em>-通知公告</em></div>
            <div class="c-abstract">关于召开矿产资源储量报告评审会的公告　　&nbsp;　　根据《矿产资源储量评审认定办法》（国土资发[1999]205号）有关规定，我中心决定召开矿产资源储量报告评审会议，现将有关事项公告如下：　　</div>
            <div class="g">http://www.hsgtj.gov.cn/wzlm/zwdt/tzgg/32138.htm&nbsp;2014-08-07&nbsp;</div>
        </li>
     --%>
    </ul>          

                <!-- 底部分页 -->
              
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