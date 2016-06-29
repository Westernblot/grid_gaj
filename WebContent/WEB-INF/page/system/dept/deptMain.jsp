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
<title>部门管理</title>
<jsp:include page="../../include.jsp"></jsp:include>
<link href="<%=basePath %>css/default.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>

<%--=================================z-tree 相关======================================================== --%>
    <link rel="stylesheet" href="<%=basePath %>/publicjs/zTree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath %>/publicjs/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery.ztree.excheck-3.5.js"></script>
	
<%-- =============================Z-dialog 相关================================================= --%>
	<script type="text/javascript" src="<%=basePath %>/publicjs/zDialog/zDrag.js"></script>
    <script type="text/javascript" src="<%=basePath %>/publicjs/zDialog/zDialog.js"></script>
	

</head>
<script type="text/javascript">
 
var setting = {
		check: {
			enable: true
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};
	
	 var zNodes=PublicAjax('mDeptList.do');
	  
	$(document).ready(function(){
		setting.check.chkboxType = { "Y" : "", "N" : "" };//设置 无关联
		var treeObj=$.fn.zTree.init($("#tree"), setting, zNodes);
		treeObj.expandAll(true); 
	
	});
	
	
	  function onCheck(){
          var treeObj=$.fn.zTree.getZTreeObj("tree"),
          nodes=treeObj.getCheckedNodes(true),
          
          m="";
          for(var i=0;i<nodes.length;i++){
              //v+=nodes[i].name + ",";
              m+=nodes[i].id+",";
              //alert(nodes[i].id); //获取选中节点的值
          }
          alert(m);
          
	  }
	  
	  function open2()
	  {
	  	var diag = new Dialog();
	  	diag.Width = 400;
	  	diag.Height = 180;
	  	diag.Title = "设定了高宽和标题的普通窗口";
	  	diag.URL = "mUserUI.do";
	  	diag.show();
	  }

	  //新增部门
      function addDept(){
         location.href="mDeptUI.do?fId=0";
      }
	  
	  //修改部门
	  function editDept(){
		  var treeObj=$.fn.zTree.getZTreeObj("tree");
          nodes=treeObj.getCheckedNodes(true);
          
          if(nodes.length!=1){
        	  alert("请选择一个项进行操作！");
        	  return;
          }
          
          var fId="";
          for(var i=0;i<nodes.length;i++){
        	  fId=nodes[i].id;
          }
         
         location.href="mDeptUI.do?fId="+fId;
	  }
	  
	  //删除部门
	  function deptDelete(){
			  var treeObj=$.fn.zTree.getZTreeObj("tree");
	          nodes=treeObj.getCheckedNodes(true);
	          
	          if(nodes.length==0){
	        	  alert("请选择操作项！");
	        	  return;
	          }
	          
		  if(confirm("确认删除吗？若该部门存在子部门，则一并删除!")){

	          var fIds="";
	          for(var i=0;i<nodes.length;i++){
	        	  if(fIds==""){
	        		  fIds=nodes[i].id;
	        	  }else{
	        		  fIds+=","+nodes[i].id;
	        	  }
	          }
	
			  var data=PublicAjax('mDeptRelateDelete.do',{'fIds':fIds});
			  if(data>0){
				  alert('操作成功!');
				  location.reload();
			  }
		  }
	  }
	  
	  
</script>
<body>
<div id="div_right">

	<div class="right_top">
					<span>部门管理</span>
				</div>
				<div class="title">
					<a href="javascript:addDept()"  class="btn btn-green">新增</a> 
					<a href="javascript:editDept()"  class="btn btn-green">修改</a> 
					<%--
					<a href="javascript:open2()"  class="btn btn-green">弹窗</a> 
					<a href="javascript:doEdit()" class="btn btn-bule">重置密码</a> 
					<a href="javascript:doPrivilage()"  class="btn btn-bule">设置权限</a>
					 --%>
					<a href="javascript:deptDelete()" class="btn btn-red">删除</a> 
				</div>
				
    <div id="zhongxin">
		<ul id="tree" class="ztree" style="overflow:auto; width: 80%;" ></ul>
	</div>

		
</div>

</body>
</html>