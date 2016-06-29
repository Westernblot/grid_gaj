<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>

<%--=================================z-tree 相关======================================================== --%>
    <link rel="stylesheet" href="<%=basePath %>/publicjs/zTree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath %>/publicjs/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery.ztree.excheck-3.5.js"></script>

<script type="text/javascript">

var setting = {
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClick,
			onClick: onClick
		}
	};

   var zNodes=PublicAjax('mDeptList.do');

	function beforeClick(treeId, treeNode) {
		var check = (treeNode && !treeNode.isParent);
		//if (!check) alert("只能选择城市...");
		//return check;
	}
	
	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		nodes = zTree.getSelectedNodes();
		var fId = "";
		var fName="";
	//	nodes.sort(function compare(a,b){return a.id-b.id;});
		for (var i=0, l=nodes.length; i<l; i++) {
			fId += nodes[i].id + ",";
			fName += nodes[i].name + ",";
		}
		if (fId.length > 0 ) fId = fId.substring(0, fId.length-1);
		if (fName.length > 0 ) fName = fName.substring(0, fName.length-1);
		
		$("#fDeptId").attr('value',fId);
		$("#fDept").attr('value',fName);
		
		hideMenu();
	}

	function showMenu() {
		var cityObj = $("#fDept");
		var cityOffset = $("#fDept").offset();
		$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

		$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}

	$(document).ready(function(){
		var treeObj=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		treeObj.expandAll(true); 
	});



//保存  AND 编辑
function doSave(){

	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}
	
	var sUser='${sUser}';
	 if(sUser==""){
    	//验证唯一性
    	var fUname=$('#fUname').val();
    	var flag=PublicAjax('mCheckUser.do?math='+Math.random(),{'fUname':fUname}); 
    	if(flag>0){
    		alert("账户已存在");
    	    return;
    	}
	 }

	//验证两次输入密码是否一样
	var fPassword=$('#fPassword').val();
	var verifyPwd=$('#verifyPwd').val();
	if(fPassword!=verifyPwd){
		alert("两次输入的密码不一致");
		return;
	}
    
	var url=$('#form1').attr('action');
	$.ajax({
		url:url,
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
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>账户管理</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default"  >返回</a>
				</div>
				
		<div class="develop">
		<form action="${sUser==null?'mUserInsert.do':'mUserUpdate.do'}"  id="form1">
		   <input type="hidden" name="fId" value="${sUser.fId}">
		   <table width="99%" border="0" class="mtable" >
		   <tr>
		   <td align="right" width=30% >账户：</td>
		   <td width=70% >
		   <input type="text" id="fUname" name="fUname" value="${sUser.fUname}"  want="yes" title="账户" 
		   <c:if test="${sUser!=null}">readOnly</c:if>
		   >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >中文名：</td>
		   <td >
		   <input type="text" id="fCname" name="fCname" value="${sUser.fCname }" want="yes" title="中文名" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >部门：</td>
		   <td >
		   <%--
		   <input type="text" id="fDept" name="fDept" value="" want="yes" title="部门" >
		   <font color="red">*</font>
		    --%>
		    <input type="hidden" id="fDeptId" name="fDeptId" value="${sUser.fDeptId}" want="yes" title="部门" >
			<input type="text" id="fDept" name="fDept" value="${sUser.fDept }" readonly />
			<a id="menuBtn" href="javascript:#" onclick="showMenu(); return false;">选择</a>
		     <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >职位：</td>
		   <td >
		   <input type="text" id="fPosition" name="fPosition" value="${sUser.fPosition }"  >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >电话：</td>
		   <td >
		   <input type="text" id="fPhone" name="fPhone" value="${sUser.fPhone }" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   
		   <%--新增的时候填写密码，修改时只能修改用户资料。不能修改密码 --%>
		   <c:if test="${sUser==null}">
		   <tr>
		   <td align="right" >密码：</td>
		   <td >
		   <input type="password" id="fPassword" name="fPassword" value="" want="yes" title="密码" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >确认密码：</td>
		   <td >
		   <input type="password" id="verifyPwd" name="verifyPwd" value="" want="yes" title="确认密码"  >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   </c:if>
		    
		   </table>
		</form>
		</div>
		
<%--=================================================================== --%>	

    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
	  <ul id="treeDemo" class="ztree" style="margin-top:0; width:160px;"></ul>
    </div>
		
</div>
</body>
</html>