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
    
  
  
                   <form action="list" style="display:none"  id="formQuery" method="post">
					       <!-- 文章分类 -->
                           <input type="hidden" name="fGroup" value="${page.pd.fGroup}" >
                    </form>
  
  <div id="content">
      <div class="navbottom"><em></em>您当前的位置：<a href="home">首页</a> > <a href="list?fGroup=${xx:encode(fGroup,'utf-8')}">部门工作动态</a> > ${fGroup} </div>
  	<div class="nyside">
        <div class="Rside">
          <div class="Rside_title"><h4>部门工作动态</h4></div>
          <ul class="Rside_con"> 
            <li><a href="list?fGroup=${xx:encode('办公室动态','utf-8') }">办公室动态</a></li>
            <li><a href="list?fGroup=${xx:encode('治安管理动态','utf-8') }">治安管理动态</a></li>
            <li><a href="list?fGroup=${xx:encode('社区警务管理动态','utf-8') }">社区警务管理动态</a></li>
            <li><a href="list?fGroup=${xx:encode('治安行动动态','utf-8') }">治安行动动态</a></li>
          </ul>
        </div>
          <div class="nyside_02">
              <div class="title"><h4>信息排行</h4></div>
              <ul class="column"> 
              
              <c:forEach items="${topNewsList}" var="news">
                <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}</a></li>
              </c:forEach>
              <%--
              
                <li><a href="show.html">土地经济容力 数字国土工程</a></li>
                <li><a href="show.html">采石场"占用荒山"，是否还需编制…</a></li>
                <li><a href="show.html">整合矿山扩深探矿成果是否交纳采矿…</a></li>
                <li><a href="show.html">补交出让金如何确定评估时点</a></li>
                <li><a href="show.html">土地拍卖的面积是按投影面积还是实…</a></li>
                <li><a href="show.html">土地拍卖的面积是按投影面积还是实…</a></li>
                <li><a href="show.html">整合矿山扩深探矿成果是否交纳采矿…</a></li>
                <li><a href="show.html">补交出让金如何确定评估时点</a></li>
                <li><a href="show.html">土地拍卖的面积是按投影面积还是实…</a></li>
                <li><a href="show.html">土地拍卖的面积是按投影面积还是实…</a></li>
               --%>
              </ul>
          </div>
    </div>
    
    <div class="nymain">
        <div class="nymain_title"><h4>${fGroup }</h4></div>
        <div class="nymain_con">
           <div class="list sjlist">
                <ul>             
                
                <c:forEach items="${newsList}" var="news">
                <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<20?(news.fSubject):(news.fSubject.substring(0,20))}</a><span>[${news.fDate.substring(5,10)}]</span></li>
                </c:forEach>
  
                <%--
                		<li><a href="show.html">关于2009年再生资源回收体系建设项目资金的实施方案</a> <span>[2011-06-24]</span></li>
                        <li><a href="show.html">北京市二手车交易市场升级改造示范工程实施办法</a> <span>[2011-07-20]</span></li>
                         <li><a href="show.html">关于印发加强北京工业品牌建设措施的通知</a> <span>[2011-06-24]</span></li>
                        <li><a href="show.html">北京市商务局关于印发《关于推进本市农业生产资料连锁经营发展的指导意见》的通知</a> <span>[2011-07-20]</span></li>
                        <li><a href="show.html">关于落实商务部开展早餐示范工程建设试点的实施方案</a> <span>[2011-07-28]</span></li>
                        <li><a href="show.html"> 北京市推进标准化菜市场示范工程实施方案</a> <span>[2011-07-08]</span></li>  
                        <li><a href="show.html">关于印发《北京市商业流通发展专项资金管理暂行办法》的通知</a> <span>[2011-07-20]</span></li>
                        <li><a href="show.html">关于印发《北京市商贸流通企业担保资金管理暂行办法》的通知</a> <span>[2011-07-28]</span></li>
                        <li><a href="show.html"> 北京市2009年度"万村千乡市场工程"资金使用操作办法</a> <span>[2011-07-08]</span></li>            
                        <li><a href="show.html">关于2009年再生资源回收体系建设项目资金的实施方案</a> <span>[2011-06-24]</span></li>
                        <li><a href="show.html">北京市二手车交易市场升级改造示范工程实施办法</a> <span>[2011-07-20]</span></li>
                         <li><a href="show.html">关于印发加强北京工业品牌建设措施的通知</a> <span>[2011-06-24]</span></li>
                        <li><a href="show.html">北京市商务局关于印发《关于推进本市农业生产资料连锁经营发展的指导意见》的通知</a> <span>[2011-07-20]</span></li>
                        <li><a href="show.html">关于落实商务部开展早餐示范工程建设试点的实施方案</a> <span>[2011-07-28]</span></li>
                        <li><a href="show.html"> 北京市推进标准化菜市场示范工程实施方案</a> <span>[2011-07-08]</span></li>         
                        <li><a href="show.html"> 北京市推进标准化菜市场示范工程实施方案</a> <span>[2011-07-08]</span></li>         
                        
                        <li><a href="show.html">北京市二手车交易市场升级改造示范工程实施办法</a> <span>[2011-07-20]</span></li>
                         <li><a href="show.html">关于印发加强北京工业品牌建设措施的通知</a> <span>[2011-06-24]</span></li>
                        <li><a href="show.html">北京市商务局关于印发《关于推进本市农业生产资料连锁经营发展的指导意见》的通知</a> <span>[2011-07-20]</span></li>
                        <li><a href="show.html">关于落实商务部开展早餐示范工程建设试点的实施方案</a> <span>[2011-07-28]</span></li>
                        <li><a href="show.html"> 北京市推进标准化菜市场示范工程实施方案</a> <span>[2011-07-08]</span></li>         
                        <li><a href="show.html"> 北京市推进标准化菜市场示范工程实施方案</a> <span>[2011-07-08]</span></li>   
                 --%>                                  
       			 </ul> 
        	</div>
            <!-- 底部分页 -->
	     <%@ include file="../system/pageBtm.jsp"%> 
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