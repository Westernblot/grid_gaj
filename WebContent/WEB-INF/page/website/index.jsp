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
<link href="css/ZAindex.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/index.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/time.js" type="text/javascript"></script>
<script type="text/javascript">

function doSearch(){
	$('#formQuery').submit();
}

</script>
</head>

<body>
<div id="container">
      
      <!-- 头 -->
      <%@ include file="../website/public/head.jsp"%> 
    
  
  <div id="content">
  	<div class="navbottom">
		<div class="left">
			<script type="text/javascript">
				$(function(){ 
				var date = getCurrentDateTime(); 
				var calendar = showCal(); 
				$("#currentDate").text("今天是" + date + "　农历" + calendar); 
				});
			</script>
			<div id="currentDate"></div>
		</div>
      
		<div class="right">
				  <form action="search"  id="formQuery" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
                    <td>站内搜索：</td>
					<td>
					<input type="text" id="fSubject" name="fSubject" class="searchText"/>
						<%--
                    <select id="searchTitle" name="searchTitle" class="searchSelect">
						<option value="1">不指定条件</option>
						<option value="2">标题</option>
						<option value="3">正文</option>
					</select>
						 --%>
                    </td>
                    <td><input name="search" type="button" class="searchBut" onclick="doSearch()" /></td>
                    <td><a href="toLogin"><img src="images/login.jpg" align="absmiddle"/></a></td>
				</tr>
			</table>
					</form>
		</div>
     </div>
  	<div class="cleft">
  		<div class="contentA">
  		<div class="news_left">
                    <div id="YNews">
                    <c:forEach items="${loopNewsList}" var="news">
 <dl><dt><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank" title="${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}"><img src="${news.fImgUrl }" /></a><span></span></dt><dd>${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}</dd></dl>
                    </c:forEach>
                      <p id="YNIndex"><a href="#1" class="current">1</a><a href="#1">2</a><a href="#1">3</a><a href="#1">4</a><a href="#1">5</a></p>
                    </div>
                    
					<script language="javascript" type="text/javascript" src="js/yao.js"></script>
                    <script language="javascript" type="text/javascript">
                    <!--
                    YAO.YTabs({
                            tabs: YAO.getEl('YNIndex').getElementsByTagName('a'),
                            contents: YAO.getEl('YNews').getElementsByTagName('dl'),
                            auto: true,
                            fadeUp: true
                    });
                    //-->
                    </script>
                </div>
            <div class="news_right">
               <div class="title"><h4>治安要闻</h4><a href="list?fGroup=${xx:encode('治安要闻','utf-8')}" class="more" target="_blank">更多>></a></div>
              <ul>
              <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='治安要闻' and num <9 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<20?(news.fSubject):(news.fSubject.substring(0,20))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
      		    
              </ul>
            </div>
       </div>
  		<div class="contentB">
           <div class="Bleft">
              <div class="index_r04">
                  <div class="title02"><h4>中心工作</h4><a href="list?fGroup=${xx:encode('中心工作','utf-8') }" class="more" target="_blank">更多>></a></div>
                  <ul>
         
                <c:forEach items="${groupList}" var="group" varStatus="vs">
      		       <c:if test="${group.fType=='中心工作' }">	
            <li><a href="list?fGroup=${xx:encode(group.fName,'utf-8') }" target="_blank"><em><img src="${group.fImgUrl}"/></em>
              ${fn:length(group.fName)<10?(group.fName):(group.fName.substring(0,10))}
                  </a></li>
      		       </c:if>
      		    </c:forEach>

                  </ul>
              </div> 
              <div class="index_r04">
                  <div class="title02"><h4>专项工作</h4><a href="list?fGroup=${xx:encode('专项工作','utf-8') }" class="more" target="_blank">更多>></a></div>
                  <ul>
                   <c:forEach items="${groupList}" var="group" varStatus="vs">
      		       <c:if test="${group.fType=='专项工作' }">	
            <li><a href="list?fGroup=${xx:encode(group.fName,'utf-8') }" target="_blank"><em><img src="${group.fImgUrl}"/></em>
              ${fn:length(group.fName)<10?(group.fName):(group.fName.substring(0,10))}
                  </a></li>
      		       </c:if>
      		    </c:forEach>

                  </ul>
              </div> 
              
              <div class="index_r04" style="margin-bottom:0;">
                  <div class="title02"><h4>友情链接</h4></div>
                  <div class="link">
                  <div class="link_c">
              <font color="red"> 全国公安网站导航</font><br>
                  <select onchange="if(this.value!='')window.open(this.value,'_blank')">
                  <option value="">-请选择-　　　　　　　</option>
                  <c:forEach items="${linkList}" var="link">
                  <c:if test="${link.fType=='全国公安网站导航' }">
                   <option value="${link.fUrl }">${link.fName}</option>
                  </c:if>
                  </c:forEach>
                  </select>
                 
              <br><font color="red"> 全省公安网站导航</font><br>
                  <select onchange="if(this.value!='')window.open(this.value,'_blank')">
                  <option value="">-请选择-　　　　　　　</option>
                  <c:forEach items="${linkList}" var="link">
                  <c:if test="${link.fType=='全省公安网站导航' }">
                   <option value="${link.fUrl }">${link.fName}</option>
                  </c:if>
                  </c:forEach>
                  </select>
                
                  
              <br><font color="red"> 全市公安网站导航</font><br>
                  <select onchange="if(this.value!='')window.open(this.value,'_blank')">
                  <option value="">-请选择-　　　　　　　</option>
                  <c:forEach items="${linkList}" var="link">
                  <c:if test="${link.fType=='全市公安网站导航' }">
                   <option value="${link.fUrl }">${link.fName}</option>
                  </c:if>
                  </c:forEach>
                  </select>
                  </div>
                  
                </div>
              </div> 
               
           </div>
            <div class="Bright">
               <%--
               <div class="content_03"><img src="images/hf-01.jpg" width="582" height="86" /></div>
                --%>            
               <div class="content_03"><img src="${centerPics}" width="582" height="86" /></div>
               <div class="content_02">
                 <div class="c02">
                  <div class="c02_title"><h3>通知</h3><a href="list?fGroup=${xx:encode('通知','utf-8') }" class="more" target="_blank">更多>></a></div>
                  <ul class="column">
               <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='通知' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="show?fId=${news.fId}&fRed=${xx:encode(news.fRed,'utf-8')}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                   </ul>
                  </div>
                 <div class="c02" style="float:right;">
                  <div class="c02_title"><h3>通报</h3><a href="list?fGroup=${xx:encode('通报','utf-8') }" class="more" target="_blank">更多>></a></div>
                  <ul class="column">
                  
                  <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='通报' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="show?fId=${news.fId}&fRed=${xx:encode(news.fRed,'utf-8')}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                   </ul>
                  </div>
               </div>
               
               <div class="content_03">
    <script type="text/javascript"> 
     
    var swf_width=582
    var swf_height=86
    //-- 参数设置 -- 自动播放时间(秒)|文字颜色|文字背景色|文字背景透明度|按键数字颜色|当前按键颜色|普通按键色彩 --
    var config='6|0x00000f|0xfffff0|80|0xffffff|0x0099ff|0x000000'
     
    //var files='images/hf-01.jpg|images/101.jpg|images/top.jpg'
    var files='${footPics}';
     
    //var links='show.html|show.html';
    var links='javascript:#';
    var texts='|';
    document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
    document.write('<param name="movie" value="images/bac.swf"><param name="quality" value="high">');
    document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
    document.write('<param name="FlashVars" value="config='+config+'&bcastr_flie='+files+'&bcastr_link='+links+'&bcastr_title='+texts+'">');
    document.write('<embed src="images/bac.swf" wmode="opaque" FlashVars="config='+config+'&bcastr_flie='+files+'&bcastr_link='+links+'&bcastr_title='+texts+'& menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 
    </script>
               </div>
               <div class="content_02">
                 <div class="c02">
                  <div class="c02_title"><h3>办公室动态</h3><a href="list?fGroup=${xx:encode('办公室动态','utf-8') }" class="more" target="_blank">更多>></a></div>
                  <ul class="column">
               <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='办公室动态' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                   </ul>
                  </div>
                 <div class="c02" style="float:right;">
                  <div class="c02_title"><h3>治安管理动态</h3><a href="list?fGroup=${xx:encode('治安管理动态','utf-8') }" class="more" target="_blank">更多>></a></div>
                  <ul class="column">
                   <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='治安管理动态' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                   </ul>
                  </div>
               </div>
        
               <div class="content_02">
                 <div class="c02">
                  <div class="c02_title"><h3>社区警务管理动态</h3><a href="list?fGroup=${xx:encode('社区警务管理动态','utf-8') }" class="more" target="_blank">更多>></a></div>
                  <ul class="column">
                   <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='社区警务管理动态' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                   </ul>
                  </div>
                 <div class="c02" style="float:right;">
                  <div class="c02_title"><h3>治安行动动态</h3><a href="list?fGroup=${xx:encode('治安行动动态','utf-8') }" class="more" target="_blank">更多>></a></div>
                  <ul class="column">
                   <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='治安行动动态' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                   </ul>
                  </div>
               </div>
        
               <div class="content_02" style="margin-bottom:0;">
                 <div class="c02">           
                    <ul class="conTopA">
                        <li class="active" id="jc01"><a href="list?fGroup=${xx:encode('治安简报','utf-8') }" target="_blank">治安简报</a></li>
                        <li class="normal" id="jc02"><a href="list?fGroup=${xx:encode('调查视窗','utf-8') }" target="_blank">调查视窗</a></li>
                        <li class="normal" id="jc03"><a href="list?fGroup=${xx:encode('队伍管理','utf-8') }" target="_blank">队伍管理</a></li>
                    </ul>
                    <div class="conA">
                       <div id="j01">                         
                        <ul class="column">
                         <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='治安简报' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                       </ul>   
                      </div>
                        
                      <div id="j02" class="hidden">
                        <ul class="column">
                         <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='调查视窗' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                       </ul>
                      </div>
                       <div id="j03" class="hidden">                         
                        <ul class="column">
                         <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='队伍管理' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                       </ul>   
                      </div>
                    </div>
                    
                  </div>
                  
                  
                 <div class="c02" style="float:right;">           
                    <ul class="conTopA">
                        <li class="active" id="gl01"><a href="list?fGroup=${xx:encode('治安动态研判','utf-8') }" target="_blank">治安研判</a></li>
                        <li class="normal" id="gl02"><a href="examShow" target="_blank">治安考核</a></li>
                        <li class="normal" id="gl03"><a href="list?fGroup=${xx:encode('学习园地','utf-8') }" target="_blank">学习园地</a></li>
                    </ul>
                    <div class="conA">
                       <div id="g01">                         
                        <ul class="column">
                         <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='治安动态研判' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                       </ul>   
                      </div>
                        
                      <div id="g02" class="hidden">
                        <ul class="column">
                         <c:set var="num" value="0"></c:set>
                <c:forEach items="${deptList}" var="dept" varStatus="vs">
      		       <c:if test="${num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="examShow?fName=${xx:encode(dept.fName,'utf-8')}" target="_blank">${dept.fName }</a></li>
      		       </c:if>
      		    </c:forEach>
                       </ul>
                      </div>
                      
                      <div id="g03" class="hidden">
                        <ul class="column">
                <c:set var="num" value="0"></c:set>
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='学习园地' and num <7 }">	
                       <c:set var="num" value="${num+1}"></c:set>
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<16?(news.fSubject):(news.fSubject.substring(0,16))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
                       </ul>
                      </div>
                      
                    </div>
                    
                  </div>
                  
                 
               </div>
            
            </div>
        </div>
  	</div>
  	<div class="cright">
    	<div class="index_r01">
              <div class="title01"><h4>今日值班</h4></div>
              <div class="index_r01C">
             	 <span>
					<script type="text/javascript">
                        $(function(){ 
                        var date = getCurrentDateTime(); 
                        $("#currentDateTime").text("今天是" + date); 
                        });
                    </script>
                    <div id="currentDateTime"></div>
                 </span>
                    <p>
                    带班领班：<B>${fLeader }</B><br />
                    值班民警：<B>${fPolice }</B><br />
                    </p>
                    <em>${fDutyPhone }</em>
              </div>
          </div>
          <div class="index_side">
              <a href="ondutyMonth" class="index_side_pbb" title="支队本月排班表" target="_blank"></a>
          </div>
          
          <div class="index_r02">
              <div class="title02"><h4>本站公告</h4><a href="list?fGroup=${xx:encode('本站公告','utf-8')}" class="more">更多>></a></div>
              <div class="index_r02C">
                  <div id="demo" style="width:178px; height:230px; overflow:hidden;">
                    <div id="demo1">
                        <ul class="column"> 
                <c:forEach items="${newsList}" var="news" varStatus="vs">
      		       <c:if test="${news.fGroup=='本站公告'  }">	
        
 <li><a href="${news.fLink!=''?news.fLink:'show'}?fId=${news.fId}" target="_blank">${fn:length(news.fSubject)<20?(news.fSubject):(news.fSubject.substring(0,20))}<c:if test="${news.fDate>bfDate }"><img src="images/new.png"/></c:if></a><span><font color="red">(${news.fRead })</font>[${news.fDate.substring(5,10)}]</span></li>
      		       </c:if>
      		    </c:forEach>
      		    <%--
                            <li><a href="${news.fLink!=''?news.fLink:'show'}.html" target="_blank">我市举行处置突发暴恐事件时男子自实战演练</a>
                            <span>[02-09]</span></li>
      		     --%>
                          </ul>
                    </div>
                    <div id=demo2></div>
                   </div>
              </div>
          </div>
    	<div class="index_r03">
              <div class="title02"><h4>在线办公</h4></div>
              <ul> 
                <li><a href="phonebook" target="_blank"><em class="img01"></em>全市治安系统通讯录</a></li>
                <li><a href="vedioList" target="_blank"><em class="img02"></em>视频资料</a></li>
                <li><a href="upload2download" target="_blank"><em class="img03"></em>文件上传下载</a></li>
                <li><a href="downlist" target="_blank"><em class="img04"></em>下载中心</a></li>
                <li><a href="search" target="_blank"><em class="img05"></em>搜索引擎</a></li>
                <%--
                <li><a href="#" target="_blank"><em class="img06"></em>治安支队对应IP</a></li>
                <li><a href="#" target="_blank"><em class="img07"></em>老版回顾</a></li>
                <li><a href="#" target="_blank"><em class="img08"></em>FTP上传下载</a></li>
                 --%>
                 <c:forEach items="${linkList}" var="link">
                 <c:if test="${link.fName=='治安支队对应IP' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="img06"></em>${link.fName }</a></li>
                 </c:if>
                 <c:if test="${link.fName=='老版回顾' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="img07"></em>${link.fName }</a></li>
                 </c:if>
                 <c:if test="${link.fName=='FTP上传下载' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="img08"></em>${link.fName }</a></li>
                 </c:if>
                 </c:forEach>
                 
              </ul>
          </div>
          <div class="index_r05" style="margin-bottom:0;">
              <div class="title02"><h4>平台系统</h4></div>
              <ul> 
              <%--
                <li><a href="#" target="_blank"><em class="sys01"></em>行贿档案查询系统</a></li>
                <li><a href="#" target="_blank"><em class="sys02"></em>机要文件管理系统</a></li>
                <li><a href="#" target="_blank"><em class="sys03"></em>综合受理系统</a></li>
                <li><a href="#" target="_blank"><em class="sys04"></em>检察统计系统</a></li>
                <li><a href="#" target="_blank"><em class="sys05"></em>在线视频会议系统</a></li>
                <li><a href="#" target="_blank"><em class="sys06"></em>信息发布系统(旧)</a></li>
                <li><a href="#" target="_blank"><em class="sys07"></em>印章业管理系统</a></li>
                <li><a href="#" target="_blank"><em class="sys08"></em>危爆物品管理系统</a></li>
                <li><a href="#" target="_blank"><em class="sys09"></em>娱乐场所管理系统</a></li>
               --%>
               
               <%--
                <c:forEach items="${linkList}" var="link">
                 <c:if test="${link.fName=='行贿档案查询系统' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="sys01"></em>${link.fName }</a></li>
                 </c:if>
                 <c:if test="${link.fName=='机要文件管理系统' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="sys02"></em>${link.fName }</a></li>
                 </c:if>
                 <c:if test="${link.fName=='综合受理系统' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="sys03"></em>${link.fName }</a></li>
                 </c:if>
                 <c:if test="${link.fName=='检察统计系统' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="sys04"></em>${link.fName }</a></li>
                 </c:if>
                 <c:if test="${link.fName=='在线视频会议系统' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="sys05"></em>${link.fName }</a></li>
                 </c:if>
                 <c:if test="${link.fName=='信息发布系统(旧)' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="sys06"></em>${link.fName }</a></li>
                 </c:if>
                 <c:if test="${link.fName=='印章业管理系统' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="sys07"></em>${link.fName }</a></li>
                 </c:if>
                 <c:if test="${link.fName=='危爆物品管理系统' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="sys08"></em>${link.fName }</a></li>
                 </c:if>
                 <c:if test="${link.fName=='娱乐场所管理系统' }">
                  <li><a href="${link.fUrl}" target="_blank"><em class="sys09"></em>${link.fName }</a></li>
                 </c:if>
                 </c:forEach>
                --%>
                
               <%--  <c:set var="num" value="1"></c:set>
                <c:forEach items="${linkList}" var="link">              
                <c:if test="${link.fType=='平台系统' }">
                 <li><a href="${link.fUrl}" target="_blank" ><em class="sys0${num}"></em>${link.fName }</a></li>
                 <c:set var="num" value="${num+1}"></c:set>
                </c:if>               
                </c:forEach> --%>
               
                 <c:set var="num" value="1"></c:set>
                <c:forEach items="${linkList}" var="link">   
                  <c:if test="${link.fType=='平台系统' }">
                   <li><a href="${link.fUrl }" target="_blank" title="${link.fName }"><img src="${link.fImgUrl }" style="width: 181px;height: 46px" /></a></li>
                    <c:set var="num" value="${num+1}"></c:set>
                  </c:if>
                </c:forEach>
                
                    <!--  <li><a href="#" target="_blank" title="警务综合平台"><img src="images/ptxt01.jpg" /></a></li>
                     <li><a href="#" target="_blank" title="全国人口信息系统"><img src="images/ptxt02.jpg" /></a></li>
                     <li><a href="#" target="_blank" title="全市旅馆业信息系统"><img src="images/ptxt03.jpg" /></a></li>
                     <li><a href="#" target="_blank" title="全国在逃人员资源库"><img src="images/ptxt04.jpg" /></a></li>
                     <li><a href="#" target="_blank" title="情报信息采集系统"><img src="images/ptxt05.jpg" /></a></li>
                     <li><a href="#" target="_blank" title="省级人口信息系统"><img src="images/ptxt06.jpg" /></a></li>
                     <li><a href="#" target="_blank" title="印章业管理系统"><img src="images/ptxt07.jpg" /></a></li>
                     <li><a href="#" target="_blank" title="危爆物品管理系统"><img src="images/ptxt08.jpg" /></a></li> -->
                     
              </ul>
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