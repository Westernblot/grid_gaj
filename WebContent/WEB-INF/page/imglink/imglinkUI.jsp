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
<script type="text/javascript" src="<%=basePath%>publicjs/ajaxfileupload.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
});

//===========================图片上传===================================
function doImg(){
	
	 $.ajaxFileUpload
     (
         {
             url: 'sUpload/img', //用于文件上传的服务器端请求地址
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
		location.href="mLinkMain.do";
	}else{
		alert('操作失败!');
	}

}

</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>图片栏目链接</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default"  >返回</a>
				</div>
				
		<div class="develop">
		<form action="${link==null?'mLinkInsert.do':'mLinkUpdate.do' }"  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${link.fId }">
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" >图片：</td>
		   <td >
		  
		  
		  
		  
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >访问路径：</td>
		   <td >
		   <input type="text" id="fLink" name="fLink" value="${imglink.fLink }"  want="yes" title="访问路径">
		   <font color="red">*</font>
		   </td>
		   </tr>
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>