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

<%--=================================z-tree 相关======================================================== --%>
    <link rel="stylesheet" href="<%=basePath %>/publicjs/zTree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath %>/publicjs/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>publicjs/ajaxfileupload.js"></script>
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="<%=basePath %>/publicjs/zTree/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript">


$(function(){
	var treeObj=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	treeObj.expandAll(true); 
	
	var treeObj1=$.fn.zTree.init($("#treeDemo1"), setting1, zNodes);
	treeObj1.expandAll(true); 
});


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
	
var setting1 = {
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
			onClick: onClick1
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
		var fValue=$('#fDutyDept').val();
		
		$("#fDutyDept").attr('value',fValue+","+fName);
			
		//hideMenu();
	}

	function showMenu() {
		var cityObj = $("#fDutyDept");
		var cityOffset = $("#fDutyDept").offset();
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
	
//=========================================分割线========================================================================	
	
	function onClick1(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo1");
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
		var fValue=$('#fFitDept').val();
		
		$("#fFitDept").attr('value',fValue+","+fName);
			
		//hideMenu();
	}

	function showMenu1() {
		var cityObj = $("#fFitDept");
		var cityOffset = $("#fFitDept").offset();
		$("#menuContent1").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

		$("body").bind("mousedown", onBodyDown1);
	}
	function hideMenu1() {
		$("#menuContent1").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown1);
	}
	function onBodyDown1(event) {
		if (!(event.target.id == "menuBtn1" || event.target.id == "menuContent1" || $(event.target).parents("#menuContent1").length>0)) {
			hideMenu1();
		}
	}



//==================================保存  AND 编辑================================================
function doSave(){

	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}
	
	
	var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		//location.href="mTaskMain.do";
		//location.reload();
		
		//如果是新增，则发送提醒
		if(url=='mTaskInsert.do'){
			$.post('mFirstSendMsg.do',$('#form1').serialize());
		}
		
		//清除填写内容
		$('#fContent').attr('value','');
		$('#fWork').attr('value','');
		$('#fDutyDept').attr('value','');
		$('#fFitDept').attr('value','');
		$('#div_attachment').html('');
		
	}
	
}

//=========================附件上传=================================

function doUpload(){
	
	$.ajaxFileUpload
    (
        {
            url: 'sUpload/newsAttachment', //用于文件上传的服务器端请求地址
            type: 'post',
            data: { Id: '123', name: 'lunis' }, //此参数非常严谨，写错一个引号都不行
            secureuri: false, //一般设置为false
            fileElementId: 'file', //文件上传空间的id属性  <input type="file" id="file" name="file" />
            dataType: 'json', //返回值类型 一般设置为json
            success: function (data, status)  //服务器成功响应处理函数
            {
            
            	var fAttachment=data.fAttachment;
    			var fAttachmentUrl=data.fAttachmentUrl;
    			var html='<span><a href="sDownload?fileName='+fAttachment+'&fileURL='+fAttachmentUrl+'" id="attachment">'+fAttachment+'</a>'
    		     +'<input type="hidden" id="fAttachment" name="fAttachment" value="'+fAttachment+'" />'
    		     +'<input type="hidden" id="fAttachmentUrl" name="fAttachmentUrl" value="'+fAttachmentUrl+'" />'
    		     +'<a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a></span>'; 
    	
    		    $('#div_attachment').append(html);
            },
            error: function (data, status, e)//服务器响应失败处理函数
            {
                alert(e);
            }
        }
    );
	
}


//删除附件
function delDiv(obj){
	$(obj).parent().remove();
}
	
