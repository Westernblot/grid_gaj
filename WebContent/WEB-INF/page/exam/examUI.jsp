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
	
	var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		location.href="mExamMain.do";
	}
	
}

//==========================动态表格添加/删除==================================
function addLine(obj){
	var tr=$(obj).parent().parent();
	var trHtml='<tr>'+$(tr).html()+'</tr>';
	$(tr).after(trHtml);
}

function delLine(obj){
	var tr = $(obj).parent().parent();
	$(tr).remove();
}
//===============================================================================

//单条保存
function saveLine(obj){
	var tr=$(obj).parent().parent();
	
	var fYear='${fYear}';
	var fName=$('#fName').val();
	var fMonth=$('#fMonth').val();
	var fEndMonth=$('#fEndMonth').val();
	
	var fItemId=$(tr).find('#fItemId').val();
	var fAdd=$(tr).find('#fAdd').val();
	var fSub=$(tr).find('#fSub').val();
	var fRemark=$(tr).find('#fRemark').val();
	
	if(fMonth=='' || fEndMonth==''){
		alert('时间必填!');
		return ;
	}
	
	if((fAdd!='' && isNaN(fAdd)) || (fSub!='' && isNaN(fSub))){
		alert('加分 和 减分 只能输入数字!');
		return ;
	}
	
	var data=PublicAjax('mExamInsert.do',
			{'fYear':fYear,
		'fName':fName,
		'fMonth':fMonth,
		'fEndMonth':fEndMonth,
		'fItemId':fItemId,
		'fAdd':fAdd,
		'fSub':fSub,
		'fRemark':fRemark
			});
	
	if(data>0){
		alert('保存成功!');
		$(tr).find('#fAdd').attr('value','');
		$(tr).find('#fSub').attr('value','');
		$(tr).find('#fRemark').attr('value','');
	}
}
	
</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>考核条目</span>
				</div>
				<div class="title">
				<%--
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
				 --%>
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
				</div>
				
		<div class="develop">
		<form action=""  id="form1">
		   
		   <table width="100%" border="0" class="mtable" >
		   <caption>
		      <h2>${fYear }年全市治安系统重点工作考核</h2>
		   </caption>
		   <tr>
		   <td colspan="6">
		   单位：<select name="fName" id="fName">
		   <c:forEach items="${deptList}" var="dept">
		   <option value="${dept.fName }" >${dept.fName }</option>
		   </c:forEach>
		   </select>
		   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   考核月份：<input type="text" id="fMonth" name="fMonth" value="" class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM'})" >
		              至     <input type="text" id="fEndMonth" name="fEndMonth" value="" class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM'})" >
		  <font color="red">*</font>
		  &nbsp;&nbsp;
		  <font color="red">提示：加分和减分 请勿输入负数</font>
		   </td>
		   </tr>
		   <tr>
		   <td width="5%"><b>序号</b>
		   <td width="50%"><b>项目<font color="red">*</font></b>
		   </td>
		   <td width="5%"><b>加分</b></td>
		   <td width="5%"><b>减分</b></td>
		   <td width="40%"><b>说明</b></td>
		   <td width="20%"><b>操作</b></td>
		   </tr>
		   
		   <c:forEach items="${itemList}" var="item"  varStatus="vs">
		     <tr>
		      <td>${item.fCode}<input type="hidden" id="fItemId" name="fItemId" value="${item.fId }"></td>
		      <td>${item.fItem}</td>
		      <td>
		      <input type="text" id="fAdd" name="fAdd" value="">
		      </td>
		      <td>
		      <input type="text" id="fSub" name="fSub" value="">
		      </td>
		      <td>
		      <%--
		      <input type="text" id="fRemark" name="fRemark" value="">
		       --%>
		       <textarea rows="3" cols="50" id="fRemark" name="fRemark"></textarea>
		      </td>
		      <td>
		      <input type="button" name="btn" value="保存"  onclick="saveLine(this)">
		      </td>
		      </tr>
		   </c:forEach>
		      
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>