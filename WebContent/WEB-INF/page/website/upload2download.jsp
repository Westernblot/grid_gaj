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
<script type="text/javascript">


</script>
</head>

<body>
<div id="container">
 
      
      <!-- 底部-->
      <%@ include file="../website/public/head.jsp"%> 
    
  
  
<div id="content">
      <div class="navbottom"><em></em>您当前的位置：<a href="index.html">首页</a> > <a href="#">文件上传下载</a></div>
  	 	<div class="fileupload">  
        	<div class="fileupload_title">
        	<%--
                <a href="fileup.html" style="float:left; margin-left:20px;"><B>文件上传</B></a>
        	 --%>
                <h4>文件下载</h4>
                <span><em>${sessionScope.user.fCname }</em>,你好　<%-- <a href="#">退出</a>--%></span>
            </div>
            <div class="fileupload_con">
            
            <form action="upload2download"   id="formQuery" method="post">
			<input type="hidden" name="fType" value="${page.pd.fType}">		     
           <table class="file03">
               <tr>          
                 <th colspan="4">查询条件</th>        
               </tr>
               <tr>
                 <td class="TDleft">文件名</td>       
                 <td><input name="fAttachment" type="text" value="${page.pd.fAttachment }" /></td>       
                 <td class="TDleft">接收单位</td> 
                 <td><input name="" type="text" value="${sessionScope.user.fDept}" readOnly />
                <%--
                   <option value=""   <c:if test="${page.pd.fRecDept=='' }">selected</c:if>    >-查询所有-</option>
                   <c:forEach items="${deptList}" var="dept">
                   <option value="${dept.fName}"   <c:if test="${page.pd.fRecDept==dept.fName }">selected</c:if>    >${dept.fName}</option>
                   </c:forEach>
                 --%>
                </td>        
               </tr>
               <tr>    
                 <td class="TDleft">开始时间</td> 
                 <td><input name="fStartDate" type="text" class="Wdate"  onclick="WdatePicker()" value="${page.pd.fStartDate }" /></td>        
                 <td class="TDleft">结束时间</td>  
                 <td><input name="fEndDate" type="text" class="Wdate"  onclick="WdatePicker()" value="${page.pd.fEndDate }" /></td>       
               </tr>
               <tr>    
                  <td align="center" colspan="4"><input name="up" type="submit" value="查询" /></td>      
               </tr>
           </table>
          </form>
           
           
           <table class="file03">
               <tr>          
                 <th>文件名</th>       
                 <th width="100">上传日期</th>       
                 <th width="150">接收单位</th>       
                 <th width="100">发送人</th>       
                  
               </tr>
               
               <c:forEach items="${fileList}" var="file">
               <tr>          
                 <td>
                 <c:if test="${file.fAttachment!=null and file.fAttachment !=''}">
		    <c:forEach items="${file.fAttachmentUrl.split(',') }" var="url" varStatus="vs">
		       <span>
  <a href="sDownload?fileName=${file.fAttachment.split(',')[vs.index]}&fileURL=${url}" id="attachment">${file.fAttachment.split(',')[vs.index] }</a>
		     ;
		      </span>
		      </c:forEach>
		      </c:if>
                 </td>       
                 <td align="center">${file.fAddDate }</td>       
                 <td align="center">${file.fRecDept }</td>       
                 <td align="center">${file.fAddName }</td>       
                    
               </tr>
               </c:forEach>
             <%--
               <tr>          
                 <td>黄石市爆破人员考核申请.jpg</td>       
                 <td align="center">2015-01-28</td>       
                 <td align="center">危管科</td>       
                 <td align="center">hsza</td>       
                 <td align="center"><input name="up" type="button" value="下载" /></td>       
               </tr>
              --%>
           </table>
           </div>
      	</div>      
      	
      		<!-- 底部分页 -->
		  
	     <%@ include file="../system/pageBtm.jsp"%> 
   </div>


  
  <!-- 底部-->
      <%@ include file="../website/public/foot.jsp"%> 
</div>
<div id="bgblock"></div>
 <script type="text/javascript" src="js/scrolltop.js"></script>
</body>

</html>