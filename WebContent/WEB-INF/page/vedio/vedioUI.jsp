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
	
	
	//===========================图片上传===================================
	function doImg(){
		
		//alert(1);
		 $.ajaxFileUpload
	     (
	         {
	             url: 'sUpload/vedioImg', //用于文件上传的服务器端请求地址
	             type: 'post',
	             data: { Id: '123', name: 'lunis' }, //此参数非常严谨，写错一个引号都不行
	             secureuri: false, //一般设置为false
	             fileElementId: 'file1', //文件上传空间的id属性  <input type="file" id="file1" name="file1" />
	             dataType: 'json', //返回值类型 一般设置为json
	             success: function (data, status)  //服务器成功响应处理函数
	             {
	             
	            	 var fAttachment=data.fAttachment;
	     			var fAttachmentUrl=data.fAttachmentUrl;
	     			var html='<span><a href="sDownload?fileName='+fAttachment+'&fileURL='+fAttachmentUrl+'" id="attachment">'+fAttachment+'</a>'
	     			 +'<input type="hidden" id="fImg" name="fImg" value="'+fAttachment+'" />'
	     		     +'<input type="hidden" id="fImgUrl" name="fImgUrl" value="'+fAttachmentUrl+'" />'
	     		     +'<a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a></span>'; 
	     	
	     		    $('#div_img').html(html);
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
	
	var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		location.href="mVedioMain.do";
	}else{
		alert('操作失败!');
	}

}

</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>视频管理</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default"  >返回</a>
				</div>
				
		<div class="develop">
		<form action="${vedio==null?'mVedioInsert.do':'mVedioUpdate.do' }"  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${vedio.fId }">
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" >标题：</td>
		   <td >
		   <input type="text" id="fSubject" name="fSubject" value="${vedio.fSubject }" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   
		   <tr>
		   <td align="right" >封面图片：</td>
		   <td >
		   <input type="file" id="file1" name="file1" onchange="doImg()"><font color="red">*</font>
		   <div id="div_img">
		   <c:if test="${vedio.fImg!=null and vedio.fImg !=''}">
		     <span>
		       <a href="sDownload?fileName=${vedio.fImg}&fileURL=${vedio.fImgUrl}" id="img">${vedio.fImg}</a>
		       <input type="hidden" id="fImg" name="fImg" value="${vedio.fImg}"  />
		       <input type="hidden" id="fImgUrl" name="fImgUrl" value="${vedio.fImgUrl}" />
		       <a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a>
		     </span>
		     </c:if>
		   </div>

		   </td>
		   </tr>
		   
		   <tr>
		   <td align="right" >视频：</td>
		   <td >
		  <input type="file" name="uploadify" id="uploadify" /><font color="red">*</font>
		   <div id="fileQueue">
           </div>
		   <div id="div_vedio">
		   <c:if test="${vedio.fVedio!=null and vedio.fVedio !=''}">
		     <span>
		       <a href="sDownload?fileName=${vedio.fVedio}&fileURL=${vedio.fVedioUrl}" id="img">${vedio.fVedio}</a>
		       <input type="hidden" id="fVedio" name="fVedio" value="${vedio.fVedio}"  />
		       <input type="hidden" id="fVedioUrl" name="fVedioUrl" value="${vedio.fVedioUrl}" />
		       <a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a>
		     </span>
		     </c:if>
		   </div>
		   
		   </td>
		   </tr>
		   
		  
		   </table>
		   
		   <font color="red">说明：请上传以.flv结尾的视频文件</font>
		</form>
		
		<%--
********************************************************

 <form id="form1" >
   <div id="fileQueue">
    </div>
    <input type="file" name="uploadify" id="uploadify" />
    
    <p>
        <a href="javascript:$('#uploadify').uploadifyUpload()">上传</a>|
        <a href="javascript:$('#uploadify').uploadifyClearQueue()">取消上传</a>

    </p>
     
    <input type="hidden" id="ftp" value="127.0.0.1"/>
    <input type="hidden" id="username" value="admin"/>
    <input type="hidden" id="pwd" value="admin"/>

    </form>
		 --%>
		
		</div>
		
</div>


</body>
</html>