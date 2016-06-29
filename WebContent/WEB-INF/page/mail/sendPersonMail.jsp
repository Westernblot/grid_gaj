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


var kindEditor;
$(document).ready(function(){
	
	kindEditor = KindEditor.create('#fContent', {
		themeType : 'simple',
		allowPreviewEmoticons : false,
		allowFileManager : false,
		allowImageUpload : true,
		uploadJson : 'manage/upload',
		urlType: 'relative',
		items : [
			'source', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
			'removeformat', 'strikethrough', 'lineheight', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
			'insertunorderedlist', '|', 'emoticons', 'image', 'table', 'hr', 'link', '|', 'wordpaste', 'quickformat', 'fullscreen']
	});
	
	/* var fId='${pData.fId}';
	if(fId!=''){
	    kindEditor.sync();
	    var fContent = $('#fContent').val();
		kindEditor.html(fContent);
	} */
	
	
	searchPerson();
	
	var treeObj=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	treeObj.expandAll(true); 
	
	
	showTrMsg();//显示只读 或者 不只读 
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

//发送邮件
function sendMail(){
	kindEditor.sync();
	
	//发送短信
	var check=$('#fSms').attr('checked');
	if(check){
	    var fReceivedIds=$('#fReceivedId').val();
	    var fRemindTime=$('#fRemindTime').val();
	    var fSmsMsg=$('#fSmsMsg').val()==""?("您有一封信主题为《"+$('#fSubject').val()+"》的邮件，请注意查收!"):($('#fSmsMsg').val());
	    //alert(fReceivedIds+"---"+fSmsMsg);
	    
	    $.post("sendMessage.do", { "fReceivedIds":fReceivedIds,"fRemindTime":fRemindTime, "fSmsMsg": fSmsMsg } );
	}
	
	
	var data=PublicAjax('mCmdSendPersonMail.do',$('#form1').serialize());
	if(data>0){
		alert('发送成功!');
		location.reload();
	}
}

//保存为草稿
function saveDrafts(){
	kindEditor.sync();
	var data=PublicAjax('mSaveDrafts.do',$('#form1').serialize());
	if(data>0){
		alert('操作成功!');
		location.reload();
	}
}

//=========================附件上传=================================

//删除附件
function delDiv(obj){
	$(obj).parent().remove();
}

//附件上传
	function ajaxFileUpload() {
	
	
            $.ajaxFileUpload
            (
                {
                    url: 'blobUpload', //用于文件上传的服务器端请求地址
                    type: 'post',
                    data: { Id: '123', name: 'lunis' }, //此参数非常严谨，写错一个引号都不行
                    secureuri: false, //一般设置为false
                    fileElementId: 'file', //文件上传空间的id属性  <input type="file" id="file" name="file" />
                    dataType: 'json', //返回值类型 一般设置为json
                    success: function (data, status)  //服务器成功响应处理函数
                    {
                    
                    	var fAttachmentId=data.fAttachmentId;
            			var fAttachment=data.fAttachment;
            			var html='<span><a href="blobRead?fId='+fAttachmentId+'">'+fAttachment+'</a>'
            		     +'<input type="hidden" id="fAttachmentId" name="fAttachmentId" value="'+fAttachmentId+'" />'
            		     +'<input type="hidden" id="fAttachment" name="fAttachment" value="'+fAttachment+'" />'
            		     +'<a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a></span>'; 
            	
            		    $('#div_attachment').append(html);
            			//$(td).find('#file').attr('value','');//清除file的内容
            			//resetFileInput($('#file'));
                    },
                    error: function (data, status, e)//服务器响应失败处理函数
                    {
                        alert(e);
                    }
                }
            );
            //return false;
        }


//======================显示短信读写===================================
	
	function showTrMsg(){
	
	var check=$('#fSms').attr('checked');
	
	if(check){
		$('#fSmsMsg').removeAttr("readOnly");
	//	if($('#fSmsMsg').val()==''){
	//    $('#fSmsMsg').attr("value","您有一封信的邮件，标题为："+$('#fSubject').val()+"。请注意查收!");	
	//	}
	}else{
	    $('#fSmsMsg').attr("readOnly","readOnly");	
	    $('#fSmsMsg').attr("value","");	
	    
	}
	
  }

</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>发送个人邮件</span>
				</div>
				<div class="title">
					<a href="javascript:sendMail()" class="btn btn-bule" >发送</a>
					<a href="javascript:saveDrafts()" class="btn btn-green" >存草稿</a>
					<%--
					<a href="javascript:ajaxFileUpload()" class="btn btn-green" >上传</a>
					 --%>
				</div>
				
		<div class="develop">
		<form action=""  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${pData.F_ID}">
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td  width="50px">收件人</td>
		   <td  >
		   <input type="hidden" size="80" id="fReceivedId" name="fReceivedId" value="${pData.F_RECEIVED_ID }" want="yes" title="收件人" readOnly >
		  
		   <input type="text" size="80" id="fReceived" name="fReceived" value="${pData.F_RECEIVED }" readOnly>
		   <a href="javascript:clearOne()">回退</a>
		   <a href="javascript:clearAll()">清空所有</a>
		   </td>
		   <td rowspan="6" width="180px"  valign="top">
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
		   </tr>
		   
		   <tr>
		   <td >主题</td>
		   <td >
		   <input type="text" size="100" id="fSubject" name="fSubject" value="${pData.F_SUBJECT }" >
		   </td>
		   </tr>
		   
		   <tr>
		   <td >选项</td>
		   <td >
		  
		   <input type="checkbox" id="fReceipt" name="fReceipt" value="是"
		    <c:if test="${pData.F_RECEIPT=='是'}">checked</c:if>
		     ><label for="fReceipt">是否需要回执</label>
		   &nbsp;&nbsp;
		   <input type="checkbox" id="fSms" name="fSms" value="是" 
		    <c:if test="${pData.F_SMS=='是'}">checked</c:if>
		    onclick="showTrMsg()"
		    ><label for="fSms">是否短信提醒</label>
		   &nbsp;&nbsp;&nbsp;&nbsp;<b> 重复提醒时间：</b>
		   <input type="text" id="fRemindTime" name="fRemindTime"  class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
		   <font color="red">注：为空则不重复提醒</font>
		   </td>
		   </tr>
		   
		   <tr id="tr_msg">
		   <td >短信内容</td>
		   <td >
		  <input type="text" size="100" id="fSmsMsg" name="fSmsMsg" value="${pData.F_SMS_MSG }" >
		  <br>
		  如不填，则默认为：<font color="red">您有一封主题为《XXXX》的邮件，请注意查收!</font>
		   </td>
		   </tr>
		   
		   <tr>
		   <td >内容</td>
		   <td >
		   <textarea id="fContent" name="fContent" style="width: 100%; height:300px;visibility: hidden;"> ${pData.F_CONTENT}</textarea>
		   <br>

		   </td>
		   </tr>
		   
		   <tr>
		   <td >附件</td>
		   <td >
		   <input type="file" id="file" name="file" value="" onchange="ajaxFileUpload()"> 
		    <div id="div_attachment">
		    <c:if test="${pData.F_ATTACHMENT !=null and pData.F_ATTACHMENT !=''}">
		    <c:forEach items="${pData.F_ATTACHMENT.split(',') }" var="name" varStatus="vs">
		       <span>
		       <a href="blobDowload?tableName=personmail_${sessionScope.user.fId}&fId=${pData.F_ATTACHMENT_ID.split(',')[vs.index] }" id="attachment">${name}</a>
		       <input type="hidden" id="fAttachmentId" name="fAttachmentId" value="${pData.F_ATTACHMENT_ID.split(',')[vs.index] }" />
		       <input type="hidden" id="fAttachment" name="fAttachment" value="${pData.F_ATTACHMENT.split(',')[vs.index] }" />
		       <a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a>
		       </span>
		    </c:forEach>
		    </c:if>
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