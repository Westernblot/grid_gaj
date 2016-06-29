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
<title></title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>


<%--=================================z-tree 相关======================================================== --%>
    <link rel="stylesheet" href="<%=basePath %>/publicjs/zTree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath %>/publicjs/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>publicjs/ajaxfileupload.js"></script>
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
		
		//$("#fKeyId").attr('value',fId);
		$("#fKey").attr('value',fName);
		
		searchPerson();//搜索人员
		
		hideMenu();
	}

	function showMenu() {
		var cityObj = $("#fKey");
		var cityOffset = $("#fKey").offset();
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
	
	searchPerson();
	
	var treeObj=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	treeObj.expandAll(true); 
	
});


//搜索人员
function searchPerson(pageNo){
	var fKey=$('#fKey').val();
	var data=PublicAjax('mSearchPerson.do',{'fKey':fKey,'pageNo':(pageNo==null || pageNo=="")?1:pageNo});
	$('#pageBtm #pageNo').text(data.pageNo);
	$('#pageBtm #totalPage').text(data.totalPage);
	$('#pageBtm #totalRecord').text(data.totalRecord);
	
	$('#pageBtm #first').attr('href','javascript:searchPerson(1)');
	$('#pageBtm #back').attr('href','javascript:searchPerson('+(data.pageNo>1?data.pageNo-1:1)+')');
	$('#pageBtm #next').attr('href','javascript:searchPerson('+(data.pageNo<data.totalPage?data.pageNo+1:(data.totalPage==0?1:data.totalPage))+')');
	$('#pageBtm #end').attr('href','javascript:searchPerson('+(data.totalPage==0?1:data.totalPage)+')');
	
	var res = data.results;	
	 var html='';
	for(var i=0;i<res.length;i++){
		html+='<li><a href=javascript:appendPerson("'+res[i].F_ID+'","'+res[i].F_CNAME+'")>'+res[i].F_CNAME+'〈'+res[i].F_DEPT+'〉</a></li>';
	}
	$('#ul_person').html(html); 
}

//赋值收件人
function appendPerson(fId,fCname){
	//alert(fId+','+fCname);
	var fSetId=$('#fReceivedId').val()==""?fId:($('#fReceivedId').val()+","+fId);
	var fSetCname=$('#fReceived').val()==""?fCname:($('#fReceived').val()+","+fCname);
	
	$('#fReceivedId').attr('value',fSetId);
	$('#fReceived').attr('value',fSetCname);
}

//清除收件人
function clearOne(){
	var fReceivedId=$('#fReceivedId').val();
	var fReceived=$('#fReceived').val();
	var index1=fReceivedId.lastIndexOf(',');
	var index2=fReceived.lastIndexOf(',');
	//alert(index);
	$('#fReceivedId').attr('value',fReceivedId.substring(0,index1));
	$('#fReceived').attr('value',fReceived.substring(0,index2));
}

//清除所有
function clearAll(){
	$('#fReceivedId').attr('value','');
	$('#fReceived').attr('value','');
}

//发送短信
function sendMail(){
	
	    var fReceivedIds=$('#fReceivedId').val();
	    var fSmsMsg=$('#fSmsMsg').val();
	    //alert(fReceivedIds+"---"+fSmsMsg);
	    
	    if(fReceivedIds==''){
	    	alert("收件人必填!");
	    	return;
	    }
	     
		var data=PublicAjax("sendMessage.do", { "fReceivedIds":fReceivedIds, "fSmsMsg": fSmsMsg} );
		if(data>0){
			alert('发送成功!');
			location.reload();
		}else{
			alert("发送失败");
		}
			
			
	  /*   
	    $.ajax({
	    	  type: 'POST',
	    	  url: "sendMessage.do",
	    	  data: { fReceivedIds:fReceivedIds, fSmsMsg: fSmsMsg},
	    	  success: function(){
	    		  alert('发送成功!');
	  			  location.reload();
	    	  },
	    	  error:function(){
	    		  alert("发送失败");
	    	  }
	    	}); */
	
}


</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>发送短信</span>
				</div>
				<div class="title">
					
					
				</div>
				
		<div class="develop">
		<form action=""  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${pData.F_ID}">
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   
		   <td rowspan="3" width="180px"  valign="top">
		    <h4>通讯录：</h4>
		    <input type="text" id="fKey" name="fKey" style="width: 110px" onkeyup="searchPerson()">
		    <a id="menuBtn" href="javascript:#" onclick="showMenu(); return false;">选择</a>
		    
		    <div  style="overflow-y:auto; width:100%;height:400px;border: 1">
		    <ul id="ul_person">
		    <%--
		    <li><a >张三     贸易部</a></li>
		     --%>
		    </ul>
		    </div>
	  
      <div id="pageBtm">
	  <a id="first" href=""  title="首页"><img align="absmiddle" src="images/sys/first_btn.png" /></a>
	  <a id="back" href=""  title="上一页"><img align="absmiddle" src="images/sys/prev_btn.png" /></a>
	  <a id="next" href=""  title="下一页"><img align="absmiddle" src="images/sys/next_btn.png" /></a>
	  <a id="end" href=""  title="末页"><img align="absmiddle" src="images/sys/last_btn.png" /></a>
	  <br>
	  <span id="pageNo"></span>/<span id="totalPage"></span>页,共 <span id="totalRecord"></span>条,每页 20 条	    
	  </div>
	  
		   </td>
		   
		   <td  width="50px">收件人</td>
		   <td  width=70% >
		   <input type="hidden" size="80" id="fReceivedId" name="fReceivedId" value="${pData.F_RECEIVED_ID }" want="yes" title="收件人" readOnly >
		  
		  <%--
		   <input type="text" size="80" id="fReceived" name="fReceived" value="${pData.F_RECEIVED }" readOnly>
		   --%>
		   <textarea rows="3" cols="30" id="fReceived" name="fReceived" readOnly ></textarea>
		   <br>
		   <a href="javascript:clearOne()">回退</a>
		   <a href="javascript:clearAll()">清空所有</a>
		   </td>
		   
		   </tr>
		    
		   <tr id="tr_msg">
		   <td >短信内容</td>
		   <td >
		 <textarea rows="3" cols="30" id="fSmsMsg" name="fSmsMsg"></textarea>
		 
		<div align="center">
		 <a href="javascript:sendMail()" class="btn btn-bule" >发送</a>
		</div>
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