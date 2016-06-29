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
		
		$("#fPid").attr('value',fId);
		$("#fPname").attr('value',fName);
		
		hideMenu();
	}

	function showMenu() {
		var cityObj = $("#fPname");
		var cityOffset = $("#fPname").offset();
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
	var url=$('#form1').attr('action');

	var data=PublicAjax(url,$('#form1').serialize());
	if(data>0){
		alert('操作成功!');
		location.href="mDeptMain.do";
	}
}

</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>部门添加</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default"  >返回</a>
				</div>
				
		<div class="develop">
		<form action="${pDept==null?'mDeptInsert.do':'mDeptUpdate.do'}"  id="form1">
		   <input type="hidden" name="fId" value="${pDept.F_ID}">
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" width=20% >上级部门：</td>
		   <td width=80% >
		   <%--
		   <select id="fPid" name="fPid">
		       <option value="0"  <c:if test="${dept.fPid==0 }">selected</c:if>    >根节点</option>
		       <c:forEach items="${deptList}" var="dp">
		        <option value="${dp.fId}"   <c:if test="${dept.fPid==dp.fId }">selected</c:if>     >${dp.fName}</option>
		       </c:forEach>
		   </select>

	   <div class="zTreeDemoBackground left">
		<ul class="list">
			<li class="title">
		    --%>

			<input type="hidden" id="fPid" name="fPid" value="${pDept.F_PID==null?'0':pDept.F_PID }" style="width:120px;">
			<input type="text" id="fPname" readonly value="${pDept.F_PNAME}" />
			<a id="menuBtn" href="javascript:#" onclick="showMenu(); return false;">选择</a>
		<%--
		</li>
		</ul>
	   </div>	
		 --%>

	
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >部门名称：</td>
		   <td >
		   <input type="text" id="fName" name="fName" value="${pDept.F_NAME }" want="yes" title="部门名称" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   
		   <tr>
		   <td align="right" >部门手机：</td>
		   <td >
		   <input type="text" id="fPhone" name="fPhone" value="${pDept.F_PHONE }" want="yes" title="部门手机" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   
		   <tr>
		   <td align="right" >排序号：</td>
		   <td >
		   <input type="text" id="fSort" name="fSort" value="${pDept.F_SORT }"  >
		   </td>
		   </tr>
		  
		   <tr>
		   <td align="right" >部门责任人：</td>
		   <td >
		   <input type="text" size="100px" id="fDutyPerson" name="fDutyPerson" value="${pDept.F_DUTY_PERSON }" >
		   <br>
		   <font color="red">提示：多个责任人，请使用字母,号分隔；如：张三,李四</font>
		   </td>
		   </tr>
		    
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