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
<jsp:include page="WEB-INF/page/include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>


    <link rel="stylesheet" href="js/ztree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="js/ztree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="js/ztree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="js/ztree/js/jquery.ztree.excheck-3.5.js"></script>

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

	var zNodes =[
		{ id:1, pId:0, name:"随意勾选 1", open:true},
		{ id:11, pId:1, name:"随意勾选 1-1"},
		{ id:111, pId:11, name:"随意勾选 1-1-1"},
		{ id:112, pId:11, name:"随意勾选 1-1-2"},
		{ id:12, pId:1, name:"随意勾选 1-2"},
		{ id:121, pId:12, name:"随意勾选 1-2-1"},
		{ id:122, pId:12, name:"随意勾选 1-2-2"},
		{ id:2, pId:0, name:"随意勾选 2"},
		{ id:21, pId:2, name:"随意勾选 2-1"},
		{ id:22, pId:2, name:"随意勾选 2-2"},
		{ id:221, pId:22, name:"随意勾选 2-2-1"},
		{ id:222, pId:22, name:"随意勾选 2-2-2"},
		{ id:23, pId:2, name:"随意勾选 2-3"}
	];
	
	
	
	$(document).ready(function(){
		$.fn.zTree.init($("#tree"), setting, zNodes);
	
	});
	
	
	function doSave(){
		
        
        var treeObj = $.fn.zTree.getZTreeObj("tree");
        var nodes = treeObj.getSelectedNodes();
       
        alert(nodes.length);
        
        var checked = nodes[1].checked;
        var id=nodes[1].id;
     /*    for(var i=0;i<length;i++){
        	treeObj.getNodes()[i].checked
        } */
        
        alert(checked);
        alert(id);
        
		var data=$('#form1').serialize();
		//alert(data);
	}

	  function onCheck(){
          var treeObj=$.fn.zTree.getZTreeObj("tree"),
          nodes=treeObj.getCheckedNodes(true),
          v="";
          for(var i=0;i<nodes.length;i++){
          v+=nodes[i].name + ",";
          //alert(nodes[i].id); //获取选中节点的值
          }
          alert(v);
	  }
	
</script>
<body>
<div id="div_right">
	<div class="right_top">
					<span> 配置用户权限</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					
					<a href="javascript:onCheck()" class="btn btn-default" >返回</a>
					
				</div>

<form action="" id="form1">
				
	<input type="text" name="fUname" >			
				
    <div id="zhongxin">
		<center><ul id="tree" class="ztree" style="overflow:auto; width: 80%;" ></ul></center>
	</div>

</form>
							
</div>
</body>
</html>