</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>重点工作安排</span>
				</div>
				<div class="title">

					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
					<font color="red">提示：所有重点工作内容，系统会在完成时间前3个工作日发送短信提醒</font>
				</div>
				
		<div class="develop">
		<form action="${task==null?'mTaskInsert.do':'mTaskUpdate.do' }"  id="form1" >
		   <input type="hidden" id="fId" name="fId" value="${task.fId }">
		   <table width="100%" border="0" class="mtable" >
		   <caption>
		      <h2>   
		    ${sessionScope.user.fDept }
		   <input type="hidden" name="fDept" value="${sessionScope.user.fDept }">
		   重点工作安排</h2>
		   </caption>
		   <tr>
		   <td ></td>
		   
		   <td>开始时间：
		   <input type="text" id="fSdate" name="fSdate" value="${task==null?nowDate:task.fSdate }" class="Wdate"  onclick="WdatePicker()" >
		   </td>
		   <td>完成时间：
		   <input type="text" id="fEdate" name="fEdate" value="${task.fEdate }" class="Wdate"  onclick="WdatePicker()" >
		   
		   </td>
		   <td><input type="checkbox" id="fLeadKnow" name="fLeadKnow" value="是" checked="checked"><label for="fLeadKnow">上级知晓</label></td>
		   </tr>
		   
		   <tr>
		  
		   <td width="10%"><b>重点工作内容:</b></td>
		   <td colspan="4">
		   <textarea rows="3" cols="30" id="fContent" name="fContent">${task.fContent }</textarea>
		   </td>
		   
		   </tr>
		   
		    <tr>
		   <td >附件：</td>
		   <td colspan="3">
		   <input type="file" id="file" name="file" value="" onchange="doUpload()"> 
		    <div id="div_attachment">
		    <c:if test="${task.fAttachment!=null and task.fAttachment !=''}">
		    <c:forEach items="${task.fAttachmentUrl.split(',') }" var="url" varStatus="vs">
		       <span>
		       <a href="sDownload?fileName=${task.fAttachment.split(',')[vs.index] }&fileURL=${url}" id="attachment">${task.fAttachment.split(',')[vs.index] }</a>
		       <input type="hidden" id="fAttachment" name="fAttachment" value="${task.fAttachment.split(',')[vs.index] }" />
		       <input type="hidden" id="fAttachmentUrl" name="fAttachmentUrl" value="${url}" />
		       <a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a>
		       </span>
		    </c:forEach>
		    </c:if>
		    </div>
		   </td>
		   </tr>
		   
		   <tr>
		  
		   <td width="10%"><b>工作情况：</b></td>
		   <td colspan="4">
		   <textarea rows="3" cols="30" id="fWork" name="fWork">${task.fWork }</textarea>
		   </td>
		   
		   </tr>
		   
		    
		      
		      <tr>
		      <td>责任单位：</td>
		      <td colspan="4">
		     <textarea rows="3" cols="20" style="width: 700px"  id="fDutyDept" name="fDutyDept" >${task.fDutyDept }</textarea>
		      <a id="menuBtn" href="javascript:#" onclick="showMenu(); return false;">选择</a>
		     </td>
		      </tr>
		      
		      <tr>
		      <td>配合单位：</td>
		      <td colspan="4">
		     <textarea rows="3" cols="20" style="width: 700px" id="fFitDept" name="fFitDept" >${task.fFitDept }</textarea>
		      <a id="menuBtn1" href="javascript:#" onclick="showMenu1(); return false;">选择</a>
		     </td>
		      </tr>
		 
		      <tr>
		      <td>责任人：</td>
		      <td colspan="4">
		     <input type="text" size="100" id="fDutyPerson" name="fDutyPerson" value="${task==null?fDutyPerson:task.fDutyPerson }" >
		     <br>
		     <font color="red">提示：责任人会由系统自动给出，如需修改。多责任人中间请用字母,号分隔；如：张三,李四</font>
		     </td>
		      </tr>
		 
		      
		   </table>
		</form>
		</div>
		
		<div style="height: 300px" ></div>
		
			<%--=================================================================== --%>	

    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
	  <ul id="treeDemo" class="ztree" style="margin-top:0; width:360px;"></ul>
    </div>
    
    
			<%--=================================================================== --%>	

    <div id="menuContent1" class="menuContent" style="display:none; position: absolute;">
	  <ul id="treeDemo1" class="ztree" style="margin-top:0; width:360px;"></ul>
    </div>
		
</div>
</body>
</html>