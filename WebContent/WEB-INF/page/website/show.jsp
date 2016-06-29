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

<jsp:include page="../include.jsp"></jsp:include>
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/time.js" type="text/javascript"></script>
</head>

<body>
<div id="container">
  
      <!-- 底部-->
      <%@ include file="../website/public/head.jsp"%> 
    
  
  
  <div id="content">
      <div class="navbottom"><em></em>您当前的位置：<a href="home">首页</a> > <a href="list?fGroup=${xx:encode(news.fGroup,'utf-8')}">${news.fGroup}</a> > 正文 </div>
  	 <div class="show">  
                  
              <div class="show_title">${news.fSubject }</div>
                <div class="show_flag">信息提供：${news.fSource } 发布时间：${news.fDate } 阅读次数：${news.fRead }</div>
                <div class="show_pic">
                <c:if test="${news.fImg !=null and news.fImg !='' }"><img src="${news.fImgUrl}" /></c:if>
                </div>
                ${news.fContent }
                <%--
                <p>　　本网讯 3月25日至28日，<a href="index.html">黄石市检察院</a>检务巡回督察组对全市检察机关党的群众路线教育实践活动、"正风肃纪、争做好干警"和查办"人情案"、"关系案"、"金钱案"专项整治活动开展情况，以及规范执法和案件评查等工作情况进行了一次巡回督察。督察组坚持问题导向，以查找各院工作中的薄弱环节为目标，坚持不听汇报，通过现场查看、翻阅文件资料、询问相关工人员，当场反馈的方式，确保督察工作实效。</p><p>

　　坚持问题导向，不走过场。按照黄石市检察院督察组长袁群荣同志在督察工作安排会上的要求，督察组全体成员带着问题开展检查、以挑剔的眼光查找不足。3天半的时间，检查6个基层院，共查看党组会、中心组学习、支部学习等各类记录本20余本，查看党的群众路线教育实践活动和"正风肃纪、争做好干警"活动党员干部学习笔记70余本，抽查自侦案件28件，不诉、不捕案件32件，案件评查21件，民事行政监督案件30件，检查办案区6个，抽查同步录音录像80余份。大到实体缺陷，小到文书制作不规范、错别字等，都是检务督察内容的对象。</p><p>

　　坚持当场反馈，不留情面。为了确保督察发现的问题得到彻底整改，做到"红红脸、出出汗"，增强各院党组工作责任心，提高思想认识。督察结束后，当场召开反馈会，要求被督察院党组成员全体参加，督察组将发现问题一一向党组反馈，有些问题还当场询问分管检察长是否知情、平时工作怎样要求等，不留情面。一些院检察长表示，"要不是市检察院这次督察，我还真不知道我们工作存在这么多问题"。反馈会上各院检察长现场表态，将立行整改。</p><p>

　　坚持限期整改，不讲条件。针对督察中发现的问题，督察组将及时整理向市检察院检察长汇报，并下发检务督察情况通报，在全市检察机关予以通报批评，同时对各院的不同问题分别下发限期整改通知，各院必须在限定的期限内无条件整改到位，并向市检察院巡回督察组报整改报告，不得讲客观原因、讲条件。
</p><p>
　　坚持跟踪监督，不留顽症。督察组根据各院存在的问题和上交的整改报告，进行跟踪监督，防止一些院只做纸面文章，督察过后问题仍然存在，成为顽症。

</p>
                 --%>
                  <div>
      <c:if test="${news.fAttachment!=null and news.fAttachment !=''}">
                      附件下载：
		    <c:forEach items="${news.fAttachmentUrl.split(',') }" var="url" varStatus="vs">
		       <span>
		       <a href="sDownload?fileName=${news.fAttachment.split(',')[vs.index] }&fileURL=${url}" id="attachment">${news.fAttachment.split(',')[vs.index] }</a>
		    
		       </span>
		    </c:forEach>
		    </c:if>
      </div>    
                
    </div>
</div>
  
  <!-- 底部-->
      <%@ include file="../website/public/foot.jsp"%> 
</div>
<div id="bgblock"></div>
 <script type="text/javascript" src="js/scrolltop.js"></script>
</body>

</html>