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
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/ZAstyle.css" rel="stylesheet" type="text/css" />
<link href="css/ZAny.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/time.js" type="text/javascript"></script>
</head>

<script type="text/javascript">

//查询
function doSearch(){
	$('#formQuery').submit();
}
</script>

<body>
<div id="container">
  
      
      <!-- 底部-->
      <%@ include file="../website/public/head.jsp"%> 
  
  
  <div id="content">
      <div class="navbottom"><em></em>您当前的位置：<a href="home">首页</a> > 治安考核情况 </div>
  	 
  	 <form action="examShow"  id="formQuery" method="post">
		                单位： 
		      <select name="fName" id="fName">
		      <option value="">-查询所有-</option>
		   <c:forEach items="${deptList}" var="dept">
		   <option value="${dept.fName }" <c:if test="${page.pd.fName==dept.fName }">selected</c:if> >${dept.fName }</option>
		   </c:forEach>
		   </select>
		   
		   考核时间：<input type="text" id="fMonth" name="fMonth" value="${page.pd.fMonth }" class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM'})" >
		               至<input type="text" id="fEndMonth" name="fEndMonth" value="${page.pd.fEndMonth }" class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM'})" >
		  
		                <a href="javascript:doSearch()" class="btn btn-bule">查询</a> 	              
      </form>
  	 
  	 <div class="show">  
                  
              <table  class="file02" >
              <tr>
                            <th width="5%" >考核年份</th>
							<th width="5%" >考核开始月份</th>
							<th width="5%" >考核结束月份</th>
							<th width="15%" >单位</th>
							<th width="60%" >项目</th>
							<th width="5%" >加分</th>
							<th width="5%" >减分</th>
							<%--
							<th width="20%" >说明</th>
							 --%>
							<th width="20%" >添加时间</th>
              </tr>
             <c:choose>
				<c:when test="${not empty pdList}">
						 <c:forEach items="${pdList}" var="pData">
						  <tr id="${pData.F_ID }">
						 
						  <td>${pData.F_YEAR }</td>
						  <td>${pData.F_MONTH }</td>
						  <td>${pData.F_END_MONTH }</td>
						  <td>${pData.F_NAME }</td>
						  <td>${pData.F_ITEM }</td>
						  <td>${pData.F_ADD }</td>
						  <td>${pData.F_SUB }</td>
						  <%--
						  <td>${pData.F_REMARK }</td>
						   --%>
						  <td>${pData.F_DATE }</td>
					
						  </tr>
						 </c:forEach>
				</c:when>
				<c:otherwise>
				<tr>
				<td colspan="20" align="center"><font color="red">暂无数据</font></td>
				</tr>
				</c:otherwise>
				</c:choose>
              </table>
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