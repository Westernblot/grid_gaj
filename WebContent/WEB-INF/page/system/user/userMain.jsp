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
<title>账户管理</title>
<link href="<%=basePath %>css/default.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>

<%--=================================z-tree 相关======================================================== --%>
    <link rel="stylesheet" href="<%=basePath %>/publicjs/zTree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath %>/publicjs/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery.ztree.excheck-3.5.js"></script>

<jsp:include page="../../include.jsp"></jsp:include>

</head>
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
		
	//	$("#fPid").attr('value',fId);
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


//新增
function doAdd(){
	var url="mUserUI.do?fId=0";
	location.href=url;
}

//编辑
function doEdit(){
	var fId = getId('update'); 
	
	if(fId==false){
		return;
	}
	var url="mUserUI.do?fId="+fId;
	location.href=url;
}

//权限设置
function doPrivilage(){
	var fId = getId('update'); 
	if(fId==false){
		return;
	}
	var url="mSetPrivilageUI.do?fId="+fId;
	location.href=url;
}

//重置密码
function resetPassword(){
	var fId = getId('delete'); 
	//alert(fId);
	if(fId==false){
		return;
	}
	
	if(confirm("确定重置吗？重置后密码为1")){
		
	var data=PublicAjax('mResetPassword.do',{'fIds':fId});
	
	if(data>0){
		alert("重置成功!");
		location.reload();
	}
	}
	
}

//查询
function doSearch(){
	$('#formQuery').submit();
}

//调序
function updateSort(obj,fId){
	var fSort=$(obj).parent().find('#fSort').val();
	//alert(sort+"-"+fId);
	if(fSort=='' || isNaN(fSort)){
		alert('序号不能为空，且只能输入数字！');
		return;
	}
	var data=PublicAjax('mUserUpdate.do',{'fId':fId,'fSort':fSort});
	if(data>0){
		location.reload();
	}
}

</script>
<body>
<div id="div_right">


	<div class="right_top">
					<span>账户管理</span>
				</div>
				<div class="title">
					<a href="javascript:doAdd()"  class="btn btn-green">新增</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">修改</a> 
					<a href="javascript:resetPassword()"  class="btn btn-bule">重置密码</a>
					<a href="javascript:doPrivilage()"  class="btn btn-bule">设置权限</a>
					<a href="javascript:doDelete('mUserDelete.do')" class="btn btn-red">删除</a> 
					提示：<font color="red">删除用户时，用户邮箱也将一并删除。请谨慎操作！</font>
              
              <div style="float: right;">
              <form action="mUserMain.do"   id="formQuery" method="post">
                  <input type="hidden" name="status" value="2" >
                  <%--
         部门：<input type="text" id="fDept" name="fDept" value="${page.pd.fDept}" />
			<a id="menuBtn" href="javascript:#" onclick="showMenu(); return false;">选择</a>
                   --%>
                  警号：<input type="text" size="20px" name="fUname" value="${page.pd.fUname }" >
                  姓名：<input type="text" name="fCname" value="${page.pd.fCname }">
                  <a href="javascript:doSearch()"  class="btn btn-bule">查询</a>
              </form>
              </div>
				</div>
				<!-- 
				style="height:400px;overflow:auto;"
				 -->
		<div class="develop"  >
					<table width="100%" border="0" class="mtable">
						<tr>
							<th class="thcheckbox" width="3%" ><input type="checkbox"
								name="checkbox" id="checkbox" onclick="checkAll(this);" ></th>
							<th width="20%" >登录名</th>
							<th width="20%" >中文名</th>
							<th width="20%" >部门</th>
							<th width="20%" >职务</th>
							<th width="20%" >电话</th>
							<th width="10%" >排序(由大到小)</th>
						</tr>
					<tbody id="goaler">
						<c:forEach items="${users }" var="user">
						 <tr id="${user.fId }">
						 <td class="thcheckbox"><input type="checkbox" name="chk" id="chk" onclick="selTr(this);" ></td>
						 <td>${user.fUname }</td>
						 <td>${user.fCname }</td>
						 <td>${user.fDept }</td>
						 <td>${user.fPosition }</td>
						 <td>${user.fPhone }</td>
						 <td>
						 <input type="text" size="5" id="fSort" name="fSort" value="${user.fSort}">
						 <input type="button" value="调序" onclick="updateSort(this,${user.fId})">
						 </td>
						 </tr>
						</c:forEach>
						
					</tbody>
					</table>
		</div>
				
		<!-- 底部分页 -->
	     <%@ include file="../pageBtm.jsp"%> 
</div>

<%--=================================================================== --%>	
   


    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
	  <ul id="treeDemo" class="ztree" style="margin-top:0; width:160px;"></ul>
    </div>

</body>
</html>