<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>..</title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
<script type="text/javascript" src="<%=basePath%>publicjs/ajaxfileupload.js"></script>

<script type="text/javascript">


//保存  AND 编辑
function doSave(){
	
	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}
	
	
	
	if('${onduty.fId}'==''){
		
     	//判断月份是否添加重复
	   var time=new Date().getTime();
	   var fMonth=$('#fMonth').val();
	   var data=PublicAjax('mOndutyCheckMonth.do?time='+time,{'fMonth':fMonth});
	   if(data>0){
		   alert('当前月份值班表已添加，请勿重复操作!');
		   return ;
	    }
	}
	
	var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		location.href="mOndutyMain.do";
	}
	
	//向LED屏幕写命令
	$.post("sendLedMsg.do");
}


</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>支队月份值班表</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
				</div>
				
		<div class="develop">
		<form action="${onduty==null?'mOndutyInsert.do':'mOndutyUpdate.do'}"  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${onduty.fId}">
		   
		   <table width="100%" border="0" class="mtable" >
		   <caption>
		   月份：<input type="text" id="fMonth" name="fMonth" value="${onduty.fMonth}" class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM'})">
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <%--
		   电话：<input type="text" id="fTel" name="fTel" value="${onduty.fTel }">
		  --%>
		   </caption>
		   <tr>
		   <td><b>月号</b></td>
		   <td><b>带班领队</b></td>
		   <td><b>民警</b></td>
		   </tr>
		   
		    <c:forEach var="i" begin="0" end="30" varStatus="vs">
              <tr>
		      <td>${vs.index+1}</td>
		      <td><input type="text" name="fLeader" value="${onduty.fLeader.split(',')[vs.index]}"></td>
		      <td><input type="text" name="fPolice" value="${onduty.fPolice.split(',')[vs.index]}"></td>
		      </tr>
           </c:forEach>
		
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>