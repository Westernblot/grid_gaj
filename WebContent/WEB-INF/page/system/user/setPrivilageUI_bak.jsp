<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>配置用户权限</title>
<jsp:include page="../../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
</head>
<script type="text/javascript">

    function selectAll(checkedValue){
	   $("input[type=checkbox]").attr("checked", checkedValue);
    }

	function doChecked( liID, checkedValue ){
		// 当前点击的checkbox元素所在的li元素
		var jLi = $("#" + liID);

		// 选中所有的直属下级。（children()方法是筛选下一级，find()是筛选所有后代）
		jLi.children("ul").find("input[type=checkbox]").attr("checked", checkedValue);
		
		// 选中或取消选中直属上级
		if( checkedValue ){ // checkedValue是boolean型，表示是否选中了当前复选框
			// 如果当前是选中，则选中所有的直属上级
			jLi.parents("li").children("input[type=checkbox]").attr("checked", checkedValue);
		}else{
			// 如果当前是取消选中，并且同级中没有被选中的项，则也取消上级的选中状态
			var jCheckedSibingCB = jLi.siblings("li").children("input[type=checkbox]:checked");
			if(jCheckedSibingCB.size() == 0){
				var jCheckboxInput = jLi.parent("ul").prev("label").prev("input[type=checkbox]");
				jCheckboxInput.attr("checked", checkedValue);
				
				// 递归操作每一层直属上级
				var jParentLi = jCheckboxInput.parent("li");
				if(jParentLi.size() > 0){
					doChecked(jParentLi.attr("id"), checkedValue);
				}
			}
		}
	} 
	
function doSave(){
	$.ajax({
		url:'mUserUpdate.do',
		data:$('#form1').serialize(),
		dataType:'json',
		type:'post',
		success:function(data){
			if(data>0){
				alert("操作成功");
			    location.href='mUserMain.do';
			}else{
				alert("操作失败");
			}
		},
		error:function(){
			alert("系统错误");
		}
	});
}

</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span> 配置用户权限</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					
					<a href="javascript:history.back()" class="btn btn-default" >返回</a>
					
				</div>
				
<div class="tree" align="center" >

<form action="" id="form1" >
<input type="hidden" name="fId" value="${user.fId}">
<input type="hidden" name="fPower" value="0">
<table width="60%" border="0" class="mtable" >
<caption><h4>正在为  ${user.fUname} 设置权限</h4></caption>
      <thead>
						<tr>
							<td style="padding-left: 10px;">
								<input type="checkbox" id="cbSelectAll" onClick="selectAll(this.checked)"/>
								<label for="cbSelectAll">全选</label>
							</td>
						</tr>
	 </thead>

<tr>
<td style="padding-left: 30px;">
<ul>
    <c:forEach items="${fMenu }" var="f">
      <li id="li_${f.fId }"><input type="checkbox" id="cb_${f.fId}" name="fPower" value="${f.fId}" onclick='doChecked("li_${f.fId}", this.checked)'
      
      <c:forEach items="${user.fPower.split(',') }" var="ac">
          <c:if test="${ac==f.fId}">checked</c:if>
      </c:forEach> >
      <label for="cb_${f.fId}">${f.fName}</label>
         <c:forEach items="${sMenu}" var="s">
         <c:if test="${f.fId==s.fPid }">
         <ul>
         <li id="li_${s.fId}">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="cb_${s.fId}" name="fPower" value="${s.fId}" onclick='doChecked("li_${s.fId}", this.checked)'
         
          <c:forEach items="${user.fPower.split(',') }" var="ac">
          <c:if test="${ac==s.fId}">checked</c:if>
      </c:forEach> >
         <label for='cb_${s.fId}'>${s.fName}</label></li>
         </ul>
         </c:if>
         </c:forEach>
      </li>
    </c:forEach>
</ul>



</td>
</tr>
</table>
</form>
</div>

							
</div>
</body>
</html>