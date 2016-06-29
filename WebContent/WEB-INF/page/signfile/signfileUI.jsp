<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib uri="http://www.xxx.com/" prefix="xx"%>
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


<!-- =========================uploadify 上传相关=========================== -->

<link href="<%=basePath %>uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>uploadify/jquery-1.4.1.min.js" type="text/javascript"></script>
<script src="<%=basePath %>uploadify/swfobject.js" type="text/javascript"></script>

<script src="<%=basePath %>uploadify/jquery.uploadify.v2.1.4.min.js" type="text/javascript"></script>

<!-- ===========================ajax 文件上传=============================== -->
<script type="text/javascript" src="<%=basePath%>publicjs/ajaxfileupload.js"></script>

<script type="text/javascript">

	$(document).ready(function () {
    
            $("#uploadify").uploadify({
                'uploader': 'uploadify/uploadify.swf',
             //   'buttonText': '添加',                        //按钮文本
                'script': 'sUpload/vedio',//Servlet名称
                'cancelImg': 'uploadify/cancel.png',
                'folder': 'upload',
                'queueID': 'fileQueue',
                'auto': true,
                'method' : 'POST',
                'multi': false,
                'removeCompleted': true,    
                'filesSelected': '1',
                'scriptData': {'URL1':'55'},
                'onComplete':function(event,queueId,fileObj,response,data){
                	var obj=str2obj(response);

                	var fAttachment=obj.fAttachment;
 	     			var fAttachmentUrl=obj.fAttachmentUrl;
 	     			var html='<span><a href="sDownload?fileName='+fAttachment+'&fileURL='+fAttachmentUrl+'" id="attachment">'+fAttachment+'</a>'
 	     			 +'<input type="hidden" id="fVedio" name="fVedio" value="'+fAttachment+'" />'
 	     		     +'<input type="hidden" id="fVedioUrl" name="fVedioUrl" value="'+fAttachmentUrl+'" />'
 	     		     +'<a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a></span>'; 
 	     	
 	     		    $('#div_vedio').html(html);
                	
                },
                'onAllComplete': function (event,data) {
                	
                	},
                'onError': function () { 
                	alert("上传出错，请您重新尝试");
                	}
            }); 
       
    });
	
	
	//=========================附件上传=================================

	function doUpload(){
		
		$.ajaxFileUpload
	    (
	        {
	            url: 'sUpload/file', //用于文件上传的服务器端请求地址
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

//保存  AND 编辑
function doSave(){

	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}
	
	//发送短信
	var check=$('#fSms').attr('checked');
	if(check){
	    var fRecDept="";
		$("input[name='fRecDept']:checked").each(function(i, o){
		    if(fRecDept==""){
		    	fRecDept=$(o).val();
		    }else{
		    	fRecDept+=","+$(o).val();
		    }
		});
		
	    var fSmsMsg=$('#fSmsMsg').val()==""?("您有一个标题为《"+$('#fSubject').val()+"》的文件，请及时签收!"):($('#fSmsMsg').val());
	    //alert(fRecDept+"---"+fSmsMsg);
	    //return;
	    
	    $.post("sendMessageDept.do", { "fRecDept":fRecDept, "fSmsMsg": fSmsMsg } );
	}
	
	//return;
	
	var fType='${xx:encode(fType,"utf-8")}';  //解决IE6 编码 不能转UTF-8 问题
	var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		location.href="mSignFileMain.do?fType="+fType;
	}else{
		alert('操作失败!');
	}

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
					<span>文件上传下载</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default"  >返回</a>
				</div>
				
		<div class="develop">
		<form action="${file==null?'mFileInsert.do':'mFileUpdate.do' }"  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${file.fId }">
		   <input type="hidden" name="fType" value="${fType}">
		   
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" >标题：</td>
		   <td >
		   <input type="text" id="fSubject" name="fSubject" value="${file.fSubject }" want="yes" title="标题" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   
		    <tr>
		   <td align="right">签收单位：</td>
		   <td colspan="3" >
		   
		   <c:forEach items="${deptList }" var="dept" varStatus="vs">
		   
		   <input type="checkbox" id="chk_${vs.index}" name="fRecDept" value="${dept.fName}" 
		   <c:if test="${fn:contains(file.fRecDept,dept.fName)}">checked</c:if>
		   >
		   <label for="chk_${vs.index}">${dept.fName}</label>
		   <c:if test="${(vs.index+1)%4==0 }"><br></c:if>
		   </c:forEach>
		   
		   </td>
		   </tr>
		   
		   <tr>
		   <td align="right">附件：</td>
		   <td >
		   <input type="file" id="file" name="file" value="" onchange="doUpload()"> 
		    <div id="div_attachment">
		    <c:if test="${file.fAttachment!=null and file.fAttachment !=''}">
		    <c:forEach items="${file.fAttachmentUrl.split(',') }" var="url" varStatus="vs">
		       <span>
		       <a href="sDownload?fileName=${file.fAttachment.split(',')[vs.index] }&fileURL=${url}" id="attachment">${file.fAttachment.split(',')[vs.index] }</a>
		       <input type="hidden" id="fAttachment" name="fAttachment" value="${file.fAttachment.split(',')[vs.index] }" />
		       <input type="hidden" id="fAttachmentUrl" name="fAttachmentUrl" value="${url}" />
		       <a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a>
		       </span>
		    </c:forEach>
		    </c:if>
		    </div>
		   </td>
		   </tr>
		  
 
		   <tr id="tr_msg">
		   <td align="right">短信提醒：</td>
		   <td >
		    <input type="checkbox" id="fSms" name="fSms" value="是" onclick="showTrMsg()" >
		    <label for="fSms">是否短信提醒</label>
		   
		   <br>
		  <input type="text" size="100" id="fSmsMsg" name="fSmsMsg" value="" >
		  <br>
		  如不填，则默认为：<font color="red">您有一个标题为《XXXX》的文件，请及时签收!</font>
		   </td>
		   </tr>
		  
		  
		   <tr>
		   <td align="right">备注说明：</td>
		   <td>
		   <textarea rows="3" cols="30" id="fRemark" name="fRemark">${file.fRemark}</textarea>
		   </td>
		   </tr>
		   
		  
		   </table>
		</form>
		
		</div>
		
</div>


</body>
</html